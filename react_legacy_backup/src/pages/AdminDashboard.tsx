import React, { useState } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { 
  FileText, Download, X, Search, Check, Users, Target, Activity, 
  ChevronRight, Calendar, Globe, Layers, BarChart3, TrendingUp, ArrowUpRight,
  Eye, Info
} from 'lucide-react';
import { cn } from '../lib/utils';

// --- MOCK DATA ---
const STATS = [
  { label: 'Tổng Người Dùng', value: '5,248', change: '+124 tuần này', icon: <Users />, color: 'text-blue-500', bg: 'bg-blue-50' },
  { label: 'Mục Tiêu Đang Hoạt Động', value: '1,248', change: '4 loại danh mục', icon: <Target />, color: 'text-orange-500', bg: 'bg-orange-50' },
  { label: 'Mục Tiêu Hoàn Thành', value: '10,842', change: '87% tỷ lệ hoàn thành', icon: <Activity />, color: 'text-emerald-500', bg: 'bg-emerald-50' },
  { label: 'CO₂ Đã Giảm (tấn)', value: '24.1', change: 'Tháng này', icon: <BarChart3 />, color: 'text-teal-500', bg: 'bg-teal-50' },
];

const CATEGORY_STATS = [
  { name: 'Tiết kiệm điện', count: '1,842 mục tiêu', percentage: 88, color: 'bg-yellow-500' },
  { name: 'Tiết kiệm nước', count: '1,560 mục tiêu', percentage: 75, color: 'bg-blue-500' },
  { name: 'Giảm rác nhựa', count: '1,920 mục tiêu', percentage: 92, color: 'bg-emerald-500' },
  { name: 'Giao thông xanh', count: '980 mục tiêu', percentage: 60, color: 'bg-purple-500' },
  { name: 'Ăn uống xanh', count: '740 mục tiêu', percentage: 55, color: 'bg-emerald-400' },
  { name: 'Phân loại rác', count: '620 mục tiêu', percentage: 48, color: 'bg-orange-500' },
];

const RECENT_ACTIVITIES = [
  { user: 'Trần Thị Lan', action: 'Hoàn thành mục tiêu Tiết kiệm điện', time: '5 phút trước', icon: <Check className="text-emerald-500" />, bg: 'bg-emerald-50' },
  { user: 'Lê Văn Hùng', action: 'Đăng ký tài khoản mới', time: '12 phút trước', icon: <PlusAdmin className="text-orange-500" />, bg: 'bg-orange-50' },
  { user: 'Phạm Thu Hà', action: 'Check-in mục tiêu Giảm rác nhựa', time: '28 phút trước', icon: <Check className="text-emerald-500" />, bg: 'bg-emerald-50' },
  { user: 'Hoàng Đức Minh', action: 'Đạt huy hiệu Chiến Binh Xanh', time: '1 giờ trước', icon: <Activity className="text-yellow-500" />, bg: 'bg-yellow-50' },
];

function PlusAdmin({ className }: { className?: string }) {
  return <div className={cn("w-5 h-5 flex items-center justify-center", className)}>+</div>;
}

const TOP_USERS = [
  { id: 1, name: 'Trần Thị Lan', job: 'Giáo viên', location: 'Hà Nội', points: '2,150', streak: '28 ngày', avatar: 'https://picsum.photos/seed/user1/100' },
  { id: 2, name: 'Lê Văn Hùng', job: 'Kỹ sư phần mềm', location: 'TP. HCM', points: '1,890', streak: '21 ngày', avatar: 'https://picsum.photos/seed/user2/100' },
  { id: 3, name: 'Nguyễn Minh Khoa', job: 'Kỹ sư Môi trường', location: 'TP. HCM', points: '1,240', streak: '14 ngày', avatar: 'https://picsum.photos/seed/user3/100' },
  { id: 4, name: 'Phạm Thu Hà', job: 'Chủ tiệm cà phê', location: 'Đà Nẵng', points: '1,180', streak: '10 ngày', avatar: 'https://picsum.photos/seed/user4/100' },
  { id: 5, name: 'Hoàng Đức Minh', job: 'Lập trình viên', location: 'Hà Nội', points: '980', streak: '7 ngày', avatar: 'https://picsum.photos/seed/user5/100' },
];

