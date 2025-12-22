package com.ecom.model;

import javax.persistence.*;

@Entity
@Table(name = "order_items")
public class OrderItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;
    
    @Column(nullable = false)
    private String productName;  // Store name in case product is deleted later
    
    @Column(nullable = false)
    private Double price;  // Store price at time of order
    
    @Column(nullable = false)
    private Integer quantity;
    
    @Column(nullable = false)
    private Double lineTotal;
    
    // Constructors
    public OrderItem() {}
    
    public OrderItem(Product product, Integer quantity) {
        this.product = product;
        this.productName = product.getName();
        this.price = product.getPrice();
        this.quantity = quantity;
        this.lineTotal = price * quantity;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Order getOrder() {
        return order;
    }
    
    public void setOrder(Order order) {
        this.order = order;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public Double getPrice() {
        return price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    
    public Integer getQuantity() {
        return quantity;
    }
    
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
    
    public Double getLineTotal() {
        return lineTotal;
    }
    
    public void setLineTotal(Double lineTotal) {
        this.lineTotal = lineTotal;
    }
}