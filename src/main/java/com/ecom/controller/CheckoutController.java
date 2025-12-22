package com.ecom.controller;

import javax.servlet.http.HttpSession;

import com.ecom.model.Cart;
import com.ecom.model.Order;
import com.ecom.model.User;
import com.ecom.service.OrderService;
import com.ecom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CheckoutController {
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private UserService userService;

    @GetMapping("/checkout")
    public String checkout(HttpSession session, Authentication authentication, Model model) {
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            return "redirect:/viewCart";
        }
        
        // Get current user
        User user = userService.findByUsername(authentication.getName()).orElse(null);
        if (user != null) {
            model.addAttribute("user", user);
        }
        
        return "checkout";
    }
    
    @PostMapping("/placeOrder")
    public String placeOrder(@RequestParam("address") String address,
                            @RequestParam("phone") String phone,
                            HttpSession session,
                            Authentication authentication,
                            Model model) {
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            return "redirect:/viewCart";
        }
        
        try {
            User user = userService.findByUsername(authentication.getName())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            
            Order order = orderService.createOrder(user, cart, address, phone);
            
            // Clear cart after successful order
            cart.clear();
            
            model.addAttribute("order", order);
            return "order-success";
            
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "checkout";
        }
    }
    
    @GetMapping("/myOrders")
    public String myOrders(Authentication authentication, Model model) {
        User user = userService.findByUsername(authentication.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        model.addAttribute("orders", orderService.getOrdersByUser(user));
        return "my-orders";
    }
}