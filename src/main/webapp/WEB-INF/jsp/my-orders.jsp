<%@ page import="com.ecom.model.Order" %>
<%@ page import="com.ecom.model.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders - ShopEasy</title>
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
                <a href="/viewCart" class="cart-icon-link">🛒 Cart</a>
                <form action="/logout" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-secondary btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>My Orders</h1>
            <p>Track and manage your orders</p>
        </div>

        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
            
            if (orders == null || orders.isEmpty()) {
        %>
            <div class="empty-state">
                <div class="empty-icon">📦</div>
                <h2>No Orders Yet</h2>
                <p>You haven't placed any orders yet. Start shopping now!</p>
                <a href="/products" class="btn btn-primary">Browse Products</a>
            </div>
        <%
            } else {
                for (Order order : orders) {
        %>
        
        <div class="order-card">
            <div class="order-header">
                <div class="order-header-left">
                    <h3>Order #<%= order.getId() %></h3>
                    <p class="order-date">
                        <span>📅 <%= order.getCreatedAt().format(formatter) %></span>
                    </p>
                </div>
                <div class="order-header-right">
                    <span class="badge badge-<%= order.getStatus().name().toLowerCase() %>">
                        <%= order.getStatus() %>
                    </span>
                    <h3 class="order-total">₹<%= String.format("%.2f", order.getTotal()) %></h3>
                </div>
            </div>

            <div class="order-items">
                <% for (OrderItem item : order.getOrderItems()) { %>
                <div class="order-item-row">
                    <div class="item-info">
                        <strong><%= item.getProductName() %></strong>
                        <span class="item-meta">Qty: <%= item.getQuantity() %> × ₹<%= String.format("%.2f", item.getPrice()) %></span>
                    </div>
                    <div class="item-total">
                        ₹<%= String.format("%.2f", item.getLineTotal()) %>
                    </div>
                </div>
                <% } %>
            </div>

            <div class="order-footer">
                <div class="order-address">
                    <strong>📍 Shipping Address:</strong>
                    <p><%= order.getShippingAddress() %></p>
                    <p><strong>Phone:</strong> <%= order.getPhone() %></p>
                </div>
                
                <div class="order-status-info">
                    <% 
                        String statusMessage = "";
                        String statusIcon = "";
                        switch(order.getStatus()) {
                            case PENDING:
                                statusMessage = "⏳ Waiting for admin approval";
                                break;
                            case APPROVED:
                                statusMessage = "✅ Approved! Being processed";
                                break;
                            case PROCESSING:
                                statusMessage = "📦 Your order is being prepared";
                                break;
                            case SHIPPED:
                                statusMessage = "🚚 On the way to you!";
                                break;
                            case DELIVERED:
                                statusMessage = "✅ Delivered successfully";
                                break;
                            case CANCELLED:
                                statusMessage = "❌ Order cancelled";
                                break;
                            case REJECTED:
                                statusMessage = "❌ Order rejected by admin";
                                break;
                        }
                    %>
                    <p class="status-message"><%= statusMessage %></p>
                    
                    <% if (order.getStatus() == Order.OrderStatus.PENDING) { %>
                        <form action="/cancelOrder" method="post" style="display: inline;" 
                              onsubmit="return confirm('Are you sure you want to cancel this order?');">
                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Cancel Order</button>
                        </form>
                    <% } %>
                </div>
            </div>

            <div class="order-timeline">
                <div class="timeline-step <%= order.getStatus().ordinal() >= 0 ? "completed" : "" %>">
                    <div class="step-icon">📝</div>
                    <div class="step-label">Placed</div>
                </div>
                <div class="timeline-line <%= order.getStatus().ordinal() >= 1 ? "completed" : "" %>"></div>
                <div class="timeline-step <%= order.getStatus().ordinal() >= 1 ? "completed" : "" %>">
                    <div class="step-icon">✅</div>
                    <div class="step-label">Approved</div>
                </div>
                <div class="timeline-line <%= order.getStatus().ordinal() >= 2 ? "completed" : "" %>"></div>
                <div class="timeline-step <%= order.getStatus().ordinal() >= 2 ? "completed" : "" %>">
                    <div class="step-icon">📦</div>
                    <div class="step-label">Processing</div>
                </div>
                <div class="timeline-line <%= order.getStatus().ordinal() >= 3 ? "completed" : "" %>"></div>
                <div class="timeline-step <%= order.getStatus().ordinal() >= 3 ? "completed" : "" %>">
                    <div class="step-icon">🚚</div>
                    <div class="step-label">Shipped</div>
                </div>
                <div class="timeline-line <%= order.getStatus().ordinal() >= 4 ? "completed" : "" %>"></div>
                <div class="timeline-step <%= order.getStatus().ordinal() >= 4 ? "completed" : "" %>">
                    <div class="step-icon">✅</div>
                    <div class="step-label">Delivered</div>
                </div>
            </div>
        </div>

        <%
                }
            }
        %>
    </div>
</body>
</html>