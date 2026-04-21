import { motion, AnimatePresence } from 'motion/react';
import { Target, Plus, X, Check, Clock, TrendingUp, Award, BarChart3, Instagram, Facebook, Twitter, Youtube, Mail, Phone, MapPin, Leaf, Zap, Droplets, Trash2, Bike, Heart } from 'lucide-react';
import { useState, useEffect, FormEvent } from 'react';
import { useNotifications } from '../context/NotificationContext';
import { cn } from '../lib/utils';

interface Goal {
  id: number;
  title: string;
  cat: string;
  description: string;
  progress: number;
  currentDays: number;
  totalDays: number;
  theme: 'orange' | 'emerald' | 'blue' | 'purple' | 'red';
  status: 'active' | 'completed';
}

const DEFAULT_GOALS: Goal[] = [
  { 
    id: 1, 
    title: 'Tiết kiệm điện mỗi ngày', 
    cat: 'Năng lượng', 
    description: 'Tắt đèn và thiết bị điện khi không sử dụng, hạn chế dùng điều hòa.',
    progress: 73,
    currentDays: 22,
    totalDays: 30,
    theme: 'orange',
    status: 'active'
  },
  { 
    id: 2, 
    title: 'Giảm rác thải nhựa', 
    cat: 'Rác thải', 
    description: 'Mang túi vải, từ chối ống hút nhựa, dùng bình nước cá nhân.',
    progress: 93,
    currentDays: 28,
    totalDays: 30,
    theme: 'emerald',
    status: 'active'
  },
  { 
    id: 3, 
    title: 'Tiết kiệm nước', 
    cat: 'Nước', 
    description: 'Tắm nhanh dưới 5 phút, khóa vòi khi đánh răng.',
    progress: 60,
    currentDays: 18,
    totalDays: 30,
    theme: 'blue',
    status: 'active'
  },
  { 
    id: 4, 
    title: 'Đi xe đạp đi làm', 
    cat: 'Giao thông', 
    description: 'Thay thế xe máy bằng xe đạp hoặc đi bộ khi có thể.',
    progress: 100,
    currentDays: 20,
    totalDays: 20,
    theme: 'purple',
    status: 'completed'
  },
  { 
    id: 5, 
    title: 'Ăn chay 2 ngày/tuần', 
    cat: 'Ăn uống', 
    description: 'Giảm tiêu thụ thịt, tăng cường rau củ quả trong bữa ăn.',
    progress: 63,
    currentDays: 5,
    totalDays: 8,
    theme: 'emerald',
    status: 'active'
  },
  { 
    id: 6, 
    title: 'Phân loại rác tại nhà', 
    cat: 'Rác thải', 
    description: 'Phân loại rác hữu cơ, vô cơ và tái chế đúng cách.',
    progress: 40,
    currentDays: 12,
    totalDays: 30,
    theme: 'orange',
    status: 'active'
  },
];

