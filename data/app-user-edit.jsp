<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<style>
body{
    font-family:"Segoe UI",Arial,sans-serif;
    background:#f4f6f9;
    margin:35px;
    color:#333;
}

h2{
    font-size:28px;
    margin-bottom:20px;
    font-weight:600;
}

form{
    background:white;
    padding:30px;
    width:460px;
    border-radius:10px;
    box-shadow:0 4px 15px rgba(0,0,0,0.08);
}

label{
    font-weight:500;
    font-size:15px;
    display:block;
    margin-bottom:6px;
}

input[type=text],
input[type=email],
input[type=password]{
    width:100%;
    padding:10px 12px;
    margin-top:5px;
    margin-bottom:18px;
    border:1px solid #ddd;
    border-radius:6px;
    font-size:14px;
    box-sizing:border-box;
}

input:focus{
    outline:none;
    border-color:#ee4d2d;
}

button,
input[type=submit]{
    background:#ee4d2d;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:6px;
    font-size:14px;
    cursor:pointer;
    transition:0.2s;
}

button:hover,
input[type=submit]:hover{
    background:#d73211;
}

a{
    color:#1a73e8;
    text-decoration:none;
}

a:hover{
    text-decoration:underline;
}

.error-box{
    background:#fff1f0;
    color:#cf1322;
    border:1px solid #ffa39e;
    padding:10px 12px;
    border-radius:8px;
    margin-bottom:16px;
}

.note{
    font-size:13px;
    color:#666;
    margin-top:-12px;
    margin-bottom:16px;
}
</style>
</head>
<body>

<jsp:include page="header.jsp" />

<h2>
    <c:choose>
        <c:when test="${isOwnProfile}">Edit My Profile</c:when>
        <c:otherwise>Edit User</c:otherwise>
    </c:choose>
</h2>

<form action="app-user-edit" method="post">
    <input type="hidden" name="id" value="${user.userId}">

    <c:if test="${not empty error}">
        <div class="error-box">${error}</div>
    </c:if>

    <label>Name:</label>
    <input type="text" name="name" value="${user.name}" required>

    <label>Email:</label>
    <input type="email" name="email" value="${user.email}" readonly>

    <c:if test="${isOwnProfile}">
        <hr style="margin:18px 0; border:0; border-top:1px solid #eee;">
        <h3 style="margin-top:0;">Đổi mật khẩu</h3>
        <div class="note">Chỉ chính chủ tài khoản mới được đổi mật khẩu. Nếu không đổi thì để trống 3 ô dưới.</div>

        <label>Mật khẩu cũ:</label>
        <input type="password" name="oldPassword">

        <label>Mật khẩu mới:</label>
        <input type="password" name="newPassword" minlength="8">
        <div class="note">Mật khẩu mới tối thiểu 8 ký tự.</div>

        <label>Xác nhận mật khẩu mới:</label>
        <input type="password" name="confirmPassword" minlength="8">
    </c:if>

    <input type="submit" value="Update">
</form>

</body>
</html>
