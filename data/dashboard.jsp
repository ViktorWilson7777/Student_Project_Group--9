<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.dashboard-shell{
    display:flex;
    flex-direction:column;
    gap:22px;
}

.dashboard-hero{
    position:relative;
    overflow:hidden;
    border-radius:22px;
    padding:28px 30px;
    background:linear-gradient(135deg,#161f3d 0%, #283a74 50%, #ff7b54 100%);
    color:#fff;
    box-shadow:0 18px 40px rgba(20,31,61,0.22);
}

.dashboard-hero::after{
    content:"";
    position:absolute;
    right:-60px;
    top:-60px;
    width:220px;
    height:220px;
    border-radius:50%;
    background:rgba(255,255,255,0.08);
}

.dashboard-hero h2{
    margin:0 0 8px;
    color:#fff;
    font-size:30px;
    font-weight:800;
}

.dashboard-hero p{
    margin:0;
    color:rgba(255,255,255,0.86);
    max-width:720px;
    line-height:1.6;
}

.hero-strip{
    margin-top:20px;
    display:flex;
    flex-wrap:wrap;
    gap:10px;
}

.hero-pill{
    padding:10px 14px;
    border-radius:999px;
    background:rgba(255,255,255,0.14);
    border:1px solid rgba(255,255,255,0.16);
    color:#fff;
    font-size:14px;
    font-weight:600;
}

.kpi-grid{
    display:grid;
    grid-template-columns:repeat(4,minmax(180px,1fr));
    gap:16px;
}

.kpi-card{
    position:relative;
    background:#fff;
    border-radius:18px;
    padding:20px 20px 18px;
    box-shadow:0 10px 28px rgba(17,24,39,0.08);
    border:1px solid #eef1f5;
    overflow:hidden;
}

.kpi-card::before{
    content:"";
    position:absolute;
    left:0;
    top:0;
    width:100%;
    height:4px;
    background:linear-gradient(90deg,#ff6b4a,#ff9f6a);
}

.kpi-top{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:12px;
}

.kpi-label{
    font-size:13px;
    color:#6b7280;
    text-transform:uppercase;
    letter-spacing:0.08em;
    font-weight:700;
}

.kpi-icon{
    width:42px;
    height:42px;
    border-radius:14px;
    display:flex;
    align-items:center;
    justify-content:center;
    background:linear-gradient(135deg,#fff3ee,#ffe1d3);
    font-size:18px;
}

.kpi-value{
    font-size:30px;
    font-weight:800;
    color:#0f172a;
    line-height:1.1;
}

.kpi-sub{
    margin-top:8px;
    font-size:13px;
    color:#7b8597;
}

.status-grid{
    display:grid;
    grid-template-columns:repeat(4,minmax(160px,1fr));
    gap:14px;
}

.status-card{
    padding:16px 18px;
    border-radius:18px;
    color:#fff;
    box-shadow:0 12px 24px rgba(17,24,39,0.10);
}

.status-card .status-name{
    font-size:13px;
    font-weight:700;
    text-transform:uppercase;
    letter-spacing:0.08em;
    opacity:0.92;
}

.status-card .status-value{
    margin-top:10px;
    font-size:28px;
    font-weight:800;
}

.status-created{ background:linear-gradient(135deg,#ff9f43,#ffb36c); }
.status-paid{ background:linear-gradient(135deg,#1d9bf0,#55b6ff); }
.status-completed{ background:linear-gradient(135deg,#1ca678,#3fd4a5); }
.status-canceled{ background:linear-gradient(135deg,#fa5252,#ff7b7b); }

.panel-grid{
    display:grid;
    grid-template-columns:1.4fr 1fr;
    gap:18px;
}

.panel-grid-equal{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:18px;
}

.panel{
    background:#fff;
    border:1px solid #eef1f5;
    border-radius:22px;
    box-shadow:0 10px 28px rgba(17,24,39,0.08);
    overflow:hidden;
}

.panel-head{
    padding:18px 22px;
    border-bottom:1px solid #f1f3f7;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:12px;
}

.panel-head h3{
    margin:0;
    color:#111827;
    font-size:20px;
    font-weight:800;
}

.panel-head span{
    color:#7b8597;
    font-size:13px;
}

.panel-body{
    padding:20px 22px 24px;
}

.chart-box{
    height:330px;
}

.chart-box.small{
    height:300px;
}

.list-table{
    width:100%;
    border-collapse:collapse;
}

.list-table th,
.list-table td{
    padding:12px 10px;
    border-bottom:1px solid #f1f3f7;
    text-align:left;
    font-size:14px;
    vertical-align:top;
}

.list-table th{
    color:#6b7280;
    font-size:12px;
    text-transform:uppercase;
    letter-spacing:0.08em;
    font-weight:800;
}

.list-table tr:last-child td{
    border-bottom:none;
}

.metric-badge{
    display:inline-flex;
    align-items:center;
    gap:6px;
    padding:6px 10px;
    border-radius:999px;
    background:#fff3ee;
    color:#ef5b2a;
    font-size:12px;
    font-weight:700;
}

.alert-list{
    display:flex;
    flex-direction:column;
    gap:12px;
}

.alert-item{
    display:flex;
    justify-content:space-between;
    gap:16px;
    align-items:flex-start;
    padding:16px;
    border-radius:16px;
    background:#f8fafc;
    border:1px solid #eef2f7;
}

.alert-item strong{
    display:block;
    color:#111827;
    margin-bottom:4px;
}

.alert-meta{
    color:#6b7280;
    font-size:13px;
}

.tag-danger,
.tag-warning,
.tag-soft{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    min-width:78px;
    padding:7px 10px;
    border-radius:999px;
    font-size:12px;
    font-weight:800;
}

.tag-danger{ background:#fff1f1; color:#e03131; }
.tag-warning{ background:#fff8e6; color:#d97706; }
.tag-soft{ background:#eef8ff; color:#1d7fd9; }

.empty-state{
    color:#94a3b8;
    text-align:center;
    padding:18px 0;
}

@media (max-width: 1280px){
    .kpi-grid{ grid-template-columns:repeat(2,minmax(180px,1fr)); }
    .status-grid{ grid-template-columns:repeat(2,minmax(160px,1fr)); }
    .panel-grid,
    .panel-grid-equal{ grid-template-columns:1fr; }
}

@media (max-width: 720px){
    .kpi-grid,
    .status-grid{ grid-template-columns:1fr; }
}
</style>

<div class="dashboard-shell">
    <div class="dashboard-hero">
        <h2>Sales Intelligence Dashboard</h2>
        
        <div class="hero-strip">
            <div class="hero-pill">Today Orders: ${summary.todayOrders}</div>
            <div class="hero-pill">Active Vouchers: ${summary.activeVouchers}</div>
            <div class="hero-pill">Month Revenue: ${summary.monthRevenue}</div>
            <div class="hero-pill">Cancel Rate: ${summary.cancelRate}%</div>
        </div>
    </div>

    <div class="kpi-grid">
        <div class="kpi-card">
            <div class="kpi-top"><div class="kpi-label">Users</div><div class="kpi-icon">👤</div></div>
            <div class="kpi-value">${summary.totalUsers}</div>
            <div class="kpi-sub">Registered accounts in the system</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-top"><div class="kpi-label">Shops</div><div class="kpi-icon">🏪</div></div>
            <div class="kpi-value">${summary.totalShops}</div>
            <div class="kpi-sub">Seller stores currently available</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-top"><div class="kpi-label">Products</div><div class="kpi-icon">📦</div></div>
            <div class="kpi-value">${summary.totalProducts}</div>
            <div class="kpi-sub">Main product records in catalog</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-top"><div class="kpi-label">Variants</div><div class="kpi-icon">🎯</div></div>
            <div class="kpi-value">${summary.totalVariants}</div>
            <div class="kpi-sub">Size and color variants tracked</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-top"><div class="kpi-label">Orders</div><div class="kpi-icon">🧾</div></div>
            <div class="kpi-value">${summary.totalOrders}</div>
            <div class="kpi-sub">All orders ever created</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-top"><div class="kpi-label">Total Revenue</div><div class="kpi-icon">💰</div></div>
            <div class="kpi-value">${summary.totalRevenue}</div>
            <div class="kpi-sub">Paid and completed order revenue</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-top"><div class="kpi-label">Today Revenue</div><div class="kpi-icon">📈</div></div>
            <div class="kpi-value">${summary.todayRevenue}</div>
            <div class="kpi-sub">Revenue generated today</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-top"><div class="kpi-label">Vouchers</div><div class="kpi-icon">🎟️</div></div>
            <div class="kpi-value">${summary.totalVouchers}</div>
            <div class="kpi-sub">Promotion codes in database</div>
        </div>
    </div>

    <div class="status-grid">
        <div class="status-card status-created">
            <div class="status-name">To Pay</div>
            <div class="status-value">${summary.createdOrders}</div>
        </div>
        <div class="status-card status-paid">
            <div class="status-name">To Ship</div>
            <div class="status-value">${summary.paidOrders}</div>
        </div>
        <div class="status-card status-completed">
            <div class="status-name">Completed</div>
            <div class="status-value">${summary.completedOrders}</div>
        </div>
        <div class="status-card status-canceled">
            <div class="status-name">Canceled</div>
            <div class="status-value">${summary.canceledOrders}</div>
        </div>
    </div>

    <div class="panel-grid">
        <div class="panel">
            <div class="panel-head">
                <h3>Orders & Revenue Trend</h3>
                <span>Last 7 days</span>
            </div>
            <div class="panel-body">
                <div class="chart-box"><canvas id="trendChart"></canvas></div>
            </div>
        </div>

        <div class="panel">
            <div class="panel-head">
                <h3>Order Status Distribution</h3>
                <span>Current snapshot</span>
            </div>
            <div class="panel-body">
                <div class="chart-box small"><canvas id="statusChart"></canvas></div>
            </div>
        </div>
    </div>

    <div class="panel-grid-equal">
        <div class="panel">
            <div class="panel-head">
                <h3>Top Shops</h3>
                <span>By sold quantity</span>
            </div>
            <div class="panel-body">
                <div class="chart-box small"><canvas id="shopChart"></canvas></div>
                <div style="height:18px"></div>
                <table class="list-table">
                    <tr>
                        <th>Shop</th>
                        <th>Sold</th>
                        <th>Orders</th>
                        <th>Revenue</th>
                    </tr>
                    <c:forEach var="shop" items="${topShops}">
                        <tr>
                            <td>${shop.shopName}</td>
                            <td>${shop.soldQty}</td>
                            <td>${shop.totalOrders}</td>
                            <td>${shop.revenue}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty topShops}">
                        <tr><td colspan="4" class="empty-state">No sales data yet</td></tr>
                    </c:if>
                </table>
            </div>
        </div>

        <div class="panel">
            <div class="panel-head">
                <h3>Top Products</h3>
                <span>Best performers</span>
            </div>
            <div class="panel-body">
                <div class="chart-box small"><canvas id="productChart"></canvas></div>
                <div style="height:18px"></div>
                <table class="list-table">
                    <tr>
                        <th>Product</th>
                        <th>Sold</th>
                        <th>Orders</th>
                        <th>Revenue</th>
                    </tr>
                    <c:forEach var="product" items="${topProducts}">
                        <tr>
                            <td>${product.productName}</td>
                            <td>${product.soldQty}</td>
                            <td>${product.totalOrders}</td>
                            <td>${product.revenue}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty topProducts}">
                        <tr><td colspan="4" class="empty-state">No product performance data yet</td></tr>
                    </c:if>
                </table>
            </div>
        </div>
    </div>

    <div class="panel-grid-equal">
        <div class="panel">
            <div class="panel-head">
                <h3>Top Buyers</h3>
                <span>High-value customers</span>
            </div>
            <div class="panel-body">
                <table class="list-table">
                    <tr>
                        <th>User</th>
                        <th>Email</th>
                        <th>Orders</th>
                        <th>Spending</th>
                    </tr>
                    <c:forEach var="buyer" items="${topBuyers}">
                        <tr>
                            <td>${buyer.userName}</td>
                            <td>${buyer.email}</td>
                            <td><span class="metric-badge">${buyer.totalOrders} orders</span></td>
                            <td>${buyer.spending}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty topBuyers}">
                        <tr><td colspan="4" class="empty-state">No buyer activity yet</td></tr>
                    </c:if>
                </table>
            </div>
        </div>

        <div class="panel">
            <div class="panel-head">
                <h3>Operational Alerts</h3>
                <span>Low stock and expiring vouchers</span>
            </div>
            <div class="panel-body">
                <div class="alert-list">
                    <c:forEach var="item" items="${lowStock}">
                        <div class="alert-item">
                            <div>
                                <strong>${item.productName}</strong>
                                <div class="alert-meta">Variant: ${item.color} / ${item.size}</div>
                            </div>
                            <span class="tag-danger">Stock ${item.stock}</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty lowStock}">
                        <div class="alert-item">
                            <div>
                                <strong>No low-stock variants</strong>
                                <div class="alert-meta">Inventory looks healthy right now.</div>
                            </div>
                            <span class="tag-soft">Stable</span>
                        </div>
                    </c:if>

                    <c:forEach var="voucher" items="${expiringVouchers}">
                        <div class="alert-item">
                            <div>
                                <strong>${voucher.code}</strong>
                                <div class="alert-meta">Discount ${voucher.discountPercent}% • Ends ${voucher.endDate}</div>
                            </div>
                            <span class="tag-warning">${voucher.daysLeft} day(s)</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty expiringVouchers}">
                        <div class="alert-item">
                            <div>
                                <strong>No expiring vouchers soon</strong>
                                <div class="alert-meta">Promotion schedule is currently clear.</div>
                            </div>
                            <span class="tag-soft">Clear</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    const palette = {
        orange: '#ff6b4a',
        orangeSoft: 'rgba(255,107,74,0.18)',
        blue: '#2970ff',
        blueSoft: 'rgba(41,112,255,0.18)',
        green: '#17b26a',
        greenSoft: 'rgba(23,178,106,0.18)',
        red: '#f04438',
        yellow: '#f79009',
        slate: '#667085'
    };

    function destroyIfExists(id) {
        const chart = Chart.getChart(id);
        if (chart) {
            chart.destroy();
        }
    }

    destroyIfExists('trendChart');
    destroyIfExists('statusChart');
    destroyIfExists('shopChart');
    destroyIfExists('productChart');

    const dayLabels = [${dayLabels}];
    const orderValues = [${dayOrderValues}];
    const revenueValues = [${dayRevenueValues}];
    const statusLabels = [${statusLabels}];
    const statusValues = [${statusValues}];
    const shopLabels = [${shopLabels}];
    const shopValues = [${shopValues}];
    const productLabels = [${productLabels}];
    const productValues = [${productValues}];

    new Chart(document.getElementById('trendChart'), {
        type: 'line',
        data: {
            labels: dayLabels,
            datasets: [
                {
                    label: 'Orders',
                    data: orderValues,
                    borderColor: palette.blue,
                    backgroundColor: palette.blueSoft,
                    tension: 0.35,
                    fill: true,
                    yAxisID: 'y'
                },
                {
                    label: 'Revenue',
                    data: revenueValues,
                    borderColor: palette.orange,
                    backgroundColor: palette.orangeSoft,
                    tension: 0.35,
                    fill: true,
                    yAxisID: 'y1'
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: { mode: 'index', intersect: false },
            plugins: {
                legend: { position: 'top' }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: '#eef2f7' }
                },
                y1: {
                    beginAtZero: true,
                    position: 'right',
                    grid: { drawOnChartArea: false }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });

    new Chart(document.getElementById('statusChart'), {
        type: 'doughnut',
        data: {
            labels: statusLabels,
            datasets: [{
                data: statusValues,
                backgroundColor: ['#ff9f43', '#2970ff', '#17b26a', '#f04438'],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '68%',
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });

    new Chart(document.getElementById('shopChart'), {
        type: 'bar',
        data: {
            labels: shopLabels,
            datasets: [{
                label: 'Sold Qty',
                data: shopValues,
                backgroundColor: palette.blueSoft,
                borderColor: palette.blue,
                borderWidth: 1,
                borderRadius: 10
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { beginAtZero: true, grid: { color: '#eef2f7' } },
                y: { grid: { display: false } }
            }
        }
    });

    new Chart(document.getElementById('productChart'), {
        type: 'bar',
        data: {
            labels: productLabels,
            datasets: [{
                label: 'Sold Qty',
                data: productValues,
                backgroundColor: palette.orangeSoft,
                borderColor: palette.orange,
                borderWidth: 1,
                borderRadius: 10
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { beginAtZero: true, grid: { color: '#eef2f7' } },
                y: { grid: { display: false } }
            }
        }
    });
})();
</script>
