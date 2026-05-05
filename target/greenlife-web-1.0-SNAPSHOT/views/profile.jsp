<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân - GreenLife</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; background-color: #F9FAFB; color: #333; }
        .font-serif { font-family: 'Playfair Display', serif; }
        .glass-card { background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.2); }
        .tab-active { border-bottom: 3px solid #10B981; color: #10B981; font-weight: 700; }
        .hide-scrollbar::-webkit-scrollbar { display: none; }
        .hide-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="antialiased min-h-screen pt-[80px]">

<jsp:include page="includes/navbar.jsp" />

<div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    
    <!-- Profile Header Card -->
    <div class="bg-white rounded-[2rem] p-8 shadow-sm border border-gray-100 flex flex-col md:flex-row items-center gap-8 mb-8 relative overflow-hidden">
        <div class="absolute top-0 right-0 p-10 opacity-[0.03] pointer-events-none transform translate-x-10 -translate-y-10">
            <i class="fa-solid fa-seedling text-[200px]"></i>
        </div>
        
        <!-- Initial-based Avatar -->
        <div class="w-28 h-28 rounded-3xl bg-[#10B981] flex items-center justify-center text-white text-5xl font-black shadow-xl shadow-green-500/20 relative">
            <c:out value="${fn:substring(sessionScope.currentUser.fullName, 0, 1)}" />
            <div class="absolute -bottom-1 -right-1 w-6 h-6 bg-white rounded-full flex items-center justify-center">
                <i class="fa-solid fa-circle-check text-green-500 text-sm"></i>
            </div>
        </div>
        
        <div class="flex-1 text-center md:text-left">
            <h1 class="text-3xl font-serif font-extrabold text-gray-900 mb-2">${sessionScope.currentUser.fullName}</h1>
            <p class="text-gray-400 font-medium text-sm mb-4">${sessionScope.currentUser.email}</p>
            
            <div class="flex flex-wrap justify-center md:justify-start items-center gap-4 text-[13px] text-gray-500 font-bold">
                <span class="flex items-center gap-2 px-3 py-1 bg-gray-50 rounded-full border border-gray-100">
                    <i class="fa-solid fa-briefcase text-gray-400"></i> ${sessionScope.currentUser.job != null ? sessionScope.currentUser.job : 'Chưa cập nhật'}
                </span>
                <span class="flex items-center gap-2 px-3 py-1 bg-gray-50 rounded-full border border-gray-100">
                    <i class="fa-solid fa-map-pin text-gray-400"></i> ${sessionScope.currentUser.location != null ? sessionScope.currentUser.location : 'Chưa cập nhật'}
                </span>
            </div>
        </div>
        
        <div class="shrink-0">
            <button onclick="document.getElementById('editProfileModal').showModal()" class="px-6 py-2.5 bg-white border border-gray-200 text-gray-600 font-bold rounded-xl hover:bg-gray-50 transition-all text-[13px] flex items-center gap-2">
                <i class="fa-solid fa-pen-to-square"></i> Chỉnh Sửa
            </button>
        </div>
    </div>

    <!-- Quick Stats Grid -->
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-10">
        <!-- Card 1 -->
        <div class="bg-white p-6 rounded-[2rem] border border-gray-50 shadow-sm hover:shadow-md transition-shadow group">
            <div class="w-10 h-10 rounded-2xl bg-green-50 text-[#10B981] flex items-center justify-center mb-4 text-lg group-hover:scale-110 transition-transform">
                <i class="fa-solid fa-flag"></i>
            </div>
            <p class="text-2xl font-black text-gray-800 mb-1">${inProgressCount}</p>
            <p class="text-[11px] font-bold text-gray-400 uppercase tracking-wider">Mục Tiêu Đang Thực Hiện</p>
        </div>
        <!-- Card 2 -->
        <div class="bg-white p-6 rounded-[2rem] border border-gray-50 shadow-sm hover:shadow-md transition-shadow group">
            <div class="w-10 h-10 rounded-2xl bg-teal-50 text-teal-500 flex items-center justify-center mb-4 text-lg group-hover:scale-110 transition-transform">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <p class="text-2xl font-black text-gray-800 mb-1">${completedCount}</p>
            <p class="text-[11px] font-bold text-gray-400 uppercase tracking-wider">Mục Tiêu Hoàn Thành</p>
        </div>
        <!-- Card 3 -->
        <div class="bg-white p-6 rounded-[2rem] border border-gray-50 shadow-sm hover:shadow-md transition-shadow group">
            <div class="w-10 h-10 rounded-2xl bg-orange-50 text-orange-500 flex items-center justify-center mb-4 text-lg group-hover:scale-110 transition-transform">
                <i class="fa-solid fa-fire"></i>
            </div>
            <p class="text-2xl font-black text-gray-800 mb-1">${streak} ngày</p>
            <p class="text-[11px] font-bold text-gray-400 uppercase tracking-wider">Streak Hiện Tại</p>
        </div>
        <!-- Card 4 -->
        <div class="bg-white p-6 rounded-[2rem] border border-gray-50 shadow-sm hover:shadow-md transition-shadow group">
            <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-500 flex items-center justify-center mb-4 text-lg group-hover:scale-110 transition-transform">
                <i class="fa-solid fa-leaf"></i>
            </div>
            <p class="text-2xl font-black text-gray-800 mb-1">${totalPoints}</p>
            <p class="text-[11px] font-bold text-gray-400 uppercase tracking-wider">Điểm Xanh</p>
        </div>
    </div>

    <!-- Content Tabs -->
    <div class="flex justify-center border-b border-gray-100 mb-10 overflow-x-auto hide-scrollbar">
        <button onclick="switchTab(this, 'overview')" class="tab-btn px-8 py-4 text-sm font-bold border-b-2 tab-active transition-all whitespace-nowrap">Tổng Quan</button>
        <button onclick="switchTab(this, 'history')" class="tab-btn px-8 py-4 text-sm font-bold text-gray-400 border-b-2 border-transparent hover:text-gray-600 transition-all whitespace-nowrap">Lịch Sử</button>
        <button onclick="switchTab(this, 'stats')" class="tab-btn px-8 py-4 text-sm font-bold text-gray-400 border-b-2 border-transparent hover:text-gray-600 transition-all whitespace-nowrap">Thống Kê</button>
        <button onclick="switchTab(this, 'badges')" class="tab-btn px-8 py-4 text-sm font-bold text-gray-400 border-b-2 border-transparent hover:text-gray-600 transition-all whitespace-nowrap">Huy Hiệu</button>
    </div>

    <div id="tab-overview" class="tab-content grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        <!-- Active Goals List -->
        <div class="lg:col-span-2 space-y-6">
            <h3 class="text-lg font-bold text-gray-800 mb-6 flex items-center gap-2">
                <i class="fa-solid fa-list-ul text-[#10B981]"></i> Mục Tiêu Đang Thực Hiện
            </h3>
            
            <c:choose>
                <c:when test="${empty activeGoals}">
                    <div class="bg-white rounded-3xl p-12 text-center border border-gray-50 shadow-sm">
                        <i class="fa-solid fa-leaf text-gray-200 text-4xl mb-4 block"></i>
                        <p class="text-gray-400 font-medium">Bạn không có mục tiêu nào đang thực hiện.</p>
                        <a href="${pageContext.request.contextPath}/goals" class="inline-block mt-4 text-[#10B981] font-bold text-sm">Khám phá ngay</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="goal" items="${activeGoals}">
                        <div class="bg-white rounded-3xl p-6 border border-gray-50 shadow-sm hover:shadow-md transition-all">
                            <div class="flex items-center gap-5 mb-5">
                                <div class="w-12 h-12 rounded-2xl bg-gray-50 flex items-center justify-center text-xl shrink-0
                                    ${goal.category == 'Tiết Kiệm Điện' ? 'bg-orange-50 text-orange-500' : ''}
                                    ${goal.category == 'Tiết Kiệm Nước' ? 'bg-blue-50 text-blue-500' : ''}
                                    ${goal.category == 'Giảm Rác Nhựa' ? 'bg-green-50 text-green-500' : ''}">
                                    <i class="fa-solid 
                                        ${goal.category == 'Tiết Kiệm Điện' ? 'fa-bolt' : (goal.category == 'Tiết Kiệm Nước' ? 'fa-droplet' : 'fa-leaf')}"></i>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <h4 class="text-base font-extrabold text-gray-800 mb-1 truncate">${goal.title}</h4>
                                    <p class="text-[12px] text-gray-400 font-medium truncate">${goal.category}</p>
                                </div>
                                <div class="text-right">
                                    <span class="text-xs font-black text-gray-400">${goal.currentProgress}/${goal.targetProgress} ngày</span>
                                    <p class="text-sm font-black text-[#10B981]">${Math.round((goal.currentProgress * 100.0) / goal.targetProgress)}%</p>
                                </div>
                            </div>
                            <!-- Progress Bar -->
                            <div class="w-full h-2.5 bg-gray-50 rounded-full overflow-hidden">
                                <div class="h-full bg-gradient-to-r from-green-400 to-[#10B981] rounded-full transition-all duration-1000" style="width: ${(goal.currentProgress * 100.0) / goal.targetProgress}%"></div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Mini Leaderboard -->
        <div class="lg:col-span-1">
            <div class="bg-white rounded-[2rem] p-8 border border-gray-50 shadow-sm">
                <h3 class="text-lg font-bold text-gray-800 mb-8 pb-4 border-b border-gray-50">Bảng Xếp Hạng Cộng Đồng</h3>
                
                <div class="space-y-6">
                    <c:forEach var="topUser" items="${topUsers}" varStatus="loop">
                        <div class="flex items-center gap-4 group cursor-pointer ${topUser.id == sessionScope.currentUser.id ? 'bg-green-50/50 -mx-4 px-4 py-3 rounded-2xl' : ''}">
                            <div class="w-7 h-7 rounded-full flex items-center justify-center text-[10px] font-black 
                                ${loop.index == 0 ? 'bg-yellow-400 text-white shadow-lg shadow-yellow-200' : 
                                  loop.index == 1 ? 'bg-gray-300 text-white shadow-lg shadow-gray-200' : 
                                  loop.index == 2 ? 'bg-orange-300 text-white shadow-lg shadow-orange-100' : 'bg-gray-100 text-gray-400'}">
                                ${loop.index + 1}
                            </div>
                            <div class="w-10 h-10 rounded-full overflow-hidden bg-gray-100 shrink-0 border-2 border-white shadow-sm">
                                <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${topUser.username}" alt="User" class="w-full h-full object-cover">
                            </div>
                            <div class="flex-1 min-w-0">
                                <h5 class="text-[13px] font-bold text-gray-800 truncate">${topUser.fullName}</h5>
                                <p class="text-[10px] text-gray-400 font-medium truncate">${topUser.job != null ? topUser.job : 'Người dùng GreenLife'}</p>
                            </div>
                            <div class="text-right shrink-0">
                                <span class="text-[13px] font-black text-gray-700">${topUser.points}</span>
                                <p class="text-[9px] text-[#10B981] font-bold uppercase tracking-tighter">Điểm</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <a href="${pageContext.request.contextPath}/leaderboard" class="block w-full text-center mt-10 py-3 rounded-2xl bg-gray-50 text-gray-500 font-bold text-xs hover:bg-gray-100 transition-colors">
                    Xem Bảng Xếp Hạng Chi Tiết
                </a>
            </div>
        </div>
    </div>

    <!-- History Tab Content -->
    <div id="tab-history" class="tab-content hidden space-y-6">
        <h3 class="text-lg font-bold text-gray-800 mb-6 flex items-center gap-2">
            <i class="fa-solid fa-clock-rotate-left text-[#10B981]"></i> Lịch Sử Check-in
        </h3>
        <div class="bg-white rounded-[2rem] overflow-hidden border border-gray-50 shadow-sm">
            <table class="w-full text-left">
                <thead class="bg-gray-50 border-b border-gray-100">
                    <tr>
                        <th class="px-6 py-4 text-[11px] font-bold text-gray-400 uppercase tracking-widest">Hành động</th>
                        <th class="px-6 py-4 text-[11px] font-bold text-gray-400 uppercase tracking-widest">Điểm</th>
                        <th class="px-6 py-4 text-[11px] font-bold text-gray-400 uppercase tracking-widest">Thời gian</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-50">
                    <c:forEach var="p" items="${progressHistory}">
                        <tr class="hover:bg-gray-50/50 transition-colors">
                            <td class="px-6 py-4">
                                <p class="text-sm font-bold text-gray-800">${p.activityName}</p>
                                <p class="text-[11px] text-gray-400">${p.notes}</p>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2 py-1 bg-green-50 text-green-600 text-[11px] font-bold rounded-lg">+${p.pointsEarned}</span>
                            </td>
                            <td class="px-6 py-4 text-xs text-gray-500">
                                ${p.createdAt}
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty progressHistory}">
                        <tr>
                            <td colspan="3" class="px-6 py-12 text-center text-gray-400 font-medium">Chưa có lịch sử check-in nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Stats Tab Content -->
    <div id="tab-stats" class="tab-content hidden space-y-8">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-bold text-gray-800 flex items-center gap-2">
                <i class="fa-solid fa-chart-pie text-[#10B981]"></i> Thống Kê Thành Tích
            </h3>
            <form action="${pageContext.request.contextPath}/export" method="GET">
                <input type="hidden" name="type" value="user" />
                <input type="hidden" name="filter" value="achieved_goals" />
                <button type="submit" class="px-5 py-2 bg-[#10B981] text-white font-bold text-[12px] rounded-xl hover:bg-[#0D9668] transition-all flex items-center gap-2 shadow-lg shadow-green-500/20">
                    <i class="fa-solid fa-download"></i> Xuất Báo Cáo (.CSV)
                </button>
            </form>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <!-- Points Chart -->
            <div class="bg-white p-8 rounded-[2rem] border border-gray-50 shadow-sm">
                <div class="flex justify-between items-center mb-8">
                    <h4 class="text-sm font-bold text-gray-800 uppercase tracking-wider">Điểm Xanh Tích Lũy</h4>
                    <select id="pointsRange" onchange="loadUserStats()" class="bg-gray-50 border-0 text-[11px] font-bold text-gray-500 rounded-lg px-3 py-1 outline-none">
                        <option value="week">7 ngày qua</option>
                        <option value="month">30 ngày qua</option>
                    </select>
                </div>
                <div class="h-[250px] w-full">
                    <canvas id="userPointsChart"></canvas>
                </div>
            </div>

            <!-- Categories Chart -->
            <div class="bg-white p-8 rounded-[2rem] border border-gray-50 shadow-sm">
                <h4 class="text-sm font-bold text-gray-800 uppercase tracking-wider mb-8 text-center">Mục Tiêu Đã Hoàn Thành</h4>
                <div class="h-[250px] w-full flex items-center justify-center">
                    <canvas id="userCategoriesChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Badges Tab Content -->
    <div id="tab-badges" class="tab-content hidden">
        <h3 class="text-lg font-bold text-gray-800 mb-8 flex items-center gap-2">
            <i class="fa-solid fa-award text-[#10B981]"></i> Huy Hiệu Đã Đạt
        </h3>
        <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-6">
            <!-- Example Badges -->
            <div class="flex flex-col items-center group">
                <div class="w-20 h-20 rounded-full bg-green-50 flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
                    <i class="fa-solid fa-seedling text-3xl text-green-500"></i>
                </div>
                <p class="text-[11px] font-bold text-gray-800 text-center">Mầm Non Xanh</p>
            </div>
            <div class="flex flex-col items-center group opacity-40 grayscale">
                <div class="w-20 h-20 rounded-full bg-blue-50 flex items-center justify-center mb-3">
                    <i class="fa-solid fa-water text-3xl text-blue-500"></i>
                </div>
                <p class="text-[11px] font-bold text-gray-800 text-center">Hộ Vệ Nguồn Nước</p>
            </div>
            <div class="flex flex-col items-center group opacity-40 grayscale">
                <div class="w-20 h-20 rounded-full bg-orange-50 flex items-center justify-center mb-3">
                    <i class="fa-solid fa-bolt text-3xl text-orange-500"></i>
                </div>
                <p class="text-[11px] font-bold text-gray-800 text-center">Kỹ Sư Tiết Kiệm</p>
            </div>
        </div>
    </div>
