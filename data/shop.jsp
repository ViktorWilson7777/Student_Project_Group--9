<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${shop.shopName}</title>
    <style>
        body{margin:0;font-family:"Segoe UI",Arial,sans-serif;background:#f5f5f5;}
        .wrap{max-width:1280px;margin:26px auto 40px;padding:0 20px;}
        .shop-box{background:#fff;border-radius:10px;padding:28px;box-shadow:0 2px 10px rgba(0,0,0,0.06);margin-bottom:24px;}
        .shop-name{font-size:28px;font-weight:700;margin-bottom:14px;}
        .shop-owner{font-size:16px;color:#555;}
        .product-grid{display:grid;grid-template-columns:repeat(4, minmax(240px, 1fr));gap:24px;}
        .product-card{background:#fff;border-radius:10px;overflow:hidden;box-shadow:0 2px 10px rgba(0,0,0,0.06);text-decoration:none;color:#222;}
        .product-img{width:100%;height:240px;object-fit:cover;background:#f0f0f0;display:block;}
        .product-info{padding:16px;}
        .product-title{font-size:18px;font-weight:700;margin-bottom:12px;min-height:48px;}
        .price{font-size:18px;color:#ee4d2d;font-weight:700;}
    </style>
</head>
<body>
<jsp:include page="user/user-header.jsp"/>
<div class="wrap">
    <div class="shop-box">
        <div class="shop-name">${shop.shopName}</div>
        <div class="shop-owner"><strong>Owner:</strong> ${shop.owner.name}</div>
    </div>
    <div class="product-grid">
        <c:forEach var="p" items="${products}">
            <a class="product-card" href="product-detail?productId=${p.productId}">
                <img class="product-img" src="${p.imageUrl}" alt="${p.name}">
                <div class="product-info">
                    <div class="product-title">${p.name}</div>
                    <div class="price">${p.price} VND</div>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
</body>
</html>
