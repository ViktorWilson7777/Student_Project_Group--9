<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name}</title>
    <style>
        body{margin:0;font-family:"Segoe UI",Arial,sans-serif;background:#f5f5f5;}
        .page-wrap{max-width:1300px;margin:30px auto;padding:0 20px;}
        .product-box{background:#fff;border-radius:10px;padding:28px;display:flex;gap:28px;box-shadow:0 2px 12px rgba(0,0,0,0.06);}
        .left{flex:1;min-width:360px;}
        .img-box{border:1px solid #eee;border-radius:8px;overflow:hidden;background:#fafafa;height:560px;display:flex;align-items:center;justify-content:center;}
        .img-box img{width:100%;height:100%;object-fit:cover;display:block;}
        .right{flex:1.2;}
        .product-name{font-size:28px;font-weight:700;margin-bottom:18px;color:#222;}
        .price-box{background:#fafafa;padding:20px 24px;font-size:32px;color:#ee4d2d;border-radius:8px;margin-bottom:24px;font-weight:500;}
        .label{font-size:14px;font-weight:700;color:#666;margin-bottom:10px;text-transform:uppercase;}
        .option-group{display:flex;flex-wrap:wrap;gap:10px;margin-bottom:22px;}
        .option-btn{min-width:96px;padding:12px 18px;background:#fff;border:1px solid #d9d9d9;border-radius:3px;cursor:pointer;text-align:center;transition:0.2s;}
        .option-btn:hover{border-color:#ee4d2d;color:#ee4d2d;}
        .option-btn.active{border:2px solid #ee4d2d;color:#ee4d2d;}
        .stock-box{font-size:18px;margin-bottom:18px;}
        .qty-row{display:flex;align-items:center;gap:0;margin-bottom:26px;}
        .qty-btn{width:42px;height:42px;border:1px solid #d9d9d9;background:#fff;font-size:24px;cursor:pointer;}
        .qty-input{width:60px;height:42px;border:1px solid #d9d9d9;border-left:none;border-right:none;text-align:center;font-size:20px;outline:none;}
        .action-row{display:flex;gap:18px;}
        .btn{min-width:200px;height:54px;border-radius:3px;cursor:pointer;transition:0.2s;border:none;font-size:18px;font-weight:500;}
        .btn-cart{background:#fff3f1;border:1px solid #ee4d2d;color:#ee4d2d;}
        .btn-buy{background:#ee4d2d;color:#fff;}
        .toast{position:fixed;top:20px;right:20px;background:#222;color:#fff;padding:14px 18px;border-radius:8px;opacity:0;transform:translateY(-10px);transition:0.25s;z-index:9999;pointer-events:none;}
        .toast.show{opacity:1;transform:translateY(0);}    
    </style>
</head>
<body>
<jsp:include page="user/user-header.jsp"/>
<div class="page-wrap">
    <div class="product-box">
        <div class="left">
            <div class="img-box">
                <img src="${product.imageUrl}" alt="${product.name}">
            </div>
        </div>
        <div class="right">
            <div class="product-name">${product.name}</div>
            <div class="price-box" id="priceDisplay">${product.price} VND</div>
            <div class="label">Color</div>
            <div class="option-group" id="colorGroup"></div>
            <div class="label">Size</div>
            <div class="option-group" id="sizeGroup"></div>
            <div class="stock-box">Stock: <strong id="stockDisplay">Please choose category</strong></div>
            <div class="qty-row">
                <button type="button" class="qty-btn" onclick="changeQty(-1)">-</button>
                <input type="text" id="qtyInput" class="qty-input" value="1" readonly>
                <button type="button" class="qty-btn" onclick="changeQty(1)">+</button>
            </div>
            <div class="action-row">
                <button type="button" class="btn btn-cart" onclick="addToCartOnly()">Add To Cart</button>
                <button type="button" class="btn btn-buy" onclick="buyNow()">Buy</button>
            </div>
        </div>
    </div>
</div>
<form id="buyForm" action="add-to-cart" method="post" style="display:none;">
    <input type="hidden" name="variantId" id="buyVariantId">
    <input type="hidden" name="quantity" id="buyQuantity">
    <input type="hidden" name="buyNow" value="true">
</form>
<div class="toast" id="toast"></div>
<script>
    const variants = [
        <c:forEach var="v" items="${variants}" varStatus="st">
        {variantId:${v.variantId}, color:'${v.color}', size:'${v.size}', price:${v.priceVariant}, stock:${v.stock}}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];
    let selectedColor = null;
    let selectedSize = null;
    let currentVariant = null;
    function uniqueValues(key){const set=new Set();variants.forEach(v=>{if(v[key]!=null&&v[key]!== '') set.add(v[key]);});return [...set];}
    function renderOptions(){
        const colorGroup=document.getElementById("colorGroup");
        const sizeGroup=document.getElementById("sizeGroup");
        colorGroup.innerHTML=""; sizeGroup.innerHTML="";
        uniqueValues("color").forEach(color=>{const btn=document.createElement("button");btn.type="button";btn.className="option-btn";btn.textContent=color;btn.onclick=function(){selectedColor=color;updateActiveButtons("colorGroup",color);updateVariant();};colorGroup.appendChild(btn);});
        uniqueValues("size").forEach(size=>{const btn=document.createElement("button");btn.type="button";btn.className="option-btn";btn.textContent=size;btn.onclick=function(){selectedSize=size;updateActiveButtons("sizeGroup",size);updateVariant();};sizeGroup.appendChild(btn);});
    }
    function updateActiveButtons(groupId, value){document.querySelectorAll("#"+groupId+" .option-btn").forEach(btn=>{btn.classList.toggle("active", btn.textContent===value);});}
    function updateVariant(){
        currentVariant = variants.find(v => v.color === selectedColor && v.size === selectedSize) || null;
        const priceDisplay=document.getElementById("priceDisplay");
        const stockDisplay=document.getElementById("stockDisplay");
        if(currentVariant){priceDisplay.textContent=currentVariant.price+" VND";stockDisplay.textContent=currentVariant.stock;} else {priceDisplay.textContent="${product.price} VND";stockDisplay.textContent="Please choose category";}
    }
    function changeQty(delta){let input=document.getElementById("qtyInput");let value=parseInt(input.value)||1;value+=delta;if(value<1)value=1;if(currentVariant&&value>currentVariant.stock){value=currentVariant.stock>0?currentVariant.stock:1;}input.value=value;}
    function showToast(message){const toast=document.getElementById("toast");toast.textContent=message;toast.classList.add("show");setTimeout(()=>toast.classList.remove("show"),2200);}
    function addToCartOnly(){
        if(!currentVariant){alert("Please choose color and size first");return;}
        const qty=document.getElementById("qtyInput").value;
        const formData=new URLSearchParams();
        formData.append("variantId", currentVariant.variantId);
        formData.append("quantity", qty);
        fetch("add-to-cart", {method:"POST", headers:{"Content-Type":"application/x-www-form-urlencoded", "X-Requested-With":"XMLHttpRequest"}, body:formData.toString()})
            .then(res=>res.json())
            .then(data=>{if(data.success){showToast(data.message);}else{alert(data.message);}})
            .catch(()=>alert("Cannot add to cart"));
    }
    function buyNow(){
        if(!currentVariant){alert("Please choose color and size first");return;}
        document.getElementById("buyVariantId").value=currentVariant.variantId;
        document.getElementById("buyQuantity").value=document.getElementById("qtyInput").value;
        document.getElementById("buyForm").submit();
    }
    renderOptions();
</script>
</body>
</html>
