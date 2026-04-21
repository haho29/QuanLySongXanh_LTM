import { motion, AnimatePresence } from 'motion/react';
import { 
  BarChart3, TrendingUp, Calendar, Leaf, Droplets, Zap, Trash2, 
  Bike, Heart, Clock, Award, FileText, ChevronLeft, ChevronRight,
  Instagram, Facebook, Twitter, Youtube, Mail, Phone, MapPin, CheckCircle2, ChevronDown, 
  X, Download, FileSpreadsheet, Code, Info
} from 'lucide-react';
import { useState } from 'react';
import { cn } from '../lib/utils';

// Consts from GoalPage for design consistency
const SERIF_FONT = "font-['Playfair_Display',_serif]";

const TOP_STATS = [
  { label: 'Tổng Mục Tiêu', value: '6', icon: <Leaf className="text-emerald-500" />, bg: 'bg-[#f0fdf4]' },
  { label: 'Streak Hiện Tại', value: '14 ngày', icon: <Clock className="text-orange-500" />, bg: 'bg-[#fff7ed]' },
  { label: 'Tổng Check-in', value: '8', icon: <CheckCircle2 className="text-blue-500" />, bg: 'bg-[#eff6ff]' },
  { label: 'Điểm Xanh', value: '1,240', icon: <Award className="text-yellow-600" />, bg: 'bg-[#fffbeb]' },
];

const WEEKLY_BAR_DATA = [
  { day: 'T2', value: 80, active: false },
  { day: 'T3', value: 90, active: true },
  { day: 'T4', value: 70, active: false },
  { day: 'T5', value: 85, active: false },
  { day: 'T6', value: 95, active: false },
  { day: 'T7', value: 100, active: false },
  { day: 'CN', value: 88, active: false },
];

const GOAL_LIST = [
  { id: 1, title: 'Tiết kiệm điện mỗi ngày', progress: 73, current: 22, total: 30, theme: 'orange', icon: <Zap size={14} /> },
  { id: 2, title: 'Giảm rác thải nhựa', progress: 93, current: 28, total: 30, theme: 'emerald', icon: <Leaf size={14} /> },
  { id: 3, title: 'Tiết kiệm nước', progress: 60, current: 18, total: 30, theme: 'blue', icon: <Droplets size={14} /> },
  { id: 4, title: 'Đi xe đạp đi làm', progress: 100, current: 20, total: 20, theme: 'purple', icon: <Bike size={14} /> },
  { id: 5, title: 'Ăn chay 2 ngày/tuần', progress: 63, current: 5, total: 8, theme: 'emerald', icon: <Heart size={14} /> },
  { id: 6, title: 'Phân loại rác tại nhà', progress: 40, current: 12, total: 30, theme: 'orange', icon: <Trash2 size={14} /> },
];

const RECENT_ACTIVITY = [
  { title: 'Tiết kiệm điện mỗi ngày', desc: 'Tắt hết đèn trước khi ra khỏi nhà', points: '+10 điểm', date: '2024-03-18', theme: 'orange', icon: <Zap size={16} /> },
  { title: 'Giảm rác thải nhựa', desc: 'Mang bình nước cá nhân đi làm', points: '+10 điểm', date: '2024-03-18', theme: 'emerald', icon: <Leaf size={16} /> },
  { title: 'Tiết kiệm nước', desc: 'Tắm 4 phút hôm nay', points: '+10 điểm', date: '2024-03-18', theme: 'blue', icon: <Droplets size={16} /> },
  { title: 'Tiết kiệm điện mỗi ngày', desc: 'Không bật điều hòa cả ngày', points: '+10 điểm', date: '2024-03-17', theme: 'orange', icon: <Zap size={16} /> },
  { title: 'Giảm rác thải nhựa', desc: 'Từ chối túi nilon ở siêu thị', points: '+10 điểm', date: '2024-03-17', theme: 'emerald', icon: <Leaf size={16} /> },
  { title: 'Ăn chay 2 ngày/tuần', desc: 'Ăn chay cả ngày, rất ngon!', points: '+15 điểm', date: '2024-03-17', theme: 'emerald', icon: <Heart size={16} /> },
];

