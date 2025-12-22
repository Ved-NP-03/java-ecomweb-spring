// UserRepository.java
package com.ecom.repository;

import com.ecom.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
}

// -------------------------------------------------------

// ProductRepository.java
package com.ecom.repository;

import com.ecom.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByActiveTrue();
    List<Product> findByCategory(String category);
    List<Product> findByNameContainingIgnoreCase(String name);
}

// -------------------------------------------------------

// OrderRepository.java
package com.ecom.repository;

import com.ecom.model.Order;
import com.ecom.model.Order.OrderStatus;
import com.ecom.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserOrderByCreatedAtDesc(User user);
    List<Order> findByStatusOrderByCreatedAtDesc(OrderStatus status);
    List<Order> findAllByOrderByCreatedAtDesc();
    long countByStatus(OrderStatus status);
}

// -------------------------------------------------------

// OrderItemRepository.java
package com.ecom.repository;

import com.ecom.model.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
}