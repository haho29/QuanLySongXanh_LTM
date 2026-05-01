<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GreenLife - Sống Xanh Mỗi Ngày</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,400;0,500;0,600;0,700;0,800;1,400;1,500;1,600;1,700;1,800&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;1,400;1,500;1,600;1,700;1,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; background-color: #ffffff; color: #333; }
        .font-serif { font-family: 'Playfair Display', serif; }
        .hero-pattern {
            background-image: url('https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
        }
        .hero-overlay {
            background: linear-gradient(180deg, rgba(16,25,20,0.8) 0%, rgba(16,25,20,0.4) 50%, rgba(16,25,20,0.9) 100%);
        }
    </style>
</head>
<body class="antialiased">

<jsp:include page="includes/navbar.jsp" />

<!-- Hero Section -->
<div class="relative min-h-[90vh] flex items-center justify-center hero-pattern text-white overflow-hidden pt-12">
    <div class="absolute inset-0 hero-overlay z-0"></div>
    
    <!-- Floating Stats (Left) -->
    <div class="hidden lg:flex flex-col gap-3 absolute left-10 top-1/2 -translate-y-1/2 z-10 w-48">
        <div class="bg-black/30 backdrop-blur-md rounded-xl p-4 border border-white/10 flex items-center gap-4">
             <div class="w-10 h-10 rounded-full bg-[#10B981]/20 text-[#10B981] flex items-center justify-center"><i class="fa-regular fa-user"></i></div>
             <div><h4 class="font-bold text-white leading-tight">${sysTotalUsers}</h4><p class="text-[10px] text-white/60">Người Dùng</p></div>
        </div>
        <div class="bg-black/30 backdrop-blur-md rounded-xl p-4 border border-white/10 flex items-center gap-4">
             <div class="w-10 h-10 rounded-full bg-[#10B981]/20 text-[#10B981] flex items-center justify-center"><i class="fa-solid fa-bullseye"></i></div>
             <div><h4 class="font-bold text-white leading-tight">${sysTotalGoals}</h4><p class="text-[10px] text-white/60">Mục Tiêu</p></div>
        </div>
    </div>

    <div class="relative z-10 text-center max-w-4xl px-4 sm:px-6 mt-10">
        <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-white/10 border border-white/20 text-xs font-medium tracking-wide mb-8">
            <i class="fa-solid fa-seedling text-[#10B981]"></i> Hệ thống quản lý lối sống xanh dành cho sinh viên
        </div>
        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <h1 class="text-4xl md:text-6xl font-serif font-bold text-white mb-6 leading-[1.1]">
                    Chào mừng trở lại,<br/>
                    <span class="text-[#10B981] italic">${sessionScope.currentUser.fullName}</span>
                </h1>
                <p class="text-lg text-white/80 font-medium mb-10 max-w-2xl mx-auto">
                    Bạn đang có <span class="text-white font-bold">${userActiveGoals}</span> mục tiêu đang thực hiện và đã tích lũy được <span class="text-[#10B981] font-bold">${userPoints}</span> điểm xanh. 
                    <c:if test="${userStreak > 0}">Chuỗi duy trì: <span class="text-orange-400 font-bold">${userStreak} ngày</span> 🔥</c:if>
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/goals" class="px-8 py-3.5 bg-[#10B981] text-white rounded-full font-bold text-sm shadow-[0_0_20px_rgba(16,185,129,0.4)] hover:bg-[#059669] hover:-translate-y-1 transition-all">
                        Xem Mục Tiêu <i class="fa-solid fa-list-check ml-2 text-xs"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/progress" class="px-8 py-3.5 bg-white/10 border border-white/20 text-white rounded-full font-bold text-sm hover:bg-white/20 transition-all">
                        Xem Tiến Độ
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <h1 class="text-5xl md:text-7xl lg:text-[80px] font-serif font-bold text-white mb-6 leading-[1.1]">
                    Sống Xanh<br/>
                    <span class="text-[#10B981] italic">Mỗi Ngày</span><br/>
                    Cho Tương Lai
                </h1>
                <p class="text-lg md:text-xl text-white/80 font-medium mb-12 max-w-2xl mx-auto leading-relaxed">
                    Đặt mục tiêu, theo dõi tiến độ và cùng cộng đồng xây dựng lối sống bền vững — từng hành động nhỏ tạo nên sự thay đổi lớn cho hành tinh.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/login" class="px-8 py-3.5 bg-[#10B981] text-white rounded-full font-bold text-sm shadow-[0_0_20px_rgba(16,185,129,0.4)] hover:bg-[#059669] hover:-translate-y-1 transition-all">
                        Bắt Đầu Ngay <i class="fa-solid fa-arrow-right ml-2 text-xs"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/goals" class="px-8 py-3.5 bg-white/10 border border-white/20 text-white rounded-full font-bold text-sm hover:bg-white/20 transition-all">
                        Khám Phá Mục Tiêu
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Features Section -->
<div class="py-24 bg-white relative">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center mb-16 px-4">
            <p class="text-[#10B981] font-bold text-[10px] tracking-[0.2em] uppercase mb-3 text-center w-max mx-auto border border-[#10B981]/20 bg-[#10B981]/5 px-4 py-1 rounded-full">TÍNH NĂNG NỔI BẬT</p>
            <h2 class="text-3xl md:text-4xl font-serif font-bold text-gray-900 mb-4">Mọi Thứ Bạn Cần Để<br>Sống Xanh Hơn</h2>
            <p class="text-gray-500 font-medium max-w-lg mx-auto">Công cụ toàn diện giúp sinh viên xây dựng thói quen thân thiện môi trường.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Box 1 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-white hover:shadow-[0_8px_30px_rgba(16,185,129,0.06)] hover:-translate-y-1 transition-all">
                 <div class="w-12 h-12 rounded-xl bg-green-50 text-[#10B981] flex items-center justify-center text-xl mb-6"><i class="fa-solid fa-list-check"></i></div>
                 <h3 class="text-[17px] font-bold text-gray-800 mb-3 block">Lựa Chọn Mục Tiêu Xanh</h3>
                 <p class="text-sm text-gray-500 leading-relaxed">Thư viện đa dạng với mức độ từ Dễ đến Khó: Tiết kiệm điện, Nước, Giảm nhựa, Di chuyển Xanh và nhiều hơn nữa.</p>
            </div>
            <!-- Box 2 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-white hover:shadow-[0_8px_30px_rgba(16,185,129,0.06)] hover:-translate-y-1 transition-all">
                 <div class="w-12 h-12 rounded-xl bg-orange-50 text-orange-500 flex items-center justify-center text-xl mb-6"><i class="fa-regular fa-calendar-check"></i></div>
                 <h3 class="text-[17px] font-bold text-gray-800 mb-3 block">Check-in Hằng Ngày</h3>
                 <p class="text-sm text-gray-500 leading-relaxed">Cập nhật tiến độ mỗi ngày, giữ vững chuỗi (streak) và thiết lập kỷ luật thép với bản thân để đạt mục tiêu.</p>
            </div>
            <!-- Box 3 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-white hover:shadow-[0_8px_30px_rgba(16,185,129,0.06)] hover:-translate-y-1 transition-all">
                 <div class="w-12 h-12 rounded-xl bg-blue-50 text-blue-500 flex items-center justify-center text-xl mb-6"><i class="fa-solid fa-chart-pie"></i></div>
                 <h3 class="text-[17px] font-bold text-gray-800 mb-3 block">Thống Kê & Tiến Độ</h3>
                 <p class="text-sm text-gray-500 leading-relaxed">Xem biểu đồ trực quan, phân tích Tác động Môi trường ảo của bạn: Lượng CO2, Nước và Rác thải đã giảm.</p>
            </div>
            <!-- Box 4 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-white hover:shadow-[0_8px_30px_rgba(16,185,129,0.06)] hover:-translate-y-1 transition-all">
                 <div class="w-12 h-12 rounded-xl bg-yellow-50 text-yellow-500 flex items-center justify-center text-xl mb-6"><i class="fa-solid fa-lightbulb"></i></div>
                 <h3 class="text-[17px] font-bold text-gray-800 mb-3 block">Gợi Ý Eco Tips</h3>
                 <p class="text-sm text-gray-500 leading-relaxed">Nhận bí kíp xanh mỗi ngày giúp tối ưu hóa lối sống của bạn, dễ đọc, dễ nhớ và cực kỳ hữu ích.</p>
            </div>
            <!-- Box 5 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-white hover:shadow-[0_8px_30px_rgba(16,185,129,0.06)] hover:-translate-y-1 transition-all">
                 <div class="w-12 h-12 rounded-xl bg-purple-50 text-purple-500 flex items-center justify-center text-xl mb-6"><i class="fa-solid fa-users"></i></div>
                 <h3 class="text-[17px] font-bold text-gray-800 mb-3 block">Lịch Sử Hoạt Động</h3>
                 <p class="text-sm text-gray-500 leading-relaxed">Nhìn lại nhật ký xanh của mình, chia sẻ khoảnh khắc với người khác để lan tỏa cảm hứng.</p>
            </div>
            <!-- Box 6 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-white hover:shadow-[0_8px_30px_rgba(16,185,129,0.06)] hover:-translate-y-1 transition-all">
                 <div class="w-12 h-12 rounded-xl bg-teal-50 text-teal-500 flex items-center justify-center text-xl mb-6"><i class="fa-solid fa-ranking-star"></i></div>
                 <h3 class="text-[17px] font-bold text-gray-800 mb-3 block">Bảng Xếp Hạng</h3>
                 <p class="text-sm text-gray-500 leading-relaxed">Cạnh tranh điểm xanh với bạn bè, leo rank Xanh và nhận thành tựu huy hiệu đầy tự hào.</p>
            </div>
        </div>
    </div>
</div>

<!-- Banner Stats -->
<div class="bg-[#1B4332] py-20 relative overflow-hidden">
    <div class="absolute right-0 top-0 opacity-10 pointer-events-none"><i class="fa-solid fa-leaf text-[400px]"></i></div>
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-center divide-x divide-white/10">
            <div class="px-4">
                 <div class="w-12 h-12 mx-auto rounded-full border border-white/20 bg-white/5 flex items-center justify-center text-white mb-4"><i class="fa-regular fa-user"></i></div>
                 <p class="text-3xl md:text-4xl font-black text-white mb-1">${sysTotalUsers}</p>
                 <p class="text-[11px] text-[#A7F3D0] uppercase tracking-wider font-bold">Người Dùng Tham Gia</p>
            </div>
            <div class="px-4">
                 <div class="w-12 h-12 mx-auto rounded-full border border-white/20 bg-white/5 flex items-center justify-center text-white mb-4"><i class="fa-regular fa-flag"></i></div>
                 <p class="text-3xl md:text-4xl font-black text-white mb-1">${sysTotalGoals}</p>
                 <p class="text-[11px] text-[#A7F3D0] uppercase tracking-wider font-bold">Mục Tiêu Được Tạo</p>
            </div>
            <div class="px-4">
                 <div class="w-12 h-12 mx-auto rounded-full border border-white/20 bg-white/5 flex items-center justify-center text-white mb-4"><i class="fa-solid fa-check-double"></i></div>
                 <p class="text-3xl md:text-4xl font-black text-white mb-1">${sysCompletionRate}%</p>
                 <p class="text-[11px] text-[#A7F3D0] uppercase tracking-wider font-bold">Tỉ Lệ Hoàn Thành</p>
            </div>
            <div class="px-4">
                 <div class="w-12 h-12 mx-auto rounded-full border border-white/20 bg-white/5 flex items-center justify-center text-white mb-4"><i class="fa-solid fa-leaf"></i></div>
                 <p class="text-3xl md:text-4xl font-black text-white mb-1">${sysEcoActions}</p>
                 <p class="text-[11px] text-[#A7F3D0] uppercase tracking-wider font-bold">Hành Động Xanh</p>
            </div>
        </div>
    </div>
</div>

<!-- Steps Section -->
<div class="py-24 bg-gray-50/50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center mb-16">
            <p class="text-[#10B981] font-bold text-[10px] tracking-[0.2em] uppercase mb-3 text-center w-max mx-auto border border-[#10B981]/20 bg-[#10B981]/5 px-4 py-1 rounded-full">HƯỚNG DẪN</p>
            <h2 class="text-3xl md:text-4xl font-serif font-bold text-gray-900">Bắt Đầu Chỉ Trong<br>4 Bước Đơn Giản</h2>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-4 gap-8 text-center relative">
            <!-- Connecting Line on Desktop -->
            <div class="hidden md:block absolute top-10 left-[10%] right-[10%] h-[1px] border-t-2 border-dashed border-[#10B981]/30"></div>
            
            <!-- Step 1 -->
            <div class="px-4 flex flex-col items-center relative z-10">
                <div class="w-20 h-20 rounded-[28px] bg-white border border-gray-100 shadow-[0_4px_20px_rgba(0,0,0,0.05)] flex items-center justify-center text-2xl text-[#10B981] mb-6 relative">
                    <i class="fa-regular fa-user"></i>
                    <div class="absolute -top-2 -right-2 w-6 h-6 rounded-full bg-[#10B981] text-white text-[10px] font-bold flex items-center justify-center border-2 border-white">1</div>
                </div>
                <h4 class="text-base font-bold text-gray-800 mb-2">Tạo Tài Khoản</h4>
                <p class="text-[13px] text-gray-500 leading-relaxed">Đăng ký nhanh chỉ trong 1 phút bằng Email Sinh viên hoặc tài khoản cá nhân. Bắt đầu ngay hôm nay.</p>
            </div>
            <!-- Step 2 -->
            <div class="px-4 flex flex-col items-center relative z-10">
                <div class="w-20 h-20 rounded-[28px] bg-[#10B981] shadow-[0_4px_20px_rgba(16,185,129,0.3)] flex items-center justify-center text-2xl text-white mb-6 relative transform rotate-3">
                    <i class="fa-regular fa-flag"></i>
                    <div class="absolute -top-2 -right-2 w-6 h-6 rounded-full bg-white text-[#10B981] text-[10px] font-bold flex items-center justify-center border-2 border-transparent">2</div>
                </div>
                <h4 class="text-base font-bold text-gray-800 mb-2">Đặt Mục Tiêu</h4>
                <p class="text-[13px] text-gray-500 leading-relaxed">Chọn các hành động xanh phù hợp với mục tiêu, khả năng tài chính và thời gian của bạn.</p>
            </div>
            <!-- Step 3 -->
            <div class="px-4 flex flex-col items-center relative z-10">
                <div class="w-20 h-20 rounded-[28px] bg-white border border-gray-100 shadow-[0_4px_20px_rgba(0,0,0,0.05)] flex items-center justify-center text-2xl text-[#10B981] mb-6 relative">
                    <i class="fa-regular fa-calendar-check"></i>
                    <div class="absolute -top-2 -right-2 w-6 h-6 rounded-full bg-[#10B981] text-white text-[10px] font-bold flex items-center justify-center border-2 border-white">3</div>
                </div>
                <h4 class="text-base font-bold text-gray-800 mb-2">Check-in Hàng Ngày</h4>
                <p class="text-[13px] text-gray-500 leading-relaxed">Xác nhận hoàn thành việc làm tốt giúp đỡ môi trường và nhận điểm xanh tích cực.</p>
            </div>
            <!-- Step 4 -->
            <div class="px-4 flex flex-col items-center relative z-10">
                <div class="w-20 h-20 rounded-[28px] bg-[#1B4332] shadow-[0_4px_20px_rgba(27,67,50,0.3)] flex items-center justify-center text-2xl text-white mb-6 relative -rotate-3">
                    <i class="fa-solid fa-chart-simple"></i>
                    <div class="absolute -top-2 -right-2 w-6 h-6 rounded-full bg-[#10B981] text-white text-[10px] font-bold flex items-center justify-center border-2 border-[#1B4332]">4</div>
                </div>
                <h4 class="text-base font-bold text-gray-800 mb-2">Xem Kết Quả</h4>
                <p class="text-[13px] text-gray-500 leading-relaxed">Theo dõi biểu đồ tiến độ đo lường độ giảm phát thải và tăng nhận thức từ cộng đồng.</p>
            </div>
        </div>
    </div>
</div>

<!-- Testimonials -->
<div class="py-24 bg-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16 px-4">
            <p class="text-[#10B981] font-bold text-[10px] tracking-[0.2em] uppercase mb-3 text-center w-max mx-auto border border-[#10B981]/20 bg-[#10B981]/5 px-4 py-1 rounded-full">GÓC YÊU THƯƠNG NGƯỜI DÙNG</p>
            <h2 class="text-3xl md:text-4xl font-serif font-bold text-gray-900 mb-4">Mọi Người Yêu Thích<br>GreenLife</h2>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Review 1 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-gray-50/50 hover:bg-white hover:shadow-[0_8px_30px_rgba(0,0,0,0.04)] transition-all">
                <div class="flex text-yellow-400 text-[10px] mb-4 gap-0.5">
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                </div>
                <p class="text-gray-700 text-sm leading-relaxed mb-8 italic">"GreenLife giúp mình hình thành thói quen rác thải ni lông suốt 100 ngày qua... Giao diện cực xinh, chức năng check-in tạo động lực thật sự."</p>
                <div class="flex items-center gap-3">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=LanN" class="w-10 h-10 rounded-full bg-gray-200">
                    <div>
                        <h5 class="text-[13px] font-bold text-gray-800">Trần Thị Lan</h5>
                        <p class="text-[11px] text-gray-500">Giáo viên cấp 3 • Hà Nội</p>
                    </div>
                </div>
            </div>
            <!-- Review 2 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-gray-50/50 hover:bg-white hover:shadow-[0_8px_30px_rgba(0,0,0,0.04)] transition-all">
                <div class="flex text-yellow-400 text-[10px] mb-4 gap-0.5">
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                </div>
                <p class="text-gray-700 text-sm leading-relaxed mb-8 italic">"Rất dễ dùng! Theo dõi mực nước mình đã tiết kiệm là một cách hay. Leaderboard giúp mình cạnh tranh xanh và nâng cấp ý thức."</p>
                <div class="flex items-center gap-3">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Hung" class="w-10 h-10 rounded-full bg-gray-200">
                    <div>
                        <h5 class="text-[13px] font-bold text-gray-800">Lê Văn Hùng</h5>
                        <p class="text-[11px] text-gray-500">Kỹ sư Máy tính • TP. HCM</p>
                    </div>
                </div>
            </div>
            <!-- Review 3 -->
            <div class="p-8 border border-gray-100 rounded-3xl bg-gray-50/50 hover:bg-white hover:shadow-[0_8px_30px_rgba(0,0,0,0.04)] transition-all">
                <div class="flex text-yellow-400 text-[10px] mb-4 gap-0.5">
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                </div>
                <p class="text-gray-700 text-sm leading-relaxed mb-8 italic">"Thích góc độ phân tích Carbon footprint, giúp nhìn nhận vấn đề môi trường vĩ mô bằng các action hàng ngày của cá nhân. Giao diện siêu mượt."</p>
                <div class="flex items-center gap-3">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Phuc" class="w-10 h-10 rounded-full bg-gray-200">
                    <div>
                        <h5 class="text-[13px] font-bold text-gray-800">Phạm Hoàng Tú</h5>
                        <p class="text-[11px] text-gray-500">Sinh viên Kiến trúc • Đà Lạt</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CTA Banner bottom -->
<div class="relative py-28 hero-pattern overflow-hidden">
    <!-- Green gradient overlay -->
    <div class="absolute inset-0 bg-gradient-to-br from-[#1B4332]/95 to-[#10B981]/80 z-0 mix-blend-multiply"></div>
    <div class="absolute inset-0 bg-[#1B4332]/60 z-0"></div> <!-- Extra darkener -->
    
    <div class="max-w-4xl mx-auto px-4 text-center relative z-10">
        <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-white/10 border border-white/20 text-[10px] uppercase font-bold tracking-widest text-[#A7F3D0] mb-8">
            <i class="fa-solid fa-rocket"></i> Tham gia cộng đồng
        </div>
        <h2 class="text-4xl md:text-5xl font-serif font-bold text-white mb-6">Bắt Đầu Hành Trình<br>Xanh Của Bạn Hôm Nay</h2>
        <p class="text-white/80 text-[15px] font-medium mb-10 max-w-xl mx-auto leading-relaxed">
            Đăng ký miễn phí, đặt mục tiêu đầu tiên và cùng hàng ngàn sinh viên chung sức kiến tạo một Hành tinh xanh.
        </p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <a href="${pageContext.request.contextPath}/login" class="px-8 py-3.5 bg-[#10B981] text-white rounded-full font-bold text-sm shadow-[0_0_20px_rgba(16,185,129,0.4)] hover:bg-white hover:text-[#1B4332] transition-colors">
                Đăng Ký Miễn Phí
            </a>
            <a href="${pageContext.request.contextPath}/home" class="px-8 py-3.5 bg-transparent border border-white/30 text-white rounded-full font-bold text-sm hover:bg-white/10 transition-colors">
                <i class="fa-solid fa-arrow-up text-xs mr-2 relative -top-px"></i> Về Đỉnh Trang
            </a>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>
