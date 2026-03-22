<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>

body{
    font-family:"Segoe UI",Arial,sans-serif;
    background:#f4f6f9;
    margin:35px;
}

h2{
    font-size:28px;
    margin-bottom:20px;
}

/* table */

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    border-radius:8px;
    overflow:hidden;
    box-shadow:0 3px 12px rgba(0,0,0,0.08);
}

/* header */

th{
    background:#ee4d2d;
    color:white;
    padding:12px;
    text-align:left;
}

/* cell */

td{
    padding:12px;
    border-bottom:1px solid #eee;
}

tr:hover{
    background:#f9f9f9;
}

/* buttons */

button,
input[type=submit]{
    background:#ee4d2d;
    color:white;
    border:none;
    padding:6px 12px;
    border-radius:5px;
    cursor:pointer;
}

button:hover{
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

<h2>Voucher List</h2>

<div style="margin-bottom:10px;">
    <a href="voucher-create"><button type="button">Create New Voucher</button></a>
</div>

<form id="voucherSearchForm" onsubmit="return false;" style="margin-bottom:10px;">
    <input type="text" id="voucherCode" name="code" value="${code}" placeholder="Search voucher code">
    <button type="button" onclick="searchVoucher()">Search</button>
</form>

<table border="1" width="100%" cellspacing="0" cellpadding="8">
    <thead>
        <tr>
            <th>ID</th>
            <th>Code</th>
            <th>Discount %</th>
            <th>Min Order</th>
            <th>Stackable</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Actions</th>
        </tr>
    </thead>

    <tbody id="voucherBody">
        <c:forEach items="${vouchers}" var="v">
            <tr>
                <td>${v.voucherId}</td>
                <td>${v.code}</td>
                <td>${v.discountPercent}</td>
                <td>${v.minOrderAmount}</td>
                <td>${v.stackable}</td>
                <td>${v.startDate}</td>
                <td>${v.endDate}</td>
                <td>
                    <a href="voucher-edit?id=${v.voucherId}">Edit</a> |
                    <a href="voucher-delete?id=${v.voucherId}"
                       onclick="return confirm('Delete voucher ${v.code}?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<div id="loading" style="display:none; text-align:center; padding:10px;">
    Loading...
</div>

<script>
    let page = ${page};
    let loading = false;
    let done = false;

    function getCode() {
        const input = document.getElementById("voucherCode");
        return input ? input.value.trim() : "";
    }

    function searchVoucher() {
        const code = encodeURIComponent(getCode());

        fetch("voucher-list?code=" + code + "&page=1")
            .then(res => res.text())
            .then(html => {
                document.getElementById("content-area").innerHTML = html;
            })
            .catch(err => console.log(err));
    }

    function loadMoreVoucher() {
        if (loading || done) return;

        loading = true;
        document.getElementById("loading").style.display = "block";

        const nextPage = page + 1;
        const code = encodeURIComponent(getCode());

        fetch("voucher-list?code=" + code + "&page=" + nextPage)
            .then(res => res.text())
            .then(html => {
                const temp = document.createElement("div");
                temp.innerHTML = html;

                const newRows = temp.querySelectorAll("#voucherBody tr");
                const body = document.getElementById("voucherBody");

                if (!newRows || newRows.length === 0) {
                    done = true;
                } else {
                    newRows.forEach(row => body.insertAdjacentHTML("beforeend", row.outerHTML));
                    page = nextPage;

                    if (newRows.length < 20) {
                        done = true;
                    }
                }

                loading = false;
                document.getElementById("loading").style.display = "none";
            })
            .catch(err => {
                console.log("Load voucher error:", err);
                loading = false;
                document.getElementById("loading").style.display = "none";
            });
    }

    window.addEventListener("scroll", function () {
        if ((window.innerHeight + window.scrollY) >= document.body.scrollHeight - 150) {
            loadMoreVoucher();
        }
    });
</script>