import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { motion, AnimatePresence } from 'motion/react';
import { 
  Leaf, Lock, User, Mail, Eye, EyeOff, Briefcase, MapPin, 
  ArrowRight, ShieldCheck, Users, Target
} from 'lucide-react';
import { cn } from '../lib/utils';
import { toast } from 'react-hot-toast';

const SERIF_FONT = "font-['Playfair_Display',_serif]";

export default function LoginPage() {
  const [isLogin, setIsLogin] = useState(true);
  const [showPassword, setShowPassword] = useState(false);
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  // Register Fields
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [job, setJob] = useState('');
  const [location, setLocation] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');

  const { login, register } = useAuth();
  const navigate = useNavigate();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    // Simulate network
    await new Promise(resolve => setTimeout(resolve, 800));

    const result = login(username, password);
    if (result.success) {
      if (username === 'admin') {
        toast.success('Chào mừng Admin quay trở lại!');
        navigate('/admin/dashboard');
      } else {
        toast.success('Đăng nhập thành công!');
        navigate('/goals');
      }
    } else {
      toast.error(result.error || 'Đăng nhập thất bại');
      // If user doesn't exist, highlight the option to register
      if (result.error?.includes('tạo tài khoản mới')) {
        // Optionally auto-switch to register? No, let the user decide.
      }
    }
    setIsLoading(false);
  };

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    if (password !== confirmPassword) {
      toast.error('Mật khẩu xác nhận không khớp');
      return;
    }

    setIsLoading(true);
    await new Promise(resolve => setTimeout(resolve, 800));

    const result = register({
      fullName,
      email,
      job,
      location,
      password
    });

    if (result.success) {
      toast.success('Đăng ký thành công! Hãy đăng nhập ngay.');
      setIsLogin(true);
      setUsername(email); // Convenience
    } else {
      toast.error(result.error || 'Đăng ký thất bại');
    }
    setIsLoading(false);
  };

  const fillDemo = (type: 'user' | 'admin') => {
    if (type === 'admin') {
      setUsername('admin');
      setPassword('admin123');
    } else {
      setUsername('demo@greenlife.vn');
      setPassword('demo123');
    }
  };

  return (
    <div className="min-h-screen flex bg-white overflow-hidden font-sans">
      {/* Left Side - Hero Branding */}
      <div className="hidden lg:flex lg:w-5/12 relative overflow-hidden">
        <img 
          src="https://picsum.photos/seed/green_people/1200/1800" 
          alt="Students in Nature" 
          className="absolute inset-0 w-full h-full object-cover brightness-[0.7] transform scale-110"
          referrerPolicy="no-referrer"
        />
        <div className="absolute inset-0 bg-[#064e3b]/40 backdrop-blur-[2px]" />
        
        <div className="relative z-10 p-16 flex flex-col justify-end h-full">
          <div className="flex items-center gap-3 mb-8">
            <div className="w-12 h-12 bg-white/20 backdrop-blur-md rounded-xl flex items-center justify-center border border-white/30">
              <Leaf size={28} className="text-emerald-300" fill="currentColor" />
            </div>
            <span className="text-3xl font-black text-white italic tracking-tighter uppercase">GreenLife</span>
          </div>

          <h2 className={cn("text-5xl font-black text-white mb-6 leading-[1.1] tracking-tight", SERIF_FONT)}>
            Cùng Nhau Sống Xanh
          </h2>
          <p className="text-emerald-50/80 text-lg font-medium max-w-md leading-relaxed mb-12">
            Tham gia cộng đồng sống xanh — đặt mục tiêu, theo dõi tiến độ và tạo nên sự thay đổi tích cực cho hành tinh.
          </p>

          <div className="flex gap-4">
             <div className="flex-1 bg-white/10 backdrop-blur-md p-6 rounded-[2rem] border border-white/20">
                <div className="flex items-center gap-3 text-white/60 mb-2">
                   <Users size={16} />
                   <span className="text-[10px] font-black uppercase tracking-widest leading-none">Người dùng</span>
                </div>
                <div className="text-3xl font-black text-white">5,000+</div>
             </div>
             <div className="flex-1 bg-white/10 backdrop-blur-md p-6 rounded-[2rem] border border-white/20">
                <div className="flex items-center gap-3 text-white/60 mb-2">
                   <Target size={16} />
                   <span className="text-[10px] font-black uppercase tracking-widest leading-none">Hoàn thành</span>
                </div>
                <div className="text-3xl font-black text-white">87%</div>
             </div>
          </div>
        </div>
      </div>

      {/* Right Side - Form */}
      <div className="w-full lg:w-7/12 flex flex-col items-center justify-center p-8 lg:p-24 overflow-y-auto bg-gray-50/30">
        <div className="w-full max-w-lg">
          {/* Toggle Switch */}
          <div className="flex bg-gray-100 p-1 rounded-full mb-12 w-full max-w-[400px] mx-auto">
             <button 
              onClick={() => setIsLogin(true)}
              className={cn(
                "flex-1 py-3 text-xs font-black uppercase tracking-widest rounded-full transition-all",
                isLogin ? "bg-white text-gray-900 shadow-sm" : "text-gray-400 hover:text-gray-600"
              )}
             >
                Đăng Nhập
             </button>
             <button 
              onClick={() => setIsLogin(false)}
              className={cn(
                "flex-1 py-3 text-xs font-black uppercase tracking-widest rounded-full transition-all",
                !isLogin ? "bg-white text-gray-900 shadow-sm" : "text-gray-400 hover:text-gray-600"
              )}
             >
                Đăng Ký
             </button>
          </div>

          <AnimatePresence mode="wait">
            {isLogin ? (
              <motion.div 
                key="login"
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -20 }}
                className="space-y-10"
              >
                <div className="text-center md:text-left">
                  <h1 className={cn("text-4xl font-black text-gray-900 mb-3", SERIF_FONT)}>Chào Mừng Trở Lại!</h1>
                  <p className="text-gray-400 font-bold text-sm">Đăng nhập để tiếp tục hành trình xanh của bạn.</p>
                </div>

                <form onSubmit={handleLogin} className="space-y-6">
                  <div className="space-y-2">
                    <label className="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Email / Tên đăng nhập</label>
                    <div className="relative group">
                      <div className="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-emerald-500 transition-colors">
                        <User size={18} />
                      </div>
                      <input 
                        type="text" 
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                        placeholder="email@example.com hoặc admin"
                        className="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-14 pr-6 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none"
                        required
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Mật Khẩu</label>
                    <div className="relative group">
                      <div className="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-emerald-500 transition-colors">
                        <Lock size={18} />
                      </div>
                      <input 
                        type={showPassword ? 'text' : 'password'} 
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        placeholder="••••••••"
                        className="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-14 pr-14 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none"
                        required
                      />
                      <button 
                        type="button"
                        onClick={() => setShowPassword(!showPassword)}
                        className="absolute right-5 top-1/2 -translate-y-1/2 text-gray-300 hover:text-gray-600"
                      >
                        {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                      </button>
                    </div>
                  </div>

                  <button 
                    disabled={isLoading}
                    type="submit" 
                    className="w-full py-4 bg-[#10a352] text-white rounded-2xl font-black text-sm uppercase tracking-widest shadow-xl shadow-emerald-500/20 hover:bg-[#0d8a45] transition-all transform active:scale-95 flex items-center justify-center gap-3"
                  >
                    {isLoading ? "Đang xử lý..." : "Đăng Nhập"}
                  </button>
                </form>

                <div className="text-center">
                   <p className="text-xs font-bold text-gray-400">
                      Chưa có tài khoản? <button onClick={() => setIsLogin(false)} className="text-[#10a352] hover:underline underline-offset-4">Đăng ký ngay</button>
                   </p>
                </div>

                {/* Account Info Boxes */}
                <div className="bg-[#f0fdf4] border border-[#dcfce7] rounded-3xl p-8 space-y-6">
                   <div>
                      <div className="flex items-center gap-2 text-[10px] font-black text-[#10a352] uppercase tracking-widest mb-3">
                         Tài khoản người dùng demo:
                      </div>
                      <p className="text-[11px] font-bold text-gray-500 leading-relaxed mb-2">
                        Email: <span className="text-emerald-700">demo@greenlife.vn</span>  |  Mật khẩu: <span className="text-emerald-700">demo123</span>
                      </p>
                      <button onClick={() => fillDemo('user')} className="text-[10px] font-black text-emerald-600 hover:underline flex items-center gap-1">
                        Dùng tài khoản demo <ArrowRight size={12} />
                      </button>
                   </div>
                   
                   <div className="pt-6 border-t border-emerald-100/50">
                      <div className="flex items-center gap-2 text-[10px] font-black text-[#10a352] uppercase tracking-widest mb-3">
                         <ShieldCheck size={12} /> Tài khoản Admin:
                      </div>
                      <p className="text-[11px] font-bold text-gray-500 leading-relaxed mb-2">
                        Tên đăng nhập: <span className="text-emerald-700">admin</span>  |  Mật khẩu: <span className="text-emerald-700">admin123</span>
                      </p>
                      <button onClick={() => fillDemo('admin')} className="text-[10px] font-black text-emerald-600 hover:underline flex items-center gap-1">
                        Điền tự động <ArrowRight size={12} />
                      </button>
                   </div>
                </div>
              </motion.div>
            ) : (
              <motion.div 
                key="register"
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -20 }}
                className="space-y-10"
              >
                <div className="text-center md:text-left">
                  <h1 className={cn("text-4xl font-black text-gray-900 mb-3", SERIF_FONT)}>Tạo Tài Khoản Mới</h1>
                  <p className="text-gray-400 font-bold text-sm">Bắt đầu hành trình sống xanh của bạn ngay hôm nay.</p>
                </div>

                <form onSubmit={handleRegister} className="space-y-6">
                  <div className="space-y-2">
                    <label className="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Họ và Tên</label>
                    <div className="relative group">
                      <div className="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-emerald-500 transition-colors">
                        <User size={18} />
                      </div>
                      <input 
                        type="text" 
                        value={fullName}
                        onChange={(e) => setFullName(e.target.value)}
                        placeholder="Nguyễn Văn A"
                        className="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-14 pr-6 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none"
                        required
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Email</label>
                    <div className="relative group">
                      <div className="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-emerald-500 transition-colors">
                        <Mail size={18} />
                      </div>
                      <input 
                        type="email" 
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        placeholder="email@example.com"
                        className="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-14 pr-6 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none"
                        required
                      />
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                     <div className="space-y-2">
                        <label className="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Nghề Nghiệp</label>
                        <div className="relative group">
                           <div className="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-emerald-500 transition-colors">
                              <Briefcase size={16} />
                           </div>
                           <input 
                              type="text" 
                              value={job}
                              onChange={(e) => setJob(e.target.value)}
                              placeholder="Kỹ sư, Giáo viên..."
                              className="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-12 pr-6 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none"
                           />
                        </div>
                     </div>
                     <div className="space-y-2">
                        <label className="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Địa Điểm</label>
                        <div className="relative group">
                           <div className="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-emerald-500 transition-colors">
                              <MapPin size={16} />
                           </div>
                           <input 
                              type="text" 
                              value={location}
                              onChange={(e) => setLocation(e.target.value)}
                              placeholder="TP. HCM, Hà Nội..."
                              className="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-12 pr-6 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none"
                           />
                        </div>
                     </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Mật Khẩu</label>
                    <div className="relative group">
                      <div className="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-emerald-500 transition-colors">
                        <Lock size={18} />
                      </div>
                      <input 
                        type={showPassword ? 'text' : 'password'} 
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        placeholder="Ít nhất 6 ký tự"
                        className="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-14 pr-14 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none"
                        required
                        minLength={6}
                      />
                      <button 
                        type="button"
                        onClick={() => setShowPassword(!showPassword)}
                        className="absolute right-5 top-1/2 -translate-y-1/2 text-gray-300 hover:text-gray-600"
                      >
                        {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                      </button>
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-[11px] font-black uppercase text-gray-400 tracking-widest ml-1">Xác Nhận Mật Khẩu</label>
                    <div className="relative group">
                      <div className="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-emerald-500 transition-colors">
                        <Lock size={18} />
                      </div>
                      <input 
                        type="password" 
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        placeholder="Nhập lại mật khẩu"
                        className="w-full bg-white border-2 border-gray-100 rounded-2xl py-4 pl-14 pr-6 text-sm font-medium focus:border-emerald-500/30 focus:ring-4 focus:ring-emerald-500/5 transition-all outline-none"
                        required
                      />
                    </div>
                  </div>

                  <button 
                    type="submit" 
                    className="w-full py-4 bg-[#10a352] text-white rounded-2xl font-black text-sm uppercase tracking-widest shadow-xl shadow-emerald-500/20 hover:bg-[#0d8a45] transition-all transform active:scale-95 flex items-center justify-center gap-3"
                  >
                    Tạo Tài Khoản
                  </button>
                </form>

                <div className="text-center">
                   <p className="text-xs font-bold text-gray-400">
                      Đã có tài khoản? <button onClick={() => setIsLogin(true)} className="text-[#10a352] hover:underline underline-offset-4">Đăng nhập</button>
                   </p>
                </div>
              </motion.div>
            )}
          </AnimatePresence>
        </div>
      </div>
    </div>
  );
}
