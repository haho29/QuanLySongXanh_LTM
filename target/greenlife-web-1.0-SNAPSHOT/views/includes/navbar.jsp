<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="com.greenlife.model.User, com.greenlife.dao.NotificationDAO, com.greenlife.model.Notification, java.util.List" %>
<% 
   String currentPath = request.getServletPath();
   request.setAttribute("currentPath", currentPath);
   
   User currentUser = (User) session.getAttribute("currentUser");
   if (currentUser != null) {
       NotificationDAO notiDAO = new NotificationDAO();
       int unreadCount = notiDAO.getUnreadCount(currentUser.getId());
       List<Notification> notifications = notiDAO.getNotificationsByUserId(currentUser.getId());
       request.setAttribute("unreadCount", unreadCount);
       request.setAttribute("notifications", notifications);
   }
%>

<nav class="bg-white border-b border-gray-100 z-40 fixed top-0 w-full shadow-sm py-3 transition-all duration-300" id="mainNavbar">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-12">
            
            <!-- Logo area -->
            <div class="flex-shrink-0 flex items-center gap-2">
                <i class="fa-solid fa-leaf text-[#10B981] text-2xl"></i>
                <span class="font-bold text-[#1F2937] text-xl tracking-tight">GreenLife</span>
            </div>
            
            <!-- Desktop Menu (Center) -->
            <div class="hidden md:flex ml-10 space-x-6 lg:space-x-8">
                <a href="${pageContext.request.contextPath}/home" 
                   class="${currentPath == '/home' || currentPath == '/views/home.jsp' ? 'text-[#10B981] font-bold' : 'text-gray-600 hover:text-[#10B981] font-semibold'} transition text-[13px] tracking-wide">
                    Trang Chủ
                </a>
                <a href="${pageContext.request.contextPath}/goals" 
                   class="${currentPath == '/goals' || currentPath == '/views/goals.jsp' ? 'text-[#10B981] font-bold' : 'text-gray-600 hover:text-[#10B981] font-semibold'} transition text-[13px] tracking-wide">
                    Mục Tiêu Xanh
                </a>
                <a href="${pageContext.request.contextPath}/progress" 
                   class="${currentPath == '/progress' || currentPath == '/views/progress.jsp' ? 'text-[#10B981] font-bold' : 'text-gray-600 hover:text-[#10B981] font-semibold'} transition text-[13px] tracking-wide">
                    Tiến Độ
                </a>
                <a href="${pageContext.request.contextPath}/eco-tips" 
                   class="${currentPath == '/eco-tips' || currentPath == '/views/eco-tips.jsp' ? 'text-[#10B981] font-bold' : 'text-gray-600 hover:text-[#10B981] font-semibold'} transition text-[13px] tracking-wide">
                    Eco Tips
                </a>
                <a href="${pageContext.request.contextPath}/leaderboard" 
                   class="${currentPath == '/leaderboard' || currentPath == '/views/leaderboard.jsp' ? 'text-[#10B981] font-bold' : 'text-gray-600 hover:text-[#10B981] font-semibold'} transition text-[13px] tracking-wide">
                    Xếp Hạng
                </a>
            </div>
            
            <!-- User Actions (Right) -->
            <div class="hidden md:flex items-center space-x-5">
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <!-- Admin Access link if Admin -->
                        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="text-xs font-bold text-gray-500 hover:text-[#1B4332] transition bg-gray-100 px-3 py-1.5 rounded-full">
                                Go to Admin
                            </a>
                        </c:if>
                        
                        <!-- Notifications -->
                        <div class="relative">
                            <button id="notificationBtn" class="relative text-gray-500 hover:text-gray-800 transition outline-none">
                                <i class="fa-regular fa-bell text-lg"></i>
                                <c:if test="${unreadCount > 0}">
                                    <span class="absolute -top-1.5 -right-1.5 bg-red-500 text-white text-[9px] font-bold px-1.5 py-0.5 rounded-full border-2 border-white">${unreadCount}</span>
                                </c:if>
                            </button>
                            
                            <!-- Notification Dropdown -->
                            <div id="notificationDropdown" class="absolute right-0 mt-4 w-80 bg-white rounded-2xl shadow-xl border border-gray-100 hidden z-50 overflow-hidden transform origin-top-right transition-all">
                                <div class="px-5 py-4 border-b border-gray-50 flex justify-between items-center bg-gray-50/50">
                                    <h3 class="font-bold text-gray-800 text-[13px]">Thông báo</h3>
                                    <span class="text-[10px] font-bold text-[#10B981] bg-green-50 px-2.5 py-1 rounded-full">Mới nhất</span>
                                </div>
                                <div class="max-h-[350px] overflow-y-auto">
                                    <c:choose>
                                        <c:when test="${empty notifications}">
                                            <div class="px-5 py-10 text-center">
                                                <i class="fa-regular fa-bell-slash text-gray-200 text-3xl mb-3 block"></i>
                                                <p class="text-[12px] text-gray-400 font-medium">Bạn chưa có thông báo nào.</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="n" items="${notifications}">
                                                <div class="px-5 py-4 border-b border-gray-50 hover:bg-gray-50/50 transition-colors cursor-pointer group">
                                                    <div class="flex gap-3">
                                                        <div class="w-8 h-8 rounded-full flex-shrink-0 flex items-center justify-center text-xs
                                                            ${n.type == 'SUCCESS' ? 'bg-green-50 text-green-500' : ''}
                                                            ${n.type == 'POINTS' ? 'bg-blue-50 text-blue-500' : ''}
                                                            ${n.type == 'INFO' ? 'bg-gray-50 text-gray-500' : ''}">
                                                            <i class="fa-solid 
                                                                ${n.type == 'SUCCESS' ? 'fa-check' : (n.type == 'POINTS' ? 'fa-leaf' : 'fa-info')}"></i>
                                                        </div>
                                                        <div class="flex-1">
                                                            <div class="flex justify-between items-start mb-0.5">
                                                                <h4 class="text-[12px] font-bold text-gray-800 leading-tight">${n.title}</h4>
                                                                <c:if test="${!n.read}">
                                                                    <span class="w-1.5 h-1.5 rounded-full bg-red-500 mt-1"></span>
                                                                </c:if>
                                                            </div>
                                                            <p class="text-[11px] text-gray-500 leading-relaxed line-clamp-2">${n.content}</p>
                                                            <p class="text-[9px] text-gray-400 font-medium mt-1">Vừa xong</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <a href="#" class="block py-3 text-center text-[11px] font-bold text-gray-500 hover:text-[#10B981] bg-gray-50/30 transition-colors border-t border-gray-50">Xem tất cả thông báo</a>
                            </div>
                        </div>
                        
                        <!-- Profile -->
                        <a href="${pageContext.request.contextPath}/profile" class="text-[13px] font-bold text-gray-700 hover:text-[#10B981] transition px-1">Hồ Sơ</a>
                        
                        <!-- Logout Outline Button -->
                        <a href="${pageContext.request.contextPath}/logout" class="px-5 py-2 rounded-full border border-red-200 text-red-500 hover:bg-red-50 hover:border-red-300 font-bold text-[13px] transition-all">
                            Đăng Xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="text-gray-700 font-bold text-[13px] hover:text-[#10B981]">Đăng Nhập</a>
                        <a href="${pageContext.request.contextPath}/login" class="bg-[#10B981] text-white px-5 py-2 rounded-full font-bold text-[13px] hover:bg-[#059669] shadow-md shadow-green-500/20 transition-all">
                            Bắt Đầu
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
            
        </div>
    </div>
