package com.ecom.controller;

import com.ecom.model.Order;
import com.ecom.model.Product;
import com.ecom.model.User;
import com.ecom.service.OrderService;
import com.ecom.service.ProductService;
import com.ecom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private UserService userService;
    
    // Dashboard
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        long pendingOrders = orderService.countOrdersByStatus(Order.OrderStatus.PENDING);
        long approvedOrders = orderService.countOrdersByStatus(Order.OrderStatus.APPROVED);
        long totalProducts = productService.getAllProducts().size();
        long totalUsers = userService.getAllUsers().stream()
                .filter(u -> u.getRole() == User.Role.USER).count();
        
        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("approvedOrders", approvedOrders);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalUsers", totalUsers);
        
        return "admin/dashboard";
    }
    
    // ========== Product Management ==========
    
    @GetMapping("/products")
    public String manageProducts(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "admin/products";
    }
    
    @GetMapping("/products/add")
    public String addProductForm(Model model) {
        model.addAttribute("product", new Product());
        return "admin/product-form";
    }
    
    @PostMapping("/products/add")
    public String addProduct(@Valid @ModelAttribute Product product,
                            BindingResult result,
                            Model model) {
        if (result.hasErrors()) {
            return "admin/product-form";
        }
        
        productService.addProduct(product);
        return "redirect:/admin/products?success=added";
    }
    
    @GetMapping("/products/edit/{id}")
    public String editProductForm(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        model.addAttribute("product", product);
        return "admin/product-form";
    }
    
    @PostMapping("/products/edit/{id}")
    public String updateProduct(@PathVariable Long id,
                               @Valid @ModelAttribute Product product,
                               BindingResult result) {
        if (result.hasErrors()) {
            return "admin/product-form";
        }
        
        product.setId(id);
        productService.updateProduct(product);
        return "redirect:/admin/products?success=updated";
    }
    
    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/admin/products?success=deleted";
    }
    
    @PostMapping("/products/toggle/{id}")
    public String toggleProductStatus(@PathVariable Long id) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        product.setActive(!product.isActive());
        productService.updateProduct(product);
        return "redirect:/admin/products";
    }
    
    // ========== Order Management ==========
    
    @GetMapping("/orders")
    public String manageOrders(@RequestParam(value = "status", required = false) String status,
                              Model model) {
        List<Order> orders;
        
        if (status != null && !status.isEmpty()) {
            try {
                Order.OrderStatus orderStatus = Order.OrderStatus.valueOf(status.toUpperCase());
                orders = orderService.getOrdersByStatus(orderStatus);
            } catch (IllegalArgumentException e) {
                orders = orderService.getAllOrders();
            }
        } else {
            orders = orderService.getAllOrders();
        }
        
        model.addAttribute("orders", orders);
        model.addAttribute("selectedStatus", status);
        return "admin/orders";
    }
    
    @GetMapping("/orders/{id}")
    public String viewOrderDetails(@PathVariable Long id, Model model) {
        Order order = orderService.getOrderById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        model.addAttribute("order", order);
        return "admin/order-details";
    }
    
    @PostMapping("/orders/approve/{id}")
    public String approveOrder(@PathVariable Long id) {
        orderService.approveOrder(id);
        return "redirect:/admin/orders?success=approved";
    }
    
    @PostMapping("/orders/reject/{id}")
    public String rejectOrder(@PathVariable Long id) {
        orderService.rejectOrder(id);
        return "redirect:/admin/orders?success=rejected";
    }
    
    @PostMapping("/orders/ship/{id}")
    public String shipOrder(@PathVariable Long id) {
        orderService.shipOrder(id);
        return "redirect:/admin/orders?success=shipped";
    }
    
    @PostMapping("/orders/deliver/{id}")
    public String deliverOrder(@PathVariable Long id) {
        orderService.deliverOrder(id);
        return "redirect:/admin/orders?success=delivered";
    }
    
    @PostMapping("/orders/updateStatus/{id}")
    public String updateOrderStatus(@PathVariable Long id,
                                   @RequestParam("status") String status) {
        try {
            Order.OrderStatus orderStatus = Order.OrderStatus.valueOf(status.toUpperCase());
            orderService.updateOrderStatus(id, orderStatus);
            return "redirect:/admin/orders?success=updated";
        } catch (IllegalArgumentException e) {
            return "redirect:/admin/orders?error=invalid";
        }
    }
    
    // ========== User Management ==========
    
    @GetMapping("/users")
    public String manageUsers(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/users";
    }
}