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
            <button class="px-6 py-2.5 bg-white border border-gray-200 text-gray-600 font-bold rounded-xl hover:bg-gray-50 transition-all text-[13px] flex items-center gap-2">
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
        <button class="px-8 py-4 text-sm font-bold border-b-2 tab-active transition-all whitespace-nowrap">Tổng Quan</button>
        <button class="px-8 py-4 text-sm font-bold text-gray-400 border-b-2 border-transparent hover:text-gray-600 transition-all whitespace-nowrap">Lịch Sử</button>
        <button class="px-8 py-4 text-sm font-bold text-gray-400 border-b-2 border-transparent hover:text-gray-600 transition-all whitespace-nowrap">Huy Hiệu</button>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
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
</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>
