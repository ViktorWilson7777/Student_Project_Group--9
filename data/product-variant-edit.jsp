<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product Variant</title>
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
</style>
</head>
<body>

<h2>Edit Product Variant</h2>

<form action="product-variant-edit" method="post">

    <input type="hidden" name="variantId" value="${variant.variantId}">

    <label>Product ID:</label>
    <input type="number" value="${variant.product.productId}" readonly>

    <label>Size:</label>
    <input type="text" name="size" value="${variant.size}" required>

    <label>Color:</label>
    <input type="text" name="color" value="${variant.color}" required>

    <label>Stock:</label>
    <input type="number" name="stock" value="${variant.stock}" min="0" required>

    <label>Price:</label>
    <input type="number" step="0.01" min="0" name="priceVariant" value="${variant.priceVariant}" required>

    <button type="submit">Update</button>
</form>

<br>
<a href="product-variant-list">Back</a>

</body>
</html>
