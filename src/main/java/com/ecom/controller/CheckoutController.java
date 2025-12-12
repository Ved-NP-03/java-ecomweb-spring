package com.ecom.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.ecom.model.Cart;

@Controller
public class CheckoutController {

    @GetMapping("/checkout")
    public String checkout(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            return "redirect:/viewCart";
        }
        
        return "receipt";
    }
}