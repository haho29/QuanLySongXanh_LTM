<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GreenLife - Admin Dashboard</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; background-color: #F8F9FA; color: #333; }
        .font-serif { font-family: 'Playfair Display', serif; }
        .hide-scrollbar::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="flex bg-[#F8F9FA]">

<jsp:include page="includes/sidebar.jsp" />

<main class="ml-[260px] flex-1 min-h-screen p-8 lg:p-10">

    <!-- Header -->
    <div class="flex justify-between items-start mb-8">
        <div>
            <h1 class="text-3xl font-serif text-[#1F2937] font-semibold mb-1">Tổng Quan Hệ Thống</h1>
            <p class="text-sm text-gray-500">Cập nhật lần cuối: hôm nay, 08:30</p>
        </div>
        <button onclick="document.getElementById('exportModal').showModal()" class="px-5 py-2.5 bg-[#1B4332] text-white rounded-lg font-medium text-sm flex items-center gap-2 hover:bg-[#2D6A4F] transition-colors">
            <i class="fa-regular fa-file-excel"></i> Xuất Báo Cáo
        </button>
    </div>

    <!-- 4 Stats Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 mb-8">
        <!-- Card 1 -->
        <div class="bg-white rounded-xl p-5 shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50">
             <div class="w-8 h-8 rounded-full bg-green-50 text-green-500 flex items-center justify-center mb-4">
                 <i class="fa-solid fa-user-group text-sm"></i>
             </div>
             <h3 class="text-2xl font-bold text-gray-800 mb-1">${totalUsersCount}</h3>
             <p class="text-xs font-medium text-gray-500 mb-2">Tổng Người Dùng</p>
             <p class="text-xs font-bold text-green-600">+${newUsersThisWeek} tuần này</p>
        </div>
        <!-- Card 2 -->
        <div class="bg-white rounded-xl p-5 shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50">
             <div class="w-8 h-8 rounded-full bg-yellow-50 text-yellow-500 flex items-center justify-center mb-4">
                 <i class="fa-solid fa-bullseye text-sm"></i>
             </div>
             <h3 class="text-2xl font-bold text-gray-800 mb-1">${activeGoalsCount}</h3>
             <p class="text-xs font-medium text-gray-500 mb-2">Mục Tiêu Đang Hoạt Động</p>
             <p class="text-xs font-bold text-orange-500">${categoryStats != null ? categoryStats.size() : 0} loại danh mục</p>
        </div>
        <!-- Card 3 -->
        <div class="bg-white rounded-xl p-5 shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50">
             <div class="w-8 h-8 rounded-full bg-teal-50 text-teal-500 flex items-center justify-center mb-4">
                 <i class="fa-regular fa-circle-check text-sm"></i>
             </div>
             <h3 class="text-2xl font-bold text-gray-800 mb-1">${completedGoalsCount}</h3>
             <p class="text-xs font-medium text-gray-500 mb-2">Mục Tiêu Hoàn Thành</p>
             <p class="text-xs font-bold text-emerald-500">Đạt ${activeGoalsCount + completedGoalsCount > 0 ? String.format("%.0f", (completedGoalsCount * 100.0) / (activeGoalsCount + completedGoalsCount)) : 0}% tỷ lệ</p>
        </div>
        <!-- Card 4 -->
        <div class="bg-white rounded-xl p-5 shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50">
             <div class="w-8 h-8 rounded-full bg-green-50 text-green-500 flex items-center justify-center mb-4">
                 <i class="fa-solid fa-leaf text-sm"></i>
             </div>
             <h3 class="text-2xl font-bold text-gray-800 mb-1">${co2ReducedThisMonth}</h3>
             <p class="text-xs font-medium text-gray-500 mb-2">CO2 Đã Giảm (tấn)</p>
             <p class="text-xs font-bold text-teal-600">Tháng này</p>
        </div>
    </div>

    <!-- Main Chart Box -->
    <div class="bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50 p-6 mb-8">
        <!-- Chart Header -->
        <div class="flex flex-col lg:flex-row justify-between items-start lg:items-center mb-6">
            <div>
                <h3 class="text-base font-bold text-gray-800">Biểu Đồ Thống Kê Người Dùng</h3>
                <p class="text-xs text-gray-400">Theo dõi xu hướng tăng trưởng hệ thống</p>
            </div>
            <!-- Filters -->
            <div class="flex flex-wrap items-center gap-2 mt-4 lg:mt-0">
                <div class="flex bg-gray-50 rounded p-1" id="chartTopicFilters">
                    <button data-topic="users" class="topic-btn px-3 py-1 bg-[#10B981] text-white text-[11px] font-medium rounded shadow-sm">Người dùng mới</button>
                    <button data-topic="checkins" class="topic-btn px-3 py-1 text-gray-500 text-[11px] font-medium hover:text-gray-800">Lượt check-in</button>
                    <button data-topic="points" class="topic-btn px-3 py-1 text-gray-500 text-[11px] font-medium hover:text-gray-800">Điểm xanh</button>
                </div>
                <div class="flex bg-gray-100 rounded p-1 ml-2" id="chartRangeFilters">
                    <button data-range="week" class="range-btn px-3 py-1 bg-white text-gray-800 text-[11px] font-medium rounded shadow-sm">Tuần này</button>
                    <button data-range="month" class="range-btn px-3 py-1 text-gray-500 text-[11px] font-medium hover:text-gray-800">Tháng này</button>
                </div>
            </div>
        </div>

        <!-- Chart Top Stats -->
        <div class="grid grid-cols-3 gap-4 mb-4">
             <div class="bg-gray-50/50 rounded-lg p-3">
                  <p class="text-[11px] text-gray-500 font-medium mb-1"><i class="fa-solid fa-user-plus text-[10px] text-green-500 mr-1"></i> Tổng cộng</p>
                  <p class="text-lg font-bold text-gray-800" id="chartTotalStat">0</p>
             </div>
             <div class="bg-gray-50/50 rounded-lg p-3">
                  <p class="text-[11px] text-gray-500 font-medium mb-1"><i class="fa-solid fa-chart-line text-[10px] text-gray-400 mr-1"></i> Trung bình / kỳ</p>
                  <p class="text-lg font-bold text-gray-800" id="chartAvgStat">0</p>
             </div>
             <div class="bg-gray-50/50 rounded-lg p-3">
                  <p class="text-[11px] text-gray-500 font-medium mb-1" id="chartMaxLabelTitle"><i class="fa-solid fa-arrow-up text-[10px] text-blue-500 mr-1"></i> Cao nhất</p>
                  <p class="text-lg font-bold text-gray-800" id="chartMaxStat">0</p>
             </div>
        </div>

        <!-- Functional Chart Area -->
        <div class="relative h-[250px] w-full mt-6 mb-4">
             <canvas id="adminChart" class="w-full h-full"></canvas>
        </div>
        
        <!-- Script config for Chart and Export -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // EXPORT LOGIC
                const exportBtns = document.querySelectorAll('.export-btn');
                const exportFilter = document.getElementById('adminExportFilter');
                const previewScopeName = document.getElementById('previewScopeName');
                const estimatedRows = document.getElementById('estimatedRows');
                
                // Base counts from JSP
                const totalUsers = ${totalUsersCount};
                const totalCategories = ${categoryStats != null ? categoryStats.size() : 0};
                const activeGoals = ${activeGoalsCount};
                
                exportBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        exportBtns.forEach(b => {
                            b.className = 'export-btn px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5';
                        });
                        this.className = 'export-btn px-4 py-1.5 border border-[#10B981] bg-green-50/50 text-[#10B981] rounded text-[11px] font-bold flex items-center gap-1.5';
                        let filterVal = this.getAttribute('data-filter');
                        exportFilter.value = filterVal;
                        
                        // Update preview texts
                        previewScopeName.innerText = this.innerText.trim();
                        if (filterVal === 'users') estimatedRows.innerText = totalUsers;
                        else if (filterVal === 'categories') estimatedRows.innerText = totalCategories;
                        else if (filterVal === 'weekly_stats' || filterVal === 'monthly_stats') estimatedRows.innerText = 30;
                        else estimatedRows.innerText = totalUsers + activeGoals + 10;
                    });
                });
                
                        let targetId = 'csv-preview-' + (filterVal === 'weekly_stats' || filterVal === 'monthly_stats' ? 'stats' : filterVal);
                        if (filterVal === 'all') targetId = 'csv-preview-overview';
                        
                        document.querySelectorAll('.csv-preview').forEach(el => el.classList.add('hidden'));
                        let tgt = document.getElementById(targetId);
                        if(tgt) tgt.classList.remove('hidden');
                    });
                });

                // CHART LOGIC
                const ctx = document.getElementById('adminChart').getContext('2d');
                let adminChart;
                
                let currentTopic = 'users';
                let currentRange = 'week';
                
                function fetchChartData() {
                    fetch(`${pageContext.request.contextPath}/admin/stats?topic=\${currentTopic}&range=\${currentRange}`)
                        .then(res => res.json())
                        .then(data => {
                            updateChart(data);
                            updateChartStats(data);
                        }).catch(err => console.error("Error fetching stats:", err));
                }
                
                function updateChartStats(data) {
                    document.getElementById('chartTotalStat').innerText = data.total;
                    document.getElementById('chartAvgStat').innerText = data.average;
                    document.getElementById('chartMaxStat').innerText = data.max;
                    document.getElementById('chartMaxLabelTitle').innerHTML = '<i class="fa-solid fa-arrow-up text-[10px] text-blue-500 mr-1"></i> Cao nhất (' + (data.maxLabel || '--') + ')';
                    
                    // Update Bottom Bar Charts
                    const barContainer = document.getElementById('bottomBarChartContainer');
                    if (barContainer) {
                        barContainer.innerHTML = '';
                        // Determine max value for percentage calculation
                        let maxVal = data.max > 0 ? data.max : 1; 
                        
                        // Try to render at most 7 last items to not clutter the UI
                        let startIndex = data.data.length > 7 ? data.data.length - 7 : 0;
                        for(let i = startIndex; i < data.data.length; i++) {
                            let val = data.data[i];
                            let label = data.labels[i];
                            let percentage = Math.max(10, Math.floor((val / maxVal) * 100)); // min 10% height to show
                            
                            let barDiv = document.createElement('div');
                            barDiv.className = 'w-full bg-[#A7F3D0] rounded hover:bg-[#34D399] transition-colors relative';
                            barDiv.style.height = percentage + '%';
                            
                            let span = document.createElement('span');
                            span.className = 'text-[9px] text-gray-400 block absolute -bottom-5 left-1/2 -translate-x-1/2';
                            span.innerText = label;
                            
                            let tooltip = document.createElement('span');
                            tooltip.className = 'text-[9px] text-gray-800 font-bold block absolute -top-4 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity';
                            tooltip.innerText = val;
                            
                            barDiv.classList.add('group');
                            barDiv.appendChild(tooltip);
                            barDiv.appendChild(span);
                            barContainer.appendChild(barDiv);
                        }
                    }
                }
                
                function updateChart(data) {
                    if (adminChart) {
                        adminChart.destroy();
                    }
                    adminChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                label: currentTopic === 'users' ? 'Người dùng mới' : (currentTopic === 'checkins' ? 'Lượt Check-in' : 'Điểm xanh'),
                                data: data.data,
                                borderColor: '#10B981',
                                backgroundColor: 'rgba(16, 185, 129, 0.1)',
                                borderWidth: 3,
                                pointBackgroundColor: '#10B981',
                                tension: 0.4,
                                fill: true
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { display: false }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: { color: 'rgba(0,0,0,0.05)' }
                                },
                                x: {
                                    grid: { display: false }
                                }
                            }
                        }
                    });
                }

                // Attach events for Topic filters
                const topicBtns = document.querySelectorAll('.topic-btn');
                topicBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        topicBtns.forEach(b => {
                            b.className = 'topic-btn px-3 py-1 text-gray-500 text-[11px] font-medium hover:text-gray-800';
                        });
                        this.className = 'topic-btn px-3 py-1 bg-[#10B981] text-white text-[11px] font-medium rounded shadow-sm';
                        currentTopic = this.getAttribute('data-topic');
                        fetchChartData();
                    });
                });

                // Attach events for Range filters
                const rangeBtns = document.querySelectorAll('.range-btn');
                rangeBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        rangeBtns.forEach(b => {
                            b.className = 'range-btn px-3 py-1 text-gray-500 text-[11px] font-medium hover:text-gray-800';
                        });
                        this.className = 'range-btn px-3 py-1 bg-white text-gray-800 text-[11px] font-medium rounded shadow-sm';
                        currentRange = this.getAttribute('data-range');
                        fetchChartData();
                    });
                });
                
                // Initial fetch
                fetchChartData();
            });
        </script>
        
        <!-- Bottom Bar Charts -->
        <div class="mt-12">
             <p class="text-[10px] font-bold text-gray-400 mb-2 uppercase tracking-wider">So Sánh Theo Kỳ</p>
             <div class="flex justify-between items-end h-8 gap-2 px-4 pb-4" id="bottomBarChartContainer">
             </div>
        </div>
    </div>

    <!-- 2 Column Bottom Layout -->
    <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">
        <!-- Left: Categorical Progress -->
        <div class="xl:col-span-2 bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50 p-6">
            <h3 class="text-base font-bold text-gray-800 mb-6">Thống Kê Theo Danh Mục</h3>
            <div class="space-y-5">
                <c:choose>
                    <c:when test="${not empty categoryStats}">
                        <c:forEach var="entry" items="${categoryStats}" varStatus="status">
                            <c:set var="total" value="${entry.value[0]}" />
                            <c:set var="completed" value="${entry.value[1]}" />
                            <c:set var="percent" value="${total > 0 ? (completed * 100 / total) : 0}" />
                            <div>
                                 <div class="flex justify-between text-xs mb-1.5"><span class="font-medium text-gray-700">${entry.key}</span><span class="text-gray-400">${total} mục tiêu <span class="text-gray-800 font-bold ml-1">${percent}%</span></span></div>
                                 <div class="w-full bg-gray-100 rounded-full h-1.5"><div class="bg-[#10B981] h-1.5 rounded-full" style="width: ${percent}%"></div></div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-sm text-gray-400">Chưa có dữ liệu danh mục</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Right: Recent Activities -->
        <div class="bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50 p-6 h-[400px] flex flex-col">
            <h3 class="text-base font-bold text-gray-800 mb-6">Hoạt Động Gần Đây</h3>
            <div class="space-y-5 overflow-y-auto hide-scrollbar flex-1 pr-2">
                <c:choose>
                    <c:when test="${not empty recentActivities}">
                        <c:forEach var="activity" items="${recentActivities}">
                            <div class="flex gap-3">
                                <div class="w-7 h-7 rounded-full bg-green-50 text-green-500 border border-green-100 flex items-center justify-center shrink-0 mt-0.5"><i class="fa-solid fa-leaf text-[10px]"></i></div>
                                <div>
                                    <p class="text-[13px] font-bold text-gray-800">${activity.fullName}</p>
                                    <p class="text-[11px] text-gray-500">${activity.activity_name}</p>
                                    <p class="text-[10px] text-gray-400 mt-1">${activity.time_ago}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-sm text-gray-400">Không có hoạt động nào</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <!-- Top Users Table -->
    <div class="bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50 p-6 mt-6 overflow-x-auto">
         <h3 class="text-base font-bold text-gray-800 mb-6">Top Người Dùng Tích Cực</h3>
         <table class="w-full text-left min-w-[700px]">
             <thead>
                 <tr class="border-b border-gray-100">
                     <th class="py-3 text-[11px] font-bold text-gray-400 uppercase tracking-widest w-8">#</th>
                     <th class="py-3 text-[11px] font-bold text-gray-400 uppercase tracking-widest">Người Dùng</th>
                     <th class="py-3 text-[11px] font-bold text-gray-400 uppercase tracking-widest">Nghề Nghiệp</th>
                     <th class="py-3 text-[11px] font-bold text-gray-400 uppercase tracking-widest">Địa Điểm</th>
                     <th class="py-3 text-[11px] font-bold text-gray-400 uppercase tracking-widest text-right">Điểm Xanh</th>
                     <th class="py-3 text-[11px] font-bold text-gray-400 uppercase tracking-widest text-right">Streak</th>
                 </tr>
             </thead>
             <tbody>
                <c:choose>
                    <c:when test="${not empty topUsers}">
                        <c:forEach var="u" items="${topUsers}" varStatus="status">
                            <tr class="border-b border-gray-50 last:border-0 hover:bg-gray-50/50">
                                <td class="py-4 text-sm font-bold text-orange-500">${status.index + 1}</td>
                                <td class="py-4 flex items-center gap-3">
                                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${u.username}" class="w-8 h-8 rounded-full bg-gray-100" />
                                    <span class="text-xs font-bold text-gray-800">${u.fullName}</span>
                                </td>
                                <td class="py-4 text-xs text-gray-500">${empty u.job ? 'Không xác định' : u.job}</td>
                                <td class="py-4 text-xs text-gray-500">${empty u.location ? 'Không xác định' : u.location}</td>
                                <td class="py-4 text-sm font-bold text-green-600 text-right">${u.points}</td>
                                <td class="py-4 text-xs font-bold text-orange-500 text-right"><i class="fa-solid fa-fire text-[10px] mr-1"></i> ${u.runStreak} ngày</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="6" class="text-center py-4 text-gray-400 text-sm">Chưa có người dùng nào</td></tr>
                    </c:otherwise>
                </c:choose>
             </tbody>
         </table>
    </div>

