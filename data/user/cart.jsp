<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cart</title>

        <style>

*{
                box-sizing:border-box;
            }

            body{
                margin:0;
                background:#f5f5f5;
                font-family:Arial, sans-serif;
                color:#222;
            }

            h2{
                max-width:1200px;
                margin:28px auto 18px;
                font-size:36px;
                font-weight:700;
            }

            form[action="cart"]{
                max-width:1200px;
                margin:0 auto;
            }

            table{
                width:100%;
                border-collapse:separate;
                border-spacing:0;
                background:#fff;
                border-radius:10px;
                overflow:hidden;
                box-shadow:0 4px 18px rgba(0,0,0,0.08);
            }

            th{
                padding:20px 14px;
                background:#fafafa;
                color:#444;
                font-size:15px;
                font-weight:700;
                border-bottom:1px solid #efefef;
                text-align:center;
            }

            td{
                padding:22px 14px;
                border-bottom:1px solid #f1f1f1;
                font-size:15px;
                vertical-align:middle;
                text-align:center;
            }

            tr:last-child td{
                border-bottom:none;
            }

            tr:hover td{
                background:#fffdfb;
            }

            th:first-child,
            td:first-child{
                width:64px;
            }

            input[type="checkbox"]{
                width:18px;
                height:18px;
                accent-color:#ee4d2d;
                cursor:pointer;
            }

            .product{
                display:flex;
                align-items:center;
                gap:16px;
                text-align:left;
            }

            .product img{
                width:88px;
                height:88px;
                object-fit:cover;
                border-radius:10px;
                border:1px solid #eee;
                background:#fff;
                flex-shrink:0;
            }

            .product b{
                display:block;
                margin-bottom:6px;
                font-size:19px;
                line-height:1.35;
                color:#222;
            }

            td:nth-child(3){
                line-height:1.6;
                color:#555;
            }

            td:nth-child(4),
            td:nth-child(5),
            td:nth-child(6){
                font-weight:600;
                white-space:nowrap;
            }

            td:nth-child(6){
                color:#ee4d2d;
                font-size:18px;
            }

            a{
                color:#ee4d2d;
                text-decoration:none;
                font-weight:600;
            }

            a:hover{
                text-decoration:underline;
            }

            .total-bar{
                margin:22px 0 0;
                background:#fff;
                border-radius:12px;
                box-shadow:0 4px 18px rgba(0,0,0,0.08);
                padding:22px 24px;
                display:grid;
                grid-template-columns:auto auto 1fr;
                gap:14px;
                align-items:center;
            }

            .total-bar > div:last-child{
                justify-self:end;
                text-align:right;
                line-height:1.8;
                font-size:17px;
            }

            .total-bar > div:last-child br{
                display:block;
                content:"";
            }

            button{
                border:none;
                background:#ee4d2d;
                color:#fff;
                padding:13px 22px;
                border-radius:8px;
                cursor:pointer;
                font-size:15px;
                font-weight:700;
                transition:background .2s ease, transform .2s ease, box-shadow .2s ease;
            }

            button:hover{
                background:#d8432b;
                transform:translateY(-1px);
                box-shadow:0 8px 18px rgba(238,77,45,0.22);
            }

            button[type="button"]{
                background:#fff1ee;
                color:#ee4d2d;
                border:1px solid #f3b3a5;
            }

            button[type="button"]:hover{
                background:#ffe6df;
            }

            form[action="checkout"]{
                max-width:1200px;
                margin:18px auto 40px;
            }

            .checkout-btn{
                min-width:190px;
                font-size:18px;
                padding:15px 28px;
            }

            #voucherModal{
                z-index:9999;
                backdrop-filter:blur(2px);
            }

            #voucherModal > div{
                box-shadow:0 18px 50px rgba(0,0,0,0.2);
                border-radius:14px !important;
            }

            #searchVoucher{
                width:100%;
                margin:10px 0 14px;
                padding:12px 14px;
                border:1px solid #ddd;
                border-radius:8px;
                outline:none;
                font-size:14px;
            }

            #searchVoucher:focus{
                border-color:#ee4d2d;
            }

            .voucher-item{
                border:1px solid #eee;
                border-radius:10px;
                padding:14px 16px;
                margin-bottom:12px;
                line-height:1.7;
                transition:all .2s ease;
            }

            .voucher-item:hover{
                border-color:#ee4d2d;
                background:#fffaf8;
            }

            .voucher-disabled{
                opacity:.45;
                background:#f3f3f3;
            }

            @media (max-width: 1280px){
                h2,
                form[action="cart"],
                form[action="checkout"]{
                    max-width:calc(100% - 32px);
                }
            }

            @media (max-width: 900px){
                h2{
                    font-size:28px;
                }

                table,
                thead,
                tbody,
                th,
                td,
                tr{
                    display:block;
                }

                th{
                    display:none;
                }

                tr{
                    background:#fff;
                    margin-bottom:14px;
                    border-radius:12px;
                    overflow:hidden;
                    box-shadow:0 4px 18px rgba(0,0,0,0.08);
                }

                td{
                    text-align:left;
                    padding:14px 16px;
                    border-bottom:1px solid #f2f2f2;
                }

                td:first-child{
                    width:auto;
                }

                .total-bar{
                    grid-template-columns:1fr;
                }

                .total-bar > div:last-child{
                    justify-self:start;
                    text-align:left;
                }
            }

        </style>

    </head>

    <jsp:include page="/user/user-header.jsp"/>

    <body>

        <h2>Shopping Cart</h2>

        <form action="cart" method="get">

            <input type="hidden" name="action" value="deleteSelected">

            <table>

                <tr>
                    <th><input type="checkbox" id="checkAll"></th>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>

                <c:forEach var="item" items="${cartItems}">

                    <tr>

                        <td>
                            <input type="checkbox" name="selectedItems"
                                   value="${item.variantId}" class="itemCheck">
                        </td>

                        <td>
                            <div class="product">

                                <img src="${item.imageUrl}">

                                <div>
                                    <b>${item.productName}</b><br>
                                    ${item.color} / ${item.size}
                                </div>

                            </div>
                        </td>

                        <td>
                            Size: ${item.size}<br>
                            Color: ${item.color}
                        </td>

                        <td>
                            ${item.priceVariant} VND
                        </td>

                        <td>
                            ${item.quantity}
                        </td>

                        <td>
                            ${item.priceVariant * item.quantity} VND
                        </td>

                        <td>
                            <a href="cart?action=delete&variantId=${item.variantId}">Delete</a>
                        </td>

                    </tr>

                </c:forEach>

            </table>

            <div class="total-bar">

                <div>
                    <button type="submit">Delete Selected</button>
                </div>

                <div>

                    <button type="button" onclick="openVoucherModal()">
                        Select or enter code
                    </button>

                </div>

                <div>

                    Total Price:
                    <fmt:formatNumber value="${totalPrice}" maxFractionDigits="3"/>
                    VND

                    <br>

                    Saved:
                    <fmt:formatNumber value="${saved}" maxFractionDigits="3"/>
                    VND
                    <br>

                    Original Price:
                    <fmt:formatNumber value="${originalPrice}" maxFractionDigits="3"/>
                    VND
                    <br>

                </div>

                <div>
                    
                </div>

            </div>

        </form>
        <form action="checkout" method="get">


        <button class="checkout-btn" type="submit">
            Checkout
        </button>

    </form>

    <!-- VOUCHER MODAL -->

    <div id="voucherModal" style="
         display:none;
         position:fixed;
         top:0;
         left:0;
         width:100%;
         height:100%;
         background:rgba(0,0,0,0.4);">

        <div style="
             background:white;
             width:500px;
             max-height:80vh;
             margin:60px auto;
             padding:20px;
             border-radius:6px;
             overflow:hidden;">

        

            <form action="cart" method="get">

                <input type="hidden" name="action" value="applyVoucher">

                

                <button type="submit">Apply</button>

                <button type="button" onclick="closeVoucherModal()">Cancel</button>

           
                <hr>

                <h4>Available Vouchers</h4>

                <c:if test="${not empty sessionScope.voucherError}">
                    <div style="color:red; margin-bottom:10px;">
                        ${sessionScope.voucherError}
                    </div>
                    <c:remove var="voucherError" scope="session"/>
                </c:if>

                <div style="max-height:350px; overflow-y:auto;">

                    <c:set var="selectedVouchers" value="${sessionScope.vouchersSelected}" />
                    <c:forEach items="${vouchers}" var="v">

                        <div class="voucher-item">

                            <c:choose>
                                <c:when test="${v.stackable}">
                                    <input type="checkbox"
                                           name="voucherId"
                                           class="voucher-checkbox"
                                           value="${v.voucherId}"
                                           data-type="STACK"
                                           onchange="handleVoucherSelection()"
                                           <c:forEach var="sv" items="${selectedVouchers}">
                                               <c:if test="${sv.voucherId == v.voucherId}">
                                                   checked="checked"
                                               </c:if>
                                           </c:forEach>
                                           >
                                </c:when>

                                <c:otherwise>
                                    <input type="checkbox"
                                           name="voucherId"
                                           class="voucher-checkbox"
                                           value="${v.voucherId}"
                                           data-type="NON_STACK"
                                           onchange="handleVoucherSelection()"
                                           <c:forEach var="sv" items="${selectedVouchers}">
                                               <c:if test="${sv.voucherId == v.voucherId}">
                                                   checked="checked"
                                               </c:if>
                                           </c:forEach>
                                           >
                                </c:otherwise>
                            </c:choose>
                            <b class="voucher-code">${v.code}</b>
                            - Discount ${v.discountPercent}%

                            <br>
                            Min order: ${v.minOrderAmount}

                        </div>



                    </c:forEach>

                </div>

            </form>

        </div>

    </div>

