<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
<style>
.error-box{
    background:#fff1f0;
    color:#cf1322;
    border:1px solid #ffa39e;
    padding:10px 12px;
    border-radius:8px;
    margin-bottom:14px;
    font-size:14px;
}
.hint{
    font-size:12px;
    color:#666;
    margin-top:-10px;
    margin-bottom:14px;
}
</style>
</head>
<body>

<div class="header">
    <div class="header-left">
        <div class="logo">S</div>
        <div class="brand">Shopbee</div>
        <div class="page-name">Register</div>
    </div>

    <div class="header-right">
        <a href="#">Need help?</a>
    </div>
</div>

<div class="main-container">

    <div class="form-box">
        <h2>Register</h2>

        <c:if test="${not empty error}">
            <div class="error-box">${error}</div>
        </c:if>

        <form action="register" method="post">

            <input type="text" name="name"
                   placeholder="Full Name" value="${name}" required>

            <input type="email" name="email"
                   placeholder="Email"
                   value="${email}"
                   pattern="^[A-Za-z0-9+_.-]+@gmail\.com$"
                   title="Email phải có đuôi @gmail.com"
                   required>
            <div class="hint">Email phải có đuôi @gmail.com</div>

            <input type="password" name="password"
                   placeholder="Password"
                   minlength="8"
                   title="Mật khẩu tối thiểu 8 ký tự"
                   required>
            <div class="hint">Mật khẩu tối thiểu 8 ký tự</div>

            <button type="submit" class="btn-primary">
                SIGN UP
            </button>
        </form>

        <div class="bottom-text">
            Already have an account?
            <a href="login">Login</a>
        </div>
    </div>

</div>

</body>
</html>
