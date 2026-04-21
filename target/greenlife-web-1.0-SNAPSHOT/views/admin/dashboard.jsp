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
             <h3 class="text-2xl font-bold text-gray-800 mb-1">5,248</h3>
             <p class="text-xs font-medium text-gray-500 mb-2">Tổng Người Dùng</p>
             <p class="text-xs font-bold text-green-600">+124 tuần này</p>
        </div>
        <!-- Card 2 -->
        <div class="bg-white rounded-xl p-5 shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50">
             <div class="w-8 h-8 rounded-full bg-yellow-50 text-yellow-500 flex items-center justify-center mb-4">
                 <i class="fa-solid fa-bullseye text-sm"></i>
             </div>
             <h3 class="text-2xl font-bold text-gray-800 mb-1">1248</h3>
             <p class="text-xs font-medium text-gray-500 mb-2">Mục Tiêu Đang Hoạt Động</p>
             <p class="text-xs font-bold text-orange-500">4 loại danh mục</p>
        </div>
        <!-- Card 3 -->
        <div class="bg-white rounded-xl p-5 shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50">
             <div class="w-8 h-8 rounded-full bg-teal-50 text-teal-500 flex items-center justify-center mb-4">
                 <i class="fa-regular fa-circle-check text-sm"></i>
             </div>
             <h3 class="text-2xl font-bold text-gray-800 mb-1">10,842</h3>
             <p class="text-xs font-medium text-gray-500 mb-2">Mục Tiêu Hoàn Thành</p>
             <p class="text-xs font-bold text-emerald-500">87% tỷ lệ hoàn thành</p>
        </div>
        <!-- Card 4 -->
        <div class="bg-white rounded-xl p-5 shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50">
             <div class="w-8 h-8 rounded-full bg-green-50 text-green-500 flex items-center justify-center mb-4">
                 <i class="fa-solid fa-leaf text-sm"></i>
             </div>
             <h3 class="text-2xl font-bold text-gray-800 mb-1">24.1</h3>
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
                <div class="flex bg-gray-50 rounded p-1">
                    <button class="px-3 py-1 bg-[#10B981] text-white text-[11px] font-medium rounded shadow-sm">Người dùng mới</button>
                    <button class="px-3 py-1 text-gray-500 text-[11px] font-medium hover:text-gray-800">Lượt check-in</button>
                    <button class="px-3 py-1 text-gray-500 text-[11px] font-medium hover:text-gray-800">Điểm xanh</button>
                </div>
                <div class="flex bg-gray-100 rounded p-1 ml-2">
                    <button class="px-3 py-1 bg-white text-gray-800 text-[11px] font-medium rounded shadow-sm">Tuần này</button>
                    <button class="px-3 py-1 text-gray-500 text-[11px] font-medium hover:text-gray-800">Năm nay</button>
                </div>
            </div>
        </div>

        <!-- Chart Top Stats -->
        <div class="grid grid-cols-3 gap-4 mb-4">
             <div class="bg-gray-50/50 rounded-lg p-3">
                  <p class="text-[11px] text-gray-500 font-medium mb-1"><i class="fa-solid fa-user-plus text-[10px] text-green-500 mr-1"></i> Tổng cộng</p>
                  <p class="text-lg font-bold text-gray-800">194</p>
             </div>
             <div class="bg-gray-50/50 rounded-lg p-3">
                  <p class="text-[11px] text-gray-500 font-medium mb-1"><i class="fa-solid fa-chart-line text-[10px] text-gray-400 mr-1"></i> Trung bình / kỳ</p>
                  <p class="text-lg font-bold text-gray-800">28</p>
             </div>
             <div class="bg-gray-50/50 rounded-lg p-3">
                  <p class="text-[11px] text-gray-500 font-medium mb-1"><i class="fa-solid fa-arrow-up text-[10px] text-blue-500 mr-1"></i> Cao nhất (T7)</p>
                  <p class="text-lg font-bold text-gray-800">42</p>
             </div>
        </div>

        <!-- Fake Chart Area -->
        <div class="relative h-[220px] w-full mt-6 mb-4 flex items-end">
             <!-- SVG Line -->
             <svg viewBox="0 0 1000 220" preserveAspectRatio="none" class="w-full h-full absolute inset-0 z-10">
                 <defs>
                     <linearGradient id="chartGradient" x1="0" x2="0" y1="0" y2="1">
                         <stop offset="0%" stop-color="#10B981" stop-opacity="0.2" />
                         <stop offset="100%" stop-color="#10B981" stop-opacity="0" />
                     </linearGradient>
                 </defs>
                 <!-- Shadow Area -->
                 <path d="M0,150 C100,140 180,110 250,110 C350,110 400,160 500,160 C600,160 650,80 750,90 C850,100 900,40 1000,60 L1000,220 L0,220 Z" fill="url(#chartGradient)" />
                 <!-- Line -->
                 <path d="M0,150 C100,140 180,110 250,110 C350,110 400,160 500,160 C600,160 650,80 750,90 C850,100 900,40 1000,60" fill="none" stroke="#10B981" stroke-width="3" />
             </svg>
             <!-- Grid Lines -->
             <div class="absolute inset-0 flex flex-col justify-between pointer-events-none opacity-5 ز-0">
                 <div class="h-px w-full bg-black"></div>
                 <div class="h-px w-full bg-black"></div>
                 <div class="h-px w-full bg-black"></div>
                 <div class="h-px w-full bg-black"></div>
                 <div class="h-px w-full bg-black"></div>
             </div>
             <!-- Y Axis Labels -->
             <div class="absolute left-0 inset-y-0 flex flex-col justify-between text-[10px] text-gray-400 -ml-6 py-1 pointer-events-none">
                 <span>48</span><span>36</span><span>24</span><span>12</span><span>0</span>
             </div>
             <!-- X Axis Labels -->
             <div class="absolute bottom-[-24px] inset-x-0 flex justify-between text-[10px] text-gray-400 px-6 font-medium">
                 <span>T2</span><span>T3</span><span>T4</span><span>T5</span><span>T6</span><span>T7</span><span>CN</span>
             </div>
        </div>
        
        <!-- Bottom Bar Charts -->
        <div class="mt-12">
             <p class="text-[10px] font-bold text-gray-400 mb-2 uppercase tracking-wider">So Sánh Theo Kỳ</p>
             <div class="flex justify-between items-end h-8 gap-2 px-4">
                 <div class="w-full bg-[#A7F3D0] rounded hover:bg-[#34D399] transition-colors h-[40%] text-center"><span class="text-[9px] text-gray-400 block mt-8">T2</span></div>
                 <div class="w-full bg-[#A7F3D0] rounded hover:bg-[#34D399] transition-colors h-[50%] text-center"><span class="text-[9px] text-gray-400 block mt-8">T3</span></div>
                 <div class="w-full bg-[#A7F3D0] rounded hover:bg-[#34D399] transition-colors h-[30%] text-center"><span class="text-[9px] text-gray-400 block mt-8">T4</span></div>
                 <div class="w-full bg-[#A7F3D0] rounded hover:bg-[#34D399] transition-colors h-[70%] text-center"><span class="text-[9px] text-gray-400 block mt-8">T5</span></div>
                 <div class="w-full bg-[#A7F3D0] rounded hover:bg-[#34D399] transition-colors h-[45%] text-center"><span class="text-[9px] text-gray-400 block mt-8">T6</span></div>
                 <div class="w-full bg-[#A7F3D0] rounded hover:bg-[#34D399] transition-colors h-[90%] text-center"><span class="text-[9px] text-gray-400 block mt-8">T7</span></div>
                 <div class="w-full bg-[#A7F3D0] rounded hover:bg-[#34D399] transition-colors h-[65%] text-center"><span class="text-[9px] text-gray-400 block mt-8">CN</span></div>
             </div>
        </div>
    </div>

    <!-- 2 Column Bottom Layout -->
    <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">
        <!-- Left: Categorical Progress -->
        <div class="xl:col-span-2 bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50 p-6">
            <h3 class="text-base font-bold text-gray-800 mb-6">Thống Kê Theo Danh Mục</h3>
            <div class="space-y-5">
                <!-- Bar 1 -->
                <div>
                     <div class="flex justify-between text-xs mb-1.5"><span class="font-medium text-gray-700">Tiết kiệm điện</span><span class="text-gray-400">1,842 mục tiêu <span class="text-gray-800 font-bold ml-1">88%</span></span></div>
                     <div class="w-full bg-gray-100 rounded-full h-1.5"><div class="bg-[#F59E0B] h-1.5 rounded-full" style="width: 88%"></div></div>
                </div>
                <!-- Bar 2 -->
                <div>
                     <div class="flex justify-between text-xs mb-1.5"><span class="font-medium text-gray-700">Tiết kiệm nước</span><span class="text-gray-400">1,560 mục tiêu <span class="text-gray-800 font-bold ml-1">75%</span></span></div>
                     <div class="w-full bg-gray-100 rounded-full h-1.5"><div class="bg-[#3B82F6] h-1.5 rounded-full" style="width: 75%"></div></div>
                </div>
                <!-- Bar 3 -->
                <div>
                     <div class="flex justify-between text-xs mb-1.5"><span class="font-medium text-gray-700">Giảm rác nhựa</span><span class="text-gray-400">1,920 mục tiêu <span class="text-gray-800 font-bold ml-1">92%</span></span></div>
                     <div class="w-full bg-gray-100 rounded-full h-1.5"><div class="bg-[#10B981] h-1.5 rounded-full" style="width: 92%"></div></div>
                </div>
                <!-- Bar 4 -->
                <div>
                     <div class="flex justify-between text-xs mb-1.5"><span class="font-medium text-gray-700">Giao thông xanh</span><span class="text-gray-400">980 mục tiêu <span class="text-gray-800 font-bold ml-1">60%</span></span></div>
                     <div class="w-full bg-gray-100 rounded-full h-1.5"><div class="bg-[#8B5CF6] h-1.5 rounded-full" style="width: 60%"></div></div>
                </div>
                <!-- Bar 5 -->
                <div>
                     <div class="flex justify-between text-xs mb-1.5"><span class="font-medium text-gray-700">Ăn uống xanh</span><span class="text-gray-400">740 mục tiêu <span class="text-gray-800 font-bold ml-1">55%</span></span></div>
                     <div class="w-full bg-gray-100 rounded-full h-1.5"><div class="bg-[#22C55E] h-1.5 rounded-full" style="width: 55%"></div></div>
                </div>
                <!-- Bar 6 -->
                <div>
                     <div class="flex justify-between text-xs mb-1.5"><span class="font-medium text-gray-700">Phân loại rác</span><span class="text-gray-400">620 mục tiêu <span class="text-gray-800 font-bold ml-1">48%</span></span></div>
                     <div class="w-full bg-gray-100 rounded-full h-1.5"><div class="bg-[#F97316] h-1.5 rounded-full" style="width: 48%"></div></div>
                </div>
            </div>
        </div>

        <!-- Right: Recent Activities -->
        <div class="bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50 p-6 h-[400px] flex flex-col">
            <h3 class="text-base font-bold text-gray-800 mb-6">Hoạt Động Gần Đây</h3>
            <div class="space-y-5 overflow-y-auto hide-scrollbar flex-1 pr-2">
                <!-- Item 1 -->
                <div class="flex gap-3">
                    <div class="w-7 h-7 rounded-full bg-green-50 text-green-500 border border-green-100 flex items-center justify-center shrink-0 mt-0.5"><i class="fa-solid fa-check text-[10px]"></i></div>
                    <div>
                        <p class="text-[13px] font-bold text-gray-800">Trần Thị Lan</p>
                        <p class="text-[11px] text-gray-500">Hoàn thành mục tiêu Tiết kiệm điện</p>
                        <p class="text-[10px] text-gray-400 mt-1">5 phút trước</p>
                    </div>
                </div>
                <!-- Item 2 -->
                <div class="flex gap-3">
                    <div class="w-7 h-7 rounded-full bg-orange-50 text-orange-500 border border-orange-100 flex items-center justify-center shrink-0 mt-0.5"><i class="fa-solid fa-user text-[10px]"></i></div>
                    <div>
                        <p class="text-[13px] font-bold text-gray-800">Lê Văn Hùng</p>
                        <p class="text-[11px] text-gray-500">Đăng ký tài khoản mới</p>
                        <p class="text-[10px] text-gray-400 mt-1">12 phút trước</p>
                    </div>
                </div>
                <!-- Item 3 -->
                <div class="flex gap-3">
                    <div class="w-7 h-7 rounded-full bg-green-50 text-green-500 border border-green-100 flex items-center justify-center shrink-0 mt-0.5"><i class="fa-solid fa-check text-[10px]"></i></div>
                    <div>
                        <p class="text-[13px] font-bold text-gray-800">Phạm Thu Hà</p>
                        <p class="text-[11px] text-gray-500">Check-in mục tiêu Giảm rác nhựa</p>
                        <p class="text-[10px] text-gray-400 mt-1">28 phút trước</p>
                    </div>
                </div>
                <!-- Item 4 -->
                <div class="flex gap-3">
                    <div class="w-7 h-7 rounded-full bg-yellow-50 text-yellow-500 border border-yellow-100 flex items-center justify-center shrink-0 mt-0.5"><i class="fa-solid fa-medal text-[10px]"></i></div>
                    <div>
                        <p class="text-[13px] font-bold text-gray-800">Hoàng Đức Minh</p>
                        <p class="text-[11px] text-gray-500">Đạt huy hiệu Chiến Binh Xanh</p>
                        <p class="text-[10px] text-gray-400 mt-1">1 giờ trước</p>
                    </div>
                </div>
                <!-- Item 5 -->
                <div class="flex gap-3">
                    <div class="w-7 h-7 rounded-full bg-blue-50 text-blue-500 border border-blue-100 flex items-center justify-center shrink-0 mt-0.5"><i class="fa-solid fa-crosshairs text-[10px]"></i></div>
                    <div>
                        <p class="text-[13px] font-bold text-gray-800">Nguyễn Thị Mai</p>
                        <p class="text-[11px] text-gray-500">Tạo mục tiêu Ăn chay 2 ngày/tuần</p>
                        <p class="text-[10px] text-gray-400 mt-1">2 giờ trước</p>
                    </div>
                </div>
                <!-- Item 6 -->
                <div class="flex gap-3">
                    <div class="w-7 h-7 rounded-full bg-green-50 text-green-500 border border-green-100 flex items-center justify-center shrink-0 mt-0.5"><i class="fa-solid fa-check text-[10px]"></i></div>
                    <div>
                        <p class="text-[13px] font-bold text-gray-800">Võ Thanh Tùng</p>
                        <p class="text-[11px] text-gray-500">Check-in mục tiêu Đi xe đạp</p>
                        <p class="text-[10px] text-gray-400 mt-1">3 giờ trước</p>
                    </div>
                </div>
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
                 <tr class="border-b border-gray-50 last:border-0 hover:bg-gray-50/50">
                     <td class="py-4 text-sm font-bold text-orange-500">1</td>
                     <td class="py-4 flex items-center gap-3">
                         <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Lan" class="w-8 h-8 rounded-full bg-gray-100" />
                         <span class="text-xs font-bold text-gray-800">Trần Thị Lan</span>
                     </td>
                     <td class="py-4 text-xs text-gray-500">Giáo viên</td>
                     <td class="py-4 text-xs text-gray-500">Hà Nội</td>
                     <td class="py-4 text-sm font-bold text-green-600 text-right">2,150</td>
                     <td class="py-4 text-xs font-bold text-orange-500 text-right"><i class="fa-solid fa-fire text-[10px] mr-1"></i> 28 ngày</td>
                 </tr>
                 <tr class="border-b border-gray-50 last:border-0 hover:bg-gray-50/50">
                     <td class="py-4 text-sm font-bold text-orange-400">2</td>
                     <td class="py-4 flex items-center gap-3">
                         <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Hung" class="w-8 h-8 rounded-full bg-gray-100" />
                         <span class="text-xs font-bold text-gray-800">Lê Văn Hùng</span>
                     </td>
                     <td class="py-4 text-xs text-gray-500">Kỹ sư phần mềm</td>
                     <td class="py-4 text-xs text-gray-500">TP. HCM</td>
                     <td class="py-4 text-sm font-bold text-green-600 text-right">1,890</td>
                     <td class="py-4 text-xs font-bold text-orange-500 text-right"><i class="fa-solid fa-fire text-[10px] mr-1"></i> 21 ngày</td>
                 </tr>
                 <tr class="border-b border-gray-50 last:border-0 hover:bg-gray-50/50">
                     <td class="py-4 text-sm font-bold text-orange-300">3</td>
                     <td class="py-4 flex items-center gap-3">
                         <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Khoa" class="w-8 h-8 rounded-full bg-gray-100" />
                         <span class="text-xs font-bold text-gray-800">Nguyễn Minh Khoa</span>
                     </td>
                     <td class="py-4 text-xs text-gray-500">Kỹ sư Môi trường</td>
                     <td class="py-4 text-xs text-gray-500">TP. HCM</td>
                     <td class="py-4 text-sm font-bold text-green-600 text-right">1,240</td>
                     <td class="py-4 text-xs font-bold text-orange-500 text-right"><i class="fa-solid fa-fire text-[10px] mr-1"></i> 14 ngày</td>
                 </tr>
                 <tr class="border-b border-gray-50 last:border-0 hover:bg-gray-50/50">
                     <td class="py-4 text-sm font-bold text-gray-400">4</td>
                     <td class="py-4 flex items-center gap-3">
                         <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Ha" class="w-8 h-8 rounded-full bg-gray-100" />
                         <span class="text-xs font-bold text-gray-800">Phạm Thu Hà</span>
                     </td>
                     <td class="py-4 text-xs text-gray-500">Chủ tiệm cà phê</td>
                     <td class="py-4 text-xs text-gray-500">Đà Nẵng</td>
                     <td class="py-4 text-sm font-bold text-green-600 text-right">1,180</td>
                     <td class="py-4 text-xs font-bold text-orange-500 text-right"><i class="fa-solid fa-fire text-[10px] mr-1"></i> 10 ngày</td>
                 </tr>
                 <tr class="border-b border-gray-50 last:border-0 hover:bg-gray-50/50">
                     <td class="py-4 text-sm font-bold text-gray-400">5</td>
                     <td class="py-4 flex items-center gap-3">
                         <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Minh" class="w-8 h-8 rounded-full bg-gray-100" />
                         <span class="text-xs font-bold text-gray-800">Hoàng Đức Minh</span>
                     </td>
                     <td class="py-4 text-xs text-gray-500">Lập trình viên</td>
                     <td class="py-4 text-xs text-gray-500">Hà Nội</td>
                     <td class="py-4 text-sm font-bold text-green-600 text-right">980</td>
                     <td class="py-4 text-xs font-bold text-orange-500 text-right"><i class="fa-solid fa-fire text-[10px] mr-1"></i> 7 ngày</td>
                 </tr>
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
            <h4 class="text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-3">ĐỊNH DẠNG XUẤT</h4>
            <div class="grid grid-cols-2 gap-4 mb-6">
                 <!-- CSV / Excel Card -->
                 <div class="border-2 border-[#10B981] rounded-xl p-4 flex items-start gap-4 bg-white relative cursor-pointer shadow-[0_2px_10px_-3px_rgba(16,185,129,0.2)]">
                      <div class="w-8 h-8 rounded bg-green-50 text-green-500 flex items-center justify-center shrink-0">
                           <i class="fa-regular fa-file-excel"></i>
                      </div>
                      <div>
                           <p class="text-[13px] font-bold text-gray-800 mb-1">CSV / Excel</p>
                           <p class="text-[11px] text-gray-400 leading-tight">Mở được bằng Excel, Google Sheets. Hỗ trợ tiếng Việt đầy đủ.</p>
                      </div>
                      <div class="absolute top-4 right-4 text-[#10B981]"><i class="fa-solid fa-circle-check"></i></div>
                 </div>
                 <!-- JSON Card -->
                 <div class="border border-gray-200 rounded-xl p-4 flex items-start gap-4 bg-white cursor-pointer hover:border-gray-300">
                      <div class="w-8 h-8 rounded bg-gray-50 text-gray-500 flex items-center justify-center shrink-0">
                           <i class="fa-solid fa-code"></i>
                      </div>
                      <div>
                           <p class="text-[13px] font-bold text-gray-800 mb-1">JSON</p>
                           <p class="text-[11px] text-gray-400 leading-tight">Dữ liệu có cấu trúc, phù hợp tích hợp hệ thống khác.</p>
                      </div>
                 </div>
            </div>
            
            <h4 class="text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-3">PHẠM VI DỮ LIỆU</h4>
            <div class="flex flex-wrap gap-2 mb-2">
                <button class="px-4 py-1.5 border border-[#10B981] bg-green-50/50 text-[#10B981] rounded text-[11px] font-bold flex items-center gap-1.5"><i class="fa-solid fa-border-all"></i> Tất cả</button>
                <button class="px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-solid fa-list"></i> Danh mục</button>
                <button class="px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-solid fa-user"></i> Người dùng</button>
                <button class="px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-regular fa-calendar"></i> Thống kê tuần</button>
                <button class="px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-solid fa-chart-column"></i> Thống kê tháng</button>
                <button class="px-4 py-1.5 border border-gray-200 text-gray-500 hover:text-gray-700 rounded text-[11px] font-medium flex items-center gap-1.5"><i class="fa-solid fa-users"></i> Cộng đồng</button>
            </div>
            <p class="text-[11px] text-gray-500 mb-6">Ước tính <span class="font-bold text-gray-800">48</span> dòng dữ liệu sẽ được xuất</p>
            
            <h4 class="text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-3">XEM TRƯỚC NỘI DUNG</h4>
            <div class="border border-gray-200 rounded-lg overflow-hidden">
                 <div class="flex border-b border-gray-200 px-4 pt-2">
                     <button class="px-3 py-2 text-[12px] font-bold text-[#10B981] border-b-2 border-[#10B981]">Tổng quan</button>
                     <button class="px-3 py-2 text-[12px] font-semibold text-gray-500 hover:text-gray-800">Người dùng</button>
                     <button class="px-3 py-2 text-[12px] font-semibold text-gray-500 hover:text-gray-800">Thống kê</button>
                 </div>
                 <div class="p-4 bg-gray-50">
                     <div class="bg-green-50 text-green-700 text-[11px] font-medium px-3 py-1.5 rounded mb-3 flex items-center gap-2">
                         <i class="fa-solid fa-circle-info text-[10px]"></i> Phạm vi: <span class="font-bold">Tất cả</span> — Định dạng: <span class="font-bold">CSV</span>
                     </div>
                     <div class="grid grid-cols-2 gap-3">
                         <div class="bg-white border border-gray-200 p-3 rounded shadow-sm">
                             <p class="text-[10px] text-gray-500 font-bold mb-1">Tổng Người Dùng</p>
                             <p class="text-xl font-black text-[#10B981]">5,248</p>
                         </div>
                         <div class="bg-white border border-gray-200 p-3 rounded shadow-sm">
                             <p class="text-[10px] text-gray-500 font-bold mb-1">Mục Tiêu Hoạt Động</p>
                             <p class="text-xl font-black text-[#10B981]">1,248</p>
                         </div>
                     </div>
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
