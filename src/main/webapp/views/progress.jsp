<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tiến Độ Của Tôi - GreenLife</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; background-color: #F8F9FA; color: #333; }
        .font-serif { font-family: 'Playfair Display', serif; }
        /* Simple donut logic */
        .donut-ring {
            stroke-dasharray: 251.2;
            stroke-dashoffset: calc(251.2 - (251.2 * ${completionPercentage != null ? completionPercentage : 72}) / 100);
            transition: stroke-dashoffset 1s ease;
        }
    </style>
</head>
<body class="antialiased min-h-screen flex flex-col pt-[72px]">

<jsp:include page="includes/navbar.jsp" />

<div class="flex-1 bg-[#F9FAFB]">
    <div class="max-w-[1200px] mx-auto px-4 sm:px-6 lg:px-8 py-10">
        
        <!-- Header -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8 gap-4">
            <div>
                <h1 class="text-[32px] font-serif font-bold text-[#1F2937] mb-1 leading-tight">Theo Dõi Tiến Độ</h1>
                <p class="text-[13px] font-medium text-gray-500">Xem biểu đồ trực quan và thống kê số liệu hoạt động xanh của bạn</p>
            </div>
            <button onclick="document.getElementById('exportModal').showModal()" class="px-5 py-2.5 bg-[#10B981] text-white font-bold rounded-lg hover:bg-[#059669] shadow-md shadow-[#10B981]/20 transition-all text-sm flex items-center gap-2">
                <i class="fa-solid fa-download"></i> Xuất Báo Cáo
            </button>
        </div>

        <!-- 4 Top Stat Cards -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
            <div class="bg-white rounded-[20px] p-5 shadow-sm border border-gray-100 flex flex-col">
                 <div class="w-8 h-8 rounded mb-2 bg-green-50 text-[#10B981] flex items-center justify-center text-sm"><i class="fa-solid fa-bullseye"></i></div>
                 <p class="text-[22px] font-bold text-gray-800 mb-0.5">${totalGoals != null ? totalGoals : 6}</p>
                 <p class="text-[11px] font-medium text-gray-400 uppercase tracking-widest">Tổng Mục Tiêu</p>
            </div>
             <div class="bg-white rounded-[20px] p-5 shadow-sm border border-gray-100 flex flex-col">
                 <div class="w-8 h-8 rounded mb-2 bg-orange-50 text-orange-500 flex items-center justify-center text-sm"><i class="fa-solid fa-fire"></i></div>
                 <p class="text-[22px] font-bold text-gray-800 mb-0.5">${streak != null ? streak : 14} ngày</p>
                 <p class="text-[11px] font-medium text-gray-400 uppercase tracking-widest">Chuỗi Check-in</p>
            </div>
            <div class="bg-white rounded-[20px] p-5 shadow-sm border border-gray-100 flex flex-col">
                 <div class="w-8 h-8 rounded mb-2 bg-blue-50 text-blue-500 flex items-center justify-center text-sm"><i class="fa-solid fa-check-double"></i></div>
                 <p class="text-[22px] font-bold text-gray-800 mb-0.5">${totalActions != null ? totalActions : 8}</p>
                 <p class="text-[11px] font-medium text-gray-400 uppercase tracking-widest">Tổng Hành Động</p>
            </div>
            <div class="bg-white rounded-[20px] p-5 shadow-sm border border-gray-100 flex flex-col">
                 <div class="w-8 h-8 rounded mb-2 bg-yellow-50 text-yellow-500 flex items-center justify-center text-sm"><i class="fa-solid fa-medal"></i></div>
                 <p class="text-[22px] font-bold text-gray-800 mb-0.5">${totalPoints != null ? totalPoints : '1,240'}</p>
                 <p class="text-[11px] font-medium text-gray-400 uppercase tracking-widest">Điểm Xanh</p>
            </div>
        </div>

        <!-- Chart Grid Data -->
        <!-- Row 1: Donut & Bar -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
             <!-- Tiến độ tổng thể (Donut) -->
             <div class="bg-white rounded-[24px] p-6 shadow-sm border border-gray-100 flex flex-col items-center">
                 <div class="w-full text-left mb-6">
                      <h3 class="text-[15px] font-bold text-gray-800 mb-1">Tiến Độ Tổng Thể</h3>
                 </div>
                 <div class="relative w-40 h-40 mb-8">
                      <!-- SVG Donut Chart -->
                      <svg viewBox="0 0 100 100" class="transform -rotate-90 w-full h-full">
                          <circle cx="50" cy="50" r="40" fill="transparent" stroke="#F3F4F6" stroke-width="12"></circle>
                          <circle cx="50" cy="50" r="40" fill="transparent" stroke="#10B981" stroke-width="12" class="donut-ring text-[#10B981]" stroke-linecap="round"></circle>
                      </svg>
                      <div class="absolute inset-0 flex flex-col items-center justify-center">
                           <span class="text-3xl font-black text-gray-800">${completionPercentage != null ? completionPercentage : 72}%</span>
                      </div>
                 </div>
                 <div class="w-full space-y-3">
                      <div class="flex justify-between items-center text-[13px] font-medium text-gray-600">
                          <div class="flex items-center gap-2"><div class="w-2 h-2 rounded-full bg-[#10B981]"></div> Đang thực hiện</div>
                          <span class="font-bold text-gray-800">5</span>
                      </div>
                      <div class="flex justify-between items-center text-[13px] font-medium text-gray-600">
                          <div class="flex items-center gap-2"><div class="w-2 h-2 rounded-full bg-gray-200"></div> Hoàn thành</div>
                          <span class="font-bold text-gray-800">${completedGoals != null ? completedGoals : 1}</span>
                      </div>
                 </div>
                 <div class="w-full mt-4 pt-4 border-t border-gray-100 text-center">
                     <a href="#" class="text-[11px] font-bold text-[#F59E0B]">Chi tiết</a>
                 </div>
             </div>

             <!-- Biểu Đồ Tuần (Bar Chart) -->
             <div class="lg:col-span-2 bg-white rounded-[24px] p-6 shadow-sm border border-gray-100">
                 <div class="flex justify-between items-center mb-6">
                      <h3 class="text-[15px] font-bold text-gray-800">Biểu Đồ Tuần</h3>
                      <div class="flex gap-2">
                           <button class="w-7 h-7 rounded bg-gray-50 text-gray-400 flex items-center justify-center hover:text-gray-800"><i class="fa-solid fa-chevron-left text-[10px]"></i></button>
                           <button class="w-7 h-7 rounded bg-gray-50 text-gray-400 flex items-center justify-center hover:text-gray-800"><i class="fa-solid fa-chevron-right text-[10px]"></i></button>
                      </div>
                 </div>
                 
                 <div class="flex gap-2 mb-8">
                      <button class="px-3 py-1 bg-[#F59E0B] text-white text-[11px] font-bold rounded-full">Điểm</button>
                      <button class="px-3 py-1 bg-gray-50 text-gray-500 hover:bg-gray-100 text-[11px] font-bold rounded-full">Mục Tiêu</button>
                      <button class="px-3 py-1 bg-gray-50 text-gray-500 hover:bg-gray-100 text-[11px] font-bold rounded-full">Hành Động</button>
                 </div>
                 
                 <div class="h-44 w-full flex items-end justify-between gap-2 md:gap-4 relative px-2 mb-4">
                      <!-- Grid lines -->
                      <div class="absolute inset-0 flex flex-col justify-between pointer-events-none opacity-[0.03]">
                          <div class="w-full h-px bg-black"></div><div class="w-full h-px bg-black"></div><div class="w-full h-px bg-black"></div><div class="w-full h-px bg-black"></div>
                      </div>
                      
                      <!-- Bars -->
                      <c:forEach items="${chartData}" var="val">
                          <c:set var="barHeight" value="${val > 100 ? 100 : val}" />
                          <c:set var="displayHeight" value="${barHeight < 5 && val > 0 ? 5 : barHeight}" />
                          <div class="w-full h-[${displayHeight > 0 ? displayHeight : 2}%] bg-[#F59E0B] rounded-t-lg relative group hover:opacity-80 transition flex flex-col items-center">
                              <span class="absolute -top-5 text-[10px] text-gray-400 font-bold opacity-0 group-hover:opacity-100">${val}</span>
                          </div>
                      </c:forEach>
                 </div>
                 
                 <!-- Days labels -->
                 <div class="flex justify-between px-4 text-[11px] font-bold text-gray-400 w-full mb-2 uppercase text-center">
                      <span class="w-full">T2</span><span class="w-full">T3</span><span class="w-full">T4</span><span class="w-full">T5</span><span class="w-full">T6</span><span class="w-full">T7</span><span class="w-full">CN</span>
                 </div>
             </div>
        </div>

        <!-- Row 2: Streak & Calendar -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-10">
              <!-- Chuỗi Hiện Tại MOCK-->
             <div class="bg-white rounded-[24px] p-6 shadow-sm border border-gray-100">
                  <div class="flex justify-between items-center mb-6">
                      <h3 class="text-[15px] font-bold text-gray-800">Chuỗi Hiện Tại</h3>
                      <div class="flex items-center text-orange-500 font-bold gap-1 text-[13px]"><i class="fa-solid fa-fire text-lg"></i> ${streak != null ? streak : 14}<span class="text-[10px] text-gray-400 font-medium">ngày liên tiếp</span></div>
                  </div>
                  <!-- Streak Calendar Week view -->
                  <div class="flex justify-between gap-1 mb-8">
                       <c:forEach items="${chartData}" var="act" varStatus="loop">
                           <div class="w-8 h-8 rounded-full ${act > 0 ? 'border-2 border-orange-500 text-orange-500 bg-orange-50' : 'border border-gray-200 text-gray-300'} flex items-center justify-center text-[11px] font-bold">
                               <c:out value="${loop.index == 6 ? 'CN' : loop.index + 2}"/>
                           </div>
                       </c:forEach>
                  </div>
                  <!-- Active status warning -->
                  <div class="bg-orange-50 border border-orange-100 rounded-xl p-4 flex justify-between items-center mb-6">
                       <div>
                            <p class="text-[13px] font-bold text-gray-800 mb-0.5">Mục tiêu sắp bị chững lại!</p>
                            <p class="text-[11px] text-gray-500">Giữ chuỗi check-in ngay.</p>
                       </div>
                       <a href="${pageContext.request.contextPath}/views/goals.jsp" class="px-4 py-2 bg-orange-500 text-white rounded-lg text-xs font-bold hover:bg-orange-600 transition">Check-in</a>
                  </div>
                  <!-- Stats smaller -->
                  <div class="grid grid-cols-2 gap-4 text-center">
                       <div class="bg-gray-50/50 p-3 rounded-lg border border-gray-100">
                            <p class="text-[15px] font-bold text-gray-800 mb-0.5"><i class="fa-solid fa-crown text-orange-400 text-xs mr-1"></i> 21</p>
                            <p class="text-[10px] text-gray-400 font-medium uppercase tracking-widest">Kỷ lục dài nhất</p>
                       </div>
                       <div class="bg-gray-50/50 p-3 rounded-lg border border-gray-100">
                            <p class="text-[15px] font-bold text-gray-800 mb-0.5"><i class="fa-solid fa-bolt text-[#10B981] text-xs mr-1"></i> 6</p>
                            <p class="text-[10px] text-gray-400 font-medium uppercase tracking-widest">Tổng chuỗi đã đạt</p>
                       </div>
                  </div>
             </div>

             <!-- Lịch Check-in -->
             <div class="bg-white rounded-[24px] p-6 shadow-sm border border-gray-100">
                  <div class="flex justify-between items-center mb-6">
                      <h3 class="text-[15px] font-bold text-gray-800">Lịch Check-in</h3>
                      <div class="flex items-center gap-3 text-[13px] font-bold text-gray-600" id="currentCalendarMonth">Tháng ...</div>
                  </div>
                  <div class="grid grid-cols-3 gap-2 mb-6 text-center">
                       <div class="p-2 rounded-lg bg-gray-50 border border-gray-100">
                           <div class="text-[18px] font-bold text-gray-800 mb-0.5"><i class="fa-regular fa-calendar text-[#10B981] text-lg mb-1 block"></i> <span id="calTotalGoals">${completedGoals != null ? completedGoals : 0}</span></div>
                           <p class="text-[9px] uppercase tracking-widest text-gray-400">Hoàn thành</p>
                       </div>
                       <div class="p-2 rounded-lg bg-gray-50 border border-gray-100">
                           <div class="text-[18px] font-bold text-gray-800 mb-0.5"><i class="fa-regular fa-square-check text-blue-500 text-lg mb-1 block"></i> <span id="calTotalCheckins">${totalActions != null ? totalActions : 0}</span></div>
                           <p class="text-[9px] uppercase tracking-widest text-gray-400">Tổng Check-in</p>
                       </div>
                       <div class="p-2 rounded-lg bg-gray-50 border border-gray-100">
                           <div class="text-[18px] font-bold text-gray-800 mb-0.5"><i class="fa-solid fa-percent text-orange-500 text-sm mb-1 block"></i> <span id="calActivityRatio">${completionPercentage != null ? completionPercentage : 0}%</span></div>
                           <p class="text-[9px] uppercase tracking-widest text-gray-400">Chỉ số TB</p>
                       </div>
                  </div>
                  <!-- Calendar grid -->
                  <div class="grid grid-cols-7 gap-1 text-center text-[10px] font-bold text-gray-400 mb-2">
                       <div>T2</div><div>T3</div><div>T4</div><div>T5</div><div>T6</div><div>T7</div><div>CN</div>
                  </div>
                  <div class="grid grid-cols-7 gap-1 text-center text-[12px] font-medium text-gray-600" id="calendarGrid">
                       <!-- Rendered via JS loop -->
                  </div>
             </div>
             
             <script>
                  document.addEventListener("DOMContentLoaded", () => {
                      const date = new Date();
                      const currentMonth = date.getMonth();
                      const currentYear = date.getFullYear();
                      const today = date.getDate();
                      
                      document.getElementById("currentCalendarMonth").innerHTML = `Tháng \${currentMonth + 1} \${currentYear}`;
                      
                      // Get all check-in dates dynamically from JSTL as a JS Set of day numbers in current month
                      const activeDays = new Set();
                      <c:forEach items="${progressList}" var="p">
                          <c:if test="${p.createdAt != null}">
                              {
                                  let d = new Date("${p.createdAt.toString().replace('.0','')}"); // Standardize parse
                                  if (d.getMonth() === currentMonth && d.getFullYear() === currentYear) {
                                      activeDays.add(d.getDate());
                                  }
                              }
                          </c:if>
                      </c:forEach>
                      
                      const firstDay = new Date(currentYear, currentMonth, 1).getDay();
                      const offset = firstDay === 0 ? 6 : firstDay - 1; // Map Sunday(0) to 6, Mon to 0 etc.
                      const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
                      
                      const grid = document.getElementById("calendarGrid");
                      grid.innerHTML = "";
                      
                      // Add empty prefixes
                      for(let i=0; i<offset; i++) grid.innerHTML += '<div class="p-1"></div>';
                      
                      for(let d=1; d<=daysInMonth; d++) {
                          if (activeDays.has(d)) {
                               // Checked in day
                               grid.innerHTML += `<div class="p-1 relative"><div class="absolute inset-x-1 inset-y-1 bg-blue-100 border border-blue-200 rounded flex items-center justify-center text-blue-700 font-bold">\${d}</div></div>`;
                          } else if (d === today) {
                               // Today (maybe not checked in yet)
                               grid.innerHTML += `<div class="p-1 border border-[#10B981] rounded text-[#10B981] font-black bg-[#10B981]/5">\${d}</div>`;
                          } else {
                               // Normal day
                               grid.innerHTML += `<div class="p-1">\${d}</div>`;
                          }
                      }
                  });
             </script>
        </div>

        <!-- Environmental Impact Green Banner Layout -->
        <div class="bg-[#1B4332] rounded-[24px] p-6 lg:p-10 text-white flex flex-col md:flex-row justify-between items-center mb-10 overflow-hidden relative shadow-lg shadow-[#1B4332]/20">
             <div class="absolute right-0 top-0 opacity-10 pointer-events-none"><i class="fa-solid fa-leaf text-[300px]"></i></div>
             
             <div class="z-10 w-full md:w-1/3 mb-6 md:mb-0">
                  <p class="text-[10px] text-[#A7F3D0] uppercase font-bold tracking-widest mb-2 border border-[#A7F3D0]/20 bg-[#A7F3D0]/10 px-3 py-1 rounded-full w-max">Tác Động</p>
                  <h3 class="text-2xl font-serif font-bold text-white mb-2">Tác Động Môi Trường Của Bạn</h3>
                  <p class="text-xs text-white/60 leading-relaxed max-w-[200px]">Số liệu thay đổi thế giới từ những hành động nhỏ của riêng bạn.</p>
             </div>
             
             <div class="z-10 w-full md:w-2/3 flex flex-col sm:flex-row gap-4 justify-end">
                  <!-- Card Nước -->
                  <div class="bg-white/10 backdrop-blur border border-white/20 rounded-xl p-5 flex flex-col min-w-[140px]">
                       <div class="w-8 h-8 rounded bg-white/10 text-[#34D399] flex items-center justify-center text-sm mb-3"><i class="fa-solid fa-cloud"></i></div>
                       <p class="text-2xl font-black text-white mb-1"><c:out value="${co2Saved != null ? co2Saved : '0.0'}"/> kg</p>
                       <p class="text-[10px] text-white/80 font-medium">CO2 Đã Giảm</p>
                  </div>
                  <!-- Card CO2 -->
                  <div class="bg-white/10 backdrop-blur border border-white/20 rounded-xl p-5 flex flex-col min-w-[140px]">
                       <div class="w-8 h-8 rounded bg-white/10 text-[#60A5FA] flex items-center justify-center text-sm mb-3"><i class="fa-solid fa-droplet"></i></div>
                       <p class="text-2xl font-black text-white mb-1"><c:out value="${waterSaved != null ? waterSaved : '0'}"/> lít</p>
                       <p class="text-[10px] text-white/80 font-medium">Nước Tiết Kiệm</p>
                  </div>
                  <!-- Card Rác thải -->
                  <div class="bg-white/10 backdrop-blur border border-white/20 rounded-xl p-5 flex flex-col min-w-[140px]">
                       <div class="w-8 h-8 rounded bg-white/10 text-orange-400 flex items-center justify-center text-sm mb-3"><i class="fa-solid fa-recycle"></i></div>
                       <p class="text-2xl font-black text-white mb-1"><c:out value="${plasticSaved != null ? plasticSaved : '0'}"/> cái</p>
                       <p class="text-[10px] text-white/80 font-medium">Rác Nhựa Giảm Tiêu</p>
                  </div>
             </div>
        </div>
        
    </div>