export default function GoalPage() {
  const [activeTab, setActiveTab] = useState('Tất Cả');
  const [goals, setGoals] = useState<Goal[]>(() => {
    const saved = localStorage.getItem('greenlife_personalized_goals');
    return saved ? JSON.parse(saved) : DEFAULT_GOALS;
  });
  
  const [showProposalModal, setShowProposalModal] = useState(false);
  const [newGoalTitle, setNewGoalTitle] = useState('');
  const { addNotification } = useNotifications();

  useEffect(() => {
    localStorage.setItem('greenlife_personalized_goals', JSON.stringify(goals));
  }, [goals]);

  const handleCheckIn = (id: number) => {
    setGoals(prev => prev.map(g => {
      if (g.id === id && g.status === 'active') {
        const nextDays = Math.min(g.currentDays + 1, g.totalDays);
        const nextProgress = Math.round((nextDays / g.totalDays) * 100);
        
        if (nextProgress === 100 && g.progress < 100) {
          addNotification({
            title: 'Mục tiêu hoàn thành!',
            message: `Chúc mừng bạn đã hoàn thành "${g.title}"!`,
            type: 'goal'
          });
          return { ...g, currentDays: nextDays, progress: 100, status: 'completed' };
        }
        
        addNotification({
          title: 'Đã check-in!',
          message: `Bạn đã ghi nhận tiến độ cho "${g.title}"`,
          type: 'activity'
        });
        return { ...g, currentDays: nextDays, progress: nextProgress };
      }
      return g;
    }));
  };

  const filteredGoals = goals.filter(g => {
    if (activeTab === 'Tất Cả') return true;
    if (activeTab === 'Đang Thực Hiện') return g.status === 'active';
    if (activeTab === 'Hoàn Thành') return g.status === 'completed';
    return true;
  });

  const getThemeStyles = (theme: string) => {
    switch(theme) {
      case 'orange': return { bg: 'bg-[#fff7ed]', text: 'text-[#f97316]', bar: 'bg-[#f97316]', btn: 'bg-[#f97316]' };
      case 'emerald': return { bg: 'bg-[#f0fdf4]', text: 'text-[#10a352]', bar: 'bg-[#10a352]', btn: 'bg-[#10a352]' };
      case 'blue': return { bg: 'bg-[#eff6ff]', text: 'text-[#3b82f6]', bar: 'bg-[#3b82f6]', btn: 'bg-[#3b82f6]' };
      case 'purple': return { bg: 'bg-[#f5f3ff]', text: 'text-[#8b5cf6]', bar: 'bg-[#8b5cf6]', btn: 'bg-[#8b5cf6]' };
      default: return { bg: 'bg-gray-50', text: 'text-gray-600', bar: 'bg-gray-300', btn: 'bg-gray-500' };
    }
  };

  const getCatIcon = (cat: string) => {
    switch(cat) {
      case 'Năng lượng': return <Zap size={20} />;
      case 'Rác thải': return <Trash2 size={20} />;
      case 'Nước': return <Droplets size={20} />;
      case 'Giao thông': return <Bike size={20} />;
      case 'Ăn uống': return <Leaf size={20} />;
      default: return <Target size={20} />;
    }
  };

  return (
    <div className="bg-[#f8f9fa] min-h-screen">
      <div className="pt-32 pb-20 px-6 lg:px-12 max-w-screen-xl mx-auto">
        {/* Header Section */}
        <header className="flex flex-col md:flex-row md:items-center justify-between gap-8 mb-12">
          <div>
            <h1 className={cn("text-4xl font-black text-[#1a2b3c] mb-2 tracking-tight", "font-serif")}>
              Mục Tiêu Xanh Của Tôi
            </h1>
            <p className="text-gray-500 font-medium">
              Quản lý và theo dõi các mục tiêu sống xanh của bạn
            </p>
          </div>

          <button 
            onClick={() => setShowProposalModal(true)}
            className="flex items-center gap-2 px-6 py-3.5 bg-[#10a352] text-white rounded-xl font-bold hover:bg-[#0d8a45] transition-all shadow-lg shadow-green-600/10 active:scale-95"
          >
            <Plus size={20} strokeWidth={3} />
            Thêm Mục Tiêu
          </button>
        </header>

        {/* Tabs Bar */}
        <nav className="flex items-center gap-4 mb-12 overflow-x-auto pb-2 scrollbar-hide">
          <button 
            onClick={() => setActiveTab('Tất Cả')}
            className={cn(
              "flex items-center gap-2 px-6 py-2.5 rounded-full text-sm font-bold transition-all border shrink-0",
              activeTab === 'Tất Cả' 
                ? "bg-[#10a352] text-white border-[#10a352] shadow-lg shadow-emerald-600/20" 
                : "bg-white text-gray-500 border-gray-100 hover:border-gray-200"
            )}
          >
            Tất Cả
            <span className={cn(
              "text-[10px] w-5 h-5 flex items-center justify-center rounded-full font-bold",
              activeTab === 'Tất Cả' ? "bg-white/20" : "bg-gray-100 text-gray-400"
            )}>
              {goals.length}
            </span>
          </button>

          <button 
            onClick={() => setActiveTab('Đang Thực Hiện')}
            className={cn(
              "flex items-center gap-2 px-6 py-2.5 rounded-full text-sm font-bold transition-all border shrink-0",
              activeTab === 'Đang Thực Hiện' 
                ? "bg-[#10a352] text-white border-[#10a352] shadow-lg shadow-emerald-600/20" 
                : "bg-white text-gray-500 border-gray-100 hover:border-gray-200"
            )}
          >
            Đang Thực Hiện
            <span className={cn(
              "text-[10px] w-5 h-5 flex items-center justify-center rounded-full font-bold",
              activeTab === 'Đang Thực Hiện' ? "bg-white/20" : "bg-gray-100 text-gray-400"
            )}>
              {goals.filter(g => g.status === 'active').length}
            </span>
          </button>

          <button 
            onClick={() => setActiveTab('Hoàn Thành')}
            className={cn(
              "flex items-center gap-2 px-6 py-2.5 rounded-full text-sm font-bold transition-all border shrink-0",
              activeTab === 'Hoàn Thành' 
                ? "bg-[#10a352] text-white border-[#10a352] shadow-lg shadow-emerald-600/20" 
                : "bg-white text-gray-500 border-gray-100 hover:border-gray-200"
            )}
          >
            Hoàn Thành
            <span className={cn(
              "text-[10px] w-5 h-5 flex items-center justify-center rounded-full font-bold",
              activeTab === 'Hoàn Thành' ? "bg-white/20" : "bg-gray-100 text-gray-400"
            )}>
              {goals.filter(g => g.status === 'completed').length}
            </span>
          </button>
        </nav>

        {/* Goals Grid */}
        <AnimatePresence mode="popLayout">
          <motion.div 
            layout
            className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8"
          >
            {filteredGoals.map((goal) => {
              const theme = getThemeStyles(goal.theme);
              const icon = getCatIcon(goal.cat);

              return (
                <motion.div 
                  key={goal.id}
                  layout
                  initial={{ opacity: 0, scale: 0.95 }}
                  animate={{ opacity: 1, scale: 1 }}
                  exit={{ opacity: 0, scale: 0.95 }}
                  className="bg-white rounded-[2.5rem] p-8 shadow-sm border border-gray-100/50 flex flex-col h-full group transition-all hover:shadow-xl hover:shadow-gray-200/50"
                >
                  {/* Card Head */}
                  <div className="flex justify-between items-start mb-6">
                    <div className="flex items-center gap-3">
                      <div className={cn("w-12 h-12 rounded-xl flex items-center justify-center", theme.bg, theme.text)}>
                        {icon}
                      </div>
                      <span className={cn(
                        "px-3 py-1 rounded-lg text-[10px] font-bold uppercase tracking-wider",
                        goal.status === 'completed' ? "bg-[#f0fdf4] text-[#10a352]" : "bg-[#eff6ff] text-[#3b82f6]"
                      )}>
                        {goal.status === 'completed' ? 'Hoàn thành' : 'Đang thực hiện'}
                      </span>
                    </div>
                  </div>

                  {/* Title & Desc */}
                  <h3 className="text-xl font-bold text-gray-900 mb-2 truncate leading-tight">{goal.title}</h3>
                  <p className="text-gray-400 text-sm mb-8 line-clamp-2 min-h-[2.5rem] font-medium leading-relaxed">
                    {goal.description}
                  </p>

                  <div className="mt-auto space-y-4">
                    {/* Progress Bar */}
                    <div className="space-y-3">
                      <div className="flex justify-between items-center text-[10px] font-bold">
                        <span className="text-gray-400 uppercase tracking-widest opacity-60">Tiến độ</span>
                        <span className={cn("text-xs font-black", theme.text)}>{goal.progress}%</span>
                      </div>
                      <div className="h-2.5 bg-gray-50 rounded-full overflow-hidden shadow-inner p-0.5 border border-gray-100">
                        <motion.div 
                          layout
                          initial={{ width: 0 }}
                          animate={{ width: `${goal.progress}%` }}
                          className={cn("h-full rounded-full transition-all", theme.bar)} 
                        />
                      </div>
                      <div className="flex justify-between text-[11px] font-bold text-gray-300">
                        <span>{goal.currentDays} ngày</span>
                        <span>{goal.totalDays} ngày</span>
                      </div>
                    </div>

                    {/* Action Buttons */}
                    <div className="flex gap-2">
                      <button 
                        onClick={() => handleCheckIn(goal.id)}
                        disabled={goal.status === 'completed'}
                        className={cn(
                          "flex-1 py-4 px-6 rounded-2xl text-white font-bold text-sm flex items-center justify-center gap-2 transition-all active:scale-95",
                          goal.status === 'completed' ? "bg-[#f0fdf4] text-[#10a352] !opacity-100 border border-[#dcfce7]" : cn(theme.btn, "shadow-lg shadow-gray-200")
                        )}
                      >
                        {goal.status === 'completed' ? <CheckCircle2 size={18} /> : <Check size={18} strokeWidth={3} />}
                        {goal.status === 'completed' ? 'Hoàn thành!' : 'Check-in'}
                      </button>
                      
                      <button className="w-14 h-14 flex items-center justify-center rounded-2xl bg-white border border-gray-100 text-gray-300 hover:text-gray-500 hover:bg-gray-50 transition-all shrink-0">
                        <BarChart3 size={20} />
                      </button>
                    </div>
                  </div>
                </motion.div>
              );
            })}
          </motion.div>
        </AnimatePresence>
      </div>

      {/* Simplified Propsal Modal to match design */}
      <AnimatePresence>
        {showProposalModal && (
          <div className="fixed inset-0 z-[100] flex items-center justify-center p-6 bg-black/40 backdrop-blur-sm">
            <motion.div 
              initial={{ opacity: 0, scale: 0.95, y: 10 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.95, y: 10 }}
              className="bg-white w-full max-w-lg rounded-[2.5rem] p-10 shadow-2xl"
            >
              <div className="flex justify-between items-center mb-8">
                 <h2 className="text-2xl font-black text-[#1a2b3c] italic tracking-tight">Thêm mục tiêu mới</h2>
                 <button onClick={() => setShowProposalModal(false)} className="p-2 hover:bg-gray-50 rounded-full text-gray-400"><X /></button>
              </div>
              <div className="space-y-6">
                <div className="space-y-2">
                  <label className="text-[10px] font-black uppercase text-gray-400 tracking-widest">Tên mục tiêu</label>
                  <input 
                    className="w-full bg-gray-50 border-none rounded-2xl py-4 px-6 focus:ring-2 focus:ring-[#10a352]" 
                    placeholder="VD: Không dùng túi nhựa..."
                    value={newGoalTitle}
                    onChange={(e) => setNewGoalTitle(e.target.value)}
                  />
                </div>
                <button 
                  onClick={() => {
                    if (!newGoalTitle) return;
                    addNotification({ title: 'Thành công', message: 'Mục tiêu mới đã được gửi phê duyệt', type: 'system' });
                    setShowProposalModal(false);
                    setNewGoalTitle('');
                  }}
                  className="w-full py-5 bg-[#10a352] text-white rounded-2xl font-black text-lg transition-all hover:bg-[#0d8a45]"
                >
                  Gửi Phê Duyệt
                </button>
              </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>

      {/* Reusable Footer to match screenshot brand feel */}
      <footer className="bg-[#0b4a2e] text-white pt-24 pb-12 px-6 lg:px-12">
        <div className="max-w-screen-xl mx-auto">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-16 mb-24 pb-24 border-b border-white/5">
             <div className="space-y-8">
                <div className="flex items-center gap-3">
                   <div className="w-12 h-12 bg-white/10 rounded-xl flex items-center justify-center">
                     <Leaf size={28} className="text-emerald-400" fill="currentColor" />
                   </div>
                   <span className="text-2xl font-black italic tracking-tighter">GreenLife</span>
                </div>
                <p className="text-emerald-100/40 text-sm leading-relaxed max-w-xs">
                  Hệ thống quản lý lối sống xanh dành cho sinh viên — cùng nhau xây dựng tương lai bền vững.
                </p>
                <div className="flex gap-4">
                   {[Facebook, Instagram, Twitter, Youtube].map((Icon, i) => (
                      <a key={i} href="#" className="w-11 h-11 rounded-full bg-white/5 flex items-center justify-center hover:bg-emerald-400 hover:text-[#0b4a2e] transition-all">
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
                      <p className="text-emerald-100/60 text-sm font-bold leading-relaxed">268 Lý Thường Kiệt, Quận 10, TP.HCM</p>
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
             <p>© 2024 GreenLife. All rights reserved.</p>
             <div className="flex gap-10">
                <a href="#" className="hover:text-emerald-400 transition-all">Privacy Policy</a>
                <a href="#" className="hover:text-emerald-400 transition-all">Terms of Service</a>
             </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
function CheckCircle2(props: any) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M12 22c5.523 0 10-4.477 10-10S17.523 2 12 2 2 6.477 2 12s4.477 10 10 10z" />
      <path d="m9 12 2 2 4-4" />
    </svg>
  );
}
