<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - ShopEasy</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>🛍️ ShopEasy</h1>
                <p>Login to your account</p>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-error">
                    Invalid username or password
                </div>
            <% } %>

            <% if (request.getParameter("logout") != null) { %>
                <div class="alert alert-success">
                    You have been logged out successfully
                </div>
            <% } %>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <form action="/login" method="post" class="auth-form">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required autofocus 
                           class="form-control" placeholder="Enter your username">
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required 
                           class="form-control" placeholder="Enter your password">
                </div>

                <button type="submit" class="btn btn-primary btn-block">Login</button>
            </form>

            <div class="auth-footer">
                <p>Don't have an account? <a href="/register">Register here</a></p>
            </div>

            <div class="demo-accounts">
                <p><strong>Demo Accounts:</strong></p>
                <p>👤 User: <code>user / user123</code></p>
                <p>👨‍💼 Admin: <code>admin / admin123</code></p>
            </div>
        </div>
    </div>
</body>
</html>