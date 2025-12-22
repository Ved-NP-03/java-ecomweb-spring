<%@ page import="com.ecom.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title><%= request.getAttribute("product") != null && 
                ((Product)request.getAttribute("product")).getId() != null ? 
                "Edit Product" : "Add Product" %> - Admin</title>
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
            Product product = (Product) request.getAttribute("product");
            boolean isEdit = product != null && product.getId() != null;
        %>

        <div class="page-header">
            <h1><%= isEdit ? "Edit Product" : "Add New Product" %></h1>
            <a href="/admin/products" class="btn btn-secondary">← Back to Products</a>
        </div>

        <div class="form-container">
            <form action="<%= isEdit ? "/admin/products/edit/" + product.getId() : "/admin/products/add" %>" 
                  method="post" class="product-form">
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Product Name *</label>
                        <input type="text" name="name" class="form-control" 
                               value="<%= product != null && product.getName() != null ? product.getName() : "" %>"
                               placeholder="Enter product name" required>
                    </div>

                    <div class="form-group">
                        <label>Category</label>
                        <input type="text" name="category" class="form-control"
                               value="<%= product != null && product.getCategory() != null ? product.getCategory() : "Stationary" %>"
                               placeholder="e.g., Stationary, Electronics">
                    </div>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" class="form-control" rows="3"
                              placeholder="Enter product description"><%= product != null && product.getDescription() != null ? product.getDescription() : "" %></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Price (₹) *</label>
                        <input type="number" name="price" class="form-control" step="0.01" min="0"
                               value="<%= product != null && product.getPrice() != null ? product.getPrice() : "" %>"
                               placeholder="0.00" required>
                    </div>

                    <div class="form-group">
                        <label>Stock Quantity *</label>
                        <input type="number" name="stock" class="form-control" min="0"
                               value="<%= product != null && product.getStock() != null ? product.getStock() : "0" %>"
                               placeholder="0" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Image URL</label>
                    <input type="text" name="imageUrl" class="form-control"
                           value="<%= product != null && product.getImageUrl() != null ? product.getImageUrl() : "" %>"
                           placeholder="/images/product.jpg">
                    <small style="color: #666;">Leave empty to use default image based on product name</small>
                </div>

                <div class="form-group">
                    <label class="checkbox-label">
                        <input type="checkbox" name="active" 
                               <%= product == null || product.isActive() ? "checked" : "" %>>
                        Active (Display in store)
                    </label>
                </div>

                <div class="form-actions">
                    <a href="/admin/products" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">
                        <%= isEdit ? "Update Product" : "Add Product" %>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <style>
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .product-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            font-weight: 600;
        }

        .checkbox-label input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 1rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</body>
</html>