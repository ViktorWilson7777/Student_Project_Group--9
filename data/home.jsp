<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body{
            margin:0;
            font-family:"Segoe UI",Arial,sans-serif;
            background:linear-gradient(180deg,#f6f8fb 0%,#eef2f7 100%);
            color:#1f2937;
        }

        .admin-shell{
            max-width:1440px;
            margin:26px auto 40px;
            padding:0 20px;
        }

        .admin-topbar{
            background:#fff;
            border:1px solid #eef1f5;
            border-radius:24px;
            box-shadow:0 12px 30px rgba(17,24,39,0.08);
            padding:24px 28px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:20px;
            flex-wrap:wrap;
        }

        .admin-title h1{
            margin:0;
            font-size:32px;
            font-weight:800;
            color:#111827;
        }

        .admin-title p{
            margin:8px 0 0;
            color:#6b7280;
        }

        .admin-userbox{
            display:flex;
            align-items:center;
            gap:14px;
        }

        .admin-avatar{
            width:52px;
            height:52px;
            border-radius:50%;
            background:linear-gradient(135deg,#ff6b4a,#ff9f6a);
            color:#fff;
            font-weight:800;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:20px;
            box-shadow:0 10px 24px rgba(255,107,74,0.28);
        }

        .admin-userbox strong{
            display:block;
            font-size:17px;
            color:#111827;
        }

        .admin-userbox span{
            color:#6b7280;
            font-size:14px;
        }

        .quick-actions{
            margin-top:18px;
            display:flex;
            gap:12px;
            flex-wrap:wrap;
        }

        .quick-btn{
            display:inline-flex;
            align-items:center;
            gap:8px;
            padding:10px 16px;
            border-radius:999px;
            background:#fff;
            border:1px solid #e8edf3;
            color:#344054;
            text-decoration:none;
            font-weight:700;
            transition:0.18s ease;
        }

        .quick-btn:hover{
            color:#ee4d2d;
            border-color:#ffd3c7;
            transform:translateY(-1px);
        }

        .management-tabs{
            margin-top:22px;
            display:flex;
            gap:12px;
            flex-wrap:wrap;
        }

        .management-tabs a{
            padding:12px 18px;
            border-radius:14px;
            background:#fff;
            border:1px solid #e8edf3;
            color:#344054;
            text-decoration:none;
            font-weight:700;
            box-shadow:0 6px 18px rgba(17,24,39,0.04);
            transition:0.2s ease;
        }

        .management-tabs a:hover,
        .management-tabs a.active-link{
            background:linear-gradient(135deg,#ff6b4a,#ff8b67);
            color:#fff;
            border-color:transparent;
            box-shadow:0 12px 28px rgba(255,107,74,0.24);
        }

        #content-area{
            margin-top:22px;
            min-height:360px;
        }

        @media (max-width: 760px){
            .admin-topbar{
                padding:20px;
            }

            .admin-title h1{
                font-size:26px;
            }
        }
    </style>
</head>
<body>
    <div class="admin-shell">
        <div class="admin-topbar">
            <div class="admin-title">
                <h1>Admin Control Center</h1>
                <p>Welcome back, ${sessionScope.account.name}. </p>
                <div class="quick-actions">
                    <a class="quick-btn" href="app-user-edit?id=${sessionScope.account.userId}">⚙ Edit My Profile</a>
                    <a class="quick-btn" href="logout">↪ Logout</a>
                </div>
            </div>

            <div class="admin-userbox">
                <div class="admin-avatar">
                    ${sessionScope.account.name.substring(0,1)}
                </div>
                <div>
                    <strong>${sessionScope.account.name}</strong>
                    <span>Role: ${sessionScope.account.role}</span>
                </div>
            </div>
        </div>

        <c:if test="${sessionScope.account.role == 'admin'}">
            <div class="management-tabs">
                <a href="#" data-url="dashboard" class="active-link" onclick="loadPage('dashboard', this); return false;">Dashboard</a>
                <a href="#" data-url="app-user-list" onclick="loadPage('app-user-list', this); return false;">Users</a>
                <a href="#" data-url="shop-list" onclick="loadPage('shop-list', this); return false;">Shops</a>
                <a href="#" data-url="product-list" onclick="loadPage('product-list', this); return false;">Products</a>
                <a href="#" data-url="product-variant-list" onclick="loadPage('product-variant-list', this); return false;">Product Variants</a>
                <a href="#" data-url="voucher-list" onclick="loadPage('voucher-list', this); return false;">Vouchers</a>
            </div>
        </c:if>

        <div id="content-area"></div>
    </div>

    <script>
        function loadPage(url, clickedLink) {
            fetch(url)
                .then(res => res.text())
                .then(html => {
                    const container = document.getElementById('content-area');
                    container.innerHTML = html;

                    document.querySelectorAll('.management-tabs a').forEach(a => a.classList.remove('active-link'));
                    if (clickedLink) {
                        clickedLink.classList.add('active-link');
                    } else {
                        const matched = document.querySelector('.management-tabs a[data-url="' + url + '"]');
                        if (matched) matched.classList.add('active-link');
                    }

                    const scripts = container.querySelectorAll('script');
                    scripts.forEach(oldScript => {
                        const newScript = document.createElement('script');
                        if (oldScript.src) {
                            newScript.src = oldScript.src;
                        } else {
                            newScript.text = oldScript.text;
                        }
                        document.body.appendChild(newScript);
                        oldScript.remove();
                    });
                })
                .catch(() => {
                    document.getElementById('content-area').innerHTML = '<div style="background:#fff;padding:28px;border-radius:18px;border:1px solid #eef1f5;box-shadow:0 10px 28px rgba(17,24,39,0.08);font-weight:700;color:#b42318;">Cannot load this module right now.</div>';
                });
        }

        document.addEventListener('DOMContentLoaded', function () {
            loadPage('dashboard');
        });
    </script>
</body>
</html>