</div>

<jsp:include page="includes/footer.jsp" />

<!-- Export Modal -->
<dialog id="exportModal" class="p-0 rounded-2xl shadow-xl backdrop:bg-black/40 overflow-hidden w-full md:max-w-[650px] max-w-[95%] mx-auto m-auto border-0">
    <div class="bg-white flex flex-col h-full rounded-2xl max-h-[85vh]">
        
        <!-- Header -->
        <div class="px-6 py-5 flex justify-between items-start border-b border-gray-100 bg-white sticky top-0 z-10 w-full shrink-0">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 rounded-xl bg-[#E0F2E9] text-[#1B4332] flex items-center justify-center text-[22px] shrink-0 border border-[#A7F3D0]">
                    <i class="fa-solid fa-file-excel"></i>
                </div>
                <div>
                    <h3 class="text-[17px] font-bold text-gray-800 mb-0.5">Xuất Báo Cáo Thống Kê</h3>
                    <p class="text-[12px] font-bold text-[#10B981] flex items-center gap-1">
                        <i class="fa-solid fa-filter text-[10px]"></i> Tất cả &middot; Tất cả thời gian
                    </p>
                </div>
            </div>
            <button onclick="document.getElementById('exportModal').close()" class="text-gray-400 hover:text-gray-600 transition-colors w-8 h-8 rounded-full flex items-center justify-center hover:bg-gray-100">
                <i class="fa-solid fa-xmark text-lg"></i>
            </button>
        </div>
        
        <!-- Body Scrollable -->
        <div class="p-6 overflow-y-auto flex-1 hide-scrollbar">
            
            <!-- File name style -->
            <div class="mb-6 bg-gray-50 border border-gray-200 rounded-lg p-3 flex items-center gap-2 text-[12px] text-gray-500 font-mono overflow-hidden">
                <i class="fa-regular fa-file-lines shrink-0"></i> 
                <span class="truncate">GreenLife_BaoCao_${sessionScope.currentUser != null ? sessionScope.currentUser.username : 'User'}_2026-04-20.csv</span>
            </div>
            
            <!-- Context Header -->
            <div class="flex justify-between items-center mb-4">
                <div class="text-[13px] font-bold text-[#10B981] flex items-center gap-2">
                    <i class="fa-solid fa-eye"></i> Xem trước nội dung
                </div>
                <div class="text-[12px] font-medium text-gray-400">
                    ${totalGoals != null ? totalGoals : 0} mục tiêu &middot; ${totalActions != null ? totalActions : 0} check-in
                </div>
            </div>
            
            <!-- Custom Tabs -->
            <div class="flex p-1 bg-gray-50 border border-gray-200 rounded-xl mb-5">
                <button id="btn-tabOverview" onclick="openTab('tabOverview')" class="tab-btn flex-1 py-2 text-[12px] rounded-lg transition-all text-gray-800 font-bold bg-white shadow-sm flex items-center justify-center gap-2 border border-gray-100">
                    <i class="fa-solid fa-table-cells-large text-gray-400"></i> Tổng quan
                </button>
                <button id="btn-tabGoals" onclick="openTab('tabGoals')" class="tab-btn flex-1 py-2 text-[12px] font-bold text-gray-400 rounded-lg transition-all hover:bg-white hover:text-gray-600 flex items-center justify-center gap-2 border border-transparent">
                    <i class="fa-regular fa-flag"></i> Mục tiêu
                </button>
                <button id="btn-tabHistory" onclick="openTab('tabHistory')" class="tab-btn flex-1 py-2 text-[12px] font-bold text-gray-400 rounded-lg transition-all hover:bg-white hover:text-gray-600 flex items-center justify-center gap-2 border border-transparent">
                    <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử
                </button>
            </div>
            
            <script>
                function openTab(tabName) {
                    document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
                    document.getElementById(tabName).classList.remove('hidden');
                    document.querySelectorAll('.tab-btn').forEach(el => {
                        el.classList.remove('bg-white', 'text-gray-800', 'shadow-sm', 'border-gray-100');
                        el.classList.add('text-gray-400', 'border-transparent');
                        const icon = el.querySelector('i');
                        if(icon) icon.classList.remove('text-[#10B981]');
                    });
                    const activeBtn = document.getElementById('btn-' + tabName);
                    activeBtn.classList.remove('text-gray-400', 'border-transparent');
                    activeBtn.classList.add('bg-white', 'text-gray-800', 'shadow-sm', 'border-gray-100');
                    const activeIcon = activeBtn.querySelector('i');
                    if(activeIcon) activeIcon.classList.add('text-[#10B981]');
                }
            </script>
            
            <!-- Tab Contents -->
            <div class="min-h-[260px]">
                
                <!-- Tab: Overview -->
                <div id="tabOverview" class="tab-content block pb-2">
                    <!-- User Info Card -->
                    <div class="flex justify-between items-center bg-white border border-gray-200 p-4 rounded-xl shadow-[0_2px_10px_rgba(0,0,0,0.02)] mb-5">
                         <div class="flex items-center gap-3">
                              <div class="w-12 h-12 rounded-xl bg-[#10B981] text-white flex items-center justify-center font-bold text-xl shadow-inner border border-[#059669]">
                                  ${sessionScope.currentUser != null ? sessionScope.currentUser.username.substring(0,1).toUpperCase() : 'U'}
                              </div>
                              <div>
                                  <h4 class="text-[15px] font-bold text-gray-800 leading-tight mb-1">${sessionScope.currentUser != null ? sessionScope.currentUser.fullName : 'Hồ Sơ Của Bạn'}</h4>
                                  <p class="text-[12px] font-medium text-gray-400 leading-none">${sessionScope.currentUser != null ? sessionScope.currentUser.email : 'email@student.edu.vn'}</p>
                              </div>
                         </div>
                         <div class="text-right">
                             <p class="text-[11px] text-gray-400 font-medium mb-1">Bộ lọc</p>
                             <p class="text-[12px] font-bold text-[#10B981]">Tất cả &middot; Tất cả thời gian</p>
                         </div>
                    </div>
                    
                    <!-- Stats Grid 3x2 -->
                    <div class="grid grid-cols-3 gap-3">
                         <div class="bg-[#F0FDF4] border border-[#DCFCE7] p-5 rounded-xl flex flex-col items-center justify-center text-center">
                             <i class="fa-regular fa-flag text-[#10B981] mb-2 text-lg"></i>
                             <p class="text-[20px] font-black text-gray-800 leading-none mb-1">${totalGoals != null ? totalGoals : 0}</p>
                             <p class="text-[11px] font-bold text-gray-500 uppercase tracking-widest">Mục tiêu</p>
                         </div>
                         <div class="bg-[#F0FDF4] border border-[#DCFCE7] p-5 rounded-xl flex flex-col items-center justify-center text-center">
                             <i class="fa-regular fa-circle-check text-[#10B981] mb-2 text-lg"></i>
                             <p class="text-[20px] font-black text-gray-800 leading-none mb-1">${completedGoals != null ? completedGoals : 0}</p>
                             <p class="text-[11px] font-bold text-gray-500 uppercase tracking-widest">Hoàn thành</p>
                         </div>
                         <div class="bg-[#F0FDF4] border border-[#DCFCE7] p-5 rounded-xl flex flex-col items-center justify-center text-center">
                             <i class="fa-solid fa-check-double text-[#10B981] mb-2 text-lg"></i>
                             <p class="text-[20px] font-black text-gray-800 leading-none mb-1">${totalActions != null ? totalActions : 0}</p>
                             <p class="text-[11px] font-bold text-gray-500 uppercase tracking-widest">Check-in</p>
                         </div>
                         <div class="bg-orange-50 border border-orange-100 p-5 rounded-xl flex flex-col items-center justify-center text-center">
                             <i class="fa-solid fa-leaf text-orange-400 mb-2 text-lg"></i>
                             <p class="text-[20px] font-black text-gray-800 leading-none mb-1">${totalPoints != null ? totalPoints : 0}</p>
                             <p class="text-[11px] font-bold text-gray-500 uppercase tracking-widest">Điểm xanh</p>
                         </div>
                         <div class="bg-orange-50 border border-orange-100 p-5 rounded-xl flex flex-col items-center justify-center text-center">
                             <i class="fa-solid fa-fire text-orange-500 mb-2 text-lg"></i>
                             <p class="text-[20px] font-black text-gray-800 leading-none mb-1">${streak != null ? streak : 0}d</p>
                             <p class="text-[11px] font-bold text-gray-500 uppercase tracking-widest">Streak</p>
                         </div>
                         <div class="bg-[#F0FDF4] border border-[#DCFCE7] p-5 rounded-xl flex flex-col items-center justify-center text-center">
                             <i class="fa-solid fa-percent text-[#10B981] mb-2 text-lg"></i>
                             <p class="text-[20px] font-black text-gray-800 leading-none mb-1">${completionPercentage != null ? completionPercentage : 0}%</p>
                             <p class="text-[11px] font-bold text-gray-500 uppercase tracking-widest">Tiến độ TB</p>
                         </div>
                    </div>
                </div>
                
                <!-- Tab: Goals -->
                <div id="tabGoals" class="tab-content hidden pr-2">
                    <c:forEach items="${userGoals}" var="goal" varStatus="loop">
                         <div class="py-4 border-b border-gray-100 flex gap-4 items-center">
                              <span class="text-[12px] font-bold text-gray-400 w-4 text-center shrink-0">${loop.index + 1}</span>
                              <div class="flex-1">
                                   <div class="flex justify-between items-start mb-2.5 gap-2">
                                        <div class="flex flex-wrap items-center gap-3">
                                            <h4 class="text-[14px] font-bold text-gray-800 leading-none">${goal.title}</h4>
                                            <c:choose>
                                                <c:when test="${goal.status == 'COMPLETED'}">
                                                    <span class="px-2.5 py-0.5 bg-[#F0FDF4] text-[#16A34A] text-[10px] font-bold rounded-full border border-[#DCFCE7] whitespace-nowrap">Hoàn thành</span>
                                                </c:when>
                                                <c:when test="${goal.status == 'PENDING'}">
                                                    <span class="px-2.5 py-0.5 bg-gray-100 text-gray-500 text-[10px] font-bold rounded-full border border-gray-200 whitespace-nowrap">Chờ duyệt</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2.5 py-0.5 bg-[#EFF6FF] text-[#2563EB] text-[10px] font-bold rounded-full border border-[#DBEAFE] whitespace-nowrap">Đang thực hiện</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                   </div>
                                   <div class="flex items-center gap-3">
                                       <div class="flex-1 h-1.5 rounded-full bg-gray-100 overflow-hidden">
                                            <div class="h-1.5 bg-[#10B981] rounded-full" style="width: ${(goal.currentProgress * 1.0 / goal.targetProgress) * 100}%;"></div>
                                       </div>
                                       <div class="text-[11px] text-gray-400 font-medium shrink-0 whitespace-nowrap w-[70px] text-right">${goal.currentProgress}/${goal.targetProgress} ngày</div>
                                       <div class="text-[12px] font-black text-[#10B981] w-[35px] text-right shrink-0"><c:out value="${Math.round((goal.currentProgress * 1.0 / goal.targetProgress) * 100)}"/>%</div>
                                   </div>
                              </div>
                         </div>
                    </c:forEach>
                    <c:if test="${empty userGoals}">
                        <div class="py-12 flex flex-col items-center text-center">
                            <i class="fa-regular fa-flag text-4xl text-gray-200 mb-3 block"></i>
                            <span class="text-[13px] font-bold text-gray-400">Không có mục tiêu nào để hiển thị</span>
                        </div>
                    </c:if>
                </div>
                
                <!-- Tab: History -->
                <div id="tabHistory" class="tab-content hidden pr-2">
                    <c:forEach items="${progressList}" var="prog" varStatus="loop">
                         <div class="py-4 border-b border-gray-100 flex justify-between items-center gap-4">
                              <span class="text-[12px] font-bold text-gray-400 w-4 text-center shrink-0">${loop.index + 1}</span>
                              <div class="flex-1">
                                   <h4 class="text-[14px] font-bold text-gray-800 leading-tight mb-1">${prog.activityName}</h4>
                                   <p class="text-[11px] font-medium text-gray-400 flex items-center gap-1"><i class="fa-regular fa-bookmark text-[10px] text-gray-300"></i> Mục tiêu ID #${prog.goalId}</p>
                              </div>
                              <div class="text-right shrink-0">
                                   <div class="text-[13px] font-black text-[#10B981] leading-tight mb-1">+${prog.pointsEarned} đ</div>
                                   <p class="text-[11px] font-bold text-gray-400">${prog.createdAt.toString().substring(0, 10)}</p>
                              </div>
                         </div>
                    </c:forEach>
                    <c:if test="${empty progressList}">
                        <div class="py-12 flex flex-col items-center text-center">
                            <i class="fa-solid fa-clock-rotate-left text-4xl text-gray-200 mb-3 block"></i>
                            <span class="text-[13px] font-bold text-gray-400">Chưa có lịch sử check-in nào</span>
                        </div>
                    </c:if>
                </div>
                
            </div>
        </div>
        
        <!-- Footer Fixed -->
        <div class="px-6 py-4 border-t border-gray-100 flex flex-col sm:flex-row justify-between items-center bg-gray-50/80 shrink-0 gap-4">
            <div class="text-[11px] font-medium text-gray-400 flex items-center gap-1.5 w-full sm:w-auto justify-center sm:justify-start">
                <i class="fa-regular fa-circle-question text-gray-300"></i> Trình duyệt sẽ tải file về thư mục Downloads mặc định
            </div>
            <div class="flex gap-2 w-full sm:w-auto">
                <button onclick="document.getElementById('exportModal').close()" class="w-full sm:w-auto px-6 py-2.5 bg-white border border-gray-200 text-gray-600 font-bold rounded-lg hover:bg-gray-50 transition-colors text-sm shadow-sm">
                    Hủy
                </button>
                <form action="${pageContext.request.contextPath}/export" method="GET" class="w-full sm:w-auto" onsubmit="setTimeout(() => document.getElementById('exportModal').close(), 1000)">
                    <input type="hidden" name="type" value="user" />
                    <input type="hidden" name="filter" value="all" id="userExportFilter" />
                    <button type="submit" class="w-full px-6 py-2.5 bg-[#10B981] text-white font-bold rounded-lg shadow-md hover:bg-[#059669] transition-all text-sm flex items-center justify-center gap-2">
                        <i class="fa-solid fa-file-csv"></i> Tải xuống .CSV
                    </button>
                </form>
            </div>
        </div>
    </div>
</dialog>

</body>
</html>
