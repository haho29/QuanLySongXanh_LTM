import { motion } from 'motion/react';
import { 
  Lightbulb, Calendar, Droplets, Zap, Trash2, Bike, Leaf, 
  Plus, Instagram, Facebook, Twitter, Youtube, Mail, Phone, MapPin, 
  Heart, ChevronRight, Hash, Eye, Tag
} from 'lucide-react';
import { useState } from 'react';
import { cn } from '../lib/utils';

// Consts from other pages for design consistency
const SERIF_FONT = "font-['Playfair_Display',_serif]";

const CATEGORIES = [
  'Tất Cả', 'Tiết Kiệm Điện', 'Tiết Kiệm Nước', 'Giảm Rác Nhựa', 
  'Giao Thông Xanh', 'Ăn Uống Xanh', 'Phân Loại Rác'
];

const STATS = [
  { label: 'Eco Tips', value: '9+', icon: <Lightbulb className="text-emerald-500" />, bg: 'bg-[#f0fdf4]' },
  { label: 'Danh Mục', value: '6', icon: <Tag className="text-emerald-500" />, bg: 'bg-[#f0fdf4]' },
  { label: 'Đã Lưu', value: '0', icon: <Heart className="text-red-500" />, bg: 'bg-[#fef2f2]' },
];

const TIPS = [
  { id: 1, title: 'Tắt thiết bị điện khi không dùng', desc: 'Thói quen đơn giản này có thể giúp bạn tiết kiệm đến 10% hóa đơn điện mỗi tháng. Đừng để TV hay máy...', icon: <Zap size={18} />, cat: 'Điện', saving: '50.000đ/tháng', level: 'Dễ', theme: 'orange', tags: ['điện', 'tiết kiệm', 'thói quen'] },
  { id: 2, title: 'Tắm nhanh dưới 5 phút', desc: 'Mỗi phút tắm tiêu tốn khoảng 10 lít nước. Tắm nhanh hơn 5 phút mỗi ngày giúp tiết kiệm 50 lít nước...', icon: <Droplets size={18} />, cat: 'Nước', saving: '18.000 lít/năm', level: 'Dễ', theme: 'blue', tags: ['nước', 'tắm', 'tiết kiệm'] },
  { id: 3, title: 'Mang túi vải khi đi mua sắm', desc: 'Một túi nilon mất 400-1000 năm để phân hủy. Hãy mang theo túi vải tái sử dụng — một hành động nhỏ...', icon: <Leaf size={18} />, cat: 'Rác thải', saving: '500 túi nilon/năm', level: 'Dễ', theme: 'emerald', tags: ['nhựa', 'túi vải', 'tái chế'] },
  { id: 4, title: 'Đi xe đạp hoặc đi bộ', desc: 'Thay thế xe máy bằng xe đạp cho những quãng đường ngắn dưới 3km. Vừa tốt cho sức khỏe, vừa...', icon: <Bike size={18} />, cat: 'Giao thông', saving: 'Giảm 2kg CO2/ngày', level: 'Trung bình', theme: 'purple', tags: ['giao thông', 'xe đạp', 'CO2'] },
  { id: 5, title: 'Ăn chay ít nhất 1 ngày/tuần', desc: 'Sản xuất 1kg thịt bò tạo ra 27kg CO2. Ăn chay 1 ngày/tuần có thể giảm lượng khí thải carbon cá nhân...', icon: <Leaf size={18} />, cat: 'Ăn uống', saving: 'Giảm 1.5 tấn CO2/năm', level: 'Trung bình', theme: 'emerald', tags: ['ăn chay', 'thực phẩm', 'CO2'] },
  { id: 6, title: 'Phân loại rác đúng cách', desc: 'Phân loại rác thành 3 nhóm: hữu cơ, tái chế và rác thải thông thường. Điều này giúp tăng tỷ lệ tái chế v...', icon: <Trash2 size={18} />, cat: 'Rác', saving: 'Tái chế 60% rác thải', level: 'Trung bình', theme: 'orange', tags: ['rác', 'phân loại', 'tái chế'] },
  { id: 7, title: 'Tận dụng ánh sáng tự nhiên', desc: 'Mở rèm cửa vào ban ngày để tận dụng ánh sáng mặt trời thay vì bật đèn. Điều này không chỉ tiết kiệm điện...', icon: <Zap size={18} />, cat: 'Điện', saving: 'Tiết kiệm 30% điện chiếu sáng', level: 'Dễ', theme: 'orange', tags: ['điện', 'ánh sáng', 'tự nhiên'] },
  { id: 8, title: 'Thu gom nước mưa tưới cây', desc: 'Đặt thùng chứa ngoài ban công để thu gom nước mưa. Dùng nước này để tưới cây, lau nhà — tiết kiệm...', icon: <Droplets size={18} />, cat: 'Nước', saving: 'Tiết kiệm 200 lít/tháng', level: 'Dễ', theme: 'blue', tags: ['nước', 'nước mưa', 'tưới cây'] },
  { id: 9, title: 'Dùng bình nước cá nhân', desc: 'Mang theo bình nước tái sử dụng thay vì mua chai nhựa. Mỗi người trung bình dùng 3 chai nhựa/ngày...', icon: <Leaf size={18} />, cat: 'Rác thải', saving: 'Giảm 1.000 chai nhựa/năm', level: 'Dễ', theme: 'emerald', tags: ['nhựa', 'bình nước', 'tái sử dụng'] },
];

