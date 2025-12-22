<%@ page import="com.ecom.model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders - Admin</title>
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
                <a href="/admin/users" class="nav-link">Users</a>
                <form action="/logout" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-secondary btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>Order Management</h1>
            <p>Review and manage customer orders</p>
        </div>

        <% if (request.getParameter("success") != null) { 
            String success = request.getParameter("success");
            String message = "";
            if ("approved".equals(success)) message = "Order approved successfully!";
            else if ("rejected".equals(success)) message = "Order rejected!";
            else if ("shipped".equals(success)) message = "Order marked as shipped!";
            else if ("delivered".equals(success)) message = "Order marked as delivered!";
            else if ("updated".equals(success)) message = "Order status updated!";
        %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>

        <!-- Filter Buttons -->
        <div class="filter-buttons">
            <a href="/admin/orders" class="btn <%= request.getParameter("status") == null ? "btn-primary" : "btn-secondary" %>">
                All Orders
            </a>
            <a href="/admin/orders?status=pending" class="btn <%= "pending".equals(request.getParameter("status")) ? "btn-primary" : "btn-secondary" %>">
                Pending
            </a>
            <a href="/admin/orders?status=approved" class="btn <%= "approved".equals(request.getParameter("status")) ? "btn-primary" : "btn-secondary" %>">
                Approved
            </a>
            <a href="/admin/orders?status=processing" class="btn <%= "processing".equals(request.getParameter("status")) ? "btn-primary" : "btn-secondary" %>">
                Processing
            </a>
            <a href="/admin/orders?status=shipped" class="btn <%= "shipped".equals(request.getParameter("status")) ? "btn-primary" : "btn-secondary" %>">
                Shipped
            </a>
            <a href="/admin/orders?status=delivered" class="btn <%= "delivered".equals(request.getParameter("status")) ? "btn-primary" : "btn-secondary" %>">
                Delivered
            </a>
        </div>

        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
            
            if (orders == null || orders.isEmpty()) {
        %>
            <div class="empty-state">
                <div class="empty-icon">📦</div>
                <h2>No Orders Found</h2>
                <p>No orders match the selected filter</p>
            </div>
        <%
            } else {
        %>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Date</th>
                        <th>Items</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Order order : orders) { %>
                    <tr>
                        <td><strong>#<%= order.getId() %></strong></td>
                        <td>
                            <%= order.getUser().getFullName() %><br>
                            <small style="color: #999;"><%= order.getUser().getEmail() %></small>
                        </td>
                        <td><%= order.getCreatedAt().format(formatter) %></td>
                        <td><%= order.getOrderItems().size() %> items</td>
                        <td><strong>₹<%= String.format("%.2f", order.getTotal()) %></strong></td>
                        <td>
                            <span class="badge badge-<%= order.getStatus().name().toLowerCase() %>">
                                <%= order.getStatus() %>
                            </span>
                        </td>
                        <td>
                            <div style="display: flex; gap: 5px; flex-wrap: wrap;">
                                <a href="/admin/orders/<%= order.getId() %>" 
                                   class="btn btn-sm btn-info">View</a>
                                
                                <% if (order.getStatus() == Order.OrderStatus.PENDING) { %>
                                    <form action="/admin/orders/approve/<%= order.getId() %>" 
                                          method="post" style="display: inline;">
                                        <button type="submit" class="btn btn-sm btn-success">Approve</button>
                                    </form>
                                    <form action="/admin/orders/reject/<%= order.getId() %>" 
                                          method="post" style="display: inline;"
                                          onsubmit="return confirm('Reject this order?');">
                                        <button type="submit" class="btn btn-sm btn-danger">Reject</button>
                                    </form>
                                <% } else if (order.getStatus() == Order.OrderStatus.APPROVED || 
                                              order.getStatus() == Order.OrderStatus.PROCESSING) { %>
                                    <form action="/admin/orders/ship/<%= order.getId() %>" 
                                          method="post" style="display: inline;">
                                        <button type="submit" class="btn btn-sm btn-warning">Ship</button>
                                    </form>
                                <% } else if (order.getStatus() == Order.OrderStatus.SHIPPED) { %>
                                    <form action="/admin/orders/deliver/<%= order.getId() %>" 
                                          method="post" style="display: inline;">
                                        <button type="submit" class="btn btn-sm btn-success">Deliver</button>
                                    </form>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <% } %>
    </div>

    <style>
        .filter-buttons {
            display: flex;
            gap: 10px;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .filter-buttons .btn {
            font-size: 0.9em;
        }
    </style>
</body>
</html>