import React, { useState } from 'react';
import { motion } from 'motion/react';
import { 
  Plus, Search, Clock, Check, Zap, Droplets, Trash2, Bike, Heart, 
  ChevronRight, Target, Activity, MoreVertical, Layout
} from 'lucide-react';
import { cn } from '../lib/utils';

const CATEGORIES = [
  { name: 'Tất cả danh mục', icon: null },
  { name: 'Tiết kiệm điện', icon: <Zap size={14} /> },
  { name: 'Tiết kiệm nước', icon: <Droplets size={14} /> },
  { name: 'Giảm rác nhựa', icon: <Trash2 size={14} /> },
  { name: 'Giao thông xanh', icon: <Bike size={14} /> },
  { name: 'Ăn uống xanh', icon: <Heart size={14} /> },
  { name: 'Phân loại rác', icon: <Layout size={14} /> },
];

const GOALS_DATA = [
  { id: 1, title: 'Tiết kiệm điện mỗi ngày', desc: 'Tắt đèn và thiết bị điện khi không sử dụng, hạn chế dùng...', cat: 'Tiết kiệm điện', progress: '22/30 ngày', date: '2024-03-01 → 2024-03-31', status: 'Đang HĐ', icon: <Zap className="text-yellow-500" />, pVal: 22/30*100 },
  { id: 2, title: 'Giảm rác thải nhựa', desc: 'Mang túi vải, từ chối ống hút nhựa, dùng bình nước cá nhân...', cat: 'Giảm rác nhựa', progress: '28/30 ngày', date: '2024-03-01 → 2024-03-31', status: 'Đang HĐ', icon: <Activity className="text-emerald-500" />, pVal: 28/30*100 },
  { id: 3, title: 'Tiết kiệm nước', desc: 'Tắm nhanh dưới 5 phút, khóa vòi khi đánh răng...', cat: 'Tiết kiệm nước', progress: '18/30 ngày', date: '2024-03-01 → 2024-03-31', status: 'Đang HĐ', icon: <Droplets className="text-blue-500" />, pVal: 18/30*100 },
  { id: 4, title: 'Đi xe đạp đi làm', desc: 'Thay thế xe máy bằng xe đạp hoặc đi bộ khi có thể...', cat: 'Giao thông xanh', progress: '20/20 ngày', date: '2024-02-01 → 2024-02-28', status: 'Hoàn thành', icon: <Bike className="text-purple-500" />, pVal: 100 },
  { id: 5, title: 'Ăn chay 2 ngày/tuần', desc: 'Giảm tiêu thụ thịt, tăng cường rau củ quả trong bữa ăn...', cat: 'Ăn uống xanh', progress: '5/8 ngày', date: '2024-03-01 → 2024-03-31', status: 'Đang HĐ', icon: <Heart className="text-emerald-400" />, pVal: 5/8*100 },
  { id: 6, title: 'Phân loại rác tại nhà', desc: 'Phân loại rác hữu cơ, vô cơ và tái chế đúng cách...', cat: 'Phân loại rác', progress: '12/30 ngày', date: '2024-03-10 → 2024-04-10', status: 'Đang HĐ', icon: <Trash2 className="text-orange-500" />, pVal: 12/30*100 },
  { id: 7, title: 'Đi xe đạp đi làm', desc: 'Thay thế máy bằng xe đạp...', cat: 'Giao thông xanh', progress: '15/20 ngày', date: '2024-03-01 → 2024-03-31', status: 'Đang HĐ', icon: <Bike className="text-purple-400" />, pVal: 15/20*100 },
  { id: 8, title: 'Tắt đèn khi ra ngoài', desc: 'Tiết kiệm điện mỗi ngày...', cat: 'Tiết kiệm điện', progress: '30/30 ngày', date: '2024-02-01 → 2024-02-28', status: 'Hoàn thành', icon: <Zap className="text-yellow-500" />, pVal: 100 },
  { id: 9, title: 'Mang túi vải đi chợ', desc: 'Không dùng túi nilon...', cat: 'Giảm rác nhựa', progress: '8/15 lần', date: '2024-03-10 → 2024-04-10', status: 'Đang HĐ', icon: <Activity className="text-emerald-500" />, pVal: 8/15*100 },
];

