<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mục Tiêu Xanh Của Tôi - GreenLife</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; background-color: #F8F9FA; color: #333; }
        .font-serif { font-family: 'Playfair Display', serif; }
    </style>
</head>
<body class="antialiased min-h-screen flex flex-col pt-[72px]">

<jsp:include page="includes/navbar.jsp" />

<div class="flex-1 bg-[#F9FAFB]">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        
        <!-- Header -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-end mb-8 gap-4">
            <div>
                <h1 class="text-[32px] font-serif font-bold text-[#1F2937] mb-1">Mục Tiêu Xanh Của Tôi</h1>
                <p class="text-[14px] text-gray-500">Quản lý và theo dõi các mục tiêu sống xanh của bạn</p>
            </div>
            <button onclick="document.getElementById('addGoalModal').showModal()" class="px-5 py-2.5 bg-[#10B981] text-white font-bold rounded-lg hover:bg-[#059669] shadow-md shadow-[#10B981]/20 transition-all text-sm flex items-center gap-2">
                <i class="fa-solid fa-plus"></i> Thêm Mục Tiêu
            </button>
        </div>

        <c:set var="countAll" value="${goals != null ? goals.size() : 0}" />
        <c:set var="countInProg" value="0" />
        <c:set var="countComp" value="0" />
        <c:set var="countPend" value="0" />
        <c:forEach var="g" items="${goals}">
            <c:if test="${g.status == 'IN_PROGRESS'}"><c:set var="countInProg" value="${countInProg + 1}"/></c:if>
            <c:if test="${g.status == 'COMPLETED'}"><c:set var="countComp" value="${countComp + 1}"/></c:if>
            <c:if test="${g.status == 'PENDING'}"><c:set var="countPend" value="${countPend + 1}"/></c:if>
        </c:forEach>

        <!-- Filters Tabs -->
        <div class="flex gap-3 mb-8 overflow-x-auto pb-2 -mx-4 px-4 sm:mx-0 sm:px-0 hide-scrollbar" id="goalTabs">
            <button onclick="filterGoals('ALL', this)" class="px-5 py-2 rounded-full border border-transparent bg-[#10B981] text-white text-[13px] font-bold shadow-sm whitespace-nowrap flex items-center gap-2 transition-all">
                Tất Cả <span class="bg-white/20 px-2 py-0.5 rounded-full text-[10px]">${countAll}</span>
            </button>
            <button onclick="filterGoals('IN_PROGRESS', this)" class="px-5 py-2 rounded-full border border-gray-200 bg-white text-gray-600 hover:border-gray-300 text-[13px] font-bold shadow-sm whitespace-nowrap flex items-center gap-2 transition-all">
                Đang Thực Hiện <span class="bg-gray-100 text-gray-500 px-2 py-0.5 rounded-full text-[10px]">${countInProg}</span>
            </button>
            <button onclick="filterGoals('COMPLETED', this)" class="px-5 py-2 rounded-full border border-gray-200 bg-white text-gray-600 hover:border-gray-300 text-[13px] font-bold shadow-sm whitespace-nowrap flex items-center gap-2 transition-all">
                Hoàn Thành <span class="bg-gray-100 text-gray-500 px-2 py-0.5 rounded-full text-[10px]">${countComp}</span>
            </button>
            <button onclick="filterGoals('PENDING', this)" class="px-5 py-2 rounded-full border border-gray-200 bg-white text-gray-600 hover:border-gray-300 text-[13px] font-bold shadow-sm whitespace-nowrap flex items-center gap-2 transition-all">
                Chờ Duyệt <span class="bg-gray-100 text-gray-500 px-2 py-0.5 rounded-full text-[10px]">${countPend}</span>
            </button>
        </div>

        <!-- Goals Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
            <c:if test="${empty goals}">
                <div class="col-span-full py-20 text-center bg-white rounded-3xl border border-gray-100 shadow-sm">
                    <div class="w-16 h-16 bg-gray-50 rounded-full flex items-center justify-center text-gray-400 mx-auto mb-4 text-2xl"><i class="fa-solid fa-leaf"></i></div>
                    <h3 class="text-lg font-bold text-gray-800 mb-2">Chưa có mục tiêu nào</h3>
                    <p class="text-sm text-gray-500">Hãy thêm mục tiêu xanh đầu tiên để bắt đầu hành trình của bạn.</p>
                </div>
            </c:if>

            <c:forEach var="goal" items="${goals}">
                <!-- Category Mapping -->
                <c:set var="iColorBg" value="bg-gray-50" /><c:set var="iColorText" value="text-gray-500" /><c:set var="icon" value="fa-leaf" /><c:set var="barColor" value="bg-gray-500" /><c:set var="btnColor" value="bg-gray-500 text-white hover:bg-gray-600" />
                
                <c:choose>
                    <c:when test="${goal.category == 'Tiết Kiệm Điện'}">
                        <c:set var="iColorBg" value="bg-orange-50" /> <c:set var="iColorText" value="text-[#F59E0B]" /> <c:set var="icon" value="fa-bolt" /> <c:set var="barColor" value="bg-[#F59E0B]" /> <c:set var="btnColor" value="bg-[#F59E0B] text-white hover:bg-orange-600" />
                    </c:when>
                    <c:when test="${goal.category == 'Tiết Kiệm Nước'}">
                        <c:set var="iColorBg" value="bg-blue-50" /> <c:set var="iColorText" value="text-[#3B82F6]" /> <c:set var="icon" value="fa-droplet" /> <c:set var="barColor" value="bg-[#3B82F6]" /> <c:set var="btnColor" value="bg-[#3B82F6] text-white hover:bg-blue-600" />
                    </c:when>
                    <c:when test="${goal.category == 'Giảm Rác Nhựa'}">
                        <c:set var="iColorBg" value="bg-emerald-50" /> <c:set var="iColorText" value="text-[#10B981]" /> <c:set var="icon" value="fa-recycle" /> <c:set var="barColor" value="bg-[#10B981]" /> <c:set var="btnColor" value="bg-[#10B981] text-white hover:bg-emerald-600" />
                    </c:when>
                    <c:when test="${goal.category == 'Giao Thông Xanh'}">
                        <c:set var="iColorBg" value="bg-purple-50" /> <c:set var="iColorText" value="text-[#8B5CF6]" /> <c:set var="icon" value="fa-bicycle" /> <c:set var="barColor" value="bg-[#8B5CF6]" /> <c:set var="btnColor" value="bg-[#8B5CF6] text-white hover:bg-purple-600" />
                    </c:when>
                    <c:when test="${goal.category == 'Ăn Uống Xanh'}">
                        <c:set var="iColorBg" value="bg-green-50" /> <c:set var="iColorText" value="text-[#22C55E]" /> <c:set var="icon" value="fa-seedling" /> <c:set var="barColor" value="bg-[#22C55E]" /> <c:set var="btnColor" value="bg-[#22C55E] text-white hover:bg-green-600" />
                    </c:when>
                    <c:when test="${goal.category == 'Phân Loại Rác'}">
                        <c:set var="iColorBg" value="bg-orange-50" /> <c:set var="iColorText" value="text-[#EA580C]" /> <c:set var="icon" value="fa-trash-can" /> <c:set var="barColor" value="bg-[#EA580C]" /> <c:set var="btnColor" value="bg-[#EA580C] text-white hover:bg-orange-700" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="iColorBg" value="bg-gray-100" /> <c:set var="iColorText" value="text-gray-500" /> <c:set var="icon" value="fa-leaf" /> <c:set var="barColor" value="bg-gray-400" /> <c:set var="btnColor" value="bg-gray-500 text-white hover:bg-gray-600" />
                    </c:otherwise>
                </c:choose>

                <!-- Thẻ Mục Tiêu -->
                <div class="goal-card bg-white rounded-[20px] p-6 shadow-sm border border-gray-100 hover:shadow-md transition-all flex flex-col h-full group relative" data-status="${goal.status}">
                    <!-- Top Part -->
                    <div class="flex justify-between items-start mb-5">
                         <div class="w-10 h-10 rounded-full ${iColorBg} ${iColorText} flex items-center justify-center text-lg">
                             <i class="fa-solid ${icon}"></i>
                         </div>
                         <c:choose>
                             <c:when test="${goal.status == 'COMPLETED'}">
                                 <div class="px-3 py-1 bg-[#F0FDF4] text-[#16A34A] border border-[#DCFCE7] rounded-full text-[11px] font-bold tracking-wide">
                                     Hoàn thành
                                 </div>
                             </c:when>
                             <c:when test="${goal.status == 'PENDING'}">
                                 <div class="px-3 py-1 bg-gray-100 text-gray-500 border border-gray-200 rounded-full text-[11px] font-bold tracking-wide">
                                     Chờ duyệt
                                 </div>
                             </c:when>
                             <c:otherwise>
                                 <div class="px-3 py-1 bg-[#EFF6FF] text-[#2563EB] border border-[#DBEAFE] rounded-full text-[11px] font-bold tracking-wide">
                                     Đang thực hiện
                                 </div>
                             </c:otherwise>
                         </c:choose>
                    </div>
                    
                    <!-- Content Info -->
                    <div class="mb-6 flex-1">
                         <h3 class="text-lg font-bold text-gray-800 leading-tight mb-2 truncate" title="${goal.title}">${goal.title}</h3>
                         <p class="text-[12px] text-gray-400 leading-relaxed font-medium line-clamp-2" title="${goal.description}">${goal.description != null ? goal.description : 'Không có mô tả'}</p>
                    </div>

                    <!-- Progress Bar -->
                    <div class="mb-6 mt-auto">
                         <div class="flex justify-between items-end mb-2">
                             <span class="text-[11px] font-bold text-gray-500">Tiến độ</span>
                             <span class="text-[12px] font-bold ${iColorText}">
                                 <c:out value="${Math.round((goal.currentProgress * 1.0 / goal.targetProgress) * 100)}" />%
                             </span>
                         </div>
                         <div class="w-full h-2 rounded-full bg-gray-100 overflow-hidden mb-2">
                             <div class="h-2 rounded-full ${barColor}" style="width: ${(goal.currentProgress * 1.0 / goal.targetProgress) * 100}%;"></div>
                         </div>
                         <div class="flex justify-between items-center text-[10px] font-medium text-gray-400">
                             <span>${goal.currentProgress} ngày</span>
                             <span>${goal.targetProgress} ngày</span>
                         </div>
                    </div>

                    <!-- Actions -->
                    <div class="flex items-center gap-2">
                         <c:choose>
                             <c:when test="${goal.status == 'COMPLETED'}">
                                 <button disabled class="flex-1 px-4 py-2.5 rounded-lg bg-[#F0FDF4] text-[#16A34A] font-bold text-[13px] flex items-center justify-center gap-2 border border-transparent cursor-not-allowed">
                                     <i class="fa-solid fa-trophy"></i> Hoàn thành!
                                 </button>
                             </c:when>
                             <c:when test="${goal.status == 'PENDING'}">
                                 <button disabled class="flex-1 px-4 py-2.5 rounded-lg bg-gray-100 text-gray-400 font-bold text-[13px] flex items-center justify-center gap-2 border border-transparent cursor-not-allowed">
                                     <i class="fa-solid fa-hourglass-half"></i> Chờ duyệt
                                 </button>
                             </c:when>
                             <c:otherwise>
                                 <form action="${pageContext.request.contextPath}/goals" method="POST" class="flex-1 pointer-events-auto">
                                     <input type="hidden" name="action" value="check_in" />
                                     <input type="hidden" name="goal_id" value="${goal.id}" />
                                     <input type="hidden" name="title" value="${goal.title}" />
                                     <button type="submit" class="w-full px-4 py-2.5 rounded-lg ${btnColor} font-bold text-[13px] flex items-center justify-center gap-2 shadow-sm transition-colors">
                                         <i class="fa-solid fa-check"></i> Check-in
                                     </button>
                                 </form>
                             </c:otherwise>
                         </c:choose>
                         <button class="w-10 h-10 rounded-lg border border-gray-200 text-gray-400 hover:text-gray-600 hover:bg-gray-50 flex items-center justify-center transition-colors shrink-0 outline-none">
                             <i class="fa-solid fa-chart-simple"></i>
                         </button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />

