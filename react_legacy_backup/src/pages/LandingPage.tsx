import { motion } from 'motion/react';
import { ArrowRight, CheckCircle2, Star, Users, Leaf, Target, BarChart3, HelpCircle } from 'lucide-react';
import { Link } from 'react-router-dom';

export default function LandingPage() {
  return (
    <div className="min-h-screen">
      {/* Hero Section */}
      <section className="relative min-h-screen flex items-center justify-center pt-20 overflow-hidden">
        <div className="absolute inset-0 z-0">
          <img 
            src="https://images.unsplash.com/photo-1542601906990-b4d3fb0a7f09?auto=format&fit=crop&q=80&w=2000" 
            alt="Nature Background" 
            className="w-full h-full object-cover opacity-20"
            referrerPolicy="no-referrer"
          />
          <div className="absolute inset-0 bg-gradient-to-b from-surface via-transparent to-surface"></div>
        </div>

        <div className="relative z-10 text-center px-6 max-w-4xl mx-auto">
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary/10 border border-primary/20 text-primary text-sm font-bold mb-8"
          >
            <Star size={16} className="fill-primary" />
            <span>Hệ thống quản lý lối sống xanh cho mọi người</span>
          </motion.div>
          
          <motion.h1 
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.2 }}
            className="text-6xl md:text-8xl font-black text-primary-dark tracking-tighter mb-8"
          >
            Sống Xanh <br />
            <span className="text-primary italic">Mỗi Ngày</span> <br />
            Cho Tương Lai
          </motion.h1>

          <motion.p 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.4 }}
            className="text-lg text-on-surface-variant mb-12 max-w-2xl mx-auto leading-relaxed"
          >
             Đặt mục tiêu, theo dõi tiến độ và cùng cộng đồng xây dựng lối sống bền vững — từng hành động nhỏ tạo nên sự thay đổi lớn cho hành tinh.
          </motion.p>

          <motion.div 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.6 }}
            className="flex flex-col sm:flex-row justify-center gap-4"
          >
            <Link to="/goals" className="px-10 py-5 eco-gradient text-white rounded-full font-bold text-lg shadow-xl shadow-primary/20 hover:scale-105 transition-all">
              Bắt Đầu Ngay
            </Link>
            <button className="px-10 py-5 bg-white border border-primary/20 text-primary-dark rounded-full font-bold text-lg hover:bg-primary/5 transition-all">
              Khám Phá Eco Tips
            </button>
          </motion.div>
        </div>

        <div className="absolute bottom-10 left-1/2 -translate-x-1/2 animate-bounce opacity-40">
           <div className="w-1 h-12 bg-primary rounded-full"></div>
        </div>
      </section>

      {/* Stats Section */}
      <section className="py-24 bg-primary-dark text-white">
        <div className="max-w-screen-2xl mx-auto px-6 lg:px-12">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-12 text-center">
            {[
              { label: 'Người dùng', val: '5,000+', icon: <Users /> },
              { label: 'Mục tiêu được tạo', val: '12,000+', icon: <Target /> },
              { label: 'Tỷ lệ hoàn thành', val: '87%', icon: <CheckCircle2 /> },
              { label: 'Hành động xanh', val: '50+', icon: <Leaf /> },
            ].map((stat, i) => (
              <motion.div 
                key={i}
                whileInView={{ opacity: 1, y: 0 }}
                initial={{ opacity: 0, y: 20 }}
                viewport={{ once: true }}
                className="flex flex-col items-center"
              >
                <div className="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center mb-4 text-primary-light">
                  {stat.icon}
                </div>
                <h3 className="text-3xl font-black mb-1">{stat.val}</h3>
                <p className="text-emerald-100/60 uppercase text-[10px] font-bold tracking-widest">{stat.label}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Features Grid */}
      <section className="py-32 bg-surface">
        <div className="max-w-screen-xl mx-auto px-6 lg:px-12">
           <div className="text-center mb-20">
              <span className="text-primary font-bold uppercase tracking-[0.3em] text-[10px]">Tận hưởng lối sống mới</span>
              <h2 className="text-4xl md:text-5xl font-black mt-4 text-primary-dark">Mọi Thứ Bạn Cần Để <br /> Sống Xanh Hơn</h2>
           </div>

           <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
             {[
               { title: 'Đặt Mục Tiêu Xanh', desc: 'Chọn từ hàng trăm hoạt động bảo vệ môi trường, giảm rác thải, tiết kiệm điện nước.', icon: <Target /> },
               { title: 'Check-in Hằng Ngày', desc: 'Cập nhật tiến độ của bạn, ghi chú những hành động đã thực hiện và tích lũy điểm thưởng.', icon: <CheckCircle2 /> },
               { title: 'Thống Kê Trực Quan', desc: 'Biểu đồ chi tiết về sự thay đổi của bạn qua từng tuần, tháng và năm.', icon: <BarChart3 /> },
               { title: 'Gợi Ý Thông Minh', desc: 'Nhận các Eco Tips phù hợp với thói quen và mục tiêu hiện tại của bạn.', icon: <HelpCircle /> },
               { title: 'Bảng Xếp Hạng', desc: 'Cạnh tranh lành mạnh, leo bảng xếp hạng và nhận những phần quà ý nghĩa từ đối tác.', icon: <Star /> },
             ].map((feature, i) => (
               <div key={i} className="bg-white p-10 rounded-[2.5rem] shadow-sm hover:shadow-xl transition-all border border-primary/5">
                 <div className="w-14 h-14 rounded-2xl bg-primary/5 text-primary flex items-center justify-center mb-6">
                    {feature.icon}
                 </div>
                 <h4 className="text-xl font-bold mb-4">{feature.title}</h4>
                 <p className="text-on-surface-variant text-sm leading-relaxed">{feature.desc}</p>
               </div>
             ))}
           </div>
        </div>
      </section>
    </div>
  );
}