</div>

<script>
    let pointsChart, categoriesChart;

    function switchTab(btn, tabId) {
        // Update Buttons
        document.querySelectorAll('.tab-btn').forEach(b => {
            b.classList.remove('tab-active');
            b.classList.add('text-gray-400', 'border-transparent');
        });
        btn.classList.add('tab-active');
        btn.classList.remove('text-gray-400', 'border-transparent');

        // Update Content
        document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));
        document.getElementById('tab-' + tabId).classList.remove('hidden');

        if (tabId === 'stats') {
            loadUserStats();
        }
    }

    function loadUserStats() {
        const range = document.getElementById('pointsRange').value;
        fetch('${pageContext.request.contextPath}/user/stats?range=' + range)
            .then(res => res.json())
            .then(data => {
                renderPointsChart(data);
                renderCategoriesChart(data);
            });
    }

    function renderPointsChart(data) {
        const ctx = document.getElementById('userPointsChart').getContext('2d');
        if (pointsChart) pointsChart.destroy();
        pointsChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: data.labels,
                datasets: [{
                    label: 'Điểm Xanh',
                    data: data.pointsData,
                    borderColor: '#10B981',
                    backgroundColor: 'rgba(16, 185, 129, 0.1)',
                    tension: 0.4,
                    fill: true,
                    borderWidth: 3,
                    pointRadius: 4,
                    pointBackgroundColor: '#fff',
                    pointBorderColor: '#10B981',
                    pointBorderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { color: '#F3F4F6' }, border: { display: false } },
                    x: { grid: { display: false }, border: { display: false } }
                }
            }
        });
    }

    function renderCategoriesChart(data) {
        const ctx = document.getElementById('userCategoriesChart').getContext('2d');
        if (categoriesChart) categoriesChart.destroy();
        
        const labels = Object.keys(data.categories);
        const vals = Object.values(data.categories);
        
        if (labels.length === 0) {
            // No data placeholder if you want
            return;
        }

        categoriesChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    data: vals,
                    backgroundColor: ['#10B981', '#3B82F6', '#F59E0B', '#EF4444', '#8B5CF6'],
                    borderWidth: 0,
                    hoverOffset: 10
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: { position: 'bottom', labels: { usePointStyle: true, font: { size: 10, weight: 'bold' } } }
                }
            }
        });
    }