// --- EXPORT MODAL COMPONENT ---
function ExportModal({ isOpen, onClose }: { isOpen: boolean, onClose: () => void }) {
  const [activeScope, setActiveScope] = useState('Tất cả');
  const [activeTab, setActiveTab] = useState('Tổng quan');

  const scopes = [
    { name: 'Tất cả', icon: <Layers size={14} /> },
    { name: 'Danh mục', icon: <Activity size={14} /> },
    { name: 'Người dùng', icon: <Users size={14} /> },
    { name: 'Thống kê tuần', icon: <Calendar size={14} /> },
    { name: 'Thống kê tháng', icon: <BarChart3 size={14} /> },
    { name: 'Cộng đồng', icon: <Globe size={14} /> },
  ];

  return (
    <AnimatePresence>
      {isOpen && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm">
          <motion.div 
            initial={{ opacity: 0, scale: 0.95, y: 20 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.95, y: 20 }}
            className="bg-white w-full max-w-2xl rounded-[2.5rem] shadow-2xl overflow-hidden flex flex-col"
          >
            {/* Header */}
            <div className="p-8 pb-4 flex justify-between items-start">
               <div className="flex gap-4 items-center">
                  <div className="w-12 h-12 bg-[#f0fdf4] text-[#10a352] rounded-2xl flex items-center justify-center shadow-sm">
                    <FileText size={24} />
                  </div>
                  <div>
                    <h2 className="text-xl font-black text-gray-900 tracking-tight">Xuất Báo Cáo Admin</h2>
                    <p className="text-gray-400 font-bold text-[10px] uppercase tracking-widest mt-1">
                      Kỳ: tháng 4 năm 2026 — Xuất lúc 20:16:48 19/4/2026
                    </p>
                  </div>
               </div>
               <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-full text-gray-400 transition-colors">
                 <X size={20} />
               </button>
            </div>

            {/* Content Body */}
            <div className="p-10 pt-4 space-y-10 overflow-y-auto max-h-[70vh] scrollbar-hide">
               {/* Data Scope Section */}
               <div className="space-y-4">
                  <h3 className="text-[10px] font-black uppercase text-gray-400 tracking-widest flex items-center gap-2">
                    <Layers size={12} /> PHẠM VI DỮ LIỆU
                  </h3>
                  <div className="flex flex-wrap gap-2">
                    {scopes.map(s => (
                      <button 
                        key={s.name}
                        onClick={() => setActiveScope(s.name)}
                        className={cn(
                          "flex items-center gap-2 px-6 py-3 rounded-xl text-[11px] font-black uppercase tracking-widest transition-all border-2",
                          activeScope === s.name 
                            ? "bg-[#10a352] text-white border-[#10a352] shadow-lg shadow-emerald-600/20" 
                            : "bg-white text-gray-400 border-gray-100 hover:border-gray-200"
                        )}
                      >
                        {s.icon} {s.name}
                      </button>
                    ))}
                  </div>
                  <p className="text-[11px] text-gray-400 font-bold">
                    Ước tính <span className="font-black text-gray-700">48</span> dòng dữ liệu sẽ được xuất
                  </p>
               </div>

               {/* Preview Section */}
               <div className="space-y-4">
                  <h3 className="text-[10px] font-black uppercase text-gray-400 tracking-widest flex items-center gap-2">
                    <Eye size={12} /> XEM TRƯỚC NỘI DUNG
                  </h3>
                  
                  <div className="bg-gray-50/50 rounded-[2rem] border border-gray-100 overflow-hidden shadow-sm">
                     {/* Preview Tabs */}
                     <div className="flex bg-white px-2 border-b border-gray-100 gap-2">
                        {['Tổng quan', 'Người dùng', 'Thống kê'].map(tab => (
                          <button 
                            key={tab}
                            onClick={() => setActiveTab(tab)}
                            className={cn(
                              "px-8 py-4 text-[10px] font-black uppercase tracking-widest transition-all relative",
                              activeTab === tab ? "text-[#10a352]" : "text-gray-400 hover:text-gray-600"
                            )}
                          >
                            {tab}
                            {activeTab === tab && (
                              <motion.div layoutId="admin-export-tab" className="absolute bottom-0 left-0 w-full h-1 bg-[#10a352] rounded-full" />
                            )}
                          </button>
                        ))}
                     </div>

                     {/* Inner Preview Content */}
                     <div className="p-8 space-y-6">
                        {/* Preview Banner */}
                        <div className="bg-[#f0fdf4] border border-[#dcfce7] rounded-xl px-6 py-3 flex items-center gap-3">
                           <Info size={14} className="text-[#10a352]" />
                           <span className="text-[10px] font-bold text-gray-600 uppercase tracking-widest">
                             Phạm vi: <span className="text-[#10a352]">{activeScope}</span> — Định dạng: <span className="text-[#10a352]">CSV</span>
                           </span>
                        </div>

                        {/* Preview Grid */}
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                           {STATS.map(s => (
                             <div key={s.label} className="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm group hover:border-[#10a352]/20 transition-all">
                                <p className="text-[9px] font-black text-gray-300 uppercase tracking-widest mb-3">{s.label}</p>
                                <div className="flex items-baseline gap-2">
                                  <span className="text-xl font-black text-gray-900">{s.value}</span>
                                  {s.change && <span className="text-[9px] font-bold text-emerald-500 uppercase">{s.change}</span>}
                                </div>
                             </div>
                           ))}
                        </div>
                     </div>
                  </div>
               </div>
            </div>

            {/* Footer */}
            <div className="p-8 bg-gray-50/50 border-t border-gray-100 flex flex-col md:flex-row items-center justify-between gap-6">
               <div className="flex items-center gap-3 text-[11px] font-bold text-gray-400">
                  <FileText size={16} className="text-gray-300" />
                  File: GreenLife_Admin_BaoCao_2026-04-19.csv
               </div>
               <div className="flex gap-4 w-full md:w-auto">
                  <button 
                    onClick={onClose} 
                    className="flex-1 md:flex-none px-10 py-4 bg-white border border-gray-200 text-gray-400 font-bold text-sm rounded-2xl hover:bg-gray-100 transition-all active:scale-95 shadow-sm"
                  >
                    Hủy
                  </button>
                  <button className="flex-1 md:flex-none px-10 py-4 bg-[#10a352] text-white font-black text-sm rounded-2xl hover:bg-[#0d8a45] shadow-lg shadow-emerald-600/20 transition-all flex items-center justify-center gap-3 active:scale-95">
                    <Download size={20} /> Tải xuống CSV
                  </button>
               </div>
            </div>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  );
}

// --- MAIN DASHBOARD PAGE ---
export default function AdminDashboard() {
  const [isExportModalOpen, setIsExportModalOpen] = useState(false);

  return (
    <div className="space-y-12">
      <header className="flex justify-between items-end">
        <div>
          <h1 className="text-4xl font-black text-primary-dark tracking-tighter mb-2 italic">Tổng Quan Hệ Thống</h1>
          <p className="text-on-surface-variant font-medium italic text-sm">Cập nhật lần cuối: hôm nay, 08:30</p>
        </div>
        <button 
          onClick={() => setIsExportModalOpen(true)}
          className="px-8 py-4 bg-primary text-white font-black rounded-2xl hover:bg-primary-dark transition-all shadow-xl shadow-primary/20 flex items-center gap-3"
        >
          <FileText size={20} /> Xuất Báo Cáo
        </button>
      </header>

      {/* Stats Cards */}
      <section className="grid grid-cols-1 md:grid-cols-4 gap-8">
        {STATS.map(s => (
          <div key={s.label} className="bg-white p-8 rounded-[3rem] border border-primary/5 shadow-sm hover:shadow-xl hover:shadow-primary/5 transition-all">
             <div className={cn("w-12 h-12 rounded-2xl mb-6 flex items-center justify-center", s.bg, s.color)}>
                {React.cloneElement(s.icon as React.ReactElement, { size: 24 })}
             </div>
             <p className="text-4xl font-black text-on-surface mb-2">{s.value}</p>
             <p className="text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest leading-tight mb-2">{s.label}</p>
             <p className={cn("text-xs font-bold", s.color)}>{s.change}</p>
          </div>
        ))}
      </section>

      {/* Charts Section Placeholder */}
      <section className="bg-white p-12 rounded-[3.5rem] border border-primary/5 shadow-sm">
         <div className="flex justify-between items-start mb-12">
            <div>
               <h3 className="text-2xl font-black text-primary-dark italic">Biểu Đồ Thống Kê Người Dùng</h3>
               <p className="text-on-surface-variant font-medium text-sm">Theo dõi xu hướng tăng trưởng hệ thống</p>
            </div>
            <div className="flex gap-2 bg-surface-container p-1 rounded-2xl">
               {['Người dùng mới', 'Lượt check-in', 'Điểm xanh'].map(tab => (
                 <button key={tab} className={cn("px-6 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all", tab === 'Người dùng mới' ? 'bg-primary text-white' : 'text-on-surface-variant hover:text-primary')}>
                   {tab}
                 </button>
               ))}
            </div>
         </div>

         <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-12">
            {[
              { label: 'Tổng cộng', val: '194', icon: <Users size={14} />, color: 'text-emerald-500' },
              { label: 'Trung bình / kỳ', val: '28', icon: <TrendingUp size={14} />, color: 'text-blue-500' },
              { label: 'Cao nhất (T7)', val: '42', icon: <ArrowUpRight size={14} />, color: 'text-orange-500' },
            ].map(item => (
              <div key={item.label} className="bg-surface-container-low p-6 rounded-3xl border border-surface-container">
                 <div className="flex items-center gap-2 text-on-surface-variant/40 mb-2">
                    {item.icon}
                    <span className="text-[10px] font-black uppercase tracking-widest">{item.label}</span>
                 </div>
                 <p className="text-2xl font-black text-on-surface">{item.val}</p>
              </div>
            ))}
         </div>

         {/* Mock Graph */}
         <div className="h-80 relative flex items-end justify-between px-12 group">
            <svg className="absolute inset-0 w-full h-full p-4 overflow-visible" viewBox="0 0 1000 300" preserveAspectRatio="none">
               <path 
                 d="M 0 150 Q 80 140 160 170 T 320 180 T 480 230 T 640 140 T 800 120 T 1000 140" 
                 fill="none" 
                 stroke="var(--color-primary)" 
                 strokeWidth="4" 
                 className="drop-shadow-xl"
               />
               <path 
                 d="M 0 150 Q 80 140 160 170 T 320 180 T 480 230 T 640 140 T 800 120 T 1000 140 L 1000 300 L 0 300 Z" 
                 fill="url(#gradient)" 
                 className="opacity-10" 
               />
               <defs>
                 <linearGradient id="gradient" x1="0" y1="0" x2="0" y2="1">
                   <stop offset="0%" stopColor="var(--color-primary)" />
                   <stop offset="100%" stopColor="transparent" />
                 </linearGradient>
               </defs>
            </svg>
            {['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'].map((day, i) => (
              <div key={day} className="relative z-10 flex flex-col items-center gap-8">
                 <div className="w-1.5 h-1.5 bg-primary rounded-full group-hover:scale-150 transition-transform shadow-xl shadow-primary/40"></div>
                 <span className="text-[10px] font-black text-on-surface-variant/40">{day}</span>
              </div>
            ))}
         </div>
      </section>

      {/* Bottom Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
         {/* Category Stats */}
         <section className="bg-white p-12 rounded-[3.5rem] border border-primary/5 shadow-sm">
            <h3 className="text-2xl font-black text-primary-dark italic mb-10">Thống Kê Theo Danh Mục</h3>
            <div className="space-y-8">
               {CATEGORY_STATS.map(cat => (
                 <div key={cat.name}>
                    <div className="flex justify-between items-end mb-3">
                       <div>
                          <p className="font-bold text-on-surface">{cat.name}</p>
                          <p className="text-[10px] text-on-surface-variant/40 font-bold italic">{cat.count}</p>
                       </div>
                       <span className="text-sm font-black text-primary">{cat.percentage}%</span>
                    </div>
                    <div className="h-2 bg-surface-container rounded-full overflow-hidden">
                       <motion.div 
                         initial={{ width: 0 }}
                         animate={{ width: `${cat.percentage}%` }}
                         className={cn("h-full", cat.color)} 
                       />
                    </div>
                 </div>
               ))}
            </div>
         </section>

         {/* Recent Activity */}
         <section className="bg-white p-12 rounded-[3.5rem] border border-primary/5 shadow-sm">
            <h3 className="text-2xl font-black text-primary-dark italic mb-10">Hoạt Động Gần Đây</h3>
            <div className="space-y-10">
               {RECENT_ACTIVITIES.map((act, i) => (
                 <div key={i} className="flex gap-6 items-start group">
                    <div className={cn("w-12 h-12 rounded-2xl flex items-center justify-center shrink-0 shadow-sm transition-transform group-hover:scale-110", act.bg)}>
                       {act.icon}
                    </div>
                    <div className="flex-1">
                       <p className="font-bold text-on-surface group-hover:text-primary transition-colors">{act.user}</p>
                       <p className="text-sm text-on-surface-variant/60 font-medium mb-1">{act.action}</p>
                       <p className="text-[10px] font-bold text-on-surface-variant/30 italic uppercase tracking-tighter">{act.time}</p>
                    </div>
                    <ChevronRight size={20} className="text-on-surface-variant/20 mt-1" />
                 </div>
               ))}
            </div>
         </section>
      </div>

      {/* Top Active Users */}
      <section className="bg-white p-12 rounded-[3.5rem] border border-primary/5 shadow-sm">
         <h3 className="text-2xl font-black text-primary-dark italic mb-10">Top Người Dùng Tích Cực</h3>
         <div className="overflow-x-auto">
            <table className="w-full">
               <thead>
                  <tr className="border-b border-surface-container">
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">#</th>
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Người Dùng</th>
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Nghề Nghiệp</th>
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Địa Điểm</th>
                     <th className="text-right py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Điểm Xanh</th>
                     <th className="text-right py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Streak</th>
                  </tr>
               </thead>
               <tbody>
                  {TOP_USERS.map((user, i) => (
                    <tr key={user.id} className="border-b border-surface-container/50 hover:bg-surface-container-low transition-colors group">
                       <td className="py-6 px-4 font-black text-emerald-600">{i + 1}</td>
                       <td className="py-6 px-4">
                          <div className="flex items-center gap-4">
                             <div className="w-10 h-10 rounded-xl overflow-hidden shadow-sm">
                                <img src={user.avatar} alt={user.name} className="w-full h-full object-cover" />
                             </div>
                             <span className="font-bold text-on-surface group-hover:text-primary transition-all">{user.name}</span>
                          </div>
                       </td>
                       <td className="py-6 px-4 text-sm text-on-surface-variant font-medium">{user.job}</td>
                       <td className="py-6 px-4 text-sm text-on-surface-variant font-medium flex items-center gap-2">
                          <Globe size={14} className="opacity-30" /> {user.location}
                       </td>
                       <td className="py-6 px-4 text-right font-black text-primary">{user.points}</td>
                       <td className="py-6 px-4 text-right">
                          <span className="px-4 py-1.5 bg-orange-50 text-orange-600 text-[10px] font-black rounded-full italic tracking-tighter ring-1 ring-orange-100">
                             🔥 {user.streak}
                          </span>
                       </td>
                    </tr>
                  ))}
               </tbody>
            </table>
         </div>
      </section>

      <ExportModal isOpen={isExportModalOpen} onClose={() => setIsExportModalOpen(false)} />
    </div>
  );
}
