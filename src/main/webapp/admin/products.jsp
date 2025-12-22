<%@ page import="com.ecom.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Products - Admin</title>
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
            <div>
                <h1>Product Management</h1>
                <p>Manage your product inventory</p>
            </div>
            <a href="/admin/products/add" class="btn btn-primary">➕ Add New Product</a>
        </div>

        <% if (request.getParameter("success") != null) { 
            String success = request.getParameter("success");
            String message = "";
            if ("added".equals(success)) message = "Product added successfully!";
            else if ("updated".equals(success)) message = "Product updated successfully!";
            else if ("deleted".equals(success)) message = "Product deleted successfully!";
        %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>

        <%
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products == null || products.isEmpty()) {
        %>
            <div class="empty-state">
                <div class="empty-icon">📦</div>
                <h2>No Products Yet</h2>
                <p>Start by adding your first product</p>
                <a href="/admin/products/add" class="btn btn-primary">Add Product</a>
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
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Product product : products) { %>
                    <tr>
                        <td>#<%= product.getId() %></td>
                        <td>
                            <strong><%= product.getName() %></strong><br>
                            <small style="color: #999;"><%= product.getDescription() != null ? 
                                (product.getDescription().length() > 50 ? 
                                product.getDescription().substring(0, 50) + "..." : 
                                product.getDescription()) : "" %></small>
                        </td>
                        <td><%= product.getCategory() != null ? product.getCategory() : "-" %></td>
                        <td><strong>₹<%= String.format("%.2f", product.getPrice()) %></strong></td>
                        <td>
                            <% if (product.getStock() <= 10) { %>
                                <span style="color: #dc3545; font-weight: bold;"><%= product.getStock() %></span>
                            <% } else { %>
                                <%= product.getStock() %>
                            <% } %>
                        </td>
                        <td>
                            <% if (product.isActive()) { %>
                                <span class="badge badge-delivered">Active</span>
                            <% } else { %>
                                <span class="badge badge-cancelled">Inactive</span>
                            <% } %>
                        </td>
                        <td>
                            <div style="display: flex; gap: 5px;">
                                <a href="/admin/products/edit/<%= product.getId() %>" 
                                   class="btn btn-sm btn-info">Edit</a>
                                
                                <form action="/admin/products/toggle/<%= product.getId() %>" 
                                      method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-sm btn-warning">
                                        <%= product.isActive() ? "Disable" : "Enable" %>
                                    </button>
                                </form>
                                
                                <form action="/admin/products/delete/<%= product.getId() %>" 
                                      method="post" style="display: inline;"
                                      onsubmit="return confirm('Are you sure you want to delete this product?');">
                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                </form>
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
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .empty-icon {
            font-size: 5em;
            margin-bottom: 1rem;
        }

        .empty-state h2 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: #666;
            margin-bottom: 2rem;
        }
    </style>
</body>
</html>