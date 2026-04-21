<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Xếp Hạng - GreenLife</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; background-color: #F8F9FA; color: #333; }
        .font-serif { font-family: 'Playfair Display', serif; }
        .lb-hero {
            background-image: url('https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=2000&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body class="antialiased min-h-screen flex flex-col pt-[72px]">

<jsp:include page="includes/navbar.jsp" />

<!-- Hero Section -->
<div class="relative w-full h-[320px] lb-hero overflow-hidden flex items-center justify-center text-center">
    <!-- Gradient overlay mix green -->
    <div class="absolute inset-0 bg-gradient-to-t from-[#1B4332]/95 to-[#1B4332]/60 mix-blend-multiply"></div>
    <div class="absolute inset-0 bg-[#052e16]/30"></div>
    
    <div class="relative z-10 px-4 mt-4">
        <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-white/20 border border-white/20 text-[#A7F3D0] text-[10px] font-bold tracking-widest uppercase mb-4 shadow-sm backdrop-blur-sm">
            <i class="fa-solid fa-trophy text-yellow-400 text-xs"></i> Cộng đồng người sống xanh
        </div>
        <h1 class="text-4xl sm:text-[50px] font-serif font-bold text-white mb-4">Bảng Xếp Hạng<br>GreenLife</h1>
        <p class="text-[13px] md:text-sm text-white/80 font-medium max-w-xl mx-auto">
            Cùng nhau cạnh tranh thân thiện, tích lũy điểm xanh và truyền cảm hứng sống bền vững cho cộng đồng.
        </p>
    </div>
</div>

<div class="flex-1 bg-[#F9FAFB] relative pb-20">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <!-- Top Floating Stats -->
        <div class="bg-white rounded-2xl shadow-[0_2px_15px_-3px_rgba(0,0,0,0.05)] border border-gray-100 p-6 flex justify-around items-center -mt-10 relative z-20 mb-8">
             <div class="text-center px-4 w-full border-r border-gray-100">
                  <i class="fa-regular fa-user text-[#10B981] text-lg mb-2 block"></i>
                  <p class="text-[20px] font-black text-gray-800 mb-0.5">5,000+</p>
                  <p class="text-[9px] text-[#10B981] font-bold uppercase tracking-widest">Người Dùng</p>
             </div>
             <div class="text-center px-4 w-full border-r border-gray-100">
                  <i class="fa-regular fa-flag text-[#10B981] text-lg mb-2 block"></i>
                  <p class="text-[20px] font-black text-gray-800 mb-0.5">12,000+</p>
                  <p class="text-[9px] text-[#10B981] font-bold uppercase tracking-widest">Mục Tiêu</p>
             </div>
             <div class="text-center px-4 w-full">
                  <i class="fa-solid fa-cloud text-[#10B981] text-lg mb-2 block"></i>
                  <p class="text-[20px] font-black text-gray-800 mb-0.5">24 Tấn</p>
                  <p class="text-[9px] text-[#10B981] font-bold uppercase tracking-widest">CO2 Giảm</p>
             </div>
        </div>

        <c:if test="${sessionScope.currentUser != null}">
            <c:set var="userRank" value="-" />
            <c:set var="userPoints" value="0" />
            <c:set var="userStreak" value="0" />
            <c:forEach var="u" items="${topUsers}" varStatus="loop">
                <c:if test="${u.username == sessionScope.currentUser.username}">
                    <c:set var="userRank" value="${loop.index + 1}" />
                    <c:set var="userPoints" value="${u.points}" />
                    <c:set var="userStreak" value="${u.runStreak}" />
                </c:if>
            </c:forEach>
            <!-- Current User Rank Banner -->
            <div class="bg-[#10B981] rounded-[24px] p-5 shadow-lg shadow-[#10B981]/20 flex justify-between items-center mb-8 border border-white/20 relative overflow-hidden">
                 <!-- Background pattern -->
                 <div class="absolute right-0 bottom-0 opacity-10"><i class="fa-solid fa-trophy text-[150px]"></i></div>
                 
                 <div class="flex items-center gap-4 relative z-10">
                      <div class="w-16 h-16 rounded-xl bg-white/20 flex flex-col items-center justify-center text-white backdrop-blur border border-white/20 shadow-inner">
                          <span class="text-[10px] font-bold uppercase tracking-wider mb-0.5 opacity-80 mt-1">Hạng</span>
                          <span class="text-xl font-black leading-none">#${userRank}</span>
                      </div>
                      <div class="flex items-center gap-3">
                          <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${sessionScope.currentUser.username}" class="w-12 h-12 rounded-full border-2 border-white bg-white/50">
                          <div>
                              <h3 class="text-white font-bold text-lg leading-tight">${sessionScope.currentUser.fullName} <span class="bg-white/20 text-[10px] px-1.5 py-0.5 rounded ml-1 font-medium">Bạn</span></h3>
                              <div class="flex gap-3 text-white/80 text-[11px] font-medium mt-1">
                                   <span><i class="fa-solid fa-fire text-yellow-300"></i> ${userStreak} ngày streak</span>
                              </div>
                          </div>
                      </div>
                 </div>
                 
                 <div class="text-right relative z-10 hidden sm:block pr-4">
                      <p class="text-[28px] font-black text-white leading-tight">${userPoints}</p>
                      <p class="text-[10px] text-white/80 uppercase tracking-widest font-bold">Điểm xanh</p>
                 </div>
            </div>
        </c:if>

        <!-- 3 Tabs Filter -->
        <div class="flex gap-2 p-1 bg-white rounded-full border border-gray-200 shadow-sm mb-12 sm:w-max mx-auto overflow-x-auto">
            <button class="px-6 py-2.5 rounded-full bg-[#10B981] text-white text-[13px] font-bold shadow transition-all whitespace-nowrap flex items-center gap-2"><i class="fa-solid fa-medal"></i> Tổng Điểm</button>
            <button class="px-6 py-2.5 rounded-full bg-transparent text-gray-500 hover:text-gray-800 text-[13px] font-bold transition-all whitespace-nowrap flex items-center gap-2"><i class="fa-regular fa-calendar-check"></i> Tuần Này</button>
            <button class="px-6 py-2.5 rounded-full bg-transparent text-gray-500 hover:text-gray-800 text-[13px] font-bold transition-all whitespace-nowrap flex items-center gap-2"><i class="fa-solid fa-users"></i> Theo Cộng Đồng</button>
        </div>

        <!-- TOP 3 Podium Area -->
        <div class="text-center mb-16">
            <p class="text-[#10B981] font-bold text-[10px] tracking-[0.2em] uppercase mb-10 text-center w-max mx-auto">TOP 3 NGƯỜI DÙNG XANH</p>
            
            <div class="flex items-end justify-center gap-2 sm:gap-6 w-full max-w-2xl mx-auto h-[260px] px-2 relative">
                
                <!-- Rank 2 -->
                <c:if test="${topUsers.size() > 1}">
                    <c:set var="u2" value="${topUsers[1]}" />
                    <div class="flex flex-col items-center w-[30%]">
                         <div class="relative w-14 h-14 sm:w-16 sm:h-16 rounded-full border-4 border-gray-300 bg-gray-100 z-10 shadow-lg -mb-6">
                              <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${u2.username}" class="w-full h-full rounded-full">
                              <div class="absolute -bottom-2 -right-1 w-6 h-6 rounded-full bg-gray-600 text-white text-[10px] font-bold flex items-center justify-center border-2 border-white shadow-sm">2</div>
                         </div>
                         <div class="bg-white px-2 py-8 rounded-t-xl w-full border border-gray-200 shadow-[0_-4px_20px_rgba(0,0,0,0.03)] h-[120px] relative z-0 flex flex-col justify-end pb-4">
                              <p class="text-[12px] font-bold text-gray-800 truncate px-1 block w-full">${u2.fullName}</p>
                              <p class="text-[9px] text-gray-400 mb-1 hidden sm:block">${u2.job}</p>
                              <p class="text-[15px] font-black text-gray-700">${u2.points} <span class="text-[9px] font-normal uppercase text-gray-400">đ</span></p>
                         </div>
                         <div class="w-full bg-gray-200 text-gray-500 text-xl font-bold py-6 rounded-b-xl shadow-inner flex flex-col items-center border border-t-0 border-gray-300">
                              #2
                         </div>
                         <p class="text-[10px] font-bold text-gray-400 mt-4"><i class="fa-solid fa-fire text-orange-400 mr-1"></i> ${u2.runStreak} ngày</p>
                    </div>
                </c:if>

                <!-- Rank 1 -->
                <c:if test="${topUsers.size() > 0}">
                    <c:set var="u1" value="${topUsers[0]}" />
                <div class="flex flex-col items-center w-[35%] relative -top-6">
                     <div class="absolute -top-10 text-yellow-400 text-2xl z-20"><i class="fa-solid fa-crown drop-shadow-md"></i></div>
                     <div class="relative w-16 h-16 sm:w-[84px] sm:h-[84px] rounded-full border-4 border-yellow-400 bg-gray-100 z-10 shadow-lg -mb-8">
                          <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${u1.username}" class="w-full h-full rounded-full">
                          <div class="absolute -bottom-2 -right-1 w-7 h-7 rounded-full bg-yellow-500 text-white text-xs font-bold flex items-center justify-center border-2 border-white shadow-sm">1</div>
                     </div>
                     <div class="bg-white px-2 py-10 rounded-t-xl w-full border border-gray-200 shadow-[0_-4px_20px_rgba(245,158,11,0.1)] h-[160px] relative z-0 flex flex-col justify-end pb-5">
                          <p class="text-[14px] font-bold text-gray-800 truncate px-1 block w-full">${u1.fullName}</p>
                          <p class="text-[9px] text-gray-400 mb-1 hidden sm:block">${u1.job}</p>
                          <p class="text-[18px] font-black text-yellow-600">${u1.points} <span class="text-[9px] font-normal uppercase text-gray-400">đ</span></p>
                     </div>
                     <div class="w-full bg-gradient-to-b from-yellow-400 to-yellow-500 text-white text-3xl font-black py-8 rounded-b-xl shadow-inner flex flex-col items-center border border-t-0 border-yellow-400">
                          #1
                     </div>
                     <p class="text-[10px] font-bold text-gray-400 mt-4"><i class="fa-solid fa-fire text-orange-400 mr-1"></i> ${u1.runStreak} ngày</p>
                </div>
                </c:if>

                <!-- Rank 3 -->
                <c:if test="${topUsers.size() > 2}">
                    <c:set var="u3" value="${topUsers[2]}" />
                <div class="flex flex-col items-center w-[30%]">
                     <div class="relative w-14 h-14 sm:w-16 sm:h-16 rounded-full border-4 border-orange-300 bg-gray-100 z-10 shadow-lg -mb-6">
                          <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${u3.username}" class="w-full h-full rounded-full">
                          <div class="absolute -bottom-2 -right-1 w-6 h-6 rounded-full bg-orange-500 text-white text-[10px] font-bold flex items-center justify-center border-2 border-white shadow-sm">3</div>
                     </div>
                     <div class="bg-white px-2 py-8 rounded-t-xl w-full border border-gray-200 shadow-[0_-4px_20px_rgba(0,0,0,0.03)] h-[100px] relative z-0 flex flex-col justify-end pb-4">
                          <p class="text-[12px] font-bold text-gray-800 truncate px-1 block w-full">${u3.fullName}</p>
                          <p class="text-[9px] text-gray-400 mb-1 hidden sm:block">${u3.job}</p>
                          <p class="text-[15px] font-black text-orange-600">${u3.points} <span class="text-[9px] font-normal uppercase text-gray-400">đ</span></p>
                     </div>
                     <div class="w-full bg-orange-300 text-orange-800 text-xl font-bold py-4 rounded-b-xl shadow-inner flex flex-col items-center border border-t-0 border-orange-300">
                          #3
                     </div>
                     <p class="text-[10px] font-bold text-gray-400 mt-4"><i class="fa-solid fa-fire text-orange-400 mr-1"></i> ${u3.runStreak} ngày</p>
                </div>
                </c:if>
            </div>
        </div>

        <!-- Search Bar -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-2 flex items-center mb-6">
             <i class="fa-solid fa-magnifying-glass text-gray-400 ml-3 mr-2"></i>
             <input type="text" placeholder="Tìm kiếm người dùng hoặc nghề nghiệp..." class="flex-1 bg-transparent border-none outline-none text-[13px] py-1 text-gray-700" />
        </div>

        <!-- Leaderboard Table -->
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden mb-12">
            <table class="w-full text-left">
                <thead>
                    <tr class="bg-gray-50/50 border-b border-gray-100 text-[10px] font-bold text-gray-400 uppercase tracking-widest">
                        <th class="py-4 px-6 text-center w-16">Hạng</th>
                        <th class="py-4 px-6">Người Dùng</th>
                        <th class="py-4 px-6 text-center">Streak</th>
                        <th class="py-4 px-6 text-center">Mục Tiêu</th>
                        <th class="py-4 px-6 text-right">Điểm</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-50">
                    <c:forEach var="u" items="${topUsers}" varStatus="loop">
                        <c:set var="rank" value="${loop.index + 1}" />
                        <c:set var="isCurrentUser" value="${sessionScope.currentUser != null && sessionScope.currentUser.username == u.username}" />
                        
                        <c:set var="bgClass" value="hover:bg-gray-50/50 transition h-16 group" />
                        <c:if test="${isCurrentUser}">
                            <c:set var="bgClass" value="bg-green-50/30 hover:bg-green-50/60 transition h-16 group" />
                        </c:if>

                        <tr class="${bgClass}">
                            <td class="px-6 text-center">
                                <c:choose>
                                    <c:when test="${rank == 1}">
                                        <div class="w-7 h-7 mx-auto rounded-full bg-yellow-100 text-yellow-600 font-bold flex items-center justify-center text-xs">1</div>
                                    </c:when>
                                    <c:when test="${rank == 2}">
                                        <div class="w-7 h-7 mx-auto rounded-full bg-gray-200 border border-gray-300 text-gray-600 font-bold flex items-center justify-center text-xs">2</div>
                                    </c:when>
                                    <c:when test="${rank == 3}">
                                        <div class="w-7 h-7 mx-auto rounded-full bg-orange-100 text-orange-500 font-bold flex items-center justify-center text-xs">3</div>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="block font-bold text-gray-400 text-sm">${rank}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6">
                                <div class="flex items-center gap-3">
                                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${u.username}" class="w-9 h-9 rounded-full bg-gray-100 <c:if test='${isCurrentUser}'>border-2 border-[#10B981]</c:if>">
                                    <div>
                                        <p class="text-[13px] font-bold ${isCurrentUser ? 'text-[#10B981]' : 'text-gray-800'} leading-tight">
                                            ${u.fullName}
                                            <c:if test="${isCurrentUser}"><span class="bg-[#10B981]/20 text-[#10B981] text-[9px] px-1 rounded ml-0.5">Bạn</span></c:if>
                                        </p>
                                        <p class="text-[10px] text-gray-400">${u.job} ${u.location != null ? '- '.concat(u.location) : ''}</p>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 text-center text-[12px] text-gray-500"><i class="fa-solid fa-fire text-orange-400 text-[10px] mr-1"></i> ${u.runStreak}</td>
                            <td class="px-6 text-center text-[12px] text-gray-500"><i class="fa-solid fa-check text-[#10B981] text-[10px] mr-1"></i> 6</td>
                            <td class="px-6 text-right"><span class="text-[14px] font-black ${isCurrentUser ? 'text-[#10B981]' : 'text-gray-800'}">${u.points}</span><br><span class="text-[9px] text-gray-400">điểm</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-- Pagination mockup -->
            <div class="px-6 py-4 bg-gray-50/50 border-t border-gray-100 text-center text-[12px] text-gray-500 font-medium cursor-pointer hover:text-gray-800">
                Hiển thị thêm <i class="fa-solid fa-chevron-down ml-1 text-[10px]"></i>
            </div>
        </div>

        <!-- Banner Boost -->
        <div class="bg-[#1B4332] rounded-2xl p-8 flex flex-col md:flex-row justify-between items-center gap-6 shadow-[0_10px_30px_-5px_rgba(27,67,50,0.4)]">
             <div>
                  <h3 class="text-xl font-serif font-bold text-white mb-2">Muốn leo hạng nhanh hơn?</h3>
                  <p class="text-[13px] text-white/70">Check-in mục tiêu hằng ngày, duy trì streak và hoàn thành nhiều mục tiêu để tích lũy điểm xanh.</p>
             </div>
             <div class="flex gap-3 shrink-0">
                  <a href="${pageContext.request.contextPath}/views/goals.jsp" class="px-5 py-2.5 bg-[#10B981] text-white font-bold rounded-lg hover:bg-[#059669] text-sm shadow flex items-center gap-2 transition"><i class="fa-solid fa-flag"></i> Xem Mục Tiêu</a>
                  <a href="${pageContext.request.contextPath}/views/eco-tips.jsp" class="px-5 py-2.5 bg-white/10 text-white font-bold rounded-lg border border-white/20 hover:bg-white/20 text-sm flex items-center gap-2 transition"><i class="fa-regular fa-lightbulb"></i> Eco Tips</a>
             </div>
        </div>

    </div>
</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>
