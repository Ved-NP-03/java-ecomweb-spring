<%@ page import="com.ecom.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users - Admin</title>
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
            <h1>User Management</h1>
            <p>View and manage registered users</p>
        </div>

        <%
            List<User> users = (List<User>) request.getAttribute("users");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
            
            if (users == null || users.isEmpty()) {
        %>
            <div class="empty-state">
                <div class="empty-icon">👥</div>
                <h2>No Users Found</h2>
            </div>
        <%
            } else {
        %>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Username</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Joined</th>
                        <th>Orders</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (User user : users) { %>
                    <tr>
                        <td>#<%= user.getId() %></td>
                        <td><strong><%= user.getFullName() %></strong></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getUsername() %></td>
                        <td><%= user.getPhone() != null ? user.getPhone() : "-" %></td>
                        <td>
                            <% if (user.getRole() == User.Role.ADMIN) { %>
                                <span class="badge badge-approved">ADMIN</span>
                            <% } else { %>
                                <span class="badge badge-pending">USER</span>
                            <% } %>
                        </td>
                        <td>
                            <% if (user.isEnabled()) { %>
                                <span class="badge badge-delivered">Active</span>
                            <% } else { %>
                                <span class="badge badge-cancelled">Disabled</span>
                            <% } %>
                        </td>
                        <td><%= user.getCreatedAt() != null ? user.getCreatedAt().format(formatter) : "-" %></td>
                        <td>
                            <span class="badge" style="background: #e3f2fd; color: #1976d2;">
                                <%= user.getOrders().size() %> orders
                            </span>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="user-stats">
            <h3>User Statistics</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-value">
                        <%= users.stream().filter(u -> u.getRole() == User.Role.USER).count() %>
                    </div>
                    <div class="stat-label">Regular Users</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">
                        <%= users.stream().filter(u -> u.getRole() == User.Role.ADMIN).count() %>
                    </div>
                    <div class="stat-label">Admins</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">
                        <%= users.stream().filter(User::isEnabled).count() %>
                    </div>
                    <div class="stat-label">Active</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">
                        <%= users.stream().filter(u -> !u.isEnabled()).count() %>
                    </div>
                    <div class="stat-label">Disabled</div>
                </div>
            </div>
        </div>

        <% } %>
    </div>

    <style>
        .user-stats {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-top: 2rem;
        }

        .user-stats h3 {
            color: #333;
            margin-bottom: 1.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .stat-item {
            text-align: center;
            padding: 1.5rem;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .stat-value {
            font-size: 2.5em;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #666;
            font-size: 0.95em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
    </style>
</body>
</html>