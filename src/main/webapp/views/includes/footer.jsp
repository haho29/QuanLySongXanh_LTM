<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <footer class="bg-[#1B4332] text-white pt-16 pb-8 border-t border-[#2D6A4F]">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-12 gap-12 mb-12">

                <!-- Column 1: Brand & Intro -->
                <div class="md:col-span-5">
                    <div class="flex items-center gap-2 mb-6">
                        <i class="fa-solid fa-leaf text-[#10B981] text-2xl"></i>
                        <span class="font-bold text-white text-xl tracking-tight">GreenLife</span>
                    </div>
                    <p class="text-white/70 text-[13px] leading-relaxed mb-8 pr-12">
                        Hệ thống quản lý lối sống xanh dành cho sinh viên — cùng nhau xây dựng tương lai bền vững cho
                        hành tinh.
                    </p>
                    <div class="flex gap-4">
                        <a href="#"
                            class="w-8 h-8 rounded-full border border-white/20 flex items-center justify-center text-white/80 hover:bg-[#10B981] hover:border-[#10B981] hover:text-white transition-all"><i
                                class="fa-brands fa-facebook-f text-xs"></i></a>
                        <a href="#"
                            class="w-8 h-8 rounded-full border border-white/20 flex items-center justify-center text-white/80 hover:bg-[#10B981] hover:border-[#10B981] hover:text-white transition-all"><i
                                class="fa-brands fa-instagram text-xs"></i></a>
                        <a href="#"
                            class="w-8 h-8 rounded-full border border-white/20 flex items-center justify-center text-white/80 hover:bg-[#10B981] hover:border-[#10B981] hover:text-white transition-all"><i
                                class="fa-brands fa-x-twitter text-xs"></i></a>
                        <a href="#"
                            class="w-8 h-8 rounded-full border border-white/20 flex items-center justify-center text-white/80 hover:bg-[#10B981] hover:border-[#10B981] hover:text-white transition-all"><i
                                class="fa-brands fa-youtube text-xs"></i></a>
                    </div>
                </div>

                <!-- Column 2: Quick Links -->
                <div class="md:col-span-3 lg:col-span-3">
                    <h3 class="text-[13px] font-bold text-white uppercase tracking-wider mb-6">ĐIỀU HƯỚNG</h3>
                    <ul class="space-y-4">
                        <li><a href="${pageContext.request.contextPath}/home"
                                class="text-white/70 hover:text-white text-[13px] transition font-medium">Trang Chủ</a>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/views/goals.jsp"
                                class="text-white/70 hover:text-white text-[13px] transition font-medium">Mục Tiêu
                                Xanh</a></li>
                        <li><a href="${pageContext.request.contextPath}/views/progress.jsp"
                                class="text-white/70 hover:text-white text-[13px] transition font-medium">Tiến Độ</a>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/views/eco-tips.jsp"
                                class="text-white/70 hover:text-white text-[13px] transition font-medium">Eco Tips</a>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/views/leaderboard.jsp"
                                class="text-white/70 hover:text-white text-[13px] transition font-medium">Xếp Hạng</a>
                        </li>
                        <li><a href="#" class="text-white/70 hover:text-white text-[13px] transition font-medium">Hồ
                                Sơ</a></li>
                    </ul>
                </div>

                <!-- Column 3: Contact Info -->
                <div class="md:col-span-4 lg:col-span-4">
                    <h3 class="text-[13px] font-bold text-white uppercase tracking-wider mb-6">LIÊN HỆ</h3>
                    <ul class="space-y-4">
                        <li class="flex items-start gap-3">
                            <i class="fa-solid fa-location-dot mt-1 text-[#10B981] text-xs"></i>
                            <span class="text-white/70 text-[13px]">48 Cao Thắng, Đà Nẵng</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <i class="fa-regular fa-envelope text-[#10B981] text-xs"></i>
                            <span class="text-white/70 text-[13px]">greenlife@gmail.com</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <i class="fa-solid fa-phone text-[#10B981] text-xs"></i>
                            <span class="text-white/70 text-[13px]">(028) 3864 7256</span>
                        </li>
                    </ul>
                </div>

            </div>

            <!-- Bottom Divider -->
            <div class="pt-8 border-t border-white/10 flex flex-col md:flex-row justify-between items-center gap-4">
                <p class="text-[11px] text-white/50 text-center md:text-left">
                    &copy; 2026 GreenLife. Tất cả quyền được bảo lưu.
                </p>
                <div class="flex gap-6">
                    <a href="#" class="text-[11px] text-white/50 hover:text-white transition">Chính Sách Bảo Mật</a>
                    <a href="#" class="text-[11px] text-white/50 hover:text-white transition">Điều Khoản Sử Dụng</a>
                </div>
            </div>
        </div>
    </footer>