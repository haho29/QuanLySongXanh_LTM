<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<% 
   String currentAdminPath = request.getServletPath();
   request.setAttribute("currentAdminPath", currentAdminPath);
%>

<aside class="w-[260px] bg-[#1B4332] text-white flex flex-col h-screen fixed left-0 top-0 z-50">
    <!-- Header/Logo -->
    <div class="h-20 flex items-center px-6 shrink-0 mt-2">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center gap-3">
            <i class="fa-solid fa-leaf text-2xl text-green-400"></i>
            <div>
                <span class="text-xl font-bold text-white tracking-wide block leading-none">GreenLife</span>
                <span class="text-[10px] font-medium text-green-300 tracking-[0.1em] mt-1 block">ADMIN PANEL</span>
            </div>
        </a>
    </div>
    
    <!-- User Profile Card -->
    <div class="px-6 mb-6">
        <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-full bg-green-500/20 text-green-400 border border-green-500/30 flex items-center justify-center relative">
                <i class="fa-solid fa-shield-halved text-lg"></i>
                <div class="absolute bottom-0 right-0 w-3 h-3 bg-green-400 rounded-full border-2 border-[#1B4332]"></div>
            </div>
            <div>
                <span class="text-sm font-bold text-white block">${sessionScope.currentUser != null ? sessionScope.currentUser.username : 'admin'}</span>
                <span class="text-xs font-medium text-white/60">Quản trị viên</span>
            </div>
        </div>
    </div>
    
    <!-- Navigation Menu -->
    <nav class="flex-1 overflow-y-auto px-4 space-y-1">
        <!-- Dashboard -->
        <a href="${pageContext.request.contextPath}/admin/dashboard" 
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all
           ${currentAdminPath == '/views/admin/dashboard.jsp' ? 'bg-[#2D6A4F] text-white font-medium' : 'text-white/60 hover:text-white font-medium'}">
            <i class="fa-solid fa-chart-pie w-5 text-center text-[15px]"></i> Tổng Quan
        </a>
        
        <!-- User Management -->
        <a href="${pageContext.request.contextPath}/admin/users" 
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all
           ${currentAdminPath == '/views/admin/users.jsp' ? 'bg-[#2D6A4F] text-white font-medium' : 'text-white/60 hover:text-white font-medium'}">
            <i class="fa-solid fa-user-group w-5 text-center text-[15px]"></i> Người Dùng
        </a>
        
        <!-- Goal Management -->
        <a href="${pageContext.request.contextPath}/admin/goals" 
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all
           ${currentAdminPath == '/views/admin/goals.jsp' ? 'bg-[#2D6A4F] text-white font-medium' : 'text-white/60 hover:text-white font-medium'}">
            <i class="fa-solid fa-crosshairs w-5 text-center text-[15px]"></i> Mục Tiêu
        </a>
    </nav>
    
    <!-- Footer Actions -->
    <div class="p-4 shrink-0 space-y-2 mb-2">
        <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-3 px-4 py-2 w-full text-white/60 hover:text-white transition-colors text-sm font-medium">
            <i class="fa-solid fa-house w-5 text-center"></i> Về Trang Chủ
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-4 py-2 w-full text-[#E76F51] hover:text-[#E76F51]/80 transition-colors font-medium text-sm">
            <i class="fa-solid fa-arrow-right-from-bracket w-5 text-center"></i> Đăng Xuất
        </a>
    </div>
</aside>
