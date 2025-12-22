<%@ page import="com.ecom.model.Order" %>
<%@ page import="com.ecom.model.OrderItem" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details - Admin</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <!-- Admin Navbar -->
    <nav class="navbar">
        <div class="navbar-content">
            <a href="/admin/dashboard" class="navbar-brand">
                🛍️ ShopEasy Admin
            </a>
            <div class="navbar-menu">
                <a href="/admin/dashboard" class="nav-link">Dashboard</a>
                <a href="/admin/products" class="nav-link">Products</a>
                <a href="/admin/orders" class="nav-link">Orders</a>
                <form action="/logout" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-secondary btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container">
        <%
            Order order = (Order) request.getAttribute("order");
            if (order == null) {
        %>
            <div class="alert alert-error">
                <p>Order not found</p>
                <a href="/admin/orders" class="btn btn-primary">Back to Orders</a>
            </div>
        <%
            } else {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
        %>

        <div class="page-header">
            <div>
                <h1>Order #<%= order.getId() %></h1>
                <p>Placed on <%= order.getCreatedAt().format(formatter) %></p>
            </div>
            <a href="/admin/orders" class="btn btn-secondary">← Back to Orders</a>
        </div>

        <div class="order-details-container">
            <!-- Left Column -->
            <div class="details-left">
                <!-- Customer Info -->
                <div class="detail-card">
                    <h3>👤 Customer Information</h3>
                    <div class="info-row">
                        <span>Name:</span>
                        <strong><%= order.getUser().getFullName() %></strong>
                    </div>
                    <div class="info-row">
                        <span>Email:</span>
                        <strong><%= order.getUser().getEmail() %></strong>
                    </div>
                    <div class="info-row">
                        <span>Username:</span>
                        <strong><%= order.getUser().getUsername() %></strong>
                    </div>
                </div>

                <!-- Shipping Info -->
                <div class="detail-card">
                    <h3>📍 Shipping Information</h3>
                    <div class="info-row">
                        <span>Phone:</span>
                        <strong><%= order.getPhone() %></strong>
                    </div>
                    <div class="info-row">
                        <span>Address:</span>
                        <p><%= order.getShippingAddress() %></p>
                    </div>
                </div>

                <!-- Order Items -->
                <div class="detail-card">
                    <h3>📦 Order Items</h3>
                    <table class="items-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Qty</th>
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
            </div>

            <!-- Right Column -->
            <div class="details-right">
                <!-- Status Card -->
                <div class="detail-card status-card">
                    <h3>📊 Order Status</h3>
                    <div class="current-status">
                        <span class="badge badge-<%= order.getStatus().name().toLowerCase() %>" 
                              style="font-size: 1.2em; padding: 10px 20px;">
                            <%= order.getStatus() %>
                        </span>
                    </div>

                    <h4 style="margin-top: 1.5rem; margin-bottom: 1rem;">Update Status:</h4>
                    <form action="/admin/orders/updateStatus/<%= order.getId() %>" method="post">
                        <select name="status" class="form-control" style="margin-bottom: 1rem;">
                            <option value="PENDING" <%= order.getStatus() == Order.OrderStatus.PENDING ? "selected" : "" %>>Pending</option>
                            <option value="APPROVED" <%= order.getStatus() == Order.OrderStatus.APPROVED ? "selected" : "" %>>Approved</option>
                            <option value="PROCESSING" <%= order.getStatus() == Order.OrderStatus.PROCESSING ? "selected" : "" %>>Processing</option>
                            <option value="SHIPPED" <%= order.getStatus() == Order.OrderStatus.SHIPPED ? "selected" : "" %>>Shipped</option>
                            <option value="DELIVERED" <%= order.getStatus() == Order.OrderStatus.DELIVERED ? "selected" : "" %>>Delivered</option>
                            <option value="CANCELLED" <%= order.getStatus() == Order.OrderStatus.CANCELLED ? "selected" : "" %>>Cancelled</option>
                            <option value="REJECTED" <%= order.getStatus() == Order.OrderStatus.REJECTED ? "selected" : "" %>>Rejected</option>
                        </select>
                        <button type="submit" class="btn btn-primary btn-block">Update Status</button>
                    </form>
                </div>

                <!-- Price Summary -->
                <div class="detail-card">
                    <h3>💰 Price Details</h3>
                    <div class="info-row">
                        <span>Subtotal:</span>
                        <strong>₹<%= String.format("%.2f", order.getSubtotal()) %></strong>
                    </div>
                    <div class="info-row">
                        <span>GST (18%):</span>
                        <strong>₹<%= String.format("%.2f", order.getGst()) %></strong>
                    </div>
                    <div class="info-row">
                        <span>Delivery:</span>
                        <strong class="text-success">FREE</strong>
                    </div>
                    <hr>
                    <div class="info-row" style="font-size: 1.2em;">
                        <span>Total:</span>
                        <strong style="color: #667eea;">₹<%= String.format("%.2f", order.getTotal()) %></strong>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="detail-card">
                    <h3>⚡ Quick Actions</h3>
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <% if (order.getStatus() == Order.OrderStatus.PENDING) { %>
                            <form action="/admin/orders/approve/<%= order.getId() %>" method="post">
                                <button type="submit" class="btn btn-success btn-block">✓ Approve Order</button>
                            </form>
                            <form action="/admin/orders/reject/<%= order.getId() %>" method="post"
                                  onsubmit="return confirm('Reject this order?');">
                                <button type="submit" class="btn btn-danger btn-block">✗ Reject Order</button>
                            </form>
                        <% } else if (order.getStatus() == Order.OrderStatus.APPROVED || 
                                      order.getStatus() == Order.OrderStatus.PROCESSING) { %>
                            <form action="/admin/orders/ship/<%= order.getId() %>" method="post">
                                <button type="submit" class="btn btn-warning btn-block">🚚 Mark as Shipped</button>
                            </form>
                        <% } else if (order.getStatus() == Order.OrderStatus.SHIPPED) { %>
                            <form action="/admin/orders/deliver/<%= order.getId() %>" method="post">
                                <button type="submit" class="btn btn-success btn-block">✓ Mark as Delivered</button>
                            </form>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <% } %>
    </div>

    <style>
        .order-details-container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }

        .detail-card {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 1.5rem;
        }

        .detail-card h3 {
            color: #333;
            margin-bottom: 1rem;
            padding-bottom: 0.8rem;
            border-bottom: 2px solid #f0f0f0;
        }

        .detail-card h4 {
            color: #666;
            font-size: 0.95em;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 0.8rem 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-row span {
            color: #666;
        }

        .info-row strong, .info-row p {
            color: #333;
        }

        .current-status {
            text-align: center;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .items-table {
            width: 100%;
            margin-top: 1rem;
        }

        .items-table th {
            background: #f8f9fa;
            padding: 0.8rem;
            text-align: left;
            font-size: 0.9em;
        }

        .items-table td {
            padding: 0.8rem;
            border-bottom: 1px solid #f0f0f0;
        }

        @media (max-width: 968px) {
            .order-details-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</body>
</html>