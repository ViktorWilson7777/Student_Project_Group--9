<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>



body{
    font-family:"Segoe UI",Arial,sans-serif;
    background:#f4f6f9;
    margin:35px;
    color:#333;
}

h2{
    font-size:28px;
    margin-bottom:20px;
}

/* form card */

form{
    background:white;
    padding:28px;
    width:450px;
    border-radius:10px;
    box-shadow:0 4px 15px rgba(0,0,0,0.08);
}

/* label */

label{
    font-weight:500;
    display:block;
    margin-bottom:6px;
}

/* inputs */

input,
select{
    width:100%;
    padding:10px 12px;
    border:1px solid #ddd;
    border-radius:6px;
    margin-bottom:18px;
}

/* focus */

input:focus,
select:focus{
    outline:none;
    border-color:#ee4d2d;
}

/* button */

button,
input[type=submit]{
    background:#ee4d2d;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:6px;
    cursor:pointer;
}

button:hover,
input[type=submit]:hover{
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

<h2>Edit Shop</h2>

<form action="shop-edit" method="post">

    <input type="hidden" name="id" value="${shop.shopId}" />

    <div>
        Shop Name:
        <input type="text" name="name" value="${shop.shopName}" required />
    </div>

    <div>
        Owner ID:
        <input type="number" name="ownerId" value="${shop.owner.userId}" required />
    </div>

    <br>

    <button type="submit">Update</button>
    <a href="home">Cancel</a>

</form>