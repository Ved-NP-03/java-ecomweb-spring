package com.ecom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ecom.data.ProductData;

@Controller
public class ProductController {

    @GetMapping({"/", "/products"})
    public String listProducts(Model model) {
        model.addAttribute("products", ProductData.getAllProducts());
        return "products";
    }
}