export default function ProgressPage() {
  const [showExportModal, setShowExportModal] = useState(false);
  const [exportFormat, setExportFormat] = useState<'CSV' | 'JSON'>('CSV');
  const [previewTab, setPreviewTab] = useState<'overview' | 'goals' | 'history'>('overview');

  const getThemeStyles = (theme: string) => {
    switch(theme) {
      case 'orange': return { bg: 'bg-[#fff7ed]', text: 'text-[#f97316]', bar: 'bg-[#fdd0a2]', activeBar: 'bg-[#f97316]' };
      case 'emerald': return { bg: 'bg-[#f0fdf4]', text: 'text-[#10a352]', bar: '#10a352', activeBar: 'bg-[#10a352]' };
      case 'blue': return { bg: 'bg-[#eff6ff]', text: 'text-[#3b82f6]', bar: 'bg-[#3b82f6]', activeBar: 'bg-[#3b82f6]' };
      case 'purple': return { bg: 'bg-[#f5f3ff]', text: 'text-[#8b5cf6]', bar: 'bg-[#8b5cf6]', activeBar: 'bg-[#8b5cf6]' };
      default: return { bg: 'bg-gray-50', text: 'text-gray-600', bar: 'bg-gray-300', activeBar: 'bg-gray-500' };
    }
  };

  return (
    <div className="bg-[#f8f9fa] min-h-screen relative">
      <div className="pt-32 pb-20 px-6 lg:px-12 max-w-screen-xl mx-auto">
        {/* Header */}
        <header className="flex flex-col md:flex-row md:items-center justify-between gap-8 mb-12">
          <div>
            <h1 className={cn("text-4xl font-black text-[#1a2b3c] mb-2 tracking-tight", SERIF_FONT)}>
              Theo Dõi Tiến Độ
            </h1>
            <p className="text-gray-500 font-medium">
              Xem biểu đồ, streak và thống kê kết quả sống xanh của bạn
            </p>
          </div>

          <button 
            onClick={() => setShowExportModal(true)}
            className="flex items-center gap-2 px-6 py-3 bg-[#10a352] text-white rounded-xl font-bold hover:bg-[#0d8a45] transition-all shadow-lg shadow-green-600/10 active:scale-95"
          >
            <FileText size={18} />
            Xuất Báo Cáo
          </button>
        </header>

        {/* Top Stats Row */}
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
          {TOP_STATS.map((stat, i) => (
            <motion.div 
              key={i}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.1 }}
              className="bg-white p-6 rounded-[2rem] shadow-sm border border-gray-100 flex flex-col items-start gap-4 transition-all hover:shadow-md"
            >
              <div className={cn("w-10 h-10 rounded-xl flex items-center justify-center", stat.bg)}>
                {stat.icon}
              </div>
              <div>
                <h4 className="text-[28px] font-black text-gray-900 leading-none mb-2">{stat.value}</h4>
                <p className="text-[10px] font-bold text-gray-300 uppercase tracking-widest">{stat.label}</p>
              </div>
            </motion.div>
          ))}
        </div>

        {/* Main Charts Row */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-12">
          {/* Circular Progress & Info */}
          <div className="bg-white p-10 rounded-[2.5rem] shadow-sm border border-gray-100 flex flex-col md:flex-row lg:flex-col items-center justify-between gap-8">
            <div className="text-center md:text-left lg:text-center w-full">
              <h3 className="text-lg font-black text-gray-900 mb-8 tracking-tight uppercase tracking-widest text-[10px] text-gray-400">Tổng Tiến Độ</h3>
              <div className="relative w-48 h-48 mx-auto flex items-center justify-center">
                <svg className="w-full h-full -rotate-90">
                  <circle cx="96" cy="96" r="80" className="stroke-gray-100 fill-none" strokeWidth="16" />
                  <circle 
                    cx="96" cy="96" r="80" 
                    className="stroke-[#10a352] fill-none" 
                    strokeWidth="16" 
                    strokeDasharray={2 * Math.PI * 80}
                    strokeDashoffset={2 * Math.PI * 80 * (1 - 0.72)}
                    strokeLinecap="round"
                  />
                </svg>
                <div className="absolute flex flex-col items-center">
                  <span className="text-4xl font-black text-gray-800">72%</span>
                  <span className="text-[10px] font-bold text-gray-400 uppercase">Hoàn thành</span>
                </div>
              </div>
            </div>

            <div className="w-full space-y-4 pt-8 border-t border-gray-100">
               <div className="flex justify-between items-center text-sm">
                  <span className="text-gray-400 font-bold">Đang thực hiện</span>
                  <span className="font-extrabold text-[#10a352]">5</span>
               </div>
               <div className="flex justify-between items-center text-sm">
                  <span className="text-gray-400 font-bold">Hoàn thành</span>
                  <span className="font-extrabold text-[#10a352]">1</span>
               </div>
               <div className="flex justify-between items-center text-sm">
                  <span className="text-gray-400 font-bold">Streak dài nhất</span>
                  <span className="font-extrabold text-orange-500">21 ngày</span>
               </div>
            </div>
          </div>

          {/* Bar Chart Section */}
          <div className="lg:col-span-2 bg-white p-10 rounded-[2.5rem] shadow-sm border border-gray-100">
            <header className="flex justify-between items-start mb-10">
               <div>
                  <h3 className="text-lg font-black text-gray-900 mb-1">Biểu Đồ Tuần</h3>
                  <span className="text-[10px] font-bold text-[#10a352] uppercase tracking-widest">Tuần Này</span>
               </div>
               <div className="flex gap-2 text-gray-300">
                  <button className="p-2 hover:bg-gray-50 rounded-lg transition-all"><ChevronLeft size={18} /></button>
                  <button className="p-2 hover:bg-gray-50 rounded-lg transition-all"><ChevronRight size={18} /></button>
               </div>
            </header>

            <div className="flex gap-3 mb-10 overflow-x-auto pb-2 scrollbar-hide">
               {['Điện', 'Nước', 'Nhựa', 'Giao thông'].map((label, i) => (
                  <button key={i} className={cn(
                    "px-4 py-2 rounded-lg text-[10px] font-black uppercase tracking-widest transition-all",
                    i === 0 ? "bg-[#fff7ed] text-[#f97316]" : "bg-gray-50 text-gray-400"
                  )}>
                    {label}
                  </button>
               ))}
            </div>

            <div className="h-48 flex items-end justify-between px-4">
               {WEEKLY_BAR_DATA.map((item, i) => (
                 <div key={i} className="flex-1 flex flex-col items-center gap-4">
                    <span className="text-[10px] font-black text-gray-300">{item.value}%</span>
                    <motion.div 
                      initial={{ height: 0 }}
                      animate={{ height: `${item.value}%` }}
                      className={cn("w-full max-w-[54px] rounded-t-lg transition-all", item.active ? "bg-[#f59e0b]" : "bg-[#fcd34d]/60")}
                    />
                    <span className="text-[10px] font-black text-gray-400 uppercase">{item.day}</span>
                 </div>
               ))}
            </div>
          </div>
        </div>

        {/* Streak & Calendar Row */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-16">
          {/* Streak Management */}
          <div className="bg-white rounded-[2.5rem] p-10 shadow-sm border border-gray-100">
             <div className="flex justify-between items-center mb-10">
                <div className="space-y-1">
                  <h3 className="text-xl font-black text-gray-900">Streak Hiện Tại</h3>
                  <p className="text-[10px] font-bold text-gray-300 uppercase tracking-widest">14 ngày gần nhất</p>
                </div>
                <div className="flex items-center gap-2">
                   <Zap size={24} className="text-orange-500 fill-orange-500" />
                   <span className="text-4xl font-black text-gray-800">14</span>
                   <span className="text-[10px] font-bold text-orange-500 uppercase leading-none">ngày <br/>liên tiếp</span>
                </div>
             </div>

             <div className="flex gap-1.5 mb-10 overflow-x-auto pb-4 scrollbar-hide">
                {Array.from({length: 13}).map((_, i) => (
                   <div key={i} className="flex flex-col items-center gap-2 group cursor-pointer shrink-0">
                      <div className="w-10 h-10 rounded-full bg-gray-50 flex items-center justify-center text-[10px] font-bold text-gray-300 group-hover:bg-emerald-50 group-hover:text-emerald-500 transition-all">
                        {6 + i}
                      </div>
                      <div className="w-10 h-10 rounded-full bg-gray-50 flex items-center justify-center text-[10px] font-bold text-gray-300 group-hover:bg-emerald-50 group-hover:text-emerald-500 transition-all">
                        {6 + i}
                      </div>
                   </div>
                ))}
                <div className="flex flex-col items-center gap-2 shrink-0">
                   <div className="w-10 h-10 rounded-full bg-[#fff7ed] border border-[#f97316] flex items-center justify-center text-[18px] font-black text-[#f97316]">?</div>
                   <span className="text-[10px] font-black text-[#f97316] uppercase tracking-tighter">Hôm nay</span>
                </div>
             </div>

             <div className="bg-[#fff7ed] rounded-3xl p-6 mb-8 relative overflow-hidden">
                <div className="flex justify-between items-center mb-4 relative z-10">
                   <h4 className="text-xs font-black text-[#f97316] uppercase tracking-widest">Mục tiêu tiếp theo: 21 ngày</h4>
                   <span className="text-xs font-black text-[#f97316]">còn 7 ngày</span>
                </div>
                <div className="h-2.5 bg-[#ffedd5] rounded-full overflow-hidden mb-2 relative z-10">
                   <div className="h-full bg-[#f97316] w-[66%] rounded-full" />
                </div>
                <div className="flex justify-between text-[10px] font-black text-[#f97316]/60 relative z-10">
                   <span>0</span>
                   <span>21 ngày</span>
                </div>
             </div>

             <div className="grid grid-cols-2 gap-4">
                <div className="bg-gray-50 p-6 rounded-3xl text-center">
                   <div className="flex items-center justify-center gap-2 text-orange-400 mb-2">
                      <Award size={18} />
                      <span className="text-xl font-black text-gray-800">21</span>
                   </div>
                   <p className="text-[9px] font-black text-gray-300 uppercase tracking-widest">Streak dài nhất</p>
                </div>
                <div className="bg-gray-50 p-6 rounded-3xl text-center">
                   <div className="flex items-center justify-center gap-2 text-emerald-400 mb-2">
                      <CheckCircle2 size={18} />
                      <span className="text-xl font-black text-gray-800">8</span>
                   </div>
                   <p className="text-[9px] font-black text-gray-300 uppercase tracking-widest">Tổng check-in</p>
                </div>
             </div>
          </div>

          {/* Activity Calendar Section */}
          <div className="bg-white rounded-[2.5rem] p-10 shadow-sm border border-gray-100 flex flex-col">
             <header className="flex justify-between items-center mb-10">
                <div className="space-y-1">
                   <h3 className="text-xl font-black text-gray-900">Lịch Check-in</h3>
                   <p className="text-[10px] font-bold text-gray-300 uppercase tracking-widest">Tháng 4 2024</p>
                </div>
                <div className="flex items-center gap-4">
                   <div className="flex gap-1 text-gray-300">
                      <button className="p-2 hover:bg-gray-50 rounded-lg transition-all"><ChevronLeft size={16} /></button>
                      <button className="px-3 py-2 text-[10px] font-black uppercase text-gray-400 bg-gray-50 rounded-lg hover:text-gray-600 transition-all flex items-center gap-1">
                        Tháng này <ChevronDown size={10} />
                      </button>
                      <button className="p-2 hover:bg-gray-50 rounded-lg transition-all"><ChevronRight size={16} /></button>
                   </div>
                </div>
             </header>

             <div className="grid grid-cols-3 gap-4 mb-10">
               {[
                 { label: 'Ngày hoạt động', value: '18', icon: <Calendar className="text-emerald-500" /> },
                 { label: 'Tổng check-in', value: '8', icon: <CheckCircle2 className="text-blue-500" /> },
                 { label: 'Tỷ lệ', value: '60%', icon: <Award className="text-orange-500" /> },
               ].map((item, i) => (
                 <div key={i} className="bg-gray-50 p-6 rounded-[2rem] flex flex-col items-center gap-3">
                    <div className="w-8 h-8 rounded-lg flex items-center justify-center bg-white shadow-sm border border-gray-100">
                      {item.icon}
                    </div>
                    <div>
                      <h4 className="text-xl font-black text-gray-800 leading-none mb-1 text-center">{item.value}</h4>
                      <p className="text-[8px] font-bold text-gray-300 uppercase tracking-widest text-center">{item.label}</p>
                    </div>
                 </div>
               ))}
             </div>

             <div className="flex-1">
                <div className="grid grid-cols-7 text-[10px] font-black text-gray-300 uppercase tracking-widest mb-6 text-center">
                   {['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'].map(d => <div key={d}>{d}</div>)}
                </div>
                <div className="grid grid-cols-7 gap-3 h-full">
                   {Array.from({length: 30}).map((_, i) => (
                     <div 
                      key={i} 
                      className={cn(
                        "aspect-square rounded-xl flex items-center justify-center text-[10px] font-bold transition-all",
                        i === 18 ? "bg-emerald-50 border border-emerald-500 text-emerald-500" : "bg-gray-50 text-gray-300 hover:bg-gray-100"
                      )}
                     >
                       {i === 18 ? 19 : i + 1}
                     </div>
                   ))}
                </div>
             </div>

             <div className="mt-8 flex items-center justify-end gap-2 text-[8px] font-bold text-gray-300 uppercase tracking-widest">
                <span>Ít</span>
                <div className="flex gap-1">
                   {[10, 30, 50, 70, 90].map(v => <div key={v} className="w-3 h-3 rounded-[2px] bg-emerald-500" style={{opacity: v/100}} />)}
                </div>
                <span>Nhiều</span>
             </div>
          </div>
        </div>

        {/* Detailed Stats Section (Long Filter list) */}
        <section className="mb-20">
           <header className="flex justify-between items-center mb-10">
              <div className="space-y-1">
                <h2 className="text-2xl font-black text-[#1a2b3c] tracking-tight">Thống Kê Mục Tiêu</h2>
                <p className="text-xs font-medium text-gray-400">Lọc theo danh mục và thời gian để xem thống kê chi tiết</p>
              </div>
              <button 
                onClick={() => setShowExportModal(true)}
                className="flex items-center gap-2 px-6 py-3 bg-[#10a352] text-white rounded-xl font-bold hover:bg-[#0d8a45] transition-all shadow-lg shadow-green-600/10 active:scale-95"
              >
                <FileText size={18} />
                Xuất Báo Cáo
              </button>
           </header>

           <div className="space-y-10">
              {/* Filters */}
              <div className="space-y-6">
                 <div>
                    <span className="text-[10px] font-black text-gray-300 uppercase tracking-widest block mb-4">Danh mục</span>
                    <div className="flex gap-3 overflow-x-auto pb-2 scrollbar-hide">
                       <button className="flex items-center gap-2 px-6 py-2.5 bg-[#4b5563] text-white rounded-lg text-[10px] font-black uppercase tracking-widest decoration-none"><BarChart3 size={14} /> Tất cả</button>
                       {['Tiết kiệm điện', 'Tiết kiệm nước', 'Giảm rác nhựa', 'Giao thông xanh', 'Ăn uống xanh', 'Phân loại rác'].map((cat, i) => (
                          <button key={i} className="flex items-center gap-2 px-6 py-2.5 bg-white border border-gray-100 text-gray-400 rounded-lg text-[10px] font-black uppercase tracking-widest whitespace-nowrap hover:bg-gray-50 transition-all">
                             {i % 2 === 0 ? <Zap size={14} /> : <Droplets size={14} />} {cat}
                          </button>
                       ))}
                    </div>
                 </div>

                 <div>
                    <span className="text-[10px] font-black text-gray-300 uppercase tracking-widest block mb-4">Thời gian</span>
                    <div className="flex items-center gap-3">
                       <div className="flex p-1 bg-white border border-gray-100 rounded-xl">
                          {['Tất cả', 'Theo ngày', 'Theo tháng', 'Theo năm'].map((t, i) => (
                             <button key={i} className={cn(
                               "px-4 py-2 rounded-lg text-[10px] font-black uppercase tracking-widest transition-all",
                               i === 0 ? "bg-[#10a352] text-white" : "text-gray-400 hover:text-gray-600"
                             )}>{t}</button>
                          ))}
                       </div>
                       <button className="px-6 py-3 bg-white border border-[#10a352] text-[#10a352] rounded-xl text-[10px] font-black uppercase tracking-widest flex items-center gap-2">
                          <Clock size={14} /> Tất cả - Tất cả thời gian
                       </button>
                    </div>
                 </div>
              </div>

              {/* Summary Score Boxes */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                 {[
                   { label: 'Mục tiêu lọc được', value: '6', sub: '/ 6 tổng', color: '#10a352', bg: 'bg-[#f0fdf4]' },
                   { label: 'Đã hoàn thành', value: '1', sub: '17% tỷ lệ', color: '#10a352', bg: 'bg-[#f0fdf4]' },
                   { label: 'Tổng check-in', value: '8', sub: '+85 điểm', color: '#3b82f6', bg: 'bg-[#eff6ff]' },
                   { label: 'Tiến độ trung bình', value: '72%', sub: 'các mục tiêu lọc', color: '#f59e0b', bg: 'bg-[#fffbeb]' },
                 ].map((box, i) => (
                   <div key={i} className={cn("p-8 rounded-[2rem] border relative overflow-hidden", box.bg, "border-transparent")}>
                      <div className="flex items-center gap-2 text-[10px] font-black uppercase tracking-widest mb-6" style={{color: box.color}}>
                        {i === 0 ? <Leaf size={14} /> : i === 1 ? <CheckCircle2 size={14} /> : i === 2 ? <TrendingUp size={14} /> : <BarChart3 size={14} />} {box.label}
                      </div>
                      <div className="flex items-baseline gap-2 mb-6">
                        <span className="text-3xl font-black text-gray-800 tracking-tighter">{box.value}</span>
                        <span className="text-[10px] font-bold text-gray-400">{box.sub}</span>
                      </div>
                      <div className="h-1.5 w-full bg-white rounded-full overflow-hidden">
                         <div className="h-full rounded-full" style={{backgroundColor: box.color, width: '60%'}} />
                      </div>
                   </div>
                 ))}
              </div>

              {/* Details & Analysis Container */}
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                 {/* Left: Scrollable Goal Progress List */}
                 <div className="bg-white rounded-[2.5rem] p-10 shadow-sm border border-gray-100 flex flex-col">
                    <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-10">Danh Sách Mục Tiêu</h4>
                    <div className="space-y-10 max-h-[400px] overflow-y-auto pr-4 scrollbar-thin">
                       {GOAL_LIST.slice(0, 3).map((goal) => {
                         const theme = getThemeStyles(goal.theme);
                         return (
                           <div key={goal.id} className="space-y-4">
                              <div className="flex justify-between items-start">
                                 <div className="flex items-center gap-3">
                                    <div className={cn("w-10 h-10 rounded-xl flex items-center justify-center", theme.bg, theme.text)}>
                                       {goal.icon}
                                    </div>
                                    <div>
                                       <h5 className="font-extrabold text-sm text-gray-900">{goal.title}</h5>
                                       <p className="text-[10px] font-bold text-gray-300">{goal.current}/{goal.total} ngày</p>
                                    </div>
                                 </div>
                                 <span className={cn("text-xs font-black", theme.text)}>{goal.progress}%</span>
                              </div>
                              <div className="h-2 bg-gray-50 rounded-full overflow-hidden">
                                 <div className={cn("h-full rounded-full", theme.activeBar)} style={{width: `${goal.progress}%`}} />
                              </div>
                           </div>
                         );
                       })}
                    </div>
                 </div>

                 {/* Right: Insights & Analysis */}
                 <div className="space-y-8">
                    <div className="space-y-4">
                       <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-6">Phân Tích & Nhận Xét</h4>
                       {[
                         { label: 'Mục tiêu tốt nhất', sub: 'Đi xe đạp đi làm', detail: '100% hoàn thành', color: 'text-emerald-500', bg: 'bg-[#f0fdf4]', icon: <Leaf size={14} /> },
                         { label: 'Ngày hoạt động nhiều nhất', sub: 'Thứ Hai', detail: '', color: 'text-orange-500', bg: 'bg-[#fffbeb]', icon: <Calendar size={14} /> },
                         { label: 'Điểm xanh trong phạm vi lọc', sub: '85 điểm từ 8 check-in', detail: '', color: 'text-blue-500', bg: 'bg-[#eff6ff]', icon: <Award size={14} /> },
                       ].map((insight, i) => (
                         <div key={i} className={cn("p-6 rounded-2xl flex items-center gap-6", insight.bg)}>
                            <div className={cn("w-10 h-10 rounded-xl bg-white border border-gray-100 flex items-center justify-center shadow-sm", insight.color)}>
                               {insight.icon}
                            </div>
                            <div className="flex-1">
                               <p className="text-[10px] font-black uppercase tracking-widest opacity-50 mb-1">{insight.label}</p>
                               <div className="flex justify-between items-baseline">
                                  <span className="text-sm font-extrabold text-gray-800">{insight.sub}</span>
                                  {insight.detail && <span className="text-[10px] font-black text-emerald-500 uppercase">{insight.detail}</span>}
                               </div>
                            </div>
                         </div>
                       ))}
                    </div>

                    <div className="space-y-6">
                       <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-widest">Phân tích theo danh mục</h4>
                       <div className="space-y-4">
                          {[
                            { icon: <Zap size={10} />, pct: 0, val: '0/1 (0%)', theme: 'orange' },
                            { icon: <Leaf size={10} />, pct: 0, val: '0/1 (0%)', theme: 'emerald' },
                            { icon: <Droplets size={10} />, pct: 0, val: '0/1 (0%)', theme: 'blue' },
                            { icon: <Bike size={10} />, pct: 100, val: '1/1 (100%)', theme: 'purple' },
                            { icon: <Heart size={10} />, pct: 0, val: '0/1 (0%)', theme: 'emerald' },
                          ].map((cat, i) => {
                            const theme = getThemeStyles(cat.theme);
                            return (
                              <div key={i} className="flex items-center gap-4">
                                 <div className={cn("w-6 h-6 rounded flex items-center justify-center shrink-0", theme.bg, theme.text)}>
                                    {cat.icon}
                                 </div>
                                 <div className="flex-1 h-1.5 bg-gray-50 rounded-full overflow-hidden">
                                    <div className={cn("h-full rounded-full", theme.activeBar)} style={{width: `${cat.pct}%`}} />
                                 </div>
                                 <span className="text-[10px] font-black text-gray-300 w-16 text-right whitespace-nowrap">{cat.val}</span>
                              </div>
                            );
                          })}
                       </div>
                    </div>
                 </div>
              </div>
           </div>
        </section>

        {/* Full Goal Progress Bar List */}
        <section className="bg-white rounded-[2.5rem] p-12 shadow-sm border border-gray-100 mb-20">
           <h2 className={cn("text-2xl font-black text-[#1a2b3c] mb-12", SERIF_FONT)}>Tiến Độ Từng Mục Tiêu</h2>
           <div className="space-y-12">
              {GOAL_LIST.map((goal) => {
                 const theme = getThemeStyles(goal.theme);
                 return (
                    <div key={goal.id} className="space-y-4">
                       <div className="flex justify-between items-center">
                          <div className="flex items-center gap-4">
                             <div className={cn("w-11 h-11 rounded-xl flex items-center justify-center shadow-lg shadow-gray-200/50", theme.bg, theme.text)}>
                                {goal.icon}
                             </div>
                             <h4 className="text-base font-extrabold text-gray-900 tracking-tight">{goal.title}</h4>
                          </div>
                          <div className="flex items-baseline gap-4">
                             <span className="text-xs font-bold text-gray-300">{goal.current}/{goal.total} ngày</span>
                             <span className={cn("text-lg font-black", theme.text)}>
                               {goal.progress}%
                               {goal.progress === 100 && <CheckCircle2 size={16} className="inline ml-2 text-emerald-500" />}
                             </span>
                          </div>
                       </div>
                       <div className="h-3 bg-gray-50 rounded-full overflow-hidden shadow-inner p-0.5 border border-gray-100/50">
                          <motion.div 
                            initial={{ width: 0 }}
                            animate={{ width: `${goal.progress}%` }}
                            className={cn("h-full rounded-full", theme.activeBar)} 
                          />
                       </div>
                    </div>
                 );
              })}
           </div>
        </section>

        {/* Environmental Impact Section */}
        <section className="bg-[#0b4a2e] rounded-[3rem] p-16 mb-20 relative overflow-hidden">
           <div className="absolute top-0 right-0 w-96 h-96 bg-emerald-500/10 rounded-full blur-[100px] -mr-48 -mt-48" />
           <div className="relative z-10">
              <h2 className={cn("text-2xl font-black text-emerald-400 mb-12", SERIF_FONT)}>Tác Động Môi Trường Của Bạn</h2>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                 {[
                   { val: '23.5 kg', label: 'CO2 Đã Giảm', sub: 'Tương đương trồng 2 cây xanh', icon: <Leaf />, color: '#10a352' },
                   { val: '840 lít', label: 'Nước Đã Tiết Kiệm', sub: 'Đủ dùng cho 28 ngày', icon: <Droplets />, color: '#3b82f6' },
                   { val: '156 cái', label: 'Rác Nhựa Giảm', sub: 'Tương đương 3.1 kg nhựa', icon: <Trash2 />, color: '#10a352' },
                 ].map((stat, i) => (
                   <div key={i} className="bg-white/5 border border-white/10 rounded-[2.5rem] p-10 backdrop-blur-sm">
                      <div className="w-12 h-12 bg-white/10 rounded-2xl flex items-center justify-center text-emerald-400 mb-8">
                        {stat.icon}
                      </div>
                      <h3 className="text-3xl font-black text-white mb-2">{stat.val}</h3>
                      <p className="text-sm font-black text-emerald-400 uppercase tracking-widest mb-4">{stat.label}</p>
                      <p className="text-xs font-bold text-emerald-100/40">{stat.sub}</p>
                   </div>
                 ))}
              </div>
           </div>
        </section>

        {/* Recent Activity List */}
        <section className="bg-white rounded-[2.5rem] p-12 shadow-sm border border-gray-100 mb-20 overflow-hidden">
           <h2 className={cn("text-2xl font-black text-[#1a2b3c] mb-12", SERIF_FONT)}>Hoạt Động Gần Đây</h2>
           <div className="divide-y divide-gray-100">
              {RECENT_ACTIVITY.map((activity, i) => {
                 const theme = getThemeStyles(activity.theme);
                 return (
                   <div key={i} className="py-8 flex items-center justify-between group cursor-pointer hover:bg-gray-50/50 -mx-12 px-12 transition-all">
                      <div className="flex items-center gap-6">
                         <div className={cn("w-12 h-12 rounded-xl flex items-center justify-center shadow-lg shadow-gray-100", theme.bg, theme.text)}>
                            {activity.icon}
                         </div>
                         <div>
                            <h4 className="font-extrabold text-gray-900 group-hover:text-[#10a352] transition-all">{activity.title}</h4>
                            <p className="text-xs font-medium text-gray-400">{activity.desc}</p>
                         </div>
                      </div>
                      <div className="text-right">
                         <span className="text-sm font-black text-emerald-500 block">{activity.points}</span>
                         <span className="text-[10px] font-bold text-gray-300 uppercase tracking-widest">{activity.date}</span>
                      </div>
                   </div>
                 );
              })}
           </div>
        </section>
      </div>

      {/* Export Report Modal */}
      <AnimatePresence>
        {showExportModal && (
          <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm">
            <motion.div 
              initial={{ opacity: 0, scale: 0.9, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: 20 }}
              className="bg-white w-full max-w-2xl rounded-[2.5rem] shadow-2xl relative overflow-hidden flex flex-col"
            >
              {/* Modal Header */}
              <div className="p-8 pb-4 flex justify-between items-start">
                 <div className="flex items-center gap-4">
                    <div className="w-12 h-12 bg-[#f0fdf4] rounded-2xl flex items-center justify-center text-[#10a352]">
                       <FileSpreadsheet size={24} />
                    </div>
                    <div>
                       <h2 className="text-xl font-black text-gray-900 tracking-tight">Xuất Báo Cáo Thống Kê</h2>
                       <div className="flex items-center gap-2 text-[10px] font-bold text-gray-300 uppercase tracking-widest mt-1">
                          <TrendingUp size={12} className="text-[#10a352]" /> Tất cả • Tất cả thời gian
                       </div>
                    </div>
                 </div>
                 <button onClick={() => setShowExportModal(false)} className="p-2 hover:bg-gray-100 rounded-full text-gray-400 transition-all">
                    <X size={20} />
                 </button>
              </div>

              {/* Modal Content - Scrollable */}
              <div className="p-8 pt-0 space-y-8 overflow-y-auto max-h-[70vh] scrollbar-hide">
                 {/* Summary Banner */}
                 <div className="bg-[#f0fdf4] rounded-3xl p-6 flex justify-between items-center border border-[#dcfce7]">
                    <div className="flex items-center gap-4">
                       <div className="p-3 bg-white rounded-xl text-[#10a352] shadow-sm">
                          <BarChart3 size={20} />
                       </div>
                       <div>
                          <p className="text-[10px] font-black text-emerald-800/40 uppercase tracking-widest mb-1">Dữ liệu sẽ được xuất</p>
                          <p className="text-sm font-black text-[#10a352]">6 mục tiêu • 8 check-in • 85 điểm xanh</p>
                       </div>
                    </div>
                    <div className="text-right">
                       <p className="text-2xl font-black text-[#10a352] leading-none">72%</p>
                       <p className="text-[9px] font-bold text-emerald-800/40 uppercase tracking-widest">Tiến độ TB</p>
                    </div>
                 </div>

                 {/* Format Selection Row */}
                 <div className="space-y-4">
                    <h3 className="flex items-center gap-2 text-[10px] font-black text-gray-400 uppercase tracking-widest">
                       <Download size={12} /> Chọn định dạng file
                    </h3>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                       {/* CSV Option */}
                       <label className={cn(
                         "relative p-6 rounded-3xl border-2 transition-all cursor-pointer group",
                         exportFormat === 'CSV' ? "border-[#10a352] bg-[#f0fdf4]/30 shadow-sm" : "border-gray-100 hover:border-gray-200"
                       )}>
                          <input 
                            type="radio" 
                            name="format" 
                            className="absolute opacity-0"
                            checked={exportFormat === 'CSV'}
                            onChange={() => setExportFormat('CSV')}
                          />
                          <div className="flex items-start gap-4">
                             <div className={cn(
                               "w-5 h-5 rounded-full border-2 flex items-center justify-center shrink-0 mt-1",
                               exportFormat === 'CSV' ? "border-[#10a352]" : "border-gray-200"
                             )}>
                                {exportFormat === 'CSV' && <div className="w-2.5 h-2.5 bg-[#10a352] rounded-full" />}
                             </div>
                             <div className="flex-1">
                                <div className="flex items-center justify-between mb-2">
                                   <div className="flex items-center gap-2 text-[#10a352]">
                                      <FileSpreadsheet size={18} />
                                      <span className="font-black text-sm">CSV (Excel / Google Sheets)</span>
                                   </div>
                                   <span className="text-[8px] px-2 py-0.5 bg-emerald-100 text-[#10a352] rounded-full font-black uppercase">Phổ biến</span>
                                </div>
                                <p className="text-[10px] font-medium text-gray-400 leading-relaxed">
                                   Mở được bằng Excel, Google Sheets. Dễ in ấn, chia sẻ và phân tích thêm.
                                </p>
                             </div>
                          </div>
                       </label>

                       {/* JSON Option */}
                       <label className={cn(
                         "relative p-6 rounded-3xl border-2 transition-all cursor-pointer group",
                         exportFormat === 'JSON' ? "border-[#10a352] bg-[#f0fdf4]/30 shadow-sm" : "border-gray-100 hover:border-gray-200"
                       )}>
                          <input 
                            type="radio" 
                            name="format" 
                            className="absolute opacity-0"
                            checked={exportFormat === 'JSON'}
                            onChange={() => setExportFormat('JSON')}
                          />
                          <div className="flex items-start gap-4">
                             <div className={cn(
                               "w-5 h-5 rounded-full border-2 flex items-center justify-center shrink-0 mt-1",
                               exportFormat === 'JSON' ? "border-[#10a352]" : "border-gray-200"
                             )}>
                                {exportFormat === 'JSON' && <div className="w-2.5 h-2.5 bg-[#10a352] rounded-full" />}
                             </div>
                             <div className="flex-1">
                                <div className="flex items-center justify-between mb-2">
                                   <div className="flex items-center gap-2 text-orange-500">
                                      <Code size={18} />
                                      <span className="font-black text-sm">JSON (Dữ liệu có cấu trúc)</span>
                                   </div>
                                   <span className="text-[8px] px-2 py-0.5 bg-orange-100 text-orange-500 rounded-full font-black uppercase">Đầy đủ nhất</span>
                                </div>
                                <p className="text-[10px] font-medium text-gray-400 leading-relaxed">
                                   Định dạng dữ liệu đầy đủ, phù hợp lưu trữ lâu dài và phân tích kỹ thuật.
                                </p>
                             </div>
                          </div>
                       </label>
                    </div>
                 </div>

                 {/* Filename Preview */}
                 <div className="bg-gray-50 rounded-2xl p-4 flex items-center gap-3">
                    <FileText size={16} className="text-gray-300" />
                    <span className="text-[11px] font-bold text-gray-400">GreenLife_BaoCao_Yunne_2026-04-19.{exportFormat.toLowerCase()}</span>
                 </div>

                 {/* Preview Tabs */}
                 <div className="space-y-4">
                    <div className="flex justify-between items-center">
                       <h3 className="flex items-center gap-2 text-[10px] font-black text-gray-400 uppercase tracking-widest">
                          <Clock size={12} /> Xem trước nội dung
                       </h3>
                       <span className="text-[9px] font-bold text-gray-300 uppercase underline decoration-gray-200">6 mục tiêu • 8 check-in</span>
                    </div>

                    <div className="bg-gray-50 p-1 rounded-2xl flex gap-1">
                       <button 
                        onClick={() => setPreviewTab('overview')}
                        className={cn(
                          "flex-1 py-3.5 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all",
                          previewTab === 'overview' ? "bg-white text-gray-900 shadow-sm" : "text-gray-400 hover:text-gray-600"
                        )}
                       >
                         <BarChart3 size={12} className="inline mr-2" /> Tổng quan
                       </button>
                       <button 
                        onClick={() => setPreviewTab('goals')}
                        className={cn(
                          "flex-1 py-3.5 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all",
                          previewTab === 'goals' ? "bg-white text-gray-900 shadow-sm" : "text-gray-400 hover:text-gray-600"
                        )}
                       >
                         <Leaf size={12} className="inline mr-2" /> Mục tiêu
                       </button>
                       <button 
                        onClick={() => setPreviewTab('history')}
                        className={cn(
                          "flex-1 py-3.5 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all",
                          previewTab === 'history' ? "bg-white text-gray-900 shadow-sm" : "text-gray-400 hover:text-gray-600"
                        )}
                       >
                         <Clock size={12} className="inline mr-2" /> Lịch sử
                       </button>
                    </div>

                    {/* Fake Preview Table */}
                    <div className="bg-white border border-gray-100 rounded-3xl overflow-hidden shadow-sm">
                       <div className="bg-gray-50/50 px-6 py-4 flex justify-between items-center border-b border-gray-100">
                          <div className="flex items-center gap-3">
                             <div className="w-8 h-8 rounded-lg bg-[#10a352] text-white flex items-center justify-center font-black">Y</div>
                             <span className="text-sm font-bold text-gray-700">Yunne</span>
                          </div>
                          <button className="flex items-center gap-1 text-[9px] font-black text-gray-400 uppercase tracking-widest">
                            Bộ lọc <ChevronDown size={10} />
                          </button>
                       </div>
                       <div className="p-6 space-y-4">
                          {previewTab === 'overview' && (
                            <div className="space-y-3">
                               <div className="flex justify-between pb-2 border-b border-gray-50">
                                  <span className="text-[10px] font-bold text-gray-400">Username</span>
                                  <span className="text-[10px] font-black text-gray-800">Yunne</span>
                               </div>
                               <div className="flex justify-between pb-2 border-b border-gray-50">
                                  <span className="text-[10px] font-bold text-gray-400">Level</span>
                                  <span className="text-[10px] font-black text-gray-800">12</span>
                               </div>
                               <div className="flex justify-between">
                                  <span className="text-[10px] font-bold text-gray-400">Total Points</span>
                                  <span className="text-[10px] font-black text-emerald-500">1,240 XP</span>
                               </div>
                            </div>
                          )}
                          {previewTab === 'goals' && (
                            <div className="space-y-3">
                               {GOAL_LIST.slice(0, 3).map(g => (
                                 <div key={g.id} className="flex justify-between items-center gap-4">
                                    <span className="text-[10px] font-bold text-gray-700 truncate">{g.title}</span>
                                    <span className="text-[10px] font-black text-emerald-500">{g.progress}%</span>
                                 </div>
                               ))}
                            </div>
                          )}
                          {previewTab === 'history' && (
                            <div className="space-y-3 font-mono text-[9px] text-gray-400 leading-relaxed">
                               2026-04-19 13:12:57, "Check-in", "Tiết kiệm điện", "+10pt"<br/>
                               2026-04-18 20:30:12, "Check-in", "Giảm rác nhựa", "+10pt"<br/>
                               2026-04-18 10:15:45, "Check-in", "Ăn chay", "+15pt"
                            </div>
                          )}
                       </div>
                    </div>
                 </div>
              </div>

              {/* Modal Footer */}
              <div className="p-8 bg-gray-50/50 border-t border-gray-100 flex flex-col md:flex-row items-center justify-between gap-6">
                 <div className="flex items-center gap-2 text-[10px] font-bold text-gray-400 italic">
                    <Info size={14} className="text-gray-300" /> File sẽ được tải về máy tính của bạn
                 </div>
                 <div className="flex gap-4 w-full md:w-auto">
                    <button 
                      onClick={() => setShowExportModal(false)}
                      className="flex-1 md:flex-none px-10 py-4 rounded-2xl border border-gray-200 text-gray-400 font-bold text-sm bg-white hover:bg-gray-50 transition-all active:scale-95"
                    >
                       Hủy
                    </button>
                    <button 
                      onClick={() => {
                        alert(`Bắt đầu tải xuống file ${exportFormat}...`);
                        setShowExportModal(false);
                      }}
                      className="flex-1 md:flex-none flex items-center justify-center gap-2 px-10 py-4 bg-[#10a352] text-white rounded-2xl font-black text-sm hover:bg-[#0d8a45] transition-all shadow-lg shadow-emerald-600/20 active:scale-95"
                    >
                       <Download size={18} /> Tải xuống .{exportFormat}
                    </button>
                 </div>
              </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>

      {/* Footer (Same as GoalPage for consistency) */}
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
