<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Mẹo Sống Xanh - Admin</title>
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

    <div class="flex justify-between items-end mb-8">
        <div>
            <h1 class="text-3xl font-serif text-[#1F2937] font-semibold mb-1">Quản Lý Mẹo Sống Xanh</h1>
            <p class="text-sm text-gray-500">Thêm, sửa hoặc xóa các nội dung hướng dẫn về môi trường.</p>
        </div>
        <button onclick="openTipModal()" class="px-5 py-2.5 bg-[#10B981] text-white font-bold rounded-lg hover:bg-[#059669] shadow-md shadow-[#10B981]/20 transition-all text-[13px] flex items-center gap-2">
            <i class="fa-solid fa-plus"></i> Thêm Mẹo Mới
        </button>
    </div>

    <!-- Data Table -->
    <div class="bg-white rounded-xl shadow-[0_2px_10px_-3px_rgba(6,81,237,0.1)] border border-gray-100/50 overflow-hidden">
        <table class="w-full text-left">
            <thead>
                <tr class="bg-gray-50 text-[11px] font-bold text-gray-400 uppercase tracking-widest border-b border-gray-100">
                    <th class="px-6 py-4 w-12 text-center">ID</th>
                    <th class="px-6 py-4">Mẹo & Nội Dung</th>
                    <th class="px-6 py-4">Danh Mục</th>
                    <th class="px-6 py-4 text-center">Điểm</th>
                    <th class="px-6 py-4 text-right">Thao Tác</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
                <c:if test="${empty tips}">
                    <tr>
                        <td colspan="5" class="py-10 text-center text-gray-500 text-sm">Chưa có mẹo nào trong hệ thống.</td>
                    </tr>
                </c:if>
                <c:forEach var="tip" items="${tips}">
                    <tr class="hover:bg-gray-50/50 transition-colors">
                        <td class="px-6 py-4 text-center text-sm font-medium text-gray-500">#${tip.id}</td>
                        <td class="px-6 py-4">
                            <p class="text-[14px] font-bold text-gray-800 mb-1">${tip.title}</p>
                            <p class="text-[12px] text-gray-400 line-clamp-1 max-w-md">${tip.content}</p>
                        </td>
                        <td class="px-6 py-4">
                            <span class="px-2.5 py-1 bg-green-50 text-green-600 rounded-full text-[10px] font-bold uppercase tracking-wide tracking-wider">${tip.category}</span>
                        </td>
                        <td class="px-6 py-4 text-center text-[13px] font-bold text-orange-500">+${tip.points}</td>
                        <td class="px-6 py-4 text-right">
                            <div class="flex gap-2 justify-end">
                                <button onclick="openTipModal(${tip.id}, '${tip.title}', '${tip.category}', ${tip.points}, `${tip.content}`)" class="text-gray-400 hover:text-blue-500 transition-colors">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/eco-tips" method="POST" onsubmit="return confirm('Bạn có chắc muốn xóa mẹo này?');" class="inline">
                                    <input type="hidden" name="action" value="delete" />
                                    <input type="hidden" name="id" value="${tip.id}" />
                                    <button type="submit" class="text-gray-400 hover:text-red-500 transition-colors">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</main>

<!-- Tip Modal (Add/Edit) -->
<div id="tipModal" class="fixed inset-0 z-50 bg-gray-900/40 hidden flex items-center justify-center backdrop-blur-sm">
    <div class="bg-white w-[500px] rounded-2xl shadow-xl overflow-hidden translate-y-0 transition-all opacity-100">
        <div class="px-6 py-5 border-b border-gray-100 flex justify-between items-center bg-gray-50/30">
            <h3 id="modalTitle" class="font-bold text-gray-800 text-[16px]">Thêm Mẹo Mới</h3>
            <button onclick="closeTipModal()" class="text-gray-400 hover:text-gray-600 outline-none"><i class="fa-solid fa-xmark text-lg"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/eco-tips" method="POST" class="p-6">
            <input type="hidden" name="action" id="modalAction" value="add" />
            <input type="hidden" name="id" id="tipId" value="" />
            
            <div class="space-y-5">
                <div>
                    <label class="block text-[12px] font-bold text-gray-400 uppercase tracking-widest mb-2">Tiêu Đề</label>
                    <input type="text" name="title" id="tipTitle" required class="w-full bg-gray-50 border border-gray-100 rounded-xl py-3 px-4 text-[13px] font-medium outline-none focus:bg-white focus:border-[#10B981] transition-all" />
                </div>
                
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-[12px] font-bold text-gray-400 uppercase tracking-widest mb-2">Danh Mục</label>
                        <select name="category" id="tipCategory" required class="w-full bg-gray-50 border border-gray-100 rounded-xl py-3 px-4 text-[13px] font-medium outline-none focus:bg-white focus:border-[#10B981] transition-all appearance-none">
                            <option value="Tiết Kiệm Điện">Tiết Kiệm Điện</option>
                            <option value="Tiết Kiệm Nước">Tiết Kiệm Nước</option>
                            <option value="Giảm Rác Nhựa">Giảm Rác Nhựa</option>
                            <option value="Giao Thông Xanh">Giao Thông Xanh</option>
                            <option value="Ăn Uống Xanh">Ăn Uống Xanh</option>
                            <option value="Phân Loại Rác">Phân Loại Rác</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-[12px] font-bold text-gray-400 uppercase tracking-widest mb-2">Điểm Thưởng</label>
                        <input type="number" name="points" id="tipPoints" required min="1" class="w-full bg-gray-50 border border-gray-100 rounded-xl py-3 px-4 text-[13px] font-medium outline-none focus:bg-white focus:border-[#10B981] transition-all" />
                    </div>
                </div>
                
                <div>
                    <label class="block text-[12px] font-bold text-gray-400 uppercase tracking-widest mb-2">Nội Dung Chi Tiết</label>
                    <textarea name="content" id="tipContent" rows="5" required class="w-full bg-gray-50 border border-gray-100 rounded-xl py-3 px-4 text-[13px] font-medium outline-none focus:bg-white focus:border-[#10B981] transition-all resize-none"></textarea>
                </div>
            </div>
            
            <div class="flex gap-3 pt-6">
                <button type="button" onclick="closeTipModal()" class="flex-1 py-3 bg-gray-100 text-gray-500 font-bold rounded-xl hover:bg-gray-200 transition-colors text-xs">Hủy</button>
                <button type="submit" class="flex-1 py-3 bg-[#10B981] text-white font-bold rounded-xl hover:bg-[#0D9668] transition-all text-xs shadow-lg shadow-green-500/20">Xác Nhận</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openTipModal(id = null, title = '', category = 'Tiết Kiệm Điện', points = 10, content = '') {
        document.getElementById('tipId').value = id || '';
        document.getElementById('tipTitle').value = title;
        document.getElementById('tipCategory').value = category;
        document.getElementById('tipPoints').value = points;
        document.getElementById('tipContent').value = content;
        
        document.getElementById('modalAction').value = id ? 'update' : 'add';
        document.getElementById('modalTitle').innerText = id ? 'Chỉnh Sửa Mẹo' : 'Thêm Mẹo Mới';
        
        document.getElementById('tipModal').classList.remove('hidden');
    }
    
    function closeTipModal() {
        document.getElementById('tipModal').classList.add('hidden');
    }
</script>

</body>
</html>