export default function AdminGoals() {
  const [activeTab, setActiveTab] = useState('Tất cả');
  const [activeCat, setActiveCat] = useState('Tất cả danh mục');
  const [searchQuery, setSearchQuery] = useState('');

  const filteredGoals = GOALS_DATA.filter(goal => {
    const matchesSearch = goal.title.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesTab = activeTab === 'Tất cả' || (activeTab === 'Đang HĐ' && goal.status === 'Đang HĐ') || (activeTab === 'Hoàn thành' && goal.status === 'Hoàn thành');
    const matchesCat = activeCat === 'Tất cả danh mục' || goal.cat === activeCat;
    return matchesSearch && matchesTab && matchesCat;
  });

  return (
    <div className="space-y-12">
      <header>
        <h1 className="text-4xl font-black text-primary-dark tracking-tighter mb-2 italic">Quản Lý Mục Tiêu</h1>
        <p className="text-on-surface-variant font-medium italic text-sm">Tổng cộng 9 mục tiêu trong hệ thống</p>
      </header>

      {/* Summary Cards */}
      <section className="grid grid-cols-1 md:grid-cols-4 gap-8">
         {[
           { label: 'Tổng Mục Tiêu', val: '9', icon: <Target />, color: 'text-primary' },
           { label: 'Đang Hoạt Động', val: '7', icon: <Clock />, color: 'text-orange-500' },
           { label: 'Đã Hoàn Thành', val: '2', icon: <Check />, color: 'text-emerald-500' },
           { label: 'Tiến Độ TB', val: '73%', icon: <BarChartSmall />, color: 'text-blue-500' },
         ].map(item => (
           <div key={item.label} className="bg-white p-8 rounded-3xl border border-primary/5 shadow-sm">
              <div className="flex justify-between items-start mb-4">
                 <div className={cn("w-10 h-10 rounded-xl flex items-center justify-center bg-surface-container", item.color)}>
                    {React.cloneElement(item.icon as React.ReactElement, { size: 18 })}
                 </div>
              </div>
              <p className="text-2xl font-black text-on-surface">{item.val}</p>
              <p className="text-[10px] font-bold text-on-surface-variant/40 uppercase tracking-widest">{item.label}</p>
           </div>
         ))}
      </section>

      <section className="bg-white p-12 rounded-[3.5rem] border border-primary/5 shadow-sm">
         <div className="space-y-8 mb-12">
            <div className="flex flex-col md:flex-row justify-between items-center gap-8">
               <div className="relative w-full md:max-w-xs">
                  <Search className="absolute left-6 top-1/2 -translate-y-1/2 text-on-surface-variant/40" size={16} />
                  <input 
                    type="text"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    placeholder="Tìm mục tiêu..."
                    className="w-full bg-surface-container border-none rounded-2xl py-3 px-12 text-sm outline-none"
                  />
               </div>
               <div className="flex gap-2 bg-surface-container p-1 rounded-2xl">
                 {['Tất cả', 'Đang HĐ', 'Hoàn thành'].map(tab => (
                   <button 
                     key={tab}
                     onClick={() => setActiveTab(tab)}
                     className={cn(
                       "px-6 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all",
                       activeTab === tab ? 'bg-white shadow-lg text-primary' : 'text-on-surface-variant hover:text-primary'
                     )}
                   >
                     {tab}
                   </button>
                 ))}
               </div>
            </div>

            <div className="flex flex-wrap gap-2">
               {CATEGORIES.map((cat) => (
                 <button 
                  key={cat.name}
                  onClick={() => setActiveCat(cat.name)}
                  className={cn(
                    "flex items-center gap-2 px-6 py-2 rounded-full text-[10px] font-black uppercase tracking-widest transition-all ring-1",
                    activeCat === cat.name 
                      ? "bg-primary text-white ring-primary shadow-lg shadow-primary/20" 
                      : "bg-white text-on-surface-variant ring-surface-container hover:bg-surface-container/50 hover:ring-primary/20"
                  )}
                 >
                   {cat.icon}
                   {cat.name}
                 </button>
               ))}
            </div>
         </div>

         <div className="overflow-x-auto">
            <table className="w-full">
               <thead>
                  <tr className="border-b border-surface-container">
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Mục Tiêu</th>
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Danh Mục</th>
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Tiến Độ</th>
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Thời Gian</th>
                     <th className="text-right py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Trạng Thái</th>
                  </tr>
               </thead>
               <tbody>
                  {filteredGoals.map((goal) => (
                    <tr key={goal.id} className="border-b border-surface-container/30 hover:bg-surface-container-low transition-colors group">
                       <td className="py-8 px-4">
                          <div className="flex items-center gap-4">
                             <div className="w-10 h-10 rounded-xl bg-surface-container flex items-center justify-center shrink-0">
                                {goal.icon}
                             </div>
                             <div>
                                <p className="font-bold text-on-surface group-hover:text-primary transition-colors">{goal.title}</p>
                                <p className="text-[10px] text-on-surface-variant/40 font-medium italic">{goal.desc}</p>
                             </div>
                          </div>
                       </td>
                       <td className="py-8 px-4">
                          <span className={cn(
                            "px-4 py-1.5 text-[10px] font-black rounded-full italic ring-1",
                            goal.cat === 'Tiết kiệm điện' ? "bg-yellow-50 text-yellow-600 ring-yellow-100" :
                            goal.cat === 'Tiết kiệm nước' ? "bg-blue-50 text-blue-600 ring-blue-100" :
                            goal.cat === 'Giảm rác nhựa' ? "bg-emerald-50 text-emerald-600 ring-emerald-100" :
                            goal.cat === 'Giao thông xanh' ? "bg-purple-50 text-purple-600 ring-purple-100" :
                            goal.cat === 'Ăn uống xanh' ? "bg-emerald-50 text-emerald-500 ring-emerald-100" :
                            "bg-orange-50 text-orange-600 ring-orange-100"
                          )}>
                             {goal.cat}
                          </span>
                       </td>
                       <td className="py-8 px-4 min-w-[200px]">
                          <div className="flex items-center justify-between gap-4 mb-2">
                             <div className="h-1.5 flex-1 bg-surface-container rounded-full overflow-hidden">
                                <motion.div 
                                  initial={{ width: 0 }}
                                  animate={{ width: `${goal.pVal}%` }}
                                  className={cn("h-full", 
                                    goal.cat === 'Tiết kiệm điện' ? "bg-yellow-500" :
                                    goal.cat === 'Tiết kiệm nước' ? "bg-blue-500" :
                                    goal.cat === 'Giảm rác nhựa' ? "bg-emerald-500" :
                                    goal.cat === 'Giao thông xanh' ? "bg-purple-500" :
                                    goal.cat === 'Ăn uống xanh' ? "bg-emerald-400" :
                                    "bg-orange-500"
                                  )}
                                />
                             </div>
                             <span className="text-[10px] font-black text-on-surface shrink-0">{goal.progress}</span>
                          </div>
                       </td>
                       <td className="py-8 px-4 text-[10px] font-bold text-on-surface-variant font-mono">
                          {goal.date}
                       </td>
                       <td className="py-8 px-4 text-right">
                          <span className={cn(
                            "px-4 py-1.5 text-[10px] font-black rounded-full italic ring-1 inline-flex items-center gap-1",
                            goal.status === 'Đang HĐ' ? "bg-orange-50 text-orange-600 ring-orange-100" : "bg-emerald-50 text-emerald-600 ring-emerald-100"
                          )}>
                             &bull; {goal.status}
                          </span>
                       </td>
                    </tr>
                  ))}
               </tbody>
            </table>
         </div>
      </section>
    </div>
  );
}

function BarChartSmall() {
  return (
    <div className="flex items-end gap-0.5 w-4 h-4">
      <div className="w-1 bg-current h-1/2 rounded-full"></div>
      <div className="w-1 bg-current h-full rounded-full"></div>
      <div className="w-1 bg-current h-3/4 rounded-full"></div>
    </div>
  );
}
