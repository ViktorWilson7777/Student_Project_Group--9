<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>My Orders</title>
        <style>
            body{
                margin:0;
                font-family:"Segoe UI",Arial,sans-serif;
                background:#f5f5f5;
            }

            .page{
                max-width:1280px;
                margin:26px auto;
                display:flex;
                gap:24px;
                padding:0 20px;
            }

            .sidebar{
                width:290px;
                background:#fff;
                border-radius:10px;
                box-shadow:0 2px 10px rgba(0,0,0,0.06);
                padding:26px;
                height:fit-content;
            }

            .userbox{
                display:flex;
                gap:16px;
                align-items:center;
                border-bottom:1px solid #eee;
                padding-bottom:18px;
                margin-bottom:18px;
            }

            .avatar{
                width:64px;
                height:64px;
                border-radius:50%;
                background:#ddd;
            }

            .sidebar a{
                display:block;
                padding:12px 0;
                color:#333;
                text-decoration:none;
                border-bottom:1px solid #f0f0f0;
            }

            .sidebar a.active{
                color:#ee4d2d;
                font-weight:700;
            }

            .content{
                flex:1;
            }

            .tabs{
                display:grid;
                grid-template-columns:repeat(5, 1fr);
                background:#fff;
                border-radius:10px 10px 0 0;
                overflow:hidden;
                box-shadow:0 2px 10px rgba(0,0,0,0.06);
            }

            .tabs a{
                text-decoration:none;
                color:#333;
                text-align:center;
                padding:18px 10px;
                border-bottom:2px solid transparent;
                background:#fff;
                font-size:16px;
            }

            .tabs a.active{
                color:#ee4d2d;
                border-bottom:2px solid #ee4d2d;
            }

            .orders{
                background:#fff;
                padding:18px;
                box-shadow:0 2px 10px rgba(0,0,0,0.06);
                border-radius:0 0 10px 10px;
            }

            .order-card{
                border:1px solid #eee;
                border-radius:10px;
                margin-bottom:18px;
                overflow:hidden;
                background:#fff;
            }

            .order-top{
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding:18px 22px;
                border-bottom:1px solid #f0f0f0;
                color:#666;
                font-size:14px;
            }

            .status{
                color:#ee4d2d;
                font-size:18px;
                font-weight:700;
            }

            .order-body{
                padding:20px 22px;
            }

            .order-row{
                display:flex;
                gap:18px;
                align-items:flex-start;
            }

            .product-img{
                width:90px;
                height:90px;
                object-fit:cover;
                border:1px solid #eee;
                border-radius:8px;
                background:#fafafa;
            }

            .product-info{
                flex:1;
            }

            .product-name{
                font-size:18px;
                font-weight:700;
                color:#222;
                margin-bottom:8px;
            }

            .variant{
                color:#666;
                margin-bottom:6px;
                font-size:14px;
            }

            .qty{
                color:#444;
                font-size:14px;
            }

            .order-note{
                margin-top:18px;
                color:#666;
                font-size:14px;
            }

            .order-bottom{
                padding:18px 22px;
                border-top:1px solid #f0f0f0;
                display:flex;
                justify-content:space-between;
                align-items:center;
                flex-wrap:wrap;
                gap:14px;
            }

            .order-total{
                font-size:20px;
                font-weight:700;
                color:#ee4d2d;
            }

            .btn-group{
                display:flex;
                gap:12px;
                flex-wrap:wrap;
            }

            .btn{
                height:44px;
                padding:0 22px;
                border-radius:8px;
                border:none;
                cursor:pointer;
                font-size:16px;
                font-weight:600;
                text-decoration:none;
                display:inline-flex;
                align-items:center;
                justify-content:center;
            }

            .btn-buy{
                background:#ee4d2d;
                color:#fff;
            }

            .btn-cancel{
                background:#fff;
                color:#333;
                border:1px solid #d9d9d9;
            }

            .empty{
                text-align:center;
                color:#777;
                padding:40px 0;
                font-size:16px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="user/user-header.jsp"/>

        <div class="page">
            <div class="sidebar">
                <div class="userbox">
                    <div class="avatar"></div>
                    <div>
                        <div style="font-size:18px;font-weight:700;">${sessionScope.account.name}</div>
                        <div style="color:#666;">${sessionScope.account.email}</div>
                    </div>
                </div>

                <a href="me">My Account</a>
                <a href="order" class="active">Order</a>
            </div>

            <div class="content">
                <div class="tabs">
                    <a href="order?status=ALL" class="${currentStatus == 'ALL' ? 'active' : ''}">All</a>
                    <a href="order?status=CREATED" class="${currentStatus == 'CREATED' ? 'active' : ''}">To Pay</a>
                    <a href="order?status=PAID" class="${currentStatus == 'PAID' ? 'active' : ''}">To Ship</a>
                    <a href="order?status=COMPLETED" class="${currentStatus == 'COMPLETED' ? 'active' : ''}">Completed</a>
                    <a href="order?status=CANCELED" class="${currentStatus == 'CANCELED' ? 'active' : ''}">Cancelled</a>
                </div>

                <div class="orders">
                    <c:choose>
                        <c:when test="${not empty orders}">
                            <c:forEach var="o" items="${orders}">
                                <div class="order-card">
                                    <div class="order-top">
                                        <div>${o.orderDate}</div>

                                        <div class="status">
                                            <c:choose>
                                                <c:when test="${o.status == 'CREATED'}">To Pay</c:when>
                                                <c:when test="${o.status == 'PAID'}">To Ship</c:when>
                                                <c:when test="${o.status == 'COMPLETED'}">Completed</c:when>
                                                <c:otherwise>Cancelled</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <div class="order-body">
                                        <c:forEach var="item" items="${o.items}">
                                            <div class="order-row">
                                                <img class="product-img" src="${item.imageUrl}" alt="${item.productName}">
                                                <div class="product-info">
                                                    <div class="product-name">${item.productName}</div>
                                                    <div class="variant">Variation: ${item.color} / ${item.size}</div>
                                                    <div class="qty">x${item.quantity}</div>
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <div class="order-note">
                                            <c:choose>
                                                <c:when test="${o.status == 'CREATED'}">
                                                    You can cancel this order before it moves to To Ship.
                                                </c:when>
                                                <c:when test="${o.status == 'PAID'}">
                                                    Your order is being prepared for shipping.
                                                </c:when>
                                                <c:when test="${o.status == 'COMPLETED'}">
                                                    Delivery completed successfully.
                                                </c:when>
                                                <c:otherwise>
                                                    This order has been cancelled.
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <div class="order-bottom">
                                        <div class="order-total">Order Total: ${o.totalAmount} VND</div>

                                        <div class="btn-group">
                                            <a class="btn btn-buy" href="buy-again?orderId=${o.orderId}">Buy Again</a>

                                            <c:if test="${o.status == 'CREATED'}">
                                                <a class="btn btn-cancel"
                                                   href="cancel-order?orderId=${o.orderId}"
                                                   onclick="return confirm('Are you sure you want to cancel this order?')">
                                                    Cancel Order
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty">No orders yet</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

    </body>
</html>