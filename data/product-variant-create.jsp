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

<h2>Create Product Variant</h2>

<form action="product-variant-create" method="post">

Product ID:
<input type="number" name="productId" required>
<br><br>

Size:
<input type="text" name="size" required>
<br><br>

Color:
<input type="text" name="color" required>
<br><br>

Stock:
<input type="number" name="stock" required>
<br><br>

Price:
<input type="number" step="0.01" name="priceVariant" required>
<br><br>

<button type="submit">Create</button>
<a href="home">Cancel</a>

</form>

<br>

<a href="product-variant-list">Back</a>