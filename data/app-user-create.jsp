<h2>Add User</h2>
<style>

body{
    font-family:"Segoe UI",Arial,sans-serif;
    background:#f4f6f9;
    margin:35px;
    color:#333;
}

/* Title */

h2{
    font-size:28px;
    margin-bottom:20px;
    font-weight:600;
}

/* Welcome text */

.welcome{
    margin-bottom:20px;
    font-size:15px;
}

/* Form card */

form{
    background:white;
    padding:30px;
    width:420px;
    border-radius:10px;
    box-shadow:0 4px 15px rgba(0,0,0,0.08);
}

/* Label */

label{
    font-weight:500;
    font-size:15px;
}

/* Inputs */

input[type=text],
input[type=email],
input[type=password]{
    width:100%;
    padding:10px 12px;
    margin-top:5px;
    margin-bottom:18px;
    border:1px solid #ddd;
    border-radius:6px;
    font-size:14px;
}

/* Focus */

input:focus{
    outline:none;
    border-color:#ee4d2d;
}

/* Buttons */

button,
input[type=submit]{
    background:#ee4d2d;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:6px;
    font-size:14px;
    cursor:pointer;
    transition:0.2s;
}

/* Hover */

button:hover,
input[type=submit]:hover{
    background:#d73211;
}

/* Links */

a{
    color:#1a73e8;
    text-decoration:none;
}

a:hover{
    text-decoration:underline;
}

</style>


<jsp:include page="header.jsp" />
<c:if test="${error != null}">
    <p style="color:red">${error}</p>
</c:if>
<form action="app-user-create" method="post">

    Name: 
    <input type="text" name="name" required><br>

    Email: 
    <input type="email" name="email" required 
           pattern="^[A-Za-z0-9+_.-]+@gmail\.com$"
           title="Email must end with @gmail.com"><br>

    Password: 
    <input type="password" name="password" required><br>

    <input type="submit" value="Add">
    <a href="home">Cancel</a>
</form>