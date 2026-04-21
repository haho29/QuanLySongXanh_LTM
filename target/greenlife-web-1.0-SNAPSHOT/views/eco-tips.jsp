<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gợi Ý Eco Tips - GreenLife</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; background-color: #F8F9FA; color: #333; }
        .font-serif { font-family: 'Playfair Display', serif; }
        .tips-hero {
            background-image: url('https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=2000&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body class="antialiased min-h-screen flex flex-col pt-[72px]">

<jsp:include page="includes/navbar.jsp" />

<!-- Hero Banner -->
<div class="relative w-full h-[320px] tips-hero overflow-hidden flex items-center justify-center text-center">
    <!-- Gradient overlay mix green -->
    <div class="absolute inset-0 bg-gradient-to-t from-[#1B4332]/90 to-[#10B981]/60 mix-blend-multiply"></div>
    <div class="absolute inset-0 bg-black/20"></div>
    
    <div class="relative z-10 px-4 mt-8">
        <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/20 border border-white/20 text-white text-[10px] font-bold tracking-widest uppercase mb-4 shadow-sm">
            <i class="fa-solid fa-lightbulb text-yellow-300 text-xs"></i> Gợi ý hành động xanh
        </div>
        <h1 class="text-4xl sm:text-5xl font-serif font-bold text-white mb-4">Eco Tips Hôm Nay</h1>
        <p class="text-[13px] md:text-sm text-white/80 font-medium max-w-xl mx-auto">
            Khám phá các hành động sống xanh đơn giản, dễ thực hiện và phù hợp với lối sống sinh viên bận rộn. Bắt đầu từ những việc nhỏ!
        </p>
    </div>
</div>

<div class="flex-1 bg-[#F9FAFB] relative pb-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <!-- Top Floating Stats -->
        <div class="bg-white rounded-2xl shadow-[0_2px_15px_-3px_rgba(0,0,0,0.05)] border border-gray-100 p-6 flex justify-around items-center -mt-10 relative z-20 mb-10 w-full max-w-4xl mx-auto">
             <div class="text-center px-4 border-r border-gray-100 w-full">
                  <i class="fa-regular fa-lightbulb text-[#10B981] text-lg mb-2 block"></i>
                  <p class="text-2xl font-bold text-gray-800 mb-0.5">9+</p>
                  <p class="text-[10px] text-gray-400 font-bold uppercase tracking-widest">Eco Tips</p>
             </div>
             <div class="text-center px-4 border-r border-gray-100 w-full">
                  <i class="fa-solid fa-layer-group text-[#10B981] text-lg mb-2 block"></i>
                  <p class="text-2xl font-bold text-gray-800 mb-0.5">6</p>
                  <p class="text-[10px] text-gray-400 font-bold uppercase tracking-widest">Danh Mục</p>
             </div>
             <div class="text-center px-4 w-full">
                  <i class="fa-regular fa-bookmark text-red-500 text-lg mb-2 block"></i>
                  <p class="text-2xl font-bold text-gray-800 mb-0.5">0</p>
                  <p class="text-[10px] text-gray-400 font-bold uppercase tracking-widest">Đã Lưu</p>
             </div>
        </div>

        <!-- Filter Chips -->
        <div class="flex flex-wrap items-center justify-center gap-2 mb-10">
            <button class="px-5 py-2 bg-[#10B981] text-white border border-[#10B981] rounded-full text-xs font-bold shadow-sm">Tất Cả</button>
            <button class="px-5 py-2 bg-white text-gray-600 border border-gray-200 hover:border-gray-300 rounded-full text-xs font-medium transition-colors">Tiết Kiệm Điện</button>
            <button class="px-5 py-2 bg-white text-gray-600 border border-gray-200 hover:border-gray-300 rounded-full text-xs font-medium transition-colors">Tiết Kiệm Nước</button>
            <button class="px-5 py-2 bg-white text-gray-600 border border-gray-200 hover:border-gray-300 rounded-full text-xs font-medium transition-colors">Giảm Rác Nhựa</button>
            <button class="px-5 py-2 bg-white text-gray-600 border border-gray-200 hover:border-gray-300 rounded-full text-xs font-medium transition-colors">Giao Thông Xanh</button>
            <button class="px-5 py-2 bg-white text-gray-600 border border-gray-200 hover:border-gray-300 rounded-full text-xs font-medium transition-colors">Ăn Uống Xanh</button>
            <button class="px-5 py-2 bg-white text-gray-600 border border-gray-200 hover:border-gray-300 rounded-full text-xs font-medium transition-colors">Phân Loại Rác</button>
        </div>

        <!-- Cards Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-16">
            <c:forEach var="tip" items="${tips}" varStatus="loop">
                <!-- Color Logic Template -->
                <c:set var="themeVal" value="${loop.index % 6}" />
                <c:set var="iColorBg" value="bg-green-50" /><c:set var="iColorText" value="text-[#10B981]" /><c:set var="icon" value="fa-recycle" /><c:set var="btnColor" value="bg-[#10B981] hover:bg-[#059669]" /><c:set var="difficulty" value="Dễ" />
                
                <c:if test="${tip.category == 'Tiết kiệm điện' || tip.category == 'Năng lượng'}"><c:set var="iColorBg" value="bg-orange-50" /> <c:set var="iColorText" value="text-[#F97316]" /> <c:set var="icon" value="fa-bolt" /> <c:set var="btnColor" value="bg-[#F97316] hover:bg-orange-600" /> <c:set var="difficulty" value="Trung bình" /></c:if>
                <c:if test="${tip.category == 'Tiết kiệm nước'}"><c:set var="iColorBg" value="bg-blue-50" /> <c:set var="iColorText" value="text-[#3B82F6]" /> <c:set var="icon" value="fa-droplet" /> <c:set var="btnColor" value="bg-[#3B82F6] hover:bg-blue-600" /> <c:set var="difficulty" value="Dễ" /></c:if>
                <c:if test="${tip.category == 'Giao thông xanh' || tip.category == 'Di chuyển'}"><c:set var="iColorBg" value="bg-purple-50" /> <c:set var="iColorText" value="text-[#8B5CF6]" /> <c:set var="icon" value="fa-bicycle" /> <c:set var="btnColor" value="bg-[#8B5CF6] hover:bg-purple-600" /> <c:set var="difficulty" value="Khó" /></c:if>
                <c:if test="${tip.category == 'Ăn uống xanh' || tip.category == 'Ăn uống'}"><c:set var="iColorBg" value="bg-[#F0FDF4]" /> <c:set var="iColorText" value="text-[#22C55E]" /> <c:set var="icon" value="fa-carrot" /> <c:set var="btnColor" value="bg-[#22C55E] hover:bg-green-600" /></c:if>
                <c:if test="${tip.category == 'Phân loại rác'}"><c:set var="iColorBg" value="bg-orange-50" /> <c:set var="iColorText" value="text-[#EA580C]" /> <c:set var="icon" value="fa-trash-can" /> <c:set var="btnColor" value="bg-[#EA580C] hover:bg-orange-700" /></c:if>
            
                <!-- Tip Card -->
                <div class="bg-white rounded-3xl p-6 shadow-sm border border-gray-100 flex flex-col hover:shadow-md transition-shadow">
                     <div class="flex justify-between items-start mb-4">
                          <div class="w-10 h-10 rounded-xl ${iColorBg} flex items-center justify-center ${iColorText}"><i class="fa-solid ${icon} text-lg"></i></div>
                          <button class="text-gray-300 hover:text-red-500 transition-colors"><i class="fa-regular fa-heart"></i></button>
                     </div>
                     <h3 class="text-base font-bold text-gray-800 mb-2">${tip.title}</h3>
                     <p class="text-xs text-gray-500 leading-relaxed mb-1 line-clamp-2">${tip.content}</p>
                     <a href="#" class="text-[11px] font-bold text-[#10B981] hover:underline mb-4 inline-block">Xem thêm</a>
                     
                     <div class="bg-gray-50 rounded-lg p-3 flex justify-between items-center mb-4 mt-auto">
                          <div class="flex items-center gap-2 ${iColorText} text-[11px] font-bold"><i class="fa-solid fa-leaf"></i> +${tip.points} Điểm Xanh</div>
                          <span class="px-2 py-0.5 bg-white border border-gray-200 text-gray-500 font-bold text-[9px] uppercase tracking-wider rounded">${difficulty}</span>
                     </div>
                     
                     <div class="flex gap-1.5 flex-wrap mb-5">
                          <span class="text-[10px] text-gray-400 bg-gray-50 border border-gray-100 px-2 py-1 rounded">#${tip.category}</span>
                          <span class="text-[10px] text-gray-400 bg-gray-50 border border-gray-100 px-2 py-1 rounded">#sống_xanh</span>
                     </div>
                     
                     <form action="${pageContext.request.contextPath}/goals" method="POST" class="w-full">
                         <input type="hidden" name="action" value="add" />
                         <input type="hidden" name="title" value="${tip.title}" />
                         <input type="hidden" name="target_progress" value="30" />
                         <button type="submit" class="w-full py-3 rounded-xl ${btnColor} text-white font-bold text-[13px] shadow-sm hover:opacity-90 transition flex items-center justify-center gap-2">
                             <i class="fa-solid fa-plus"></i> Thêm Vào Mục Tiêu
                         </button>
                     </form>
                </div>
            </c:forEach>
        </div>

        <!-- Callout Banner Challenge -->
        <div class="bg-[#1B4332] rounded-[32px] overflow-hidden flex flex-col md:flex-row relative items-center shadow-xl shadow-[#1B4332]/20 border border-[#1B4332]">
            <div class="p-10 md:p-14 md:w-[60%] lg:w-1/2 z-10 text-white flex flex-col justify-center h-full">
                <p class="text-[10px] font-bold uppercase tracking-[0.2em] mb-4 text-[#A7F3D0] w-max border-b-2 border-[#10B981] pb-1">TIP NỔI BẬT TUẦN NÀY</p>
                <h3 class="text-3xl md:text-4xl font-serif font-bold text-white mb-4 leading-tight">Thách Thức 30 Ngày Không Rác Nhựa</h3>
                <p class="text-white/80 text-sm leading-relaxed mb-8 max-w-sm">
                    Tham gia thử thách 30 ngày giảm thiểu rác thải nhựa cùng cộng đồng sinh viên GreenLife. Mỗi ngày một hành động nhỏ, cùng nhau tạo nên sự thay đổi lớn cho môi trường.
                </p>
                <div class="flex flex-wrap gap-2 mb-8">
                     <span class="px-3 py-1 bg-white/10 rounded-full text-[10px] font-bold border border-white/20">Mang túi vải</span>
                     <span class="px-3 py-1 bg-white/10 rounded-full text-[10px] font-bold border border-white/20">Dùng bình nước</span>
                     <span class="px-3 py-1 bg-white/10 rounded-full text-[10px] font-bold border border-white/20">Từ chối ống hút</span>
                     <span class="px-3 py-1 bg-white/10 rounded-full text-[10px] font-bold border border-white/20">Mua đồ bulk</span>
                </div>
                <button class="bg-[#10B981] text-white px-8 py-3 rounded-full font-bold text-[13px] flex items-center gap-2 w-max hover:bg-[#059669] transition-all shadow-md">
                    Tham Gia Thử Thách <i class="fa-solid fa-arrow-right"></i>
                </button>
            </div>
            
            <div class="w-full md:w-[40%] lg:w-1/2 h-64 md:h-full absolute right-0 bottom-0 md:top-0 bg-cover bg-center" style="background-image: url('https://images.unsplash.com/photo-1611284446314-60a58ac526e0?q=80&w=2670&auto=format&fit=crop');">
                 <div class="absolute inset-0 bg-gradient-to-r from-[#1B4332] to-transparent"></div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>
