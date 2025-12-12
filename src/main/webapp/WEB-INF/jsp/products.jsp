<%@ page import="java.util.List" %>
<%@ page import="com.ecom.model.Item" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products - E-commerce Store</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <div class="container">
        <h1> Product List</h1>
        <div class="nav-links">
            <a href="/viewCart" class="btn btn-secondary">   View Cart</a>
        </div>

        <%
            List<Item> products = (List<Item>) request.getAttribute("products");
        %>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Price (₹)</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (products != null) {
                        for (Item p : products) {
                %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getName() %></td>
                    <td>₹<%= String.format("%.2f", p.getPrice()) %></td>
                    <td>
                        <form action="/addToCart" method="post" style="display: inline;">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <input type="number" name="qty" value="1" min="1" max="99" class="qty-input" />
                    </td>
                    <td>
                            <button type="submit" class="btn btn-primary">Add to Cart</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>