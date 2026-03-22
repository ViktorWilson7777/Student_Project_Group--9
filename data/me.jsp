<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Account</title>
    <style>
        body{margin:0;font-family:"Segoe UI",Arial,sans-serif;background:#f5f5f5;}
        .page{max-width:1280px;margin:26px auto;display:flex;gap:24px;padding:0 20px;}
        .sidebar{width:290px;background:#fff;border-radius:10px;box-shadow:0 2px 10px rgba(0,0,0,0.06);padding:26px;height:fit-content;}
        .userbox{display:flex;gap:16px;align-items:center;border-bottom:1px solid #eee;padding-bottom:18px;margin-bottom:18px;}
        .avatar{width:64px;height:64px;border-radius:50%;background:#ddd;}
        .sidebar a{display:block;padding:12px 0;color:#333;text-decoration:none;border-bottom:1px solid #f0f0f0;}
        .sidebar a.active{color:#ee4d2d;font-weight:700;}
        .content{flex:1;background:#fff;border-radius:10px;box-shadow:0 2px 10px rgba(0,0,0,0.06);padding:30px;}
        h1{margin:0 0 10px;font-size:28px;}
        .desc{color:#666;margin-bottom:28px;}
        .section-title{font-size:18px;font-weight:700;margin:24px 0 18px;}
        .form-row{display:grid;grid-template-columns:170px 1fr;align-items:center;gap:22px;margin-bottom:16px;}
        .form-row label{font-size:16px;font-weight:600;color:#444;}
        .form-row input{height:48px;border:1px solid #ddd;border-radius:8px;padding:0 14px;font-size:16px;outline:none;}
        .readonly{background:#f8f8f8;}
        .btn{margin-top:4px;background:#ee4d2d;color:#fff;border:none;border-radius:8px;height:46px;padding:0 24px;font-size:16px;font-weight:700;cursor:pointer;}
        .msg{padding:12px 14px;border-radius:8px;margin-bottom:18px;font-size:15px;}
        .msg.success{background:#edf9f0;color:#1f7a35;}
        .msg.error{background:#fff0f0;color:#c62828;}
    </style>
</head>
<body>
<jsp:include page="user/user-header.jsp"/>
<div class="page">
    <div class="sidebar">
        <div class="userbox">
            <div class="avatar"></div>
            <div>
                <div style="font-size:18px;font-weight:700;">${user.name}</div>
                <div style="color:#666;">${user.email}</div>
            </div>
        </div>
        <a href="me" class="active">My Account</a>
        <a href="order">Order</a>
    </div>
    <div class="content">
        <h1>My Account</h1>
        <div class="desc">Manage your profile information and password.</div>
        <c:if test="${not empty success}"><div class="msg success">${success}</div></c:if>
        <c:if test="${not empty error}"><div class="msg error">${error}</div></c:if>
        <div class="section-title">Profile Information</div>
        <form action="me" method="post">
            <input type="hidden" name="action" value="profile">
            <div class="form-row"><label>Name</label><input type="text" name="name" value="${user.name}" required></div>
            <div class="form-row"><label>Email</label><input type="text" value="${user.email}" readonly class="readonly"></div>
            <button type="submit" class="btn">Save Profile</button>
        </form>
        <div class="section-title">Change Password</div>
        <form action="me" method="post">
            <input type="hidden" name="action" value="password">
            <div class="form-row"><label>Old Password</label><input type="password" name="oldPassword" required></div>
            <div class="form-row"><label>New Password</label><input type="password" name="newPassword" required></div>
            <div class="form-row"><label>Confirm Password</label><input type="password" name="confirmPassword" required></div>
            <button type="submit" class="btn">Change Password</button>
        </form>
    </div>
</div>
</body>
</html>
