<%@ page import="com.ecom.model.Order" %>
<%@ page import="com.ecom.model.OrderItem" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Success - ShopEasy</title>
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
                <form action="/logout" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-secondary btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container">
        <%
            Order order = (Order) request.getAttribute("order");
            if (order != null) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
        %>
        
        <div class="success-container">
            <div class="success-icon">✅</div>
            <h1>Order Placed Successfully!</h1>
            <p class="success-message">Thank you for your order. Your order has been received and is pending approval.</p>
            
            <div class="order-info-box">
                <h3>Order Details</h3>
                <div class="info-row">
                    <span>Order ID:</span>
                    <strong>#<%= order.getId() %></strong>
                </div>
                <div class="info-row">
                    <span>Order Date:</span>
                    <strong><%= order.getCreatedAt().format(formatter) %></strong>
                </div>
                <div class="info-row">
                    <span>Status:</span>
                    <span class="badge badge-<%= order.getStatus().name().toLowerCase() %>">
                        <%= order.getStatus() %>
                    </span>
                </div>
                <div class="info-row">
                    <span>Total Amount:</span>
                    <strong class="text-success">₹<%= String.format("%.2f", order.getTotal()) %></strong>
                </div>
            </div>

            <div class="order-items-section">
                <h3>Items Ordered</h3>
                <table class="simple-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (OrderItem item : order.getOrderItems()) { %>
                        <tr>
                            <td><%= item.getProductName() %></td>
                            <td>₹<%= String.format("%.2f", item.getPrice()) %></td>
                            <td><%= item.getQuantity() %></td>
                            <td>₹<%= String.format("%.2f", item.getLineTotal()) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="shipping-info-section">
                <h3>Shipping Address</h3>
                <p><%= order.getShippingAddress() %></p>
                <p><strong>Phone:</strong> <%= order.getPhone() %></p>
            </div>

            <div class="next-steps">
                <h3>What's Next?</h3>
                <ul class="steps-list">
                    <li>📧 You will receive an email confirmation shortly</li>
                    <li>👨‍💼 Our admin will review and approve your order</li>
                    <li>📦 Once approved, your order will be processed</li>
                    <li>🚚 You can track your order status in "My Orders"</li>
                </ul>
            </div>

            <div class="action-buttons">
                <a href="/myOrders" class="btn btn-primary">View My Orders</a>
                <a href="/products" class="btn btn-secondary">Continue Shopping</a>
            </div>
        </div>

        <% } else { %>
        
        <div class="alert alert-error">
            <p>Order information not found.</p>
            <a href="/products" class="btn btn-primary">Go to Products</a>
        </div>

        <% } %>
    </div>
</body>
</html>