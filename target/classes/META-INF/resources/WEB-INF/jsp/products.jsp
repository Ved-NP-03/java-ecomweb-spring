<%@ page import="java.util.List" %>
<%@ page import="com.ecom.model.Product" %>
<%@ page import="com.ecom.model.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop - ShopEasy</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-content">
            <a href="/" class="navbar-brand">
                🛍️ ShopEasy
            </a>
            <div class="navbar-menu">
                <a href="/products" class="nav-link">Products</a>
                <sec:authorize access="isAuthenticated()">
                    <a href="/myOrders" class="nav-link">My Orders</a>
                    <sec:authorize access="hasAuthority('ADMIN')">
                        <a href="/admin/dashboard" class="nav-link">Admin Panel</a>
                    </sec:authorize>
                </sec:authorize>
                <a href="/viewCart" class="cart-icon-link">
                    🛒 Cart
                    <%
                        Cart cart = (Cart) session.getAttribute("cart");
                        int itemCount = 0;
                        if (cart != null && !cart.isEmpty()) {
                            itemCount = cart.getItems().size();
                        }
                    %>
                    <% if (itemCount > 0) { %>
                        <span class="cart-badge"><%= itemCount %></span>
                    <% } %>
                </a>
                <sec:authorize access="isAuthenticated()">
                    <form action="/logout" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-secondary btn-sm">Logout</button>
                    </form>
                </sec:authorize>
                <sec:authorize access="!isAuthenticated()">
                    <a href="/login" class="btn btn-primary btn-sm">Login</a>
                </sec:authorize>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="page-header">
            <h1>Stationary Products</h1>
            <p>Quality stationery for all your needs</p>
        </div>

        <% if (request.getParameter("error") != null && "outofstock".equals(request.getParameter("error"))) { %>
            <div class="alert alert-error">
                Sorry, this product is out of stock or insufficient quantity available.
            </div>
        <% } %>

        <%
            List<Product> products = (List<Product>) request.getAttribute("products");
        %>

        <div class="product-grid">
            <%
                if (products != null && !products.isEmpty()) {
                    for (Product p : products) {
                        if (p.isActive()) {
            %>
            <div class="product-card">
                <div class="product-image">
                    <img src="<%= p.getImageUrl() != null ? p.getImageUrl() : "/images/" + p.getName().toLowerCase() + ".jpg" %>" 
                         alt="<%= p.getName() %>" 
                         onerror="this.src='/images/default.jpg'">
                </div>
                <div class="product-info">
                    <div class="product-name"><%= p.getName() %></div>
                    <% if (p.getDescription() != null && !p.getDescription().isEmpty()) { %>
                        <p style="color: #666; font-size: 0.9em; margin: 0.5rem 0;">
                            <%= p.getDescription().length() > 60 ? 
                                p.getDescription().substring(0, 60) + "..." : 
                                p.getDescription() %>
                        </p>
                    <% } %>
                    
                    <div class="product-price">₹<%= String.format("%.2f", p.getPrice()) %></div>
                    
                    <div class="product-stock">
                        <% if (p.getStock() > 0) { %>
                            <span style="color: #28a745;">✓ In Stock (<%= p.getStock() %> available)</span>
                        <% } else { %>
                            <span style="color: #dc3545;">✗ Out of Stock</span>
                        <% } %>
                    </div>
                    
                    <sec:authorize access="isAuthenticated()">
                        <% if (p.getStock() > 0) { %>
                            <form action="/addToCart" method="post">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <div class="product-actions">
                                    <input type="number" name="qty" value="1" min="1" max="<%= p.getStock() %>" class="qty-input" />
                                    <button type="submit" class="btn btn-primary">Add to Cart</button>
                                </div>
                            </form>
                        <% } else { %>
                            <button class="btn btn-secondary" disabled style="width: 100%; margin-top: auto;">Out of Stock</button>
                        <% } %>
                    </sec:authorize>
                    <sec:authorize access="!isAuthenticated()">
                        <a href="/login" class="btn btn-primary" style="width: 100%; margin-top: auto;">Login to Buy</a>
                    </sec:authorize>
                </div>
            </div>
            <%
                        }
                    }
                } else {
            %>
                <div class="empty-state" style="grid-column: 1 / -1;">
                    <div class="empty-icon">📦</div>
                    <h2>No Products Available</h2>
                    <p>Check back later for new products!</p>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>