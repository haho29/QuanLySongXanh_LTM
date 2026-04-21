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
            <form action="${pageContext.request.contextPath}/admin/users" method="GET" class="relative w-[320px]">
                <input type="hidden" name="status" value="${paramStatus}" />
                <i class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400 text-sm"></i>
                <input type="text" name="search" value="${paramSearch}" placeholder="Tìm kiếm người dùng..." 
                       class="w-full bg-white pl-10 pr-4 py-2 rounded-lg text-[13px] border border-gray-200 focus:border-[#1B4332] outline-none shadow-sm transition-colors" />
            </form>
            
            <!-- Pill Filters -->
            <div class="flex bg-gray-100 p-1 rounded-lg">
                <a href="${pageContext.request.contextPath}/admin/users?status=all&search=${paramSearch}" class="px-4 py-1.5 ${paramStatus == 'all' ? 'bg-white shadow-sm border border-gray-200 text-gray-800' : 'text-gray-500 hover:text-gray-800'} rounded text-[12px] font-bold">Tất cả</a>
                <a href="${pageContext.request.contextPath}/admin/users?status=ACTIVE&search=${paramSearch}" class="px-4 py-1.5 ${paramStatus == 'ACTIVE' ? 'bg-white shadow-sm border border-gray-200 text-gray-800' : 'text-gray-500 hover:text-gray-800'} rounded text-[12px] font-bold">Hoạt động</a>
                <a href="${pageContext.request.contextPath}/admin/users?status=INACTIVE&search=${paramSearch}" class="px-4 py-1.5 ${paramStatus == 'INACTIVE' ? 'bg-white shadow-sm border border-gray-200 text-gray-800' : 'text-gray-500 hover:text-gray-800'} rounded text-[12px] font-bold">Không hoạt động</a>
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
                            ${u.points}
                        </td>
                        <td class="px-6 py-2 text-center text-[13px] text-gray-600 font-medium">
                            ${u.goalsCount}
                        </td>
                        <td class="px-6 py-2 text-center whitespace-nowrap">
                            <c:choose>
                                <c:when test="${u.status == 'ACTIVE'}">
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
                            <button type="button" onclick="openDetailsModal('${u.id}', '${u.fullName}', '${u.username}', '${u.email}', '${u.job}', '${u.location}', '${u.points}', '${u.goalsCount}', '${u.status}')" class="text-[12px] font-bold text-[#10B981] hover:text-[#059669] transition-colors">Xem chi tiết</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <!-- Thin bottom spacing padding -->
    <div class="h-10"></div>
</main>

