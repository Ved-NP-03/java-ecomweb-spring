<%@ page import="com.ecom.model.Cart" %>
<%@ page import="com.ecom.model.CartItem" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - E-commerce Store</title>
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
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>Your Shopping Cart</h1>
        </div>

        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <div class="empty-cart-icon">🛒</div>
                <p>Your cart is empty</p>
                <p style="color: #999; font-size: 1em;">Start adding some amazing products!</p>
                <br>
                <a href="/products" class="btn btn-primary">Start Shopping</a>
            </div>
        <%
            } else {
        %>
        <div class="cart-table-container">
            <table>
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                            CartItem ci = entry.getValue();
                    %>
                    <tr>
                        <td>
                            <strong><%= ci.getItem().getName() %></strong><br>
                            <small style="color: #999;">ID: #<%= ci.getItem().getId() %></small>
                        </td>
                        <td>₹<%= String.format("%.2f", ci.getItem().getPrice()) %></td>
                        <td>
                            <div class="qty-controls">
                                <form action="/decreaseQty" method="post" style="display: inline;">
                                    <input type="hidden" name="id" value="<%= ci.getItem().getId() %>">
                                    <button type="submit" class="qty-btn">−</button>
                                </form>
                                <span class="qty-display"><%= ci.getQuantity() %></span>
                                <form action="/increaseQty" method="post" style="display: inline;">
                                    <input type="hidden" name="id" value="<%= ci.getItem().getId() %>">
                                    <button type="submit" class="qty-btn">+</button>
                                </form>
                            </div>
                        </td>
                        <td><strong>₹<%= String.format("%.2f", ci.getLineTotal()) %></strong></td>
                        <td>
                            <form action="/removeFromCart" method="post" style="display: inline;">
                                <input type="hidden" name="id" value="<%= ci.getItem().getId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="cart-summary">
            <div class="summary-row">
                <span>Subtotal:</span>
                <strong>₹<%= String.format("%.2f", cart.getSubtotal()) %></strong>
            </div>
            <div class="summary-row">
                <span>GST (18%):</span>
                <strong>₹<%= String.format("%.2f", cart.getGST()) %></strong>
            </div>
            <div class="summary-row total">
                <span>Grand Total:</span>
                <strong>₹<%= String.format("%.2f", cart.getGrandTotal()) %></strong>
            </div>
        </div>

        <div class="cart-actions">
            <a href="/products" class="btn btn-secondary">Continue Shopping</a>
            <form action="/clearCart" method="post" style="display: inline;">
                <button type="submit" class="btn btn-warning">Clear Cart</button>
            </form>
            <a href="/checkout" class="btn btn-success">Proceed to Checkout →</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>