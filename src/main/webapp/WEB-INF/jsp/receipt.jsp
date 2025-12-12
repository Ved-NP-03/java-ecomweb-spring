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
    <div class="container">
        <div class="receipt">
            <h1> Bill Receipt</h1>
            
            <%
                LocalDateTime now = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                String dateTime = now.format(formatter);
            %>
            
            <div class="receipt-header">
                <p><strong>E-commerce Store</strong></p>
                <p>Date & Time: <%= dateTime %></p>
                <p>Receipt #: <%= System.currentTimeMillis() % 100000 %></p>
            </div>

            <%
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>
                <p>No items to display.</p>
                <a href="/products" class="btn btn-primary">Back to Products</a>
            <%
                } else {
            %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
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
                        <td><%= ci.getItem().getId() %></td>
                        <td><%= ci.getItem().getName() %></td>
                        <td>₹<%= String.format("%.2f", ci.getItem().getPrice()) %></td>
                        <td><%= ci.getQuantity() %></td>
                        <td>₹<%= String.format("%.2f", ci.getLineTotal()) %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="receipt-summary">
                <div class="summary-row">
                    <span>Subtotal:</span>
                    <strong>₹<%= String.format("%.2f", cart.getSubtotal()) %></strong>
                </div>
                <div class="summary-row">
                    <span>GST (18%):</span>
                    <strong>₹<%= String.format("%.2f", cart.getGST()) %></strong>
                </div>
                <div class="summary-row total">
                    <span>Total Payable:</span>
                    <strong>₹<%= String.format("%.2f", cart.getGrandTotal()) %></strong>
                </div>
            </div>

            <div class="receipt-footer">
                <p><strong>Payment Successful</strong></p>
                <p>Thank you for shopping with us!</p>
            </div>

            <div class="cart-actions">
                <a href="/products" class="btn btn-primary">Shop Again</a>
                <button onclick="window.print()" class="btn btn-secondary">Print Receipt</button>
            </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>