</main>

<!-- Modal Export Report (Phần 4) -->
<dialog id="exportModal" class="p-0 rounded-2xl shadow-2xl backdrop:bg-black/50 overflow-hidden w-full max-w-2xl mx-auto m-auto border-0 bg-white">
    <div class="flex flex-col h-full bg-white">
        <!-- Header -->
        <div class="px-6 py-4 flex justify-between items-center bg-white border-b border-gray-100">
            <div class="flex items-center gap-3">
                 <div class="w-8 h-8 bg-green-50 text-[#1B4332] rounded flex items-center justify-center">
                     <i class="fa-regular fa-file-excel"></i>
                 </div>
                 <div>
                     <h3 class="text-base font-bold text-gray-800">Xuất Báo Cáo Admin</h3>
                     <p class="text-[11px] text-gray-500">Kỳ: tháng 4 năm 2026 — Xuất lúc 23:41:15 19/4/2026</p>
                 </div>
            </div>
            <button onclick="document.getElementById('exportModal').close()" class="text-gray-400 hover:text-gray-600 transition-colors">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        
        <!-- Content -->
        <div class="p-6">

            <h4 class="text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-3">PHẠM VI DỮ LIỆU</h4>
            <div class="flex flex-wrap gap-2 mb-2" id="exportDataFilters">
                <button type="button" data-filter="all" class="export-btn px-4 py-1.5 border border-[#10B981] bg-green-50/50 text-[#10B981] rounded text-[11px] font-bold flex items-center gap-1.5"><i class="fa-solid fa-border-all"></i> Tất cả</button>
                <button type="button" data-filter="categories" class="export-btn px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-solid fa-list"></i> Danh mục</button>
                <button type="button" data-filter="users" class="export-btn px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-solid fa-user"></i> Người dùng</button>
                <button type="button" data-filter="weekly_stats" class="export-btn px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-regular fa-calendar"></i> Thống kê tuần</button>
                <button type="button" data-filter="monthly_stats" class="export-btn px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-solid fa-chart-column"></i> Thống kê tháng</button>
                <button type="button" data-filter="community" class="export-btn px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-solid fa-users"></i> Cộng đồng</button>
            </div>
            <p class="text-[11px] text-gray-500 mb-6">Ước tính <span class="font-bold text-gray-800" id="estimatedRows">${totalUsersCount + activeGoalsCount + 10}</span> dòng dữ liệu sẽ được xuất</p>
            
            <h4 class="text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-3">XEM TRƯỚC NỘI DUNG (CSV)</h4>
            <div class="border border-gray-200 rounded-lg overflow-hidden bg-[#1E1E1E]">
                 <div class="p-3 bg-[#2D2D2D] text-gray-400 text-[11px] font-mono flex items-center justify-between border-b border-gray-700">
                     <span><i class="fa-solid fa-file-csv text-[#10B981] mr-2"></i> preview.csv</span>
                     <span id="previewScopeName" class="px-2 py-0.5 bg-gray-700 rounded text-gray-300">Tất cả</span>
                 </div>
                 <div class="p-4 overflow-x-auto">
                     <pre class="text-[#D4D4D4] font-mono text-[11px] leading-relaxed whitespace-pre" id="csvPreviewContainer">
