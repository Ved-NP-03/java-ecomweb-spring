package com.ecom.config;

import com.ecom.model.Product;
import com.ecom.model.User;
import com.ecom.service.ProductService;
import com.ecom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ProductService productService;
    
    @Override
    public void run(String... args) throws Exception {
        // Create Admin user if not exists
        if (!userService.existsByUsername("admin")) {
            User admin = new User();
            admin.setUsername("admin");
            admin.setEmail("admin@shopeasy.com");
            admin.setPassword("admin123");
            admin.setFullName("Admin User");
            admin.setPhone("1234567890");
            admin.setAddress("Admin Address");
            userService.registerAdmin(admin);
            System.out.println("✓ Admin user created - Username: admin, Password: admin123");
        }
        
        // Create Sample user if not exists
        if (!userService.existsByUsername("user")) {
            User user = new User();
            user.setUsername("user");
            user.setEmail("user@shopeasy.com");
            user.setPassword("user123");
            user.setFullName("Sample User");
            user.setPhone("9876543210");
            user.setAddress("123 Main Street, City");
            userService.registerUser(user);
            System.out.println("✓ Sample user created - Username: user, Password: user123");
        }
        
        // Add sample products if database is empty
        if (productService.getAllProducts().isEmpty()) {
            Product[] products = {
                new Product("Pen", "Premium quality ballpoint pen", 10.0, 100),
                new Product("Notebook", "A4 size ruled notebook", 50.0, 80),
                new Product("Pencil", "HB pencil set of 10", 5.0, 150),
                new Product("Eraser", "Non-dust eraser", 3.0, 200),
                new Product("Bag", "Waterproof school bag", 500.0, 50),
                new Product("Ruler", "30cm steel ruler", 15.0, 120),
                new Product("Marker", "Permanent marker set", 25.0, 90),
                new Product("Stapler", "Heavy duty stapler", 80.0, 60)
            };
            
            for (Product product : products) {
                product.setCategory("Stationary");
                product.setActive(true);
                productService.addProduct(product);
            }
            System.out.println("✓ Sample products added");
        }
        
        System.out.println("\n========================================");
        System.out.println("  E-commerce Application Ready!");
        System.out.println("========================================");
        System.out.println("  Admin Login: admin / admin123");
        System.out.println("  User Login:  user / user123");
        System.out.println("  H2 Console:  http://localhost:8080/h2-console");
        System.out.println("========================================\n");
    }
}