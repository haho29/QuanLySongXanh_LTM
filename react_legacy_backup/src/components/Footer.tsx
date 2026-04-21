import { Leaf, Facebook, Instagram, Twitter, Youtube } from 'lucide-react';

export default function Footer() {
  return (
    <footer className="bg-primary-dark text-white pt-16 pb-8 px-6 lg:px-12">
      <div className="max-w-screen-2xl mx-auto grid grid-cols-1 md:grid-cols-4 gap-12">
        <div className="col-span-1 md:col-span-1">
          <div className="flex items-center gap-2 mb-6">
            <Leaf className="text-primary-light w-8 h-8" />
            <span className="text-2xl font-bold tracking-tighter text-white">GreenLife</span>
          </div>
          <p className="text-emerald-100/60 text-sm leading-relaxed mb-8">
            Hệ thống quản lý lối sống xanh dành cho sinh viên — cùng nhau xây dựng tương lai bền vững cho hành tinh.
          </p>
          <div className="flex gap-4">
            <a href="#" className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-primary-light transition-colors">
              <Facebook size={18} />
            </a>
            <a href="#" className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-primary-light transition-colors">
              <Instagram size={18} />
            </a>
            <a href="#" className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-primary-light transition-colors">
              <Twitter size={18} />
            </a>
            <a href="#" className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center hover:bg-primary-light transition-colors">
              <Youtube size={18} />
            </a>
          </div>
        </div>

        <div>
           <h4 className="font-bold mb-6">Điều Hướng</h4>
           <ul className="space-y-4 text-sm text-emerald-100/60">
             <li><a href="/" className="hover:text-primary-light transition-colors">Trang Chủ</a></li>
             <li><a href="/goals" className="hover:text-primary-light transition-colors">Mục Tiêu Xanh</a></li>
             <li><a href="/progress" className="hover:text-primary-light transition-colors">Tiến Độ</a></li>
             <li><a href="/tips" className="hover:text-primary-light transition-colors">Eco Tips</a></li>
             <li><a href="/leaderboard" className="hover:text-primary-light transition-colors">Xếp Hạng</a></li>
           </ul>
        </div>

        <div>
           <h4 className="font-bold mb-6">Liên Hệ</h4>
           <ul className="space-y-4 text-sm text-emerald-100/60">
             <li className="flex gap-2">
               <span>📍</span>
               <span>268 Lý Thường Kiệt, Q.10, TP.HCM</span>
             </li>
             <li className="flex gap-2">
                <span>📧</span>
                <span>greenlife@student.edu.vn</span>
             </li>
             <li className="flex gap-2">
                <span>📞</span>
                <span>(028) 3864 7256</span>
             </li>
           </ul>
        </div>

        <div>
           <h4 className="font-bold mb-6">Phản Hồi</h4>
           <p className="text-sm text-emerald-100/60 mb-4">Gửi góp ý của bạn để giúp chúng tôi hoàn thiện hơn.</p>
           <div className="relative">
             <input 
               type="text" 
               placeholder="Email của bạn..."
               className="w-full bg-white/10 border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-primary-light"
             />
             <button className="absolute right-2 top-2 bg-primary-light text-primary-dark p-1.5 rounded-lg">
                <Leaf size={16} />
             </button>
           </div>
        </div>
      </div>
      
      <div className="max-w-screen-2xl mx-auto mt-16 pt-8 border-t border-white/10 flex flex-col md:flex-row justify-between items-center gap-4 text-xs text-emerald-100/40">
        <p>© 2024 GreenLife. Tất cả quyền được bảo lưu.</p>
        <div className="flex gap-8">
          <a href="#" className="hover:text-emerald-100 transition-colors">Chính Sách Bảo Mật</a>
          <a href="#" className="hover:text-emerald-100 transition-colors">Điều Khoản Sử Dụng</a>
        </div>
      </div>
    </footer>
  );
}