</script>

<jsp:include page="includes/footer.jsp" />

<!-- Edit Profile Modal -->
<dialog id="editProfileModal" class="p-0 rounded-2xl shadow-xl backdrop:bg-black/40 overflow-hidden w-full max-w-[450px] mx-auto m-auto border-0">
    <div class="bg-white flex flex-col h-full rounded-2xl">
        <div class="px-6 py-5 flex justify-between items-center border-b border-gray-50">
            <h3 class="text-[16px] font-bold text-gray-800">Chỉnh Sửa Hồ Sơ</h3>
            <button onclick="document.getElementById('editProfileModal').close()" class="text-gray-400 hover:text-gray-600 transition-colors w-8 h-8 rounded-full flex items-center justify-center hover:bg-gray-100">
                <i class="fa-solid fa-xmark text-lg"></i>
            </button>
        </div>
        
        <form action="${pageContext.request.contextPath}/profile" method="POST" class="px-6 py-6">
            <div class="space-y-5">
                <div>
                    <label class="block text-[12px] font-bold text-gray-400 uppercase tracking-widest mb-2 ml-1">Họ và Tên</label>
                    <input type="text" name="fullName" value="${sessionScope.currentUser.fullName}" required 
                        class="w-full bg-gray-50 border border-gray-100 rounded-xl py-3 px-4 text-sm font-medium focus:bg-white focus:border-green-500 outline-none transition-all" />
                </div>
                <div>
                    <label class="block text-[12px] font-bold text-gray-400 uppercase tracking-widest mb-2 ml-1">Nghề nghiệp</label>
                    <input type="text" name="job" value="${sessionScope.currentUser.job}" placeholder="VD: Sinh viên IT"
                        class="w-full bg-gray-50 border border-gray-100 rounded-xl py-3 px-4 text-sm font-medium focus:bg-white focus:border-green-500 outline-none transition-all" />
                </div>
                <div>
                    <label class="block text-[12px] font-bold text-gray-400 uppercase tracking-widest mb-2 ml-1">Địa điểm</label>
                    <input type="text" name="location" value="${sessionScope.currentUser.location}" placeholder="VD: TP. HCM"
                        class="w-full bg-gray-50 border border-gray-100 rounded-xl py-3 px-4 text-sm font-medium focus:bg-white focus:border-green-500 outline-none transition-all" />
                </div>
            </div>
            
            <div class="flex gap-3 mt-8">
                <button type="button" onclick="document.getElementById('editProfileModal').close()" 
                    class="flex-1 py-3 bg-gray-100 text-gray-500 font-bold rounded-xl hover:bg-gray-200 transition-colors text-sm">Hủy</button>
                <button type="submit" 
                    class="flex-1 py-3 bg-[#10B981] text-white font-bold rounded-xl hover:bg-[#0D9668] transition-all text-sm shadow-lg shadow-green-500/20">Lưu Thay Đổi</button>
            </div>
        </form>
    </div>
</dialog>

</body>
</html>
