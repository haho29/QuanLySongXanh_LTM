<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Mục Tiêu - Admin GreenLife</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; background-color: #F8F9FA; color: #333; }
        .font-serif { font-family: 'Playfair Display', serif; }
    </style>
</head>
<body class="flex bg-[#F8F9FA]">

<jsp:include page="includes/sidebar.jsp" />

<main class="ml-[260px] flex-1 min-h-screen p-8 lg:p-10">

    <div class="flex justify-between items-start mb-8">
        <div>
            <h1 class="text-3xl font-serif text-[#1F2937] font-semibold mb-1">Kiểm Duyệt Mục Tiêu</h1>
            <p class="text-sm text-gray-500">Phê duyệt hoặc từ chối các mục tiêu xanh được người dùng khởi tạo.</p>
        </div>
    </div>

    <!-- Alert / Stats section -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
        <div class="bg-amber-50 border border-amber-200 rounded-xl p-5 flex gap-4 shadow-sm">
            <div class="mt-1 text-amber-500 text-xl"><i class="fa-solid fa-bell"></i></div>
            <div>
                <h3 class="text-base font-bold text-amber-800">Cần Duyệt (PENDING)</h3>
                <p class="text-sm text-amber-700/80 mt-1">Đang có <span class="font-bold text-amber-600">${pendingGoals.size()}</span> mục tiêu mới được tạo cần bạn xem xét trước khi thiết lập trạng thái Đang thực hiện.</p>
            </div>
        </div>
    </div>

    <!-- Pending Goals Table -->
    <div class="bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50 p-0 mb-8 overflow-hidden">
        <div class="px-6 py-5 border-b border-gray-100">
            <h3 class="text-base font-bold text-gray-800">Danh Sách Chờ Duyệt</h3>
        </div>
        
        <c:choose>
            <c:when test="${empty pendingGoals}">
                <div class="p-10 text-center text-gray-500">
                    <i class="fa-solid fa-check-circle text-4xl text-green-300 mb-4 block"></i>
                    <p class="font-medium">Tuyệt vời, không có mục tiêu nào cần duyệt lúc này!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="bg-gray-50 text-[11px] font-bold text-gray-400 uppercase tracking-widest border-b border-gray-100">
                                <th class="px-6 py-4 w-12 text-center">ID</th>
                                <th class="px-6 py-4">Mục Tiêu & Mô Tả</th>
                                <th class="px-6 py-4">Danh Mục</th>
                                <th class="px-6 py-4 text-center">Tiến Độ (Ngày)</th>
                                <th class="px-6 py-4">Hạn Hoàn Thành</th>
                                <th class="px-6 py-4 text-right">Phê Duyệt</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                            <c:forEach var="goal" items="${pendingGoals}">
                                <tr class="hover:bg-gray-50/50">
                                    <td class="px-6 py-4 text-center text-sm font-medium text-gray-500">#${goal.id}</td>
                                    <td class="px-6 py-4">
                                        <p class="text-[14px] font-bold text-gray-800 mb-1">${goal.title}</p>
                                        <p class="text-[12px] text-gray-500 line-clamp-1 max-w-sm" title="${goal.description}">${goal.description != null ? goal.description : 'Không có mô tả'}</p>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="px-2.5 py-1 bg-blue-50 text-blue-600 rounded text-xs font-semibold">${goal.category != null ? goal.category : 'Khác'}</span>
                                    </td>
                                    <td class="px-6 py-4 text-center text-sm font-bold text-gray-700">${goal.targetProgress}</td>
                                    <td class="px-6 py-4 text-sm text-gray-600 font-medium">
                                        <c:choose>
                                            <c:when test="${goal.endDate != null}">
                                                <fmt:formatDate value="${goal.endDate}" pattern="dd/MM/yyyy" />
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-gray-400 italic">Không có hạn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <div class="flex gap-2 justify-end">
                                            <form action="${pageContext.request.contextPath}/admin/goals" method="POST" class="inline">
                                                <input type="hidden" name="action" value="approve" />
                                                <input type="hidden" name="goal_id" value="${goal.id}" />
                                                <button class="w-8 h-8 rounded-full bg-green-50 text-green-600 hover:bg-green-500 hover:text-white transition-all flex items-center justify-center shadow-sm" title="Duyệt">
                                                    <i class="fa-solid fa-check"></i>
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/admin/goals" method="POST" class="inline">
                                                <input type="hidden" name="action" value="reject" />
                                                <input type="hidden" name="goal_id" value="${goal.id}" />
                                                <button class="w-8 h-8 rounded-full bg-red-50 text-red-600 hover:bg-red-500 hover:text-white transition-all flex items-center justify-center shadow-sm" title="Từ chối">
                                                    <i class="fa-solid fa-xmark"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</main>
</body>
</html>
