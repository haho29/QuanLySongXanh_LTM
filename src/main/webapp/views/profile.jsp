<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="includes/navbar.jsp" />

<div class="min-h-screen pt-24 bg-surface">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
         <div class="bg-white rounded-3xl p-8 border border-primary/10 shadow-sm flex items-center gap-6 mb-10">
              <div class="w-24 h-24 bg-gray-200 rounded-full flex items-center justify-center overflow-hidden border-4 border-white shadow-lg">
                  <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${sessionScope.currentUser.username}" alt="Avatar" class="w-full h-full object-cover">
              </div>
              <div class="flex-1">
                  <h2 class="text-3xl font-black text-gray-900 mb-1">${sessionScope.currentUser.fullName}</h2>
                  <p class="text-primary font-bold text-sm mb-3"><i class="fa-solid fa-envelope mr-1"></i> ${sessionScope.currentUser.email}</p>
                  
                  <div class="flex items-center gap-4 text-sm text-gray-500 font-medium">
                      <span class="flex items-center gap-1"><i class="fa-solid fa-briefcase"></i> ${sessionScope.currentUser.job != null ? sessionScope.currentUser.job : 'Chưa cập nhật'}</span>
                      <span>•</span>
                      <span class="flex items-center gap-1"><i class="fa-solid fa-map-pin"></i> ${sessionScope.currentUser.location != null ? sessionScope.currentUser.location : 'Chưa cập nhật'}</span>
                      <c:if test="${sessionScope.currentUser.admin}">
                           <span class="px-2 py-0.5 bg-red-100 text-red-600 rounded text-xs font-bold border border-red-200 uppercase ml-2">ADMIN</span>
                      </c:if>
                  </div>
              </div>
              <div>
                  <button class="px-6 py-2.5 border-2 border-primary/20 text-primary hover:bg-primary hover:text-white transition-colors rounded-full font-bold">
                       Chỉnh sửa
                  </button>
              </div>
         </div>

         <!-- Placeholder for other tabs -->
         <div class="bg-white rounded-[2rem] border border-primary/10 shadow-sm p-10 text-center text-gray-400">
              <i class="fa-solid fa-chart-pie text-5xl mb-4 text-gray-200"></i>
              <h3 class="text-xl font-bold text-gray-600 mb-2">Thống Kê Cá Nhân</h3>
              <p>Biểu đồ đóng góp sẽ hiển thị ở đây (Đang chờ cài đặt dữ liệu Backend)</p>
         </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
