<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Checkout</title>
        <style>
            *{
                box-sizing:border-box;
                margin:0;
                padding:0;
                font-family:Arial,sans-serif;
            }

            body{
                background:#f5f5f5;
            }

            .header{
                background:#f4511e;
                color:white;
                padding:30px 40px;
                font-size:28px;
                font-weight:bold;
            }

            .container{
                width:80%;
                margin:30px auto;
                background:white;
                padding:30px;
            }

            .section-title{
                font-size:20px;
                font-weight:bold;
                margin-bottom:20px;
            }

            .address-box{
                display:flex;
                justify-content:space-between;
                align-items:flex-start;
                margin-bottom:20px;
            }

            .address-info{
                width:70%;
            }

            .address-info p{
                margin:10px 0;
                font-size:16px;
            }

            .address-form{
                margin-top:10px;
            }

            .address-form input[type="text"]{
                width:100%;
                padding:10px;
                margin:8px 0 14px 0;
                border:1px solid #ccc;
                font-size:15px;
            }

            .add-btn{
                border:1px solid #999;
                background:white;
                padding:18px 20px;
                cursor:pointer;
            }

            table{
                width:100%;
                border-collapse:collapse;
                margin-top:20px;
            }

            th{
                background:#fafafa;
                padding:14px;
                text-align:center;
                font-size:16px;
                border-bottom:1px solid #ddd;
            }

            td{
                padding:14px;
                border-bottom:1px solid #ddd;
                vertical-align:middle;
                font-size:16px;
            }

            .product-cell{
                display:flex;
                align-items:center;
                gap:15px;
            }

            .product-cell img{
                width:70px;
                height:70px;
                object-fit:cover;
                border:1px solid #ddd;
                background:#fff;
            }

            .summary{
                margin-top:20px;
                text-align:right;
                line-height:2;
                font-size:18px;
            }

            .summary .saved{
                color:green;
                font-weight:bold;
            }

            .summary .total{
                color:#f4511e;
                font-size:22px;
                font-weight:bold;
            }

            .payment-section{
                margin-top:40px;
            }

            .payment-option{
                margin:8px 0;
                font-size:16px;
            }

            .place-order-btn{
                margin-top:20px;
                background:#f4511e;
                color:white;
                border:none;
                padding:14px 30px;
                font-size:18px;
                cursor:pointer;
            }

            .error{
                background:#ffe5e5;
                color:#c62828;
                padding:12px;
                margin-bottom:20px;
                border:1px solid #f5b5b5;
            }

            .readonly-line{
                margin-bottom:10px;
                font-size:16px;
            }

            .hint{
                color:#666;
                font-size:14px;
                margin-top:-8px;
                margin-bottom:10px;
            }
        </style>
    </head>
    <body>

        <div class="header">Checkout</div>

        <div class="container">

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <!-- QUAN TRỌNG: phải bọc form toàn bộ phần nhập phone/address/payment -->
            <form action="checkout" method="post">

                <div class="section-title">Delivery Address</div>

                <div class="address-box">
                    <div class="address-info">

                        <div class="readonly-line">
                            <strong>Receiver:</strong>
                            <c:out value="${sessionScope.account.name}" />
                        </div>

                        <div class="address-form">
                            <label><strong>Phone:</strong></label>
                            <input type="text"
                                   name="receiverPhone"
                                   value="${param.receiverPhone}"
                                   placeholder="Enter receiver phone"
                                   required>

                            <label><strong>Address:</strong></label>
                            <input type="text"
                                   name="shippingAddress"
                                   value="${param.shippingAddress}"
                                   placeholder="Enter shipping address"
                                   required>


                        </div>
                    </div>

                    <div>
                        <button type="button" class="add-btn">Add New Address</button>
                    </div>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cartItems}" var="item">
                            <tr>
                                <td>
                                    <div class="product-cell">
                                        <img src="${item.imageUrl}" alt="">
                                        <div>
                                            <div>${item.productName}</div>
                                            <div>Size: ${item.size} | Color: ${item.color}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>${item.priceVariant} VND</td>
                                <td>${item.quantity}</td>
                                <td>${item.priceVariant * item.quantity} VND</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="summary">
                    <div>
                        Original Price:
                        <strong><fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            VND</strong>
                    </div>
                    <div>
                        Saved:
                        <span class="saved"><fmt:formatNumber value="${saved}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            VND</span>
                    </div>
                    <div>
                        Total Payment:
                        <span class="total"><fmt:formatNumber value="${totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND</span>
                    </div>
                </div>

                <div class="payment-section">
                    <div class="section-title">Payment Method</div>

                    <div class="payment-option">
                        <label>
                            <input type="radio" name="paymentMethod" value="COD" checked>
                            Cash on Delivery
                        </label>
                    </div>

                    <div class="payment-option">
                        <label>
                            <input type="radio" name="paymentMethod" value="Bank Transfer">
                            Bank Transfer
                        </label>
                    </div>

                    <button type="submit" class="place-order-btn">Place Order</button>
                </div>

            </form>
        </div>

    </body>
</html>