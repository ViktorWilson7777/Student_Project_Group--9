<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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
</style>
</head>
<body>

<div class="header">
    <div class="header-left">
        <div class="logo">S</div>
        <div class="brand">Shopbee</div>
        <div class="page-name">Login</div>
    </div>

    <div class="header-right">
        <a href="#">Need help?</a>
    </div>
</div>

<div class="main-container">

    <div class="form-box">
        <h2>Login</h2>

        <c:if test="${not empty error}">
            <div class="error-box">${error}</div>
        </c:if>

        <form action="login" method="post">
            <input type="text" name="username"
                   placeholder="Email / Phone / Username"
                   value="${username}" required>

            <input type="password" name="password"
                   placeholder="Password" required>

            <button type="submit" class="btn-primary">
                LOG IN
            </button>
        </form>

        <div class="form-links">
            <a href="#">Forgot password?</a>
        </div>

        <div class="bottom-text">
            New to Shopee?
            <a href="register">Sign Up</a>
        </div>
    </div>

</div>

</body>
</html>
