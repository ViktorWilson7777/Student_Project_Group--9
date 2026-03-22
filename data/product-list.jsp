<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <style>
body{
    font-family:"Segoe UI",Arial,sans-serif;
    background:#f4f6f9;
    margin:35px;
}

h2{
    font-size:28px;
    margin-bottom:20px;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    border-radius:8px;
    overflow:hidden;
    box-shadow:0 3px 12px rgba(0,0,0,0.08);
}

th{
    background:#ee4d2d;
    color:white;
    padding:12px;
    text-align:left;
}

td{
    padding:12px;
    border-bottom:1px solid #eee;
}

tr:hover{
    background:#f9f9f9;
}

button,
input[type=submit]{
    background:#ee4d2d;
    color:white;
    border:none;
    padding:6px 12px;
    border-radius:5px;
    cursor:pointer;
}

button:hover{
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

<h1>Product List</h1>
<div style="width:80%;margin-bottom:10px;">
    <a href="product-create"><button>Create Product</button></a>
</div>

<form onsubmit="searchProduct(event)">
    <input type="text" name="keyword" id="productKeyword" value="${keyword}">
    <button type="submit">Search</button>
</form>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Shop ID</th>
            <th>Shop</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody id="productTable">
        <c:forEach var="p" items="${list}">
            <tr>
                <td>${p.productId}</td>
                <td>${p.name}</td>
                <td><fmt:formatNumber value="${p.price}" pattern="#,#00"/> ₫</td>
                <td>${p.shop.shopId}</td>
                <td>${p.shop.shopName}</td>
                <td>
                    <a href="product-variant-list?productId=${p.productId}">View Variants</a> |
                    <a href="product-edit?id=${p.productId}">Edit</a> |
                    <a href="product-delete?id=${p.productId}">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
function searchProduct(e) {
    e.preventDefault();

    const keyword = document.getElementById("productKeyword").value;

    fetch("product-list?keyword=" + encodeURIComponent(keyword))
        .then(res => res.text())
        .then(html => {
            const container = document.getElementById("content-area");
            container.innerHTML = html;

            const scripts = container.querySelectorAll("script");
            scripts.forEach(s => {
                const newScript = document.createElement("script");
                newScript.text = s.text;
                document.body.appendChild(newScript);
            });
        });
}
</script>

<script>
var page = ${page};
var loading = false;

window.onscroll = function () {
    if (loading) return;

    if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 100) {
        loading = true;
        page++;

        const keyword = encodeURIComponent(document.getElementById("productKeyword").value || "");

        fetch("product-list?page=" + page + "&keyword=" + keyword)
            .then(res => res.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, "text/html");
                const rows = doc.querySelectorAll("table tbody tr");
                const table = document.querySelector("#productTable");
                rows.forEach(r => table.appendChild(r));
                loading = false;
            })
            .catch(() => loading = false);
    }
}
</script>
</body>
</html>
