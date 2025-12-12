package com.ecom.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ecom.data.ProductData;
import com.ecom.model.Cart;
import com.ecom.model.Item;

@Controller
public class CartController {

    @PostMapping("/addToCart")
    public String addToCart(@RequestParam("id") int id,
                           @RequestParam("qty") int qty,
                           HttpSession session) {
        
        Item item = ProductData.getById(id);
        if (item != null) {
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            cart.addItem(item, qty);
        }
        
        return "redirect:/viewCart";
    }

    @GetMapping("/viewCart")
    public String viewCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        return "cart";
    }

    @PostMapping("/clearCart")
    public String clearCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.clear();
        }
        return "redirect:/viewCart";
    }
}