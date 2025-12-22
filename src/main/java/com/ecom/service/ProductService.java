package com.ecom.service;

import com.ecom.model.Product;
import com.ecom.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProductService {
    
    @Autowired
    private ProductRepository productRepository;
    
    public Product addProduct(Product product) {
        return productRepository.save(product);
    }
    
    public Product updateProduct(Product product) {
        return productRepository.save(product);
    }
    
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }
    
    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }
    
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }
    
    public List<Product> getActiveProducts() {
        return productRepository.findByActiveTrue();
    }
    
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }
    
    public List<Product> searchProducts(String keyword) {
        return productRepository.findByNameContainingIgnoreCase(keyword);
    }
    
    public void updateStock(Long productId, int quantity) {
        Optional<Product> optProduct = productRepository.findById(productId);
        if (optProduct.isPresent()) {
            Product product = optProduct.get();
            product.setStock(product.getStock() - quantity);
            productRepository.save(product);
        }
    }
    
    public boolean isInStock(Long productId, int quantity) {
        Optional<Product> optProduct = productRepository.findById(productId);
        return optProduct.isPresent() && optProduct.get().getStock() >= quantity;
    }
}