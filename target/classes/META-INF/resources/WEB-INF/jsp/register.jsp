<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - ShopEasy</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>🛍️ ShopEasy</h1>
                <p>Create your account</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="/register" method="post" class="auth-form">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" name="fullName" required 
                           class="form-control" placeholder="Enter your full name">
                </div>

                <div class="form-group">
                    <label>Username *</label>
                    <input type="text" name="username" required 
                           class="form-control" placeholder="Choose a username" minlength="3">
                </div>

                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" name="email" required 
                           class="form-control" placeholder="Enter your email">
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="tel" name="phone" 
                           class="form-control" placeholder="Enter your phone number">
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <textarea name="address" class="form-control" rows="2" 
                              placeholder="Enter your address"></textarea>
                </div>

                <div class="form-group">
                    <label>Password *</label>
                    <input type="password" name="password" required 
                           class="form-control" placeholder="Choose a password" minlength="6">
                </div>

                <button type="submit" class="btn btn-primary btn-block">Register</button>
            </form>

            <div class="auth-footer">
                <p>Already have an account? <a href="/login">Login here</a></p>
            </div>
        </div>
    </div>
</body>
</html>