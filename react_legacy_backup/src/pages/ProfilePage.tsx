import { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { User, Settings, Edit3, MapPin, Award, Target, Flame, ChevronRight, LogOut, BellRing, CheckCircle2, TrendingUp } from 'lucide-react';
import { cn } from '../lib/utils';
import { useNotifications } from '../context/NotificationContext';
import { useNavigate } from 'react-router-dom';

const USER_BADGES = [
  { id: 1, name: 'Sứ Giả Xanh', date: '12/03/2024', icon: <Award className="text-yellow-500" /> },
  { id: 2, name: 'Người Tiết Kiệm Năng Lượng', date: '05/04/2024', icon: <Award className="text-blue-500" /> },
  { id: 3, name: 'Chiến Binh Rác Thải', date: '18/04/2024', icon: <Award className="text-emerald-500" /> },
];

export default function ProfilePage() {
  const { requestPushPermission } = useNotifications();
  const navigate = useNavigate();

  const [xp] = useState(() => {
    const saved = localStorage.getItem('greenlife_user_xp');
    return saved ? parseInt(saved) : 2450;
  });

  const [activeGoals] = useState(() => {
    const saved = localStorage.getItem('greenlife_user_active_goals');
    return saved ? JSON.parse(saved) : [
      { id: 'def-1', title: 'Không dùng túi nhựa', progress: 85, cat: 'Rác thải', xp: 150 },
      { id: 'def-2', title: 'Tiết kiệm 20% điện', progress: 45, cat: 'Năng lượng', xp: 500 },
    ];
  });

  const [logs] = useState(() => {
    const saved = localStorage.getItem('greenlife_activity_logs');
    return saved ? JSON.parse(saved) : [
      { id: 1, action: 'Đã hoàn thành mục tiêu "Không dùng túi nhựa"', time: '2 giờ trước', points: '+150 XP' },
      { id: 2, action: 'Đã cập nhật chỉ số rác thải tháng 4', time: '1 ngày trước', points: '+50 XP' },
      { id: 3, action: 'Lên hạng #142 trên bảng xếp hạng toàn quốc', time: '3 ngày trước', points: '+200 XP' },
    ];
  });

  const level = Math.floor(xp / 200);
  const nextLevelXp = (level + 1) * 200;
  const levelProgress = ((xp % 200) / 200) * 100;

  return (
    <div className="pt-28 pb-20 px-6 lg:px-12 max-w-screen-xl mx-auto min-h-screen">
      <div className="grid grid-cols-1 lg:grid-cols-4 gap-12">
        {/* Sidebar */}
        <aside className="lg:col-span-1">
          <motion.div 
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            className="flex flex-col items-center text-center sticky top-28"
          >
            <div className="relative mb-6">
              <div className="w-40 h-40 rounded-[3rem] overflow-hidden border-4 border-white shadow-2xl ring-4 ring-primary/5">
                <img src="https://picsum.photos/seed/current/400" alt="User Profile" className="w-full h-full object-cover" />
              </div>
              <button className="absolute -bottom-2 -right-2 p-3 bg-primary text-white rounded-2xl shadow-lg hover:scale-110 transition-transform">
                <Edit3 size={18} />
              </button>
            </div>
            
            <h2 className="text-2xl font-black text-on-surface mb-1">Hà Văn Minh</h2>
            <p className="text-primary font-bold text-sm mb-6">Sinh viên • Đại học Bách Khoa</p>
            
            <div className="flex flex-col w-full gap-2 mt-4 text-left">
              <button className="flex items-center gap-3 px-6 py-4 bg-primary text-white rounded-2xl font-bold shadow-xl shadow-primary/20">
                <User size={18} /> Thông tin cá nhân
              </button>
              <button className="flex items-center justify-between px-6 py-4 text-on-surface-variant hover:bg-primary/5 rounded-2xl font-bold transition-all">
                <div className="flex items-center gap-3">
                  <Settings size={18} /> Cài đặt
                </div>
                <ChevronRight size={16} />
              </button>
              
              <div className="mt-8 p-6 bg-primary/5 rounded-3xl border border-primary/10">
                 <div className="flex items-center gap-3 mb-4">
                    <BellRing size={20} className="text-primary" />
                    <h4 className="text-sm font-bold text-primary tracking-tight">Thông báo đẩy</h4>
                 </div>
                 <p className="text-[10px] text-on-surface-variant mb-4 leading-relaxed italic">
                    Nhận nhắc nhở tức thì về mục tiêu và các hoạt động xanh mới nhất.
                 </p>
                 <button 
                  onClick={() => requestPushPermission()}
                  className="w-full py-3 bg-white border border-primary/20 rounded-xl text-xs font-bold text-primary hover:bg-primary hover:text-white transition-all shadow-sm"
                 >
                   Kích Hoạt Ngay
                 </button>
              </div>

              <button className="flex items-center gap-3 px-6 py-4 text-red-500 hover:bg-red-50 rounded-2xl font-bold transition-all mt-4">
                 <LogOut size={18} /> Đăng xuất
              </button>
            </div>
          </motion.div>
        </aside>

        {/* Main Content */}
        <div className="lg:col-span-3 space-y-12">
          {/* Stats Bar */}
          <section className="bg-surface-container-low p-10 rounded-[3rem] space-y-8 shadow-sm">
             <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
                <div className="text-center">
                   <p className="text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest mb-1">Cấp độ</p>
                   <p className="text-2xl font-black text-primary">{level}</p>
                </div>
                <div className="text-center">
                   <p className="text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest mb-1">Tổng điểm (XP)</p>
                   <p className="text-2xl font-black text-on-surface">{xp.toLocaleString()}</p>
                </div>
                <div className="text-center">
                   <p className="text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest mb-1">Chuỗi (Streak)</p>
                   <div className="flex items-center justify-center gap-1 text-orange-500">
                     <Flame size={18} fill="currentColor" />
                     <p className="text-2xl font-black text-on-surface">12</p>
                   </div>
                </div>
                <div className="text-center">
                   <p className="text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest mb-1">Huy hiệu</p>
                   <p className="text-2xl font-black text-on-surface">8</p>
                </div>
             </div>
             
             <div className="space-y-2">
                <div className="flex justify-between items-end text-[10px] font-black uppercase tracking-widest text-on-surface-variant/40">
                   <span>Tiến độ cấp độ {level}</span>
                   <span>{xp % 200} / 200 XP để lên cấp {level + 1}</span>
                </div>
                <div className="h-3 bg-white rounded-full overflow-hidden shadow-inner p-0.5">
                   <motion.div 
                     initial={{ width: 0 }}
                     animate={{ width: `${levelProgress}%` }}
                     className="h-full bg-primary rounded-full shadow-lg shadow-primary/20"
                   />
                </div>
             </div>
          </section>

          {/* Goals and Badges Area */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
             <section className="bg-white p-10 rounded-[3rem] shadow-sm border border-primary/5">
                <h3 className="text-xl font-bold mb-8 flex items-center justify-between">
                   Mục tiêu đang thực hiện
                   <Target className="text-primary" />
                </h3>
                <div className="space-y-10">
                   {activeGoals.map((goal: any) => (
                     <div key={goal.id} className="group">
                        <div className="flex justify-between items-start mb-4">
                           <div>
                              <p className="font-bold text-on-surface group-hover:text-primary transition-colors">{goal.title}</p>
                              <p className="text-[10px] text-on-surface-variant/40 font-bold uppercase tracking-tighter italic">{goal.cat}</p>
                           </div>
                           <span className="text-xs font-black text-primary">{goal.progress}%</span>
                        </div>
                        <div className="h-2 bg-surface-container rounded-full overflow-hidden">
                           <motion.div 
                             initial={{ width: 0 }}
                             animate={{ width: `${goal.progress}%` }}
                             className={cn("h-full", goal.progress === 100 ? 'bg-emerald-500' : 'bg-primary')} 
                           />
                        </div>
                        {goal.progress === 100 && (
                          <div className="mt-4 flex items-center gap-2 text-[10px] font-black text-emerald-600 uppercase tracking-widest">
                            <CheckCircle2 size={14} /> Mục tiêu đã hoàn tất
                          </div>
                        )}
                     </div>
                   ))}
                </div>
                <button 
                  onClick={() => navigate('/goals')}
                  className="w-full mt-10 py-5 border-2 border-dashed border-surface-container rounded-3xl text-on-surface-variant font-black text-xs uppercase tracking-widest hover:border-primary hover:text-primary transition-all group"
                >
                   <span className="group-hover:scale-110 inline-block transition-transform">+ Thêm mục tiêu mới</span>
                </button>
             </section>

             <section className="bg-white p-10 rounded-[3rem] shadow-sm border border-primary/5">
                <h3 className="text-xl font-bold mb-8 flex items-center justify-between">
                   Huy hiệu đã đạt
                   <Award className="text-primary" />
                </h3>
                <div className="grid grid-cols-3 gap-6">
                   {USER_BADGES.map((badge) => (
                     <div key={badge.id} className="flex flex-col items-center text-center group">
                        <div className="w-20 h-20 rounded-[2rem] bg-surface-container-low flex items-center justify-center text-3xl group-hover:scale-110 transition-transform cursor-pointer shadow-sm">
                           {badge.icon}
                        </div>
                        <span className="text-[10px] font-black mt-3 leading-tight uppercase tracking-tighter opacity-60">{badge.name}</span>
                        <span className="text-[8px] font-bold text-on-surface-variant/30 mt-1">{badge.date}</span>
                     </div>
                   ))}
                </div>
                <div className="mt-12 p-6 bg-emerald-50 border border-emerald-100 rounded-[2rem]">
                   <h4 className="text-[10px] font-black text-emerald-700 uppercase tracking-widest mb-2">Thử thách tiếp theo</h4>
                   <p className="text-xs text-emerald-600 font-bold mb-4 italic">Hoàn thành 10 check-in "Tiết kiệm nước" để nhận huy hiệu "Bậc Thầy Tiết Kiệm".</p>
                   <div className="h-1.5 bg-white rounded-full overflow-hidden">
                      <div className="h-full bg-emerald-500 w-[60%]" />
                   </div>
                </div>
             </section>
          </div>

          {/* Activity Logs */}
          <section className="bg-white p-10 rounded-[3rem] shadow-sm border border-primary/5">
             <h3 className="text-xl font-bold mb-10 italic">Nhật ký hoạt động</h3>
             <div className="space-y-8">
               <AnimatePresence mode="popLayout">
                 {logs.map((activity: any) => (
                   <motion.div 
                     layout
                     initial={{ opacity: 0, x: -10 }}
                     animate={{ opacity: 1, x: 0 }}
                     key={activity.id} 
                     className="flex items-center justify-between group"
                   >
                      <div className="flex items-center gap-6">
                         <div className="w-1.5 h-1.5 rounded-full bg-primary/20 group-hover:bg-primary transition-colors" />
                         <div>
                            <p className="font-bold text-on-surface group-hover:text-primary transition-colors">{activity.action}</p>
                            <p className="text-[10px] text-on-surface-variant/40 font-bold uppercase italic tracking-tighter">{activity.time}</p>
                         </div>
                      </div>
                      <span className="font-black text-primary tracking-tighter bg-primary/5 px-4 py-1.5 rounded-full">{activity.points}</span>
                   </motion.div>
                 ))}
               </AnimatePresence>
             </div>
          </section>
        </div>
      </div>
    </div>
  );
}
