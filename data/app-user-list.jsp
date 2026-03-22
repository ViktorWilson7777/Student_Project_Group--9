<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<title>User List</title>

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
}

/* Table */

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    border-radius:8px;
    overflow:hidden;
    box-shadow:0 3px 12px rgba(0,0,0,0.08);
}

/* Header */

th{
    background:#ee4d2d;
    color:white;
    padding:12px;
    text-align:left;
}

/* Row */

td{
    padding:12px;
    border-bottom:1px solid #eee;
}

/* Hover row */

tr:hover{
    background:#f9f9f9;
}

/* Buttons */

button,
input[type=submit]{
    background:#ee4d2d;
    color:white;
    border:none;
    padding:6px 12px;
    border-radius:5px;
    cursor:pointer;
}

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






<h2>User List</h2>
<a href="app-user-create.jsp">
            <button>Add New User</button>
        </a>
<form onsubmit="searchUser(event)">
    <input type="text" name="keyword" id="keyword">
    <button type="submit">Search</button>
</form>

<br>

<table>

    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody id="userTable">

        <c:forEach items="${list}" var="u">

            <tr>
                <td>${u.userId}</td>
                <td>${u.name}</td>
                <td>${u.email}</td>
                <td>${u.role}</td>
                <td>
                    <a href="app-user-edit?id=${u.userId}">Edit</a> | 
                    <a href="app-user-delete?id=${u.userId}">Delete</a>

                </td>
            </tr>

        </c:forEach>

</tbody>

</table>

<div id="loading">Loading more users...</div>



<script>

var page = ${page};
var loading = false;

window.onscroll = function() {

    if (loading) return;

    if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 100) {

        loading = true;
        page++;

        fetch("app-user-list?page=" + page + "&keyword=${keyword}")
        .then(res => res.text())
        .then(html => {

            const parser = new DOMParser();
            const doc = parser.parseFromString(html, "text/html");

            const rows = doc.querySelectorAll("table tbody tr");

            const table = document.querySelector("#userTable");

            rows.forEach(r => table.appendChild(r));

            loading = false;
        });

    }

}

</script>

<script>
function searchUser(e){
    e.preventDefault();

    const keyword = document.getElementById("keyword").value;

    fetch("app-user-list?keyword=" + keyword)
    .then(res => res.text())
    .then(html => {

        const container = document.getElementById("content-area");

        container.innerHTML = html;

        const scripts = container.querySelectorAll("script");

        scripts.forEach(s => {
            const newScript = document.createElement("script");
            newScript.text = s.text;
            document.body.appendChild(newScript);
        });

    });
}
</script>

</body>
</html>

