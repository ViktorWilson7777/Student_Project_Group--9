<style>

.search-container{
    padding:30px 40px;
}

.product-grid{
    display:grid;
    grid-template-columns:repeat(5,1fr);
    gap:20px;
}

.product-card{
    background:white;
    border-radius:6px;
    padding:10px;
    transition:0.2s;
}

.product-card:hover{
    transform:translateY(-4px);
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
}

.product-card img{
    width:100%;
    height:180px;
    object-fit:cover;
}

.product-card h3{
    font-size:15px;
}

.product-card p{
    color:#ee4d2d;
    font-weight:bold;
}

</style>

<c:if test="${shop != null}">

<div style="border:1px solid #ddd;padding:20px;margin:20px">

<h2>${shop.shopName}</h2>

<p>Owner: ${shop.owner}</p>

<p>Products: ${shopProductCount}</p>

<a href="shop?shopId=${shop.shopId}">
Visit Shop
</a>

</div>

</c:if>

<c:forEach items="${products}" var="p">

<div style="border:1px solid #ddd;width:200px;
display:inline-block;margin:10px">

<a href="product-detail?productId=${p.productId}">

<img src="${p.imageUrl}" width="180">

<h4>${p.name}</h4>

<p>${p.price} VND</p>

</a>

</div>

</c:forEach>