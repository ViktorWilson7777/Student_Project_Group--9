<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Variant List</title>
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

<h2>Product Variant List</h2>

<c:choose>
    <c:when test="${viewMode == 'product'}">
        

        <div style="margin-bottom:10px;">
            <strong>Showing variants of Product ID: ${productId}</strong>
        </div>
    </c:when>
    <c:otherwise>
        <form onsubmit="searchVariant(event)">
            <input type="text" name="keyword" id="variantKeyword" value="${keyword}" placeholder="Search by product name or shop name">
            <button type="submit">Search</button>
        </form>
        <br>
    </c:otherwise>
</c:choose>

<table>
    <thead>
        <tr>
            <th>Variant ID</th>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Size</th>
            <th>Color</th>
            <th>Stock</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody id="variantTable">
        <c:forEach items="${variants}" var="v">
            <tr>
                <td>${v.variantId}</td>
                <td>${v.product.productId}</td>
                <td>${v.product.name}</td>
                <td>${v.size}</td>
                <td>${v.color}</td>
                <td>${v.stock}</td>
                <td>${v.priceVariant}</td>
                <td>
                    <a href="product-variant-edit?id=${v.variantId}">Edit</a> |
                    <a href="product-variant-delete?id=${v.variantId}"
                       onclick="return confirm('Delete this variant?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<div id="loading" style="display:none; text-align:center; padding:10px;">
    Loading...
</div>

<script>
var page = ${page};
var loading = false;
var done = false;

const viewMode = '${viewMode}';
const productId = '${productId}';

function searchVariant(e){
    e.preventDefault();

    const keyword = document.getElementById("variantKeyword").value;

    fetch("product-variant-list?keyword=" + encodeURIComponent(keyword))
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

function loadMoreVariant() {
    if (loading || done) return;

    loading = true;
    document.getElementById("loading").style.display = "block";

    const nextPage = page + 1;
    let url = "product-variant-list?page=" + nextPage;

    if (viewMode === "product" && productId !== "") {
        url += "&productId=" + encodeURIComponent(productId);
    } else {
        const keywordInput = document.getElementById("variantKeyword");
        const keyword = keywordInput ? keywordInput.value.trim() : "";
        url += "&keyword=" + encodeURIComponent(keyword);
    }

    fetch(url)
        .then(res => res.text())
        .then(html => {
            const temp = document.createElement("div");
            temp.innerHTML = html;

            const newRows = temp.querySelectorAll("#variantTable tr");
            const body = document.getElementById("variantTable");

            if (!newRows || newRows.length === 0) {
                done = true;
            } else {
                newRows.forEach(row => body.insertAdjacentHTML("beforeend", row.outerHTML));
                page = nextPage;

                if (newRows.length < 20) {
                    done = true;
                }
            }

            loading = false;
            document.getElementById("loading").style.display = "none";
        })
        .catch(err => {
            console.log("Load variant error:", err);
            loading = false;
            document.getElementById("loading").style.display = "none";
        });
}

window.addEventListener("scroll", function () {
    if ((window.innerHeight + window.scrollY) >= document.body.scrollHeight - 150) {
        loadMoreVariant();
    }
});
</script>

</body>
</html>