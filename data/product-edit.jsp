<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product</title>
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
}

form{
    background:white;
    padding:28px;
    width:450px;
    border-radius:10px;
    box-shadow:0 4px 15px rgba(0,0,0,0.08);
}

label{
    font-weight:500;
    display:block;
    margin-bottom:6px;
}

input,
select{
    width:100%;
    padding:10px 12px;
    border:1px solid #ddd;
    border-radius:6px;
    margin-bottom:18px;
    box-sizing:border-box;
}

input:focus,
select:focus{
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
    cursor:pointer;
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
</style>
</head>
<body>

<h2>Edit Product</h2>

<form action="product-edit" method="post">
    <input type="hidden" name="id" value="${product.productId}">

    <c:if test="${not empty error}">
        <div class="error-box">${error}</div>
    </c:if>

    <label>Product ID:</label>
    <input type="text" value="${product.productId}" readonly>

    <label>Product Name:</label>
    <input type="text" name="name" value="${product.name}" required>

    <label>Price:</label>
    <input type="number" step="0.01" min="0" name="price" value="${product.price}" required>

    <label>Shop:</label>
    <input type="text" value="${product.shop.shopName}" readonly>

    <input type="submit" value="Update Product">
</form>

<br>
<a href="home">Back</a>

</body>
</html>