<!-- Details & Delete Modal -->
<div id="userModal" class="fixed inset-0 z-50 bg-gray-900/40 hidden flex items-center justify-center backdrop-blur-sm transition-opacity">
    <div class="bg-white w-[400px] rounded-2xl shadow-xl overflow-hidden transform transition-all scale-95 opacity-0" id="userModalContent">
        <div class="px-6 py-5 border-b border-gray-100 flex justify-between items-center bg-gray-50/50">
            <h3 class="font-bold text-gray-800 text-[15px]">Chi tiết Người dùng</h3>
            <button onclick="closeDetailsModal()" class="text-gray-400 hover:text-gray-600 outline-none"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="p-6">
            <div class="flex items-center gap-4 mb-6">
                <img id="mAvatar" src="" class="w-14 h-14 rounded-full bg-gray-100" />
                <div>
                    <h4 id="mFullName" class="font-bold text-[15px] text-gray-800"></h4>
                    <p id="mEmail" class="text-[12px] text-gray-500"></p>
                    <span id="mStatusBadge" class="inline-block mt-1.5 text-[10px] font-bold px-2 py-0.5 rounded border uppercase tracking-widest"></span>
                </div>
            </div>
            
            <div class="grid grid-cols-2 gap-4 mb-6">
                <div class="bg-gray-50 p-3 rounded-xl border border-gray-100">
                    <p class="text-[11px] text-gray-500 mb-1">Cấp bậc / Nghề</p>
                    <p id="mJob" class="text-[13px] font-bold text-gray-800"></p>
                </div>
                <div class="bg-gray-50 p-3 rounded-xl border border-gray-100">
                    <p class="text-[11px] text-gray-500 mb-1">Địa bàn</p>
                    <p id="mLocation" class="text-[13px] font-bold text-gray-800"></p>
                </div>
                <div class="bg-green-50 p-3 rounded-xl border border-green-100">
                    <p class="text-[11px] text-green-600 mb-1">Điểm Xanh</p>
                    <p id="mPoints" class="text-[15px] font-bold text-green-700"></p>
                </div>
                <div class="bg-blue-50 p-3 rounded-xl border border-blue-100">
                    <p class="text-[11px] text-blue-600 mb-1">Mục Tiêu Đã Tạo</p>
                    <p id="mGoals" class="text-[15px] font-bold text-blue-700"></p>
                </div>
            </div>
            
            <div class="border-t border-gray-100 pt-5 flex justify-between items-center">
                <form action="${pageContext.request.contextPath}/admin/users" method="POST" onsubmit="return confirm('Bạn có chắc chắn muốn XÓA vĩnh viễn người dùng này?');">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="userId" id="mUserId" value="" />
                    <input type="hidden" name="search" value="${paramSearch}" />
                    <input type="hidden" name="status" value="${paramStatus}" />
                    <button type="submit" class="text-[12px] font-bold text-red-500 hover:text-red-700 hover:bg-red-50 px-3 py-1.5 rounded transition-colors"><i class="fa-regular fa-trash-can mr-1"></i> Xóa tài khoản</button>
                </form>
                
                <form action="${pageContext.request.contextPath}/admin/users" method="POST" class="inline">
                    <input type="hidden" name="action" value="toggle_status" />
                    <input type="hidden" name="userId" id="mStatusUserId" value="" />
                    <input type="hidden" name="newStatus" id="mNewStatus" value="" />
                    <input type="hidden" name="search" value="${paramSearch}" />
                    <input type="hidden" name="status" value="${paramStatus}" />
                    <button type="submit" id="mStatusBtn" class="text-[12px] font-bold px-4 py-1.5 rounded transition-all"></button>
                </form>
                
                <button type="button" onclick="closeDetailsModal()" class="px-5 py-2 rounded-lg bg-gray-100 text-gray-700 text-[12px] font-bold hover:bg-gray-200 transition-colors">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script>
    const modal = document.getElementById('userModal');
    const modalContent = document.getElementById('userModalContent');

    function openDetailsModal(id, fullName, username, email, job, location, points, goals, status) {
        document.getElementById('mUserId').value = id;
        document.getElementById('mAvatar').src = 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + username;
        document.getElementById('mFullName').innerText = fullName;
        document.getElementById('mEmail').innerText = email;
        document.getElementById('mJob').innerText = job && job !== 'null' ? job : 'Không xác định';
        document.getElementById('mLocation').innerText = location && location !== 'null' ? location : 'Không rõ';
        document.getElementById('mPoints').innerText = points;
        document.getElementById('mGoals').innerText = goals;
        
        const badge = document.getElementById('mStatusBadge');
        const statusBtn = document.getElementById('mStatusBtn');
        document.getElementById('mStatusUserId').value = id;
        
        if (status === 'ACTIVE') {
            badge.className = 'inline-block mt-1.5 text-[10px] font-bold px-2 py-0.5 rounded border uppercase tracking-widest border-green-200 bg-green-50 text-green-600';
            badge.innerText = 'Hoạt động';
            
            statusBtn.innerText = 'Khóa Tài Khoản';
            statusBtn.className = 'text-[12px] font-bold text-orange-600 hover:bg-orange-50 border border-orange-100 px-4 py-1.5 rounded transition-all';
            document.getElementById('mNewStatus').value = 'INACTIVE';
        } else {
            badge.className = 'inline-block mt-1.5 text-[10px] font-bold px-2 py-0.5 rounded border uppercase tracking-widest border-red-200 bg-red-50 text-red-500';
            badge.innerText = 'Không HĐ';
            
            statusBtn.innerText = 'Mở Khóa';
            statusBtn.className = 'text-[12px] font-bold text-green-600 hover:bg-green-50 border border-green-100 px-4 py-1.5 rounded transition-all';
            document.getElementById('mNewStatus').value = 'ACTIVE';
        }

        modal.classList.remove('hidden');
        // Give browser time to render block before animating transitions
        setTimeout(() => {
            modalContent.classList.remove('scale-95', 'opacity-0');
            modalContent.classList.add('scale-100', 'opacity-100');
        }, 10);
    }
    
    function closeDetailsModal() {
        modalContent.classList.remove('scale-100', 'opacity-100');
        modalContent.classList.add('scale-95', 'opacity-0');
        setTimeout(() => {
            modal.classList.add('hidden');
        }, 300);
    }
</script>

</body>
</html>
