<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    *{ box-sizing:border-box; }
    .user-topbar{
        background:linear-gradient(180deg,#ee4d2d 0%, #f35b2f 100%);
        padding:18px 28px;
        color:#fff;
        display:flex;
        align-items:center;
        gap:18px;
        flex-wrap:wrap;
    }
    .user-topbar h1{
        margin:0;
        font-size:34px;
        font-weight:800;
        min-width:320px;
    }
    .user-search-form{
        display:flex;
        align-items:center;
        gap:0;
        flex:1;
        max-width:760px;
        min-width:380px;
    }
    .user-search-form input{
        height:48px;
        border:none;
        outline:none;
        padding:0 16px;
        font-size:16px;
        width:280px;
        background:#fff;
        color:#333;
    }
    .user-search-form input:first-child{ border-radius:6px 0 0 6px; border-right:1px solid #eee; }
    .user-search-form button{
        height:48px;
        border:none;
        border-radius:0 6px 6px 0;
        background:#ffb08f;
        color:#7d230f;
        font-weight:700;
        padding:0 24px;
        cursor:pointer;
    }
    .user-search-form button:hover{ background:#ffd2c1; }
    .user-cart-link{
        color:#fff;
        text-decoration:none;
        font-size:18px;
        font-weight:700;
        margin-left:auto;
    }
    .user-cart-link:hover{ text-decoration:underline; }
    .user-menu{ position:relative; display:flex; align-items:center; gap:10px; padding-bottom:14px; margin-bottom:-14px; }
    .user-menu::after{ content:""; position:absolute; left:0; right:0; top:100%; height:16px; }
    .user-avatar{ width:46px; height:46px; border-radius:50%; object-fit:cover; background:#ddd; border:2px solid rgba(255,255,255,.85); }
    .user-name{ color:#fff; font-weight:700; max-width:160px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
    .user-dropdown{
        position:absolute; top:calc(100% + 2px); right:0; min-width:190px; background:#fff;
        border-radius:10px; box-shadow:0 12px 30px rgba(0,0,0,.18); display:none; overflow:hidden; z-index:9999;
    }
    .user-dropdown a{ display:block; padding:12px 16px; color:#333; text-decoration:none; font-size:15px; }
    .user-dropdown a:hover{ background:#f8f8f8; color:#ee4d2d; }
    .user-menu:hover .user-dropdown, .user-menu:focus-within .user-dropdown{ display:block; }
    @media (max-width: 900px){
        .user-topbar h1{ min-width:100%; font-size:28px; }
        .user-search-form{ min-width:100%; max-width:none; flex-wrap:wrap; gap:8px; }
        .user-search-form input{ width:calc(50% - 4px); border-radius:6px !important; }
        .user-search-form button{ border-radius:6px; width:100%; }
        .user-cart-link{ margin-left:0; }
    }
</style>

<div class="user-topbar">
    <h1>Shopbee</h1>

    <form class="user-search-form" action="user-home" method="get">
        <input type="text" name="productKeyword" placeholder="Search product..." value="${param.productKeyword}">
        <input type="text" name="shopKeyword" placeholder="Search shop..." value="${param.shopKeyword}">
        <button type="submit">Search</button>
    </form>

    <a class="user-cart-link" href="cart">Cart</a>

    <div class="user-menu">
        <img class="user-avatar" src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="User">
        <span class="user-name">${sessionScope.account.name}</span>
        <div class="user-dropdown">
            <a href="me">My Account</a>
            <a href="order">Order</a>
            <a href="logout">Logout</a>
        </div>
    </div>
</div>
