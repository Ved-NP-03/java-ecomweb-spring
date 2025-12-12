package com.ecom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class EcommerceApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(EcommerceApplication.class, args);
        System.out.println("\n Application Started Successfully!");
        System.out.println(" Access at: http://localhost:8080");
        System.out.println(" E-commerce Cart is ready!\n");
    }
}