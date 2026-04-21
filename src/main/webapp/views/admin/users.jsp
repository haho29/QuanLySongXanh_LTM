<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Người Dùng - Admin</title>
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

    <!-- Header Section -->
    <div class="mb-6">
        <h1 class="text-[28px] font-serif font-bold text-[#1F2937] mb-1">Quản Lý Người Dùng</h1>
        <p class="text-[13px] text-gray-500 font-medium">Tổng cộng ${users.size()} người dùng trong hệ thống</p>
    </div>

    <!-- Tools -->
    <div class="flex justify-between items-center mb-6">
        <div class="flex items-center gap-4">
            <!-- Search bar -->
            <div class="relative w-[320px]">
                <i class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400 text-sm"></i>
                <input type="text" placeholder="Tìm kiếm người dùng..." 
                       class="w-full bg-white pl-10 pr-4 py-2 rounded-lg text-[13px] border border-gray-200 focus:border-[#1B4332] outline-none shadow-sm transition-colors" />
            </div>
            
            <!-- Pill Filters -->
            <div class="flex bg-gray-100 p-1 rounded-lg">
                <button class="px-4 py-1.5 bg-white shadow-sm rounded border border-gray-200 text-[12px] font-bold text-gray-800">Tất cả</button>
                <button class="px-4 py-1.5 rounded text-[12px] font-medium text-gray-500 hover:text-gray-800">Hoạt động</button>
                <button class="px-4 py-1.5 rounded text-[12px] font-medium text-gray-500 hover:text-gray-800">Không hoạt động</button>
            </div>
        </div>
        
        <p class="text-[13px] text-gray-500">Hiển thị <span class="font-bold text-gray-800">${users.size()}</span> người dùng</p>
    </div>

    <!-- Data Table -->
    <div class="bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-200/60 overflow-x-auto w-full">
        <table class="w-full text-left min-w-[900px]">
            <thead>
                <tr class="border-b border-gray-200 bg-gray-50/30">
                    <th class="py-4 px-6 text-[11px] font-bold text-gray-500">Người Dùng</th>
                    <th class="py-4 px-6 text-[11px] font-bold text-gray-500">Nghề Nghiệp</th>
                    <th class="py-4 px-6 text-[11px] font-bold text-gray-500">Địa Điểm</th>
                    <th class="py-4 px-6 text-[11px] font-bold text-gray-500 text-center">Điểm Xanh</th>
                    <th class="py-4 px-6 text-[11px] font-bold text-gray-500 text-center">Mục Tiêu</th>
                    <th class="py-4 px-6 text-[11px] font-bold text-gray-500 text-center">Trạng Thái</th>
                    <th class="py-4 px-6 text-[11px] font-bold text-gray-500 text-right">Thao Tác</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-100 bg-white">
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="7" class="py-10 text-center text-gray-500 text-sm font-medium">Không tìm thấy người dùng nào.</td>
                    </tr>
                </c:if>
                <c:forEach var="u" items="${users}" varStatus="loop">
                    <tr class="hover:bg-gray-50/50 transition-colors group h-[72px]">
                        <td class="px-6 py-2">
                            <div class="flex items-center gap-3">
                                <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=${u.username}" class="w-10 h-10 rounded-full bg-gray-100" />
                                <div class="flex flex-col">
                                    <span class="font-bold text-[13px] text-gray-800 leading-tight block">${u.fullName}</span>
                                    <span class="text-[11px] text-gray-400 mt-0.5 block">${u.email}</span>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-2 text-[12px] text-gray-600 font-medium whitespace-nowrap">
                            <c:out value="${empty u.job ? 'Không xác định' : u.job}" />
                        </td>
                        <td class="px-6 py-2 text-[12px] text-gray-500 whitespace-nowrap">
                            <i class="fa-solid fa-location-dot text-gray-400 mr-1 text-[10px]"></i> <c:out value="${empty u.location ? 'Không rõ' : u.location}" />
                        </td>
                        <td class="px-6 py-2 text-center text-[13px] font-bold text-[#10B981]">
                            <!-- Mock Data points relative to index -->
                            ${2150 - (loop.index * 125)}
                        </td>
                        <td class="px-6 py-2 text-center text-[13px] text-gray-600 font-medium">
                            ${8 - loop.index > 0 ? 8 - loop.index : 1}
                        </td>
                        <td class="px-6 py-2 text-center whitespace-nowrap">
                            <c:choose>
                                <c:when test="${loop.index < 7}">
                                    <span class="inline-flex items-center gap-1.5 text-[10px] font-bold px-2.5 py-1 rounded border border-green-200 bg-green-50 text-green-600 uppercase tracking-widest">
                                        <span class="w-1.5 h-1.5 rounded-full bg-green-500"></span>
                                        Hoạt động
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-1.5 text-[10px] font-bold px-2.5 py-1 rounded border border-gray-200 bg-gray-50 text-gray-500 uppercase tracking-widest">
                                        <span class="w-1.5 h-1.5 rounded-full bg-gray-400"></span>
                                        Không HĐ
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-6 py-2 text-right">
                            <a href="#" class="text-[12px] font-bold text-[#10B981] hover:text-[#059669] transition-colors">Xem chi tiết</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <!-- Thin bottom spacing padding -->
    <div class="h-10"></div>
</main>
</body>
</html>