<!-- Add Goal Modal (Thêm Mục Tiêu) -->
<dialog id="addGoalModal" class="p-0 rounded-2xl shadow-xl backdrop:bg-black/40 overflow-hidden w-full max-w-[500px] mx-auto m-auto border-0">
    <div class="bg-white flex flex-col h-full rounded-2xl">
        <div class="px-6 py-5 flex justify-between items-center bg-white">
            <h3 class="text-[17px] font-bold text-[#1F2937]">Thêm Mục Tiêu Mới</h3>
            <button onclick="document.getElementById('addGoalModal').close()" class="text-gray-400 hover:text-gray-600 transition-colors w-8 h-8 rounded-full flex items-center justify-center hover:bg-gray-100">
                <i class="fa-solid fa-xmark text-lg"></i>
            </button>
        </div>
        
        <form action="${pageContext.request.contextPath}/goals" method="POST" class="px-6 pb-6 pt-2">
            <input type="hidden" name="action" value="add" />
            
            <div class="mb-5">
                <label class="block text-[13px] font-bold text-[#4B5563] mb-2">Tên Mục Tiêu</label>
                <input type="text" name="title" required placeholder="VD: Tiết kiệm điện mỗi ngày" class="w-full px-4 py-2.5 rounded-lg border border-gray-200 focus:border-[#10B981] outline-none text-sm transition-colors text-gray-800" />
            </div>

            <div class="mb-5">
                <label class="block text-[13px] font-bold text-[#4B5563] mb-2">Danh Mục</label>
                <!-- Grid picker uses radio inputs hidden -->
                <div class="grid grid-cols-3 gap-3">
                    <label class="cursor-pointer">
                        <input type="radio" name="category" value="Tiết Kiệm Điện" class="peer hidden" checked>
                        <div class="flex flex-col items-center justify-center border border-gray-200 rounded-xl p-3 peer-checked:border-[#10B981] peer-checked:bg-[#F0FDF4] hover:bg-gray-50 transition-all h-[90px]">
                            <i class="fa-solid fa-bolt text-[#F59E0B] text-xl mb-2"></i>
                            <span class="text-[11px] font-bold text-gray-600 peer-checked:text-[#10B981] text-center leading-tight">Tiết Kiệm Điện</span>
                        </div>
                    </label>
                    <label class="cursor-pointer">
                        <input type="radio" name="category" value="Tiết Kiệm Nước" class="peer hidden">
                        <div class="flex flex-col items-center justify-center border border-gray-200 rounded-xl p-3 peer-checked:border-[#10B981] peer-checked:bg-[#F0FDF4] hover:bg-gray-50 transition-all h-[90px]">
                            <i class="fa-solid fa-droplet text-gray-400 text-xl mb-2"></i>
                            <span class="text-[11px] font-bold text-gray-600 peer-checked:text-[#10B981] text-center leading-tight">Tiết Kiệm Nước</span>
                        </div>
                    </label>
                    <label class="cursor-pointer">
                        <input type="radio" name="category" value="Giảm Rác Nhựa" class="peer hidden">
                        <div class="flex flex-col items-center justify-center border border-gray-200 rounded-xl p-3 peer-checked:border-[#10B981] peer-checked:bg-[#F0FDF4] hover:bg-gray-50 transition-all h-[90px]">
                            <i class="fa-solid fa-recycle text-gray-400 text-xl mb-2"></i>
                            <span class="text-[11px] font-bold text-gray-600 peer-checked:text-[#10B981] text-center leading-tight">Giảm Rác Nhựa</span>
                        </div>
                    </label>
                    <label class="cursor-pointer">
                        <input type="radio" name="category" value="Giao Thông Xanh" class="peer hidden">
                        <div class="flex flex-col items-center justify-center border border-gray-200 rounded-xl p-3 peer-checked:border-[#10B981] peer-checked:bg-[#F0FDF4] hover:bg-gray-50 transition-all h-[90px]">
                            <i class="fa-solid fa-bicycle text-gray-400 text-xl mb-2"></i>
                            <span class="text-[11px] font-bold text-gray-600 peer-checked:text-[#10B981] text-center leading-tight">Giao Thông Xanh</span>
                        </div>
                    </label>
                    <label class="cursor-pointer">
                        <input type="radio" name="category" value="Ăn Uống Xanh" class="peer hidden">
                        <div class="flex flex-col items-center justify-center border border-gray-200 rounded-xl p-3 peer-checked:border-[#10B981] peer-checked:bg-[#F0FDF4] hover:bg-gray-50 transition-all h-[90px]">
                            <i class="fa-solid fa-seedling text-gray-400 text-xl mb-2"></i>
                            <span class="text-[11px] font-bold text-gray-600 peer-checked:text-[#10B981] text-center leading-tight">Ăn Uống Xanh</span>
                        </div>
                    </label>
                    <label class="cursor-pointer">
                        <input type="radio" name="category" value="Phân Loại Rác" class="peer hidden">
                        <div class="flex flex-col items-center justify-center border border-gray-200 rounded-xl p-3 peer-checked:border-[#10B981] peer-checked:bg-[#F0FDF4] hover:bg-gray-50 transition-all h-[90px]">
                            <i class="fa-solid fa-trash-can text-gray-400 text-xl mb-2"></i>
                            <span class="text-[11px] font-bold text-gray-600 peer-checked:text-[#10B981] text-center leading-tight">Phân Loại Rác</span>
                        </div>
                    </label>
                </div>
                <script>
                    // Add simple script to highlight icons when selected
                    const categoryRadios = document.querySelectorAll('input[name="category"]');
                    categoryRadios.forEach(radio => {
                        radio.addEventListener('change', function() {
                            // reset all icons to gray
                            document.querySelectorAll('input[name="category"] ~ div i').forEach(i => i.className = i.className.replace(/text-[a-z0-9\[\]\#\-]+/, 'text-gray-400'));
                            
                            // set color based on value
                            const icon = this.nextElementSibling.querySelector('i');
                            if(this.value === 'Tiết Kiệm Điện') icon.className = icon.className.replace('text-gray-400', 'text-[#F59E0B]');
                            else if(this.value === 'Tiết Kiệm Nước') icon.className = icon.className.replace('text-gray-400', 'text-[#3B82F6]');
                            else if(this.value === 'Giảm Rác Nhựa') icon.className = icon.className.replace('text-gray-400', 'text-[#10B981]');
                            else if(this.value === 'Giao Thông Xanh') icon.className = icon.className.replace('text-gray-400', 'text-[#8B5CF6]');
                            else if(this.value === 'Ăn Uống Xanh') icon.className = icon.className.replace('text-gray-400', 'text-[#22C55E]');
                            else if(this.value === 'Phân Loại Rác') icon.className = icon.className.replace('text-gray-400', 'text-[#EA580C]');
                        });
                    });
                </script>
            </div>
            
            <div class="mb-5">
                <label class="block text-[13px] font-bold text-[#4B5563] mb-2">Mô Tả</label>
                <textarea name="description" rows="3" placeholder="Mô tả chi tiết mục tiêu của bạn..." class="w-full px-4 py-2.5 rounded-lg border border-gray-200 focus:border-[#10B981] outline-none text-sm transition-colors text-gray-800 resize-none"></textarea>
            </div>
            
            <div class="grid grid-cols-2 gap-4 mb-6">
                <div>
                    <label class="block text-[13px] font-bold text-[#4B5563] mb-2">Mục Tiêu (ngày)</label>
                    <input type="number" name="target_progress" required min="1" max="365" value="30" class="w-full px-4 py-2.5 rounded-lg border border-gray-200 focus:border-[#10B981] outline-none text-sm transition-colors text-gray-800" />
                </div>
                <div>
                    <label class="block text-[13px] font-bold text-[#4B5563] mb-2">Ngày Kết Thúc</label>
                    <input type="date" name="end_date" class="w-full px-4 py-2.5 rounded-lg border border-gray-200 focus:border-[#10B981] outline-none text-sm transition-colors text-gray-800 appearance-none bg-white" style="color-scheme: light;" />
                </div>
            </div>
            
            <div class="flex justify-end gap-3 pt-2">
                <button type="button" onclick="document.getElementById('addGoalModal').close()" class="px-5 py-2.5 bg-white border border-gray-200 text-gray-600 font-bold rounded-lg hover:bg-gray-50 transition-colors text-sm w-full md:w-auto">
                    Hủy
                </button>
                <button type="submit" class="px-6 py-2.5 bg-[#86EFAC] text-[#166534] font-bold rounded-lg hover:bg-[#4ADE80] transition-colors text-sm w-full md:w-auto">
                    Tạo Mục Tiêu
                </button>
            </div>
        </form>
    </div>
</dialog>

<script>
    function filterGoals(status, btn) {
        // Cập nhật lại các nút để reset về style mặc định (xám)
        const tabs = document.getElementById('goalTabs').querySelectorAll('button');
        tabs.forEach(t => {
            t.className = 'px-5 py-2 rounded-full border border-gray-200 bg-white text-gray-600 hover:border-gray-300 text-[13px] font-bold shadow-sm whitespace-nowrap flex items-center gap-2 transition-all';
            t.querySelector('span').className = 'bg-gray-100 text-gray-500 px-2 py-0.5 rounded-full text-[10px]';
        });

        // Set style nổi bật (xanh) cho nút được chọn
        btn.className = 'px-5 py-2 rounded-full border border-transparent bg-[#10B981] text-white text-[13px] font-bold shadow-sm whitespace-nowrap flex items-center gap-2 transition-all';
        btn.querySelector('span').className = 'bg-white/20 px-2 py-0.5 rounded-full text-[10px]';

        // Xử lý ẩn hiện thẻ mục tiêu
        const cards = document.querySelectorAll('.goal-card');
        cards.forEach(card => {
            if (status === 'ALL' || card.getAttribute('data-status') === status) {
                card.style.display = 'flex';
            } else {
                card.style.display = 'none';
            }
        });
    }
</script>

</body>
</html>