</nav>

<!-- Navbar transparency logic for Home Page -->
<c:if test="${currentPath == '/home' || currentPath == '/views/home.jsp'}">
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const nav = document.getElementById('mainNavbar');
        // Initial state for home page
        nav.classList.replace('bg-white', 'bg-black/20');
        nav.classList.replace('border-gray-100', 'border-white/10');
        nav.classList.remove('shadow-sm');
        
        // Find text links and change to white temporarily
        const links = nav.querySelectorAll('a, span');
        links.forEach(l => {
           if(l.classList.contains('text-gray-600')) l.classList.replace('text-gray-600', 'text-white/80');
           if(l.classList.contains('text-gray-700')) l.classList.replace('text-gray-700', 'text-white/80');
           if(l.classList.contains('text-[#1F2937]')) l.classList.replace('text-[#1F2937]', 'text-white');
           if(l.classList.contains('text-gray-500')) l.classList.replace('text-gray-500', 'text-white/80');
        });
        
        const logoutBtn = nav.querySelector('.border-red-200');
        if(logoutBtn) {
            logoutBtn.classList.replace('border-red-200', 'border-white/30');
            logoutBtn.classList.replace('text-red-500', 'text-white');
            logoutBtn.classList.replace('hover:bg-red-50', 'hover:bg-white/10');
        }

        window.addEventListener('scroll', () => {
            if (window.scrollY > 50) {
                // Restore to original white
                nav.classList.replace('bg-black/20', 'bg-white');
                nav.classList.replace('border-white/10', 'border-gray-100');
                nav.classList.add('shadow-sm');
                
                links.forEach(l => {
                    if(l.classList.contains('text-white/80')) l.classList.replace('text-white/80', 'text-gray-600');
                    if(l.classList.contains('text-white') && l.tagName === 'SPAN') l.classList.replace('text-white', 'text-[#1F2937]');
                });
                
                if(logoutBtn) {
                    logoutBtn.classList.replace('border-white/30', 'border-red-200');
                    logoutBtn.classList.replace('text-white', 'text-red-500');
                    logoutBtn.classList.replace('hover:bg-white/10', 'hover:bg-red-50');
                }
            } else {
                // Transparent
                nav.classList.replace('bg-white', 'bg-black/20');
                nav.classList.replace('border-gray-100', 'border-white/10');
                nav.classList.remove('shadow-sm');
                
                links.forEach(l => {
                    if(l.classList.contains('text-gray-600')) l.classList.replace('text-gray-600', 'text-white/80');
                    if(l.classList.contains('text-[#1F2937]')) l.classList.replace('text-[#1F2937]', 'text-white');
                });
                
                if(logoutBtn) {
                    logoutBtn.classList.replace('border-red-200', 'border-white/30');
                    logoutBtn.classList.replace('text-red-500', 'text-white');
                    logoutBtn.classList.replace('hover:bg-red-50', 'hover:bg-white/10');
                }
            }
        });
    });
</script>
</c:if>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const notiBtn = document.getElementById('notificationBtn');
        const notiDropdown = document.getElementById('notificationDropdown');
        
        if (notiBtn && notiDropdown) {
            notiBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                notiDropdown.classList.toggle('hidden');
                // Optional: Fade animation can be added here
            });
            
            document.addEventListener('click', function(e) {
                if (!notiDropdown.contains(e.target) && e.target !== notiBtn) {
                    notiDropdown.classList.add('hidden');
                }
            });
        }
    });
</script>
