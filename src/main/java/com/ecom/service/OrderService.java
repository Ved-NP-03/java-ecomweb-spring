package com.ecom.service;

import com.ecom.model.*;
import com.ecom.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class OrderService {
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private ProductService productService;
    
    public Order createOrder(User user, Cart cart, String shippingAddress, String phone) {
        // Validate cart
        if (cart == null || cart.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }
        
        // Create order
        Order order = new Order();
        order.setUser(user);
        order.setSubtotal(cart.getSubtotal());
        order.setGst(cart.getGST());
        order.setTotal(cart.getGrandTotal());
        order.setShippingAddress(shippingAddress);
        order.setPhone(phone);
        order.setStatus(Order.OrderStatus.PENDING);
        
        // Add order items
        for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
            CartItem cartItem = entry.getValue();
            
            // Check stock
            Product product = productService.getProductById(cartItem.getItem().getId().longValue())
                    .orElseThrow(() -> new RuntimeException("Product not found"));
            
            if (!productService.isInStock(product.getId(), cartItem.getQuantity())) {
                throw new RuntimeException("Product " + product.getName() + " is out of stock");
            }
            
            OrderItem orderItem = new OrderItem(product, cartItem.getQuantity());
            order.addOrderItem(orderItem);
            
            // Reduce stock
            productService.updateStock(product.getId(), cartItem.getQuantity());
        }
        
        return orderRepository.save(order);
    }
    
    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }
    
    public List<Order> getAllOrders() {
        return orderRepository.findAllByOrderByCreatedAtDesc();
    }
    
    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUserOrderByCreatedAtDesc(user);
    }
    
    public List<Order> getOrdersByStatus(Order.OrderStatus status) {
        return orderRepository.findByStatusOrderByCreatedAtDesc(status);
    }
    
    public long countOrdersByStatus(Order.OrderStatus status) {
        return orderRepository.countByStatus(status);
    }
    
    public void updateOrderStatus(Long orderId, Order.OrderStatus status) {
        Optional<Order> optOrder = orderRepository.findById(orderId);
        if (optOrder.isPresent()) {
            Order order = optOrder.get();
            order.setStatus(status);
            orderRepository.save(order);
        }
    }
    
    public void approveOrder(Long orderId) {
        updateOrderStatus(orderId, Order.OrderStatus.APPROVED);
    }
    
    public void rejectOrder(Long orderId) {
        updateOrderStatus(orderId, Order.OrderStatus.REJECTED);
    }
    
    public void cancelOrder(Long orderId) {
        updateOrderStatus(orderId, Order.OrderStatus.CANCELLED);
    }
    
    public void shipOrder(Long orderId) {
        updateOrderStatus(orderId, Order.OrderStatus.SHIPPED);
    }
    
    public void deliverOrder(Long orderId) {
        updateOrderStatus(orderId, Order.OrderStatus.DELIVERED);
    }
}