</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const selected = "${empty param.selectedVariantIds ? param.selectedVariantId : param.selectedVariantIds}";
    if (!selected) return;

    selected.split(",").forEach(function(id){
        const checkbox = document.querySelector('input[name="selectedItems"][value="' + id + '"]');
        if (checkbox) {
            checkbox.checked = true;
        }
    });

    handleVoucherSelection();
});
</script>

<script>
    function openVoucherModal() {
        document.getElementById("voucherModal").style.display = "block";
        handleVoucherSelection();
    }

    function closeVoucherModal() {
        document.getElementById("voucherModal").style.display = "none";
    }
</script>

<script>

    const checkAll = document.getElementById("checkAll");

    if (checkAll) {
        checkAll.addEventListener("change", function () {

            let items = document.querySelectorAll(".itemCheck");

            items.forEach(function (cb) {
                cb.checked = checkAll.checked;
            });

        });
    }

</script>


<script>

    function searchVoucher() {

        let input = document.getElementById("searchVoucher");
        if (!input) return;

        let keyword = input.value.toLowerCase();

        let items = document.querySelectorAll(".voucher-item");

        items.forEach(function (v) {

            let text = v.querySelector(".voucher-code").innerText.toLowerCase();

            if (text.includes(keyword)) {
                v.style.display = "block";
            } else {
                v.style.display = "none";
            }

        });

    }