<div id="csv-preview-overview" class="csv-preview">--- TỔNG QUAN HỆ THỐNG ---
Thời gian xuất:, 2026-05-01 15:30:00
Tổng Người Dùng:, ${totalUsersCount}
Tổng Danh Mục:, ${categoryStats != null ? categoryStats.size() : 0}
Mục Tiêu Đang Hoạt Động:, ${activeGoalsCount}
Mục Tiêu Hoàn Thành:, ${completedGoalsCount}</div>
<div id="csv-preview-categories" class="csv-preview hidden">--- DANH SÁCH DANH MỤC ---
Tên Danh Mục,Tổng Mục Tiêu,Mục Tiêu Hoàn Thành
<c:forEach var="entry" items="${categoryStats}" end="2">"${entry.key}",${entry.value[0]},${entry.value[1]}
</c:forEach>...</div>
<div id="csv-preview-users" class="csv-preview hidden">--- DANH SÁCH NGƯỜI DÙNG ---
ID,Tên đăng nhập,Họ tên,Email,Nghề nghiệp,Địa điểm,Vai trò,Tổng Điểm
<c:forEach var="u" items="${topUsers}" end="2">${u.id},"${u.username}","${u.fullName}","${u.email}","${empty u.job ? '' : u.job}","${empty u.location ? '' : u.location}","${u.role}",${u.points}
</c:forEach>...</div>
<div id="csv-preview-community" class="csv-preview hidden">--- BẢNG XẾP HẠNG CỘNG ĐỒNG ---
Hạng,Khu vực,Số Thành Viên,Tổng Điểm Xanh
<c:forEach var="c" items="${communityRanking}" end="2">${c.rank},"${c.location}",${c.members},${c.total_points}
</c:forEach>...</div>
<div id="csv-preview-stats" class="csv-preview hidden">--- THỐNG KÊ LƯỢT CHECK-IN VÀ ĐIỂM XANH ---
Ngày,Lượt Check-in,Điểm Xanh
"2026-05-01",25,350
"2026-04-30",18,210
...</div>
                     </pre>
                 </div>
            </div>
        </div>
        
        <!-- Footer actions -->
        <div class="px-6 py-4 flex justify-between items-center border-t border-gray-100 mt-auto">
            <span class="text-[11px] text-gray-400">File: GreenLife_Admin_BaoCao_2026.csv</span>
            <div class="flex gap-3">
                <button onclick="document.getElementById('exportModal').close()" class="px-5 py-2 bg-white border border-gray-200 text-gray-600 font-bold text-sm rounded-lg hover:bg-gray-50 transition-colors">
                    Hủy
                </button>
                <form action="${pageContext.request.contextPath}/export" method="GET" onsubmit="setTimeout(() => document.getElementById('exportModal').close(), 1000)">
                    <input type="hidden" name="type" value="admin" />
                    <input type="hidden" name="filter" value="all" id="adminExportFilter" />
                    <button type="submit" class="px-5 py-2 bg-[#1B4332] text-white font-bold text-sm rounded-lg hover:bg-[#2D6A4F] transition-all flex items-center gap-2 shadow-md cursor-pointer">
                        <i class="fa-solid fa-download text-xs"></i> Tải xuống .CSV
                    </button>
                </form>
            </div>
        </div>
    </div>
</dialog>

</body>
</html>
