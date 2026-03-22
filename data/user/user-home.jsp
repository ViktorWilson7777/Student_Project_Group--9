<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Home - E-Commerce</title>
        <style>
            body{
                margin:0;
                font-family:"Segoe UI",Arial,sans-serif;
                background:#f5f5f5;
            }

            .wrap{
                max-width:1380px;
                margin:26px auto 40px;
                padding:0 20px;
            }

            .title{
                font-size:28px;
                font-weight:700;
                margin:0 0 26px;
                color:#222;
            }

            .product-grid{
                display:grid;
                grid-template-columns:repeat(4, minmax(260px, 1fr));
                gap:24px;
            }

            .product-card{
                background:#fff;
                border-radius:10px;
                overflow:hidden;
                box-shadow:0 2px 10px rgba(0,0,0,0.06);
                text-decoration:none;
                color:#222;
                transition:0.2s;
                display:flex;
                flex-direction:column;
            }

            .product-card:hover{
                transform:translateY(-3px);
                box-shadow:0 6px 18px rgba(0,0,0,0.1);
            }

            .product-img{
                width:100%;
                height:240px;
                object-fit:cover;
                background:#f0f0f0;
                display:block;
            }

            .product-info{
                padding:16px;
                display:flex;
                flex-direction:column;
                gap:10px;
            }

            .product-name{
                font-size:18px;
                font-weight:700;
                line-height:1.35;
                min-height:48px;
            }

            .shop-link{
                font-size:14px;
                color:#666;
                text-decoration:underline;
            }

            .price{
                font-size:18px;
                color:#ee4d2d;
                font-weight:700;
            }

            .pagination{
                margin-top:30px;
                display:flex;
                justify-content:center;
                align-items:center;
                gap:8px;
                flex-wrap:wrap;
            }

            .pagination a,
            .pagination span{
                min-width:42px;
                height:42px;
                padding:0 14px;
                border-radius:8px;
                display:flex;
                align-items:center;
                justify-content:center;
                text-decoration:none;
                font-weight:600;
                border:1px solid #ddd;
                background:#fff;
                color:#333;
                box-sizing:border-box;
            }

            .pagination a:hover{
                border-color:#ee4d2d;
                color:#ee4d2d;
            }

            .pagination .active{
                background:#ee4d2d;
                color:#fff;
                border-color:#ee4d2d;
            }

            .pagination .disabled{
                background:#f5f5f5;
                color:#aaa;
                border-color:#eee;
                pointer-events:none;
            }

            .pagination .dots{
                border:none;
                background:transparent;
                min-width:auto;
                padding:0 4px;
            }

            @media (max-width:1200px){
                .product-grid{
                    grid-template-columns:repeat(3, minmax(240px, 1fr));
                }
            }

            @media (max-width:900px){
                .product-grid{
                    grid-template-columns:repeat(2, minmax(220px, 1fr));
                }
            }

            @media (max-width:600px){
                .product-grid{
                    grid-template-columns:1fr;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="user-header.jsp"/>

        <div class="wrap">
            <h2 class="title">Recommend Products</h2>

            <div class="product-grid">
                <c:forEach var="p" items="${products}">
                    <div class="product-card">
                        <a href="${pageContext.request.contextPath}/product-detail?productId=${p.productId}">
                            <img class="product-img" src="${p.imageUrl}" alt="${p.name}">
                        </a>

                        <div class="product-info">
                            <a href="${pageContext.request.contextPath}/product-detail?productId=${p.productId}" style="text-decoration:none;color:#222;">
                                <div class="product-name">${p.name}</div>
                            </a>

                            <a class="shop-link" href="${pageContext.request.contextPath}/shop?shopId=${p.shop.shopId}">
                                Shop: ${p.shop.shopName}
                            </a>

                            <div class="price">${p.price} VND</div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${totalPages > 1}">
                <c:set var="startPage" value="${currentPage - 2}" />
                <c:set var="endPage" value="${currentPage + 2}" />

                <c:if test="${startPage < 1}">
                    <c:set var="startPage" value="1" />
                </c:if>

                <c:if test="${endPage > totalPages}">
                    <c:set var="endPage" value="${totalPages}" />
                </c:if>

                <div class="pagination">

                    <c:choose>
                        <c:when test="${currentPage > 1}">
                            <a href="user-home?page=1&productKeyword=${productKeyword}&shopKeyword=${shopKeyword}">&laquo;</a>
                            <a href="user-home?page=${currentPage - 1}&productKeyword=${productKeyword}&shopKeyword=${shopKeyword}">&lsaquo;</a>
                        </c:when>
                        <c:otherwise>
                            <span class="disabled">&laquo;</span>
                            <span class="disabled">&lsaquo;</span>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${startPage > 1}">
                        <a href="user-home?page=1&productKeyword=${productKeyword}&shopKeyword=${shopKeyword}">1</a>
                        <c:if test="${startPage > 2}">
                            <span class="dots">...</span>
                        </c:if>
                    </c:if>

                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="active">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="user-home?page=${i}&productKeyword=${productKeyword}&shopKeyword=${shopKeyword}">
                                    ${i}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${endPage < totalPages}">
                        <c:if test="${endPage < totalPages - 1}">
                            <span class="dots">...</span>
                        </c:if>
                        <a href="user-home?page=${totalPages}&productKeyword=${productKeyword}&shopKeyword=${shopKeyword}">
                            ${totalPages}
                        </a>
                    </c:if>

                    <c:choose>
                        <c:when test="${currentPage < totalPages}">
                            <a href="user-home?page=${currentPage + 1}&productKeyword=${productKeyword}&shopKeyword=${shopKeyword}">&rsaquo;</a>
                            <a href="user-home?page=${totalPages}&productKeyword=${productKeyword}&shopKeyword=${shopKeyword}">&raquo;</a>
                        </c:when>
                        <c:otherwise>
                            <span class="disabled">&rsaquo;</span>
                            <span class="disabled">&raquo;</span>
                        </c:otherwise>
                    </c:choose>

                </div>
            </c:if>
        </div>

    </body>
</html>