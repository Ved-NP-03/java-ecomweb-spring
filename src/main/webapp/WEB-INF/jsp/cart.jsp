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
    <div class="container">
        <h1>🛒 Your Shopping Cart</h1>

        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <p>Your cart is empty.</p>
                <a href="/products" class="btn btn-primary">Start Shopping</a>
            </div>
        <%
            } else {
        %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Price (₹)</th>
                    <th>Quantity</th>
                    <th>Total (₹)</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                        CartItem ci = entry.getValue();
                %>
                <tr>
                    <td><%= ci.getItem().getId() %></td>
                    <td><%= ci.getItem().getName() %></td>
                    <td>₹<%= String.format("%.2f", ci.getItem().getPrice()) %></td>
                    <td><%= ci.getQuantity() %></td>
                    <td>₹<%= String.format("%.2f", ci.getLineTotal()) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

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
                <button type="submit" class="btn btn-danger">Clear Cart</button>
            </form>
            <a href="/checkout" class="btn btn-primary">Proceed to Checkout</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>