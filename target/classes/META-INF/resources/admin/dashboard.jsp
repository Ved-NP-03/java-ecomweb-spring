<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - ShopEasy</title>
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
                <a href="/products" class="nav-link">Shop View</a>
                <form action="/logout" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-secondary btn-sm">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>Admin Dashboard</h1>
            <p>Welcome, <sec:authentication property="principal.username"/>! Here's your overview.</p>
        </div>

        <!-- Statistics Cards -->
        <div class="dashboard-stats">
            <div class="stat-card">
                <div class="stat-icon">⏳</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("pendingOrders") %></h3>
                    <p>Pending Orders</p>
                    <a href="/admin/orders?status=pending" class="btn btn-sm btn-primary">View</a>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("approvedOrders") %></h3>
                    <p>Approved Orders</p>
                    <a href="/admin/orders?status=approved" class="btn btn-sm btn-success">View</a>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">📦</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("totalProducts") %></h3>
                    <p>Total Products</p>
                    <a href="/admin/products" class="btn btn-sm btn-info">Manage</a>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">👥</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("totalUsers") %></h3>
                    <p>Total Users</p>
                    <a href="/admin/users" class="btn btn-sm btn-secondary">View</a>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions-section">
            <h2>Quick Actions</h2>
            <div class="quick-actions-grid">
                <a href="/admin/products/add" class="quick-action-card">
                    <div class="action-icon">➕</div>
                    <h3>Add Product</h3>
                    <p>Create new product</p>
                </a>

                <a href="/admin/orders?status=pending" class="quick-action-card">
                    <div class="action-icon">📋</div>
                    <h3>Review Orders</h3>
                    <p>Approve pending orders</p>
                </a>

                <a href="/admin/orders?status=shipped" class="quick-action-card">
                    <div class="action-icon">🚚</div>
                    <h3>Track Shipments</h3>
                    <p>View shipped orders</p>
                </a>

                <a href="/admin/products" class="quick-action-card">
                    <div class="action-icon">📊</div>
                    <h3>Manage Stock</h3>
                    <p>Update inventory</p>
                </a>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="recent-activity-section">
            <h2>System Info</h2>
            <div class="info-box">
                <p>✅ All systems operational</p>
                <p>📊 Database: Connected</p>
                <p>🔒 Security: Active</p>
                <p>⚡ Performance: Good</p>
            </div>
        </div>
    </div>

    <style>
        .quick-actions-section {
            margin: 3rem 0;
        }

        .quick-actions-section h2 {
            color: #333;
            margin-bottom: 1.5rem;
        }

        .quick-actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .quick-action-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            text-align: center;
            text-decoration: none;
            transition: all 0.3s;
        }

        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }

        .action-icon {
            font-size: 3em;
            margin-bottom: 1rem;
        }

        .quick-action-card h3 {
            color: #333;
            font-size: 1.2em;
            margin-bottom: 0.5rem;
        }

        .quick-action-card p {
            color: #666;
            font-size: 0.9em;
        }

        .recent-activity-section {
            margin: 3rem 0;
        }

        .recent-activity-section h2 {
            color: #333;
            margin-bottom: 1.5rem;
        }

        .info-box {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .info-box p {
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
            font-size: 1.1em;
        }

        .info-box p:last-child {
            border-bottom: none;
        }
    </style>
</body>
</html>