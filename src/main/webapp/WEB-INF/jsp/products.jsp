<%@ page import="java.util.List" %>
<%@ page import="com.ecom.model.Item" %>
<%@ page import="com.ecom.model.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop - E-commerce Store</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-content">
            <a href="/" class="navbar-brand">
                🛍️ ShopEasy
            </a>
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
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="page-header">
            <h1>Stationary Products</h1>
           
        </div>

        <%
            List<Item> products = (List<Item>) request.getAttribute("products");
        %>

        <div class="product-grid">
            <%
                if (products != null) {
                    for (Item p : products) {
            %>
            <div class="product-card">
                <div class="product-image">
                    <img src="/images/<%= p.getName().toLowerCase() %>.jpg" 
                         alt="<%= p.getName() %>" 
                         onerror="this.src='/images/default.jpg'">
                </div>
                <div class="product-info">
                    <div class="product-name"><%= p.getName() %></div>
                    
                    <div class="product-price">₹<%= String.format("%.2f", p.getPrice()) %></div>
                    
                    <form action="/addToCart" method="post">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <div class="product-actions">
                            <input type="number" name="qty" value="1" min="1" max="99" class="qty-input" />
                            <button type="submit" class="btn btn-primary">Add to Cart</button>
                        </div>
                    </form>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</body>
</html>