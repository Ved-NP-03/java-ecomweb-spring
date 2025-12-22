<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied - ShopEasy</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <div class="error-container">
        <div class="error-card">
            <div class="error-icon">🚫</div>
            <h1>Access Denied</h1>
            <p>You don't have permission to access this page.</p>
            <p class="error-details">This page is restricted to administrators only.</p>
            
            <div class="error-actions">
                <a href="/" class="btn btn-primary">Go to Home</a>
                <a href="/products" class="btn btn-secondary">Browse Products</a>
            </div>
            
            <div class="error-help">
                <p>If you believe this is an error, please contact support.</p>
            </div>
        </div>
    </div>

    <style>
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }

        .error-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            padding: 3rem;
            text-align: center;
            max-width: 500px;
        }

        .error-icon {
            font-size: 5em;
            margin-bottom: 1rem;
        }

        .error-card h1 {
            color: #dc3545;
            font-size: 2em;
            margin-bottom: 1rem;
        }

        .error-card p {
            color: #666;
            font-size: 1.1em;
            margin-bottom: 0.5rem;
        }

        .error-details {
            color: #999;
            font-size: 0.95em;
            margin-bottom: 2rem;
        }

        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-bottom: 2rem;
        }

        .error-help {
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }

        .error-help p {
            font-size: 0.9em;
            color: #999;
        }
    </style>
</body>
</html>