export default function EcoTipsPage() {
  const [activeCategory, setActiveCategory] = useState('Tất Cả');

  const getThemeStyles = (theme: string) => {
    switch(theme) {
      case 'orange': return { bg: 'bg-[#fff7ed]', text: 'text-[#f97316]', btn: 'bg-[#f97316] shadow-orange-200' };
      case 'blue': return { bg: 'bg-[#eff6ff]', text: 'text-[#3b82f6]', btn: 'bg-[#3b82f6] shadow-blue-200' };
      case 'emerald': return { bg: 'bg-[#f0fdf4]', text: 'text-[#10a352]', btn: 'bg-[#10a352] shadow-emerald-200' };
      case 'purple': return { bg: 'bg-[#f5f3ff]', text: 'text-[#8b5cf6]', btn: 'bg-[#8b5cf6] shadow-purple-200' };
      default: return { bg: 'bg-gray-50', text: 'text-gray-600', btn: 'bg-gray-600 shadow-gray-200' };
    }
  };

  return (
    <div className="bg-[#f8f9fa] min-h-screen">
      {/* Hero Header */}
      <section className="relative h-[480px] flex items-center justify-center overflow-hidden">
        <div className="absolute inset-0 z-0">
          <img 
            src="https://picsum.photos/seed/forest/1920/1080?blur=4" 
            alt="Forest Background" 
            className="w-full h-full object-cover brightness-[0.4]"
            referrerPolicy="no-referrer"
          />
          <div className="absolute inset-0 bg-gradient-to-b from-transparent to-[#f8f9fa]" />
        </div>

        <div className="relative z-10 text-center px-6 max-w-4xl mx-auto mt-16">
          <motion.div 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="inline-flex items-center gap-2 px-4 py-2 bg-white/10 backdrop-blur-md rounded-full border border-white/20 text-white text-xs font-bold mb-8"
          >
            <Lightbulb size={14} className="text-emerald-400" />
            Gợi ý hành động xanh
          </motion.div>
          <motion.h1 
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className={cn("text-5xl md:text-7xl font-black text-white mb-6 tracking-tighter", SERIF_FONT)}
          >
            Eco Tips Hôm Nay
          </motion.h1>
          <motion.p 
            initial={{ opacity: 0, y: 40 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="text-emerald-50/80 text-lg md:text-xl font-medium max-w-2xl mx-auto leading-relaxed"
          >
            Khám phá các hành động sống xanh đơn giản, dễ thực hiện và phù hợp với lối sống sinh viên.
          </motion.p>
        </div>
      </section>

      <div className="-mt-16 relative z-20 px-6 max-w-screen-xl mx-auto">
        {/* Stats Row */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-16">
          {STATS.map((stat, i) => (
            <motion.div 
              key={i}
              whileHover={{ y: -5 }}
              className="bg-white p-8 rounded-[2rem] shadow-sm border border-gray-100 flex items-center gap-6"
            >
              <div className={cn("w-14 h-14 rounded-2xl flex items-center justify-center shrink-0", stat.bg)}>
                {stat.icon}
              </div>
              <div>
                <h4 className="text-3xl font-black text-gray-900 leading-none mb-1">{stat.value}</h4>
                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-widest">{stat.label}</p>
              </div>
            </motion.div>
          ))}
        </div>

        {/* Category Filters */}
        <div className="flex gap-3 overflow-x-auto pb-4 mb-16 scrollbar-hide">
           {CATEGORIES.map((cat, i) => (
             <button 
              key={cat} 
              onClick={() => setActiveCategory(cat)}
              className={cn(
               "px-6 py-3 rounded-full text-[11px] font-black uppercase tracking-widest transition-all whitespace-nowrap active:scale-95",
               activeCategory === cat 
                ? "bg-[#10a352] text-white shadow-lg shadow-green-600/20" 
                : "bg-white border border-gray-100 text-gray-400 hover:bg-gray-50"
             )}>
                {cat}
             </button>
           ))}
        </div>

        {/* Tips Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mb-24">
           {TIPS.map((tip, i) => {
             const themeStyle = getThemeStyles(tip.theme);
             return (
               <motion.div 
                key={tip.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: i * 0.05 }}
                className="bg-white p-8 rounded-[2.5rem] shadow-sm border border-gray-100 flex flex-col group hover:shadow-xl hover:shadow-gray-200/50 transition-all duration-500 relative overflow-hidden"
               >
                 <div className="flex justify-between items-start mb-8">
                    <div className={cn("w-12 h-12 rounded-2xl flex items-center justify-center shadow-lg shadow-gray-100", themeStyle.bg, themeStyle.text)}>
                       {tip.icon}
                    </div>
                    <button className="p-2 text-gray-300 hover:text-red-500 transition-colors">
                       <Heart size={20} />
                    </button>
                 </div>

                 <h3 className="text-xl font-black text-[#1a2b3c] mb-4 tracking-tight group-hover:text-[#10a352] transition-colors leading-tight">
                    {tip.title}
                 </h3>
                 <p className="text-gray-400 text-sm leading-relaxed mb-4 line-clamp-2">
                    {tip.desc}
                 </p>
                 <button className="text-[10px] font-black text-emerald-500 uppercase tracking-widest mb-6 flex items-center gap-1 hover:gap-2 transition-all">
                    Xem thêm <ChevronRight size={14} />
                 </button>

                 <div className="mt-auto pt-6 border-t border-gray-50 space-y-4">
                    <div className="flex justify-between items-center">
                       <div className="flex items-center gap-2 text-[10px] font-bold text-gray-400 uppercase tracking-widest">
                          <Leaf size={12} className="text-emerald-500" />
                          {tip.saving}
                       </div>
                       <span className={cn(
                        "px-3 py-1 rounded-full text-[9px] font-black uppercase tracking-widest",
                        tip.level === 'Dễ' ? "bg-emerald-50 text-emerald-500" : "bg-orange-50 text-orange-500"
                       )}>
                          {tip.level}
                       </span>
                    </div>

                    <div className="flex flex-wrap gap-2 mb-6">
                       {tip.tags.map(tag => (
                         <span key={tag} className="text-[9px] font-bold text-gray-300 bg-gray-50 px-2 py-1 rounded-md">
                           #{tag}
                         </span>
                       ))}
                    </div>

                    <button className={cn("w-full py-4 rounded-xl text-white text-xs font-black uppercase tracking-widest flex items-center justify-center gap-2 transition-all active:scale-95 shadow-lg", themeStyle.btn)}>
                       <Plus size={18} /> Thêm Vào Mục Tiêu
                    </button>
                 </div>
               </motion.div>
             );
           })}
        </div>

        {/* Highlight Section */}
        <section className="bg-[#0b4a2e] rounded-[3.5rem] p-12 mb-24 relative overflow-hidden group">
           <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-emerald-500/10 rounded-full blur-[120px] -mr-80 -mt-80" />
           <div className="absolute inset-0 z-0">
             <img 
               src="https://picsum.photos/seed/sustainability/1200/800" 
               alt="Challenge" 
               className="w-full h-full object-cover opacity-20 group-hover:scale-105 transition-all duration-1000"
               referrerPolicy="no-referrer"
             />
             <div className="absolute inset-0 bg-gradient-to-r from-[#0b4a2e] via-[#0b4a2e]/90 to-transparent" />
           </div>

           <div className="relative z-10 grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
              <div className="space-y-8">
                 <div>
                    <span className="text-[10px] font-black text-emerald-400 uppercase tracking-widest mb-4 block">Tip nổi bật tuần này</span>
                    <h2 className={cn("text-4xl md:text-5xl font-black text-white tracking-tighter leading-none mb-6", SERIF_FONT)}>
                      Thách Thức 30 Ngày Không Rác Nhựa
                    </h2>
                    <p className="text-emerald-100/60 text-lg font-medium leading-relaxed max-w-xl">
                      Tham gia thử thách 30 ngày giảm thiểu rác thải nhựa cùng cộng đồng sinh viên GreenLife. Mỗi ngày một hành động nhỏ, cùng nhau tạo nên sự thay đổi lớn cho môi trường.
                    </p>
                 </div>

                 <div className="flex flex-wrap gap-3">
                    {['Mang túi vải', 'Dùng bình nước', 'Từ chối ống hút', 'Mua đồ bulk'].map(t => (
                      <span key={t} className="px-5 py-2.5 bg-white/5 border border-white/10 rounded-xl text-xs font-black text-emerald-100/80">
                        {t}
                      </span>
                    ))}
                 </div>

                 <button className="px-8 py-4 bg-[#10a352] text-white rounded-2xl font-black text-sm uppercase tracking-widest flex items-center gap-3 hover:bg-[#0d8a45] transition-all shadow-xl shadow-emerald-900/40 active:scale-95 group/btn">
                    Tham Gia Thử Thách <ChevronRight size={18} className="group-hover/btn:translate-x-1 transition-transform" />
                 </button>
              </div>

              <div className="hidden lg:block">
                 <div className="grid grid-cols-2 gap-4">
                    <motion.div 
                      animate={{ y: [0, -10, 0] }}
                      transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
                      className="aspect-square rounded-[2rem] overflow-hidden rotate-3"
                    >
                       <img src="https://picsum.photos/seed/bottle/400/400" className="w-full h-full object-cover" referrerPolicy="no-referrer" />
                    </motion.div>
                    <motion.div 
                      animate={{ y: [0, 10, 0] }}
                      transition={{ duration: 4, repeat: Infinity, ease: "easeInOut", delay: 1 }}
                      className="aspect-square rounded-[2rem] overflow-hidden -rotate-3 mt-12"
                    >
                       <img src="https://picsum.photos/seed/bag/400/400" className="w-full h-full object-cover" referrerPolicy="no-referrer" />
                    </motion.div>
                 </div>
              </div>
           </div>
        </section>
      </div>

      {/* Footer */}
      <footer className="bg-[#0b4a2e] text-white pt-24 pb-12 px-6 lg:px-12">
        <div className="max-w-screen-xl mx-auto">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-16 mb-24 pb-24 border-b border-white/5">
             <div className="space-y-8">
                <div className="flex items-center gap-3">
                   <div className="w-12 h-12 bg-white/10 rounded-xl flex items-center justify-center">
                     <Leaf size={28} className="text-emerald-400" fill="currentColor" />
                   </div>
                   <span className="text-2xl font-black italic tracking-tighter uppercase tracking-tight">GreenLife</span>
                </div>
                <p className="text-emerald-100/40 text-sm leading-relaxed max-w-xs font-medium">
                  Hệ thống quản lý lối sống xanh dành cho sinh viên — cùng nhau xây dựng tương lai bền vững.
                </p>
                <div className="flex gap-4">
                   {[Facebook, Instagram, Twitter, Youtube].map((Icon, i) => (
                      <a key={i} href="#" className="w-11 h-11 rounded-full bg-white/5 flex items-center justify-center hover:bg-emerald-400 hover:text-[#0b4a2e] transition-all shadow-sm">
                        <Icon size={20} />
                      </a>
                   ))}
                </div>
             </div>

             <div className="lg:pl-10">
                <h4 className="text-emerald-400 text-[10px] font-black uppercase tracking-widest mb-10">Điều hướng</h4>
                <ul className="space-y-5">
                   {['Trang Chủ', 'Mục Tiêu Xanh', 'Tiến Độ', 'Eco Tips', 'Xếp Hạng', 'Hồ Sơ'].map(link => (
                      <li key={link}><a href="#" className="text-emerald-100/60 hover:text-white font-bold text-sm transition-all">{link}</a></li>
                   ))}
                </ul>
             </div>

             <div className="lg:pl-10">
                <h4 className="text-emerald-400 text-[10px] font-black uppercase tracking-widest mb-10">Liên kết</h4>
                <ul className="space-y-5">
                   {['Check-in', 'Ghi chú', 'Cộng đồng', 'Thử thách', 'Phần thưởng'].map(link => (
                      <li key={link}><a href="#" className="text-emerald-100/60 hover:text-white font-bold text-sm transition-all">{link}</a></li>
                   ))}
                </ul>
             </div>

             <div>
                <h4 className="text-emerald-400 text-[10px] font-black uppercase tracking-widest mb-10">Liên hệ</h4>
                <div className="space-y-6">
                   <div className="flex items-start gap-4">
                      <MapPin size={20} className="text-emerald-400 shrink-0" />
                      <p className="text-emerald-100/60 text-sm font-bold leading-relaxed">268 Lý Thường Kiệt, Q.10, TP.HCM</p>
                   </div>
                   <div className="flex items-center gap-4">
                      <Mail size={20} className="text-emerald-400 shrink-0" />
                      <p className="text-emerald-100/60 text-sm font-bold">greenlife@student.edu.vn</p>
                   </div>
                   <div className="flex items-center gap-4">
                      <Phone size={20} className="text-emerald-400 shrink-0" />
                      <p className="text-emerald-100/60 text-sm font-bold">(028) 3864 7256</p>
                   </div>
                </div>
             </div>
          </div>

          <div className="flex flex-col md:flex-row justify-between items-center gap-8 text-[10px] font-bold text-emerald-100/20 uppercase tracking-widest">
             <p>© 2024 GreenLife. Tất cả quyền được bảo lưu.</p>
             <div className="flex gap-10">
                <a href="#" className="hover:text-emerald-400 transition-all">Chính Sách Bảo Mật</a>
                <a href="#" className="hover:text-emerald-400 transition-all">Điều Khoản Sử Dụng</a>
             </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
