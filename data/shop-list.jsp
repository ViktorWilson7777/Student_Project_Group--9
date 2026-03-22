<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Shop List</title>
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

<h2>Shop List</h2>

<a href="shop-create.jsp"><button>Create New Shop</button></a>

<form onsubmit="searchShop(event)">
    <input type="text" name="keyword" id="shopKeyword" value="${keyword}">
    <button type="submit">Search</button>
</form>

<br>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Shop Name</th>
            <th>Owner ID</th>
            <th>Owner Name</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody id="shopTable">
        <c:forEach items="${list}" var="s">
            <tr>
                <td>${s.shopId}</td>
                <td>${s.shopName}</td>
                <td>${s.owner.userId}</td>
                <td>${s.owner.name}</td>
                <td>
                    <a href="shop-edit?id=${s.shopId}">Edit</a> |
                    <a href="shop-delete?id=${s.shopId}">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
var page = ${page};
var loading = false;

window.onscroll = function () {
    if (loading) return;

    if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 100) {
        loading = true;
        page++;

        const keyword = encodeURIComponent(document.getElementById("shopKeyword").value || "");

        fetch("shop-list?page=" + page + "&keyword=" + keyword)
            .then(res => res.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, "text/html");
                const rows = doc.querySelectorAll("table tbody tr");
                const table = document.querySelector("#shopTable");
                rows.forEach(r => table.appendChild(r));
                loading = false;
            })
            .catch(() => loading = false);
    }
}
</script>

<script>
function searchShop(e){
    e.preventDefault();

    const keyword = document.getElementById("shopKeyword").value;

    fetch("shop-list?keyword=" + encodeURIComponent(keyword))
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
</body>
</html>