</script>

<script>

    function handleVoucherSelection() {

        let checkboxes = document.querySelectorAll(".voucher-checkbox");

        let selected = [];

        checkboxes.forEach(cb => {
            if (cb.checked) {
                selected.push(cb);
            }
        });

        let stackSelected = selected.filter(cb => cb.dataset.type === "STACK");
        let nonStackSelected = selected.filter(cb => cb.dataset.type === "NON_STACK");

        checkboxes.forEach(cb => {
            cb.disabled = false;
            cb.parentElement.classList.remove("voucher-disabled");
        });

        if (nonStackSelected.length > 0) {

            checkboxes.forEach(cb => {
                if (!cb.checked) {
                    cb.disabled = true;
                    cb.parentElement.classList.add("voucher-disabled");
                }
            });

            return;
        }

        if (stackSelected.length > 0) {

            checkboxes.forEach(cb => {
                if (cb.dataset.type === "NON_STACK" && !cb.checked) {
                    cb.disabled = true;
                    cb.parentElement.classList.add("voucher-disabled");
                }
            });

        }

        if (selected.length >= 3) {

            checkboxes.forEach(cb => {
                if (!cb.checked) {
                    cb.disabled = true;
                    cb.parentElement.classList.add("voucher-disabled");
                }
            });

        }

    }

</script>
</html>