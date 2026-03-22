<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Success</title>
    <style>
        body{margin:0;font-family:"Segoe UI", Arial, sans-serif;background:#f5f5f5;}
        .success-container{min-height:100vh;display:flex;justify-content:center;align-items:center;padding:20px;}
        .success-box{width:100%;max-width:650px;background:#fff;border-radius:12px;box-shadow:0 4px 16px rgba(0,0,0,0.08);padding:40px 30px;text-align:center;}
        .icon{width:90px;height:90px;margin:0 auto 20px;border-radius:50%;background:#e8f8ee;color:#18a957;display:flex;align-items:center;justify-content:center;font-size:42px;font-weight:bold;}
        h1{margin:0 0 12px;color:#222;font-size:32px;}
        p{margin:0 0 30px;color:#666;font-size:18px;}
        .btn-group{display:flex;justify-content:center;gap:16px;flex-wrap:wrap;}
        .btn{min-width:180px;height:48px;border:none;border-radius:8px;font-size:16px;font-weight:600;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;justify-content:center;transition:0.2s;}
        .btn-home{background:#ee4d2d;color:#fff;}
        .btn-home:hover{background:#d73211;}
        .btn-order{background:#fff;color:#ee4d2d;border:1px solid #ee4d2d;}
        .btn-order:hover{background:#fff3f0;}
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-box">
            <div class="icon">✓</div>
            <h1>Order placed successfully!</h1>
            <p>Your order has been created successfully.</p>
            <div class="btn-group">
                <a href="user-home" class="btn btn-home">Continue Shopping</a>
                <a href="order" class="btn btn-order">View Order</a>
            </div>
        </div>
    </div>
</body>
</html>
