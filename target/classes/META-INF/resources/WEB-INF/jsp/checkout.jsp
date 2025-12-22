<%@ page import="com.ecom.model.Cart" %>
<%@ page import="com.ecom.model.CartItem" %>
<%@ page import="com.ecom.model.User" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - ShopEasy</title>
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
                <a href="/myOrders" class="nav-link">My Orders</a>
                <a href="/viewCart" class="cart-icon-link">
                    🛒 Cart
                    <%
                        Cart navCart = (Cart) session.getAttribute("cart");
                        int itemCount = 0;
                        if (navCart != null && !navCart.isEmpty()) {
                            itemCount = navCart.getItems().size();
                        }
                    %>
                    <% if (itemCount > 0) { %>
                        <span class="cart-badge"><%= itemCount %></span>
                    <% } %>
                </a>
                <form action="/logout" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-secondary btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>Checkout</h1>
            <p>Complete your order</p>
        </div>

        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="alert alert-warning">
                <p>Your cart is empty. Please add items before checkout.</p>
                <a href="/products" class="btn btn-primary">Continue Shopping</a>
            </div>
        <%
            } else {
                User user = (User) request.getAttribute("user");
        %>

        <div class="checkout-container">
            <div class="checkout-left">
                <!-- Order Summary -->
                <div class="checkout-section">
                    <h2>Order Summary</h2>
                    <div class="order-items">
                        <%
                            for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                                CartItem ci = entry.getValue();
                        %>
                        <div class="order-item">
                            <div class="item-details">
                                <strong><%= ci.getItem().getName() %></strong>
                                <span class="item-qty">Qty: <%= ci.getQuantity() %></span>
                            </div>
                            <div class="item-price">
                                ₹<%= String.format("%.2f", ci.getLineTotal()) %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Shipping Form -->
                <div class="checkout-section">
                    <h2>Shipping Information</h2>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-error">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <form action="/placeOrder" method="post" class="checkout-form">
                        <div class="form-group">
                            <label>Full Name *</label>
                            <input type="text" name="fullName" class="form-control" 
                                   value="<%= user != null ? user.getFullName() : "" %>" 
                                   readonly required>
                        </div>

                        <div class="form-group">
                            <label>Phone Number *</label>
                            <input type="tel" name="phone" class="form-control" 
                                   value="<%= user != null && user.getPhone() != null ? user.getPhone() : "" %>" 
                                   placeholder="Enter your phone number" required>
                        </div>

                        <div class="form-group">
                            <label>Shipping Address *</label>
                            <textarea name="address" class="form-control" rows="4" 
                                      placeholder="Enter complete shipping address" required><%= user != null && user.getAddress() != null ? user.getAddress() : "" %></textarea>
                        </div>

                        <div class="form-actions">
                            <a href="/viewCart" class="btn btn-secondary">Back to Cart</a>
                            <button type="submit" class="btn btn-success">Place Order</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="checkout-right">
                <div class="price-summary">
                    <h3>Price Details</h3>
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <strong>₹<%= String.format("%.2f", cart.getSubtotal()) %></strong>
                    </div>
                    <div class="summary-row">
                        <span>GST (18%):</span>
                        <strong>₹<%= String.format("%.2f", cart.getGST()) %></strong>
                    </div>
                    <div class="summary-row">
                        <span>Delivery:</span>
                        <strong class="text-success">FREE</strong>
                    </div>
                    <hr>
                    <div class="summary-row total">
                        <span>Total Amount:</span>
                        <strong>₹<%= String.format("%.2f", cart.getGrandTotal()) %></strong>
                    </div>
                </div>

                <div class="checkout-info">
                    <h4>🔒 Safe & Secure</h4>
                    <ul>
                        <li>✓ Secure checkout</li>
                        <li>✓ 100% genuine products</li>
                        <li>✓ Easy returns</li>
                        <li>✓ Fast delivery</li>
                    </ul>
                </div>
            </div>
        </div>

        <% } %>
    </div>
</body>
</html>