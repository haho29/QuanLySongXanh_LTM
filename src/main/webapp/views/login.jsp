<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GreenLife - Đăng nhập</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#006c4a',
                        'primary-light': '#3fb687',
                        'primary-dark': '#00422c',
                        surface: '#f7f9fb',
                        'on-surface-variant': '#3c4a42',
                    },
                    fontFamily: {
                        sans: ['"Be Vietnam Pro"', 'sans-serif'],
                        serif: ['"Playfair Display"', 'serif'],
                    }
                }
            }
        }
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,400;0,700;0,900&family=Playfair+Display:ital,wght@0,400..900;1,400..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-white overflow-hidden font-sans min-h-screen">

<div class="min-h-screen flex">
    <!-- Left Side - Hero Branding -->
    <div class="hidden lg:flex lg:w-5/12 relative overflow-hidden">
        <img src="https://images.unsplash.com/photo-1542601906990-b4d3fb0a7f09?auto=format&fit=crop&q=80&w=2000" 
             alt="Students in Nature" 
             class="absolute inset-0 w-full h-full object-cover brightness-[0.7] transform scale-110"/>
        <div class="absolute inset-0 bg-[#064e3b]/40 backdrop-blur-[2px]"></div>
        
        <div class="relative z-10 p-16 flex flex-col justify-end h-full">
            <div class="flex items-center gap-3 mb-8">
                <div class="w-12 h-12 bg-white/20 backdrop-blur-md rounded-xl flex items-center justify-center border border-white/30">
                    <i class="fa-solid fa-leaf text-emerald-300 text-2xl"></i>
                </div>
                <span class="text-3xl font-black text-white italic tracking-tighter uppercase">GreenLife</span>
            </div>

            <h2 class="text-5xl font-black text-white mb-6 leading-[1.1] tracking-tight font-serif">
                Cùng Nhau Sống Xanh
            </h2>
            <p class="text-emerald-50/80 text-lg font-medium max-w-md leading-relaxed mb-12">
                Tham gia cộng đồng sống xanh — đặt mục tiêu, theo dõi tiến độ và tạo nên sự thay đổi tích cực cho hành tinh.
            </p>
        </div>
    </div>

    <!-- Right Side - Form -->
    <div class="w-full lg:w-7/12 flex flex-col items-center justify-center p-8 lg:p-24 overflow-x-hidden overflow-y-auto bg-gray-50/30 relative">
        <div class="w-full max-w-lg relative min-h-[500px]">
            
            <!-- ===================== LOGIN FORM ===================== -->
            <div id="loginFormContainer" class="space-y-10 transition-all duration-500 transform opacity-100 translate-x-0 absolute top-0 left-0 w-full">
                <div class="text-center md:text-left">
                    <h1 class="text-4xl font-black text-gray-900 mb-3 font-serif">Chào Mừng!</h1>
                    <p class="text-gray-400 font-bold text-sm">Đăng nhập để tiếp tục hành trình xanh của bạn.</p>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-xl text-[13px] font-bold shadow-sm mb-4" role="alert">
                        <p>${errorMessage}</p>
                    </div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="bg-emerald-100 border-l-4 border-emerald-500 text-emerald-700 p-4 rounded-xl text-[13px] font-bold shadow-sm mb-4" role="alert">
                        <p>${successMessage}</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-6">
                    <div class="space-y-2">
                        <label class="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Email / Tên đăng nhập</label>
                        <div class="relative group">
                            <div class="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300">
                                <i class="fa-solid fa-user"></i>
                            </div>
                            <input type="text" name="username" placeholder="Nhập tên đăng nhập hoặc email" required
                                   class="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-14 pr-6 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none shadow-sm" />
                        </div>
                    </div>

                    <div class="space-y-2">
                        <label class="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Mật Khẩu</label>
                        <div class="relative group">
                            <div class="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300">
                                <i class="fa-solid fa-lock"></i>
                            </div>
                            <input type="password" name="password" placeholder="••••••••" required
                                   class="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-14 pr-14 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none shadow-sm" />
                        </div>
                    </div>

                    <button type="submit" 
                            class="w-full py-4 bg-[#10a352] text-white rounded-2xl font-black text-sm uppercase tracking-widest shadow-xl shadow-emerald-500/30 hover:bg-[#0d8a45] transition-all transform active:scale-[0.98] flex items-center justify-center gap-3">
                        Đăng Nhập
                    </button>
                    
                    <div class="text-center mt-6">
                        <p class="text-sm font-medium text-gray-500">Chưa có tài khoản? <button type="button" onclick="toggleForms()" class="text-emerald-500 hover:text-emerald-600 font-bold ml-1 hover:underline transition-all">Đăng ký ngay</button></p>
                    </div>
                </form>
            </div>

            <!-- ===================== REGISTER FORM ===================== -->
            <div id="registerFormContainer" class="space-y-8 transition-all duration-500 transform opacity-0 translate-x-12 absolute top-0 left-0 w-full pointer-events-none">
                <div class="text-center md:text-left">
                    <h1 class="text-4xl font-black text-gray-900 mb-3 font-serif">Đăng Ký</h1>
                    <p class="text-gray-400 font-bold text-sm">Gia nhập cộng đồng sinh viên sống xanh.</p>
                </div>

                <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-4">
                    <!-- Row 1: Username & Email -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-1.5">
                            <label class="text-[10px] font-black uppercase text-gray-400 tracking-widest ml-1">Tên đăng nhập</label>
                            <input type="text" name="username" placeholder="VD: minhkhoa2k" required value="${param.username}"
                                   class="w-full bg-white border-2 border-gray-100 rounded-xl py-3 px-4 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all shadow-sm outline-none" />
                        </div>
                        <div class="space-y-1.5">
                            <label class="text-[10px] font-black uppercase text-gray-400 tracking-widest ml-1">Email</label>
                            <input type="email" name="email" placeholder="email@student.edu.vn" required value="${param.email}"
                                   class="w-full bg-white border-2 border-gray-100 rounded-xl py-3 px-4 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all shadow-sm outline-none" />
                        </div>
                    </div>

                    <!-- Row 2: Job & Location -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-1.5">
                            <label class="text-[10px] font-black uppercase text-gray-400 tracking-widest ml-1">Nghề nghiệp</label>
                            <input type="text" name="job" placeholder="VD: Sinh viên IT" required value="${param.job}"
                                   class="w-full bg-white border-2 border-gray-100 rounded-xl py-3 px-4 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all shadow-sm outline-none" />
                        </div>
                        <div class="space-y-1.5">
                            <label class="text-[10px] font-black uppercase text-gray-400 tracking-widest ml-1">Địa chỉ</label>
                            <input type="text" name="location" placeholder="VD: KTX Khu A, Thủ Đức" required value="${param.location}"
                                   class="w-full bg-white border-2 border-gray-100 rounded-xl py-3 px-4 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all shadow-sm outline-none" />
                        </div>
                    </div>

                    <!-- Row 3: Password -->
                    <div class="space-y-1.5">
                        <label class="text-[10px] font-black uppercase text-gray-400 tracking-widest ml-1">Mật khẩu</label>
                        <input type="password" name="password" placeholder="Ít nhất 6 ký tự" required minlength="6"
                               class="w-full bg-white border-2 border-gray-100 rounded-xl py-3 px-4 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all shadow-sm outline-none" />
                    </div>

                    <button type="submit" 
                            class="w-full py-4 mt-2 bg-[#1B4332] text-white rounded-xl font-black text-sm uppercase tracking-widest shadow-xl shadow-[#1B4332]/30 hover:bg-[#2D6A4F] transition-all transform active:scale-[0.98] flex items-center justify-center gap-2">
                        Tạo Tài Khoản
                    </button>
                    
                    <div class="text-center mt-6">
                        <p class="text-sm font-medium text-gray-500">Đã có tài khoản? <button type="button" onclick="toggleForms()" class="text-[#1B4332] hover:text-[#2D6A4F] font-bold ml-1 hover:underline transition-all">Đăng nhập</button></p>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<script>
    function toggleForms() {
        const loginForm = document.getElementById('loginFormContainer');
        const registerForm = document.getElementById('registerFormContainer');
        
        if (loginForm.classList.contains('opacity-100')) {
            // Hide Login
            loginForm.classList.remove('opacity-100', 'translate-x-0');
            loginForm.classList.add('opacity-0', '-translate-x-12', 'pointer-events-none');
            
            // Show Register
            registerForm.classList.remove('opacity-0', 'translate-x-12', 'pointer-events-none');
            registerForm.classList.add('opacity-100', 'translate-x-0');
        } else {
            // Hide Register
            registerForm.classList.remove('opacity-100', 'translate-x-0');
            registerForm.classList.add('opacity-0', 'translate-x-12', 'pointer-events-none');
            
            // Show Login
            loginForm.classList.remove('opacity-0', '-translate-x-12', 'pointer-events-none');
            loginForm.classList.add('opacity-100', 'translate-x-0');
        }
    // Auto toggling if redirected from registration error
    document.addEventListener('DOMContentLoaded', function() {
        <c:if test="${not empty errorMessage and not empty param.email}">
            toggleForms();
        </c:if>
    });
</script>

</body>
</html>
