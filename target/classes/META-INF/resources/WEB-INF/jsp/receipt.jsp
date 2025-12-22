<%@ page import="com.ecom.model.Cart" %>
<%@ page import="com.ecom.model.CartItem" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Receipt - E-commerce Store</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-content">
            <a href="/" class="navbar-brand">
                🛍️ ShopEasy
            </a>
        </div>
    </nav>

    <div class="container">
        <div class="receipt">
            <%
                LocalDateTime now = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                String dateTime = now.format(formatter);
            %>
            
            <div class="receipt-header">
                <h1>📄 Order Receipt</h1>
                <p><strong>ShopEasy Store</strong></p>
                <p>Date: <%= dateTime %></p>
                <p>Order #: SE<%= System.currentTimeMillis() % 100000 %></p>
            </div>

            <%
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>
                <div class="empty-cart">
                    <p>No items to display.</p>
                    <a href="/products" class="btn btn-primary">Back to Products</a>
                </div>
            <%
                } else {
            %>
            <table>
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                            CartItem ci = entry.getValue();
                    %>
                    <tr>
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
                    <span>Total Paid:</span>
                    <strong>₹<%= String.format("%.2f", cart.getGrandTotal()) %></strong>
                </div>
            </div>

            <div class="receipt-footer">
                <div class="success-icon"></div>
                <p><strong>Payment Successful!</strong></p>
                <p>Thank you for shopping   </p>
            </div>

            <div class="cart-actions">
                <a href="/products" class="btn btn-primary">Shop Again</a>
                <button onclick="window.print()" class="btn btn-secondary">🖨️ Print Receipt</button>
            </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>