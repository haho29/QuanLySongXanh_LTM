import { motion } from 'motion/react';
import { Trophy, Flame, Target, MapPin, ChevronUp, ChevronDown, Search } from 'lucide-react';
import { cn } from '../lib/utils';

const TOP_USERS = [
  { rank: 2, name: 'Minh Tú', job: 'Kiến trúc sư • Hà Nội', points: '2,450', avatar: 'https://picsum.photos/seed/user2/200', color: 'border-slate-300', rankBg: 'bg-slate-300' },
  { rank: 1, name: 'Phương Anh', job: 'Môi trường học • TP. HCM', points: '3,120', avatar: 'https://picsum.photos/seed/user1/200', color: 'border-primary', rankBg: 'bg-primary' },
  { rank: 3, name: 'Hoàng Nam', job: 'Kỹ sư năng lượng • Đà Nẵng', points: '2,105', avatar: 'https://picsum.photos/seed/user3/200', color: 'border-amber-600/40', rankBg: 'bg-amber-700' },
];

const LIST_USERS = [
  { rank: 4, name: 'Lê Quang', job: 'Thiết kế đồ họa', location: 'Cần Thơ', streak: 28, points: '1,950', avatar: 'https://picsum.photos/seed/user4/100' },
  { rank: 5, name: 'Mai Hương', job: 'Bác sĩ', location: 'Huế', streak: 15, points: '1,820', avatar: 'https://picsum.photos/seed/user5/100' },
  { rank: 6, name: 'Trần Bình', job: 'Sinh viên', location: 'Hải Phòng', streak: 32, points: '1,780', avatar: 'https://picsum.photos/seed/user6/100' },
  { rank: 7, name: 'Thu Thảo', job: 'Giáo viên', location: 'Vũng Tàu', streak: 5, points: '1,640', avatar: 'https://picsum.photos/seed/user7/100' },
];

export default function LeaderboardPage() {
  return (
    <div className="pt-28 pb-20 px-6 lg:px-12 max-w-screen-xl mx-auto min-h-screen">
      <motion.header 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="mb-12"
      >
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
          <div>
            <span className="text-primary font-bold tracking-[0.2em] text-xs uppercase mb-2 block">Cộng Đồng Bền Vững</span>
            <h1 className="text-4xl md:text-5xl font-extrabold text-on-surface tracking-tight mb-4">Bảng Xếp Hạng</h1>
            <p className="text-on-surface-variant max-w-lg leading-relaxed italic">
              Vinh danh những cá nhân xuất sắc đang dẫn đầu trong hành trình kiến tạo một tương lai xanh tại Việt Nam.
            </p>
          </div>

          <div className="bg-primary/5 p-1 rounded-2xl border border-primary/10">
            <div className="bg-white px-6 py-4 rounded-xl flex items-center gap-6 shadow-sm">
              <div className="flex items-center gap-3">
                <div className="w-12 h-12 rounded-full overflow-hidden border-2 border-primary">
                  <img className="w-full h-full object-cover" src="https://picsum.photos/seed/current/100" alt="Your Avatar" />
                </div>
                <div>
                  <p className="text-[10px] font-bold text-on-surface-variant uppercase tracking-wider">Hạng của bạn</p>
                  <p className="text-lg font-extrabold text-primary">#142</p>
                </div>
              </div>
              <div className="w-px h-8 bg-surface-container"></div>
              <div>
                <p className="text-[10px] font-bold text-on-surface-variant uppercase tracking-wider">Chuỗi (Streak)</p>
                <div className="flex items-center gap-1 text-orange-500">
                  <Flame size={18} fill="currentColor" />
                  <p className="text-lg font-extrabold text-on-surface">12 Ngày</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </motion.header>

      {/* Podium Section */}
      <section className="mb-16">
        <div className="grid grid-cols-1 md:grid-cols-3 items-end gap-6 md:gap-0 mt-20">
          {TOP_USERS.map((user, idx) => (
            <motion.div 
              key={user.rank}
              initial={{ opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: idx * 0.1 }}
              className={cn(
                "flex flex-col items-center relative",
                user.rank === 1 ? "z-10 order-1 md:order-2" : user.rank === 2 ? "order-2 md:order-1" : "order-3 md:order-3"
              )}
            >
              <div className="relative mb-6">
                {user.rank === 1 && (
                   <div className="absolute -top-12 left-1/2 -translate-x-1/2 text-yellow-500 drop-shadow-lg">
                      <Trophy size={48} fill="currentColor" />
                   </div>
                )}
                <div className={cn(
                  "rounded-full border-4 overflow-hidden shadow-2xl transition-transform hover:scale-105 duration-300",
                  user.color,
                  user.rank === 1 ? "w-36 h-36 md:w-48 md:h-48 ring-8 ring-primary/5" : "w-28 h-28 md:w-36 md:h-36"
                )}>
                  <img className="w-full h-full object-cover" src={user.avatar} alt={user.name} />
                </div>
                <div className={cn(
                  "absolute -bottom-3 left-1/2 -translate-x-1/2 text-white w-10 h-10 rounded-full flex items-center justify-center font-bold border-4 border-surface shadow-lg",
                  user.rankBg
                )}>
                  {user.rank}
                </div>
              </div>

              <div className={cn(
                "w-full flex flex-col items-center text-center p-8 rounded-t-[2.5rem] shadow-sm",
                user.rank === 1 ? "bg-primary text-white p-10 rounded-t-[3.5rem] shadow-xl" : "bg-surface-container-low"
              )}>
                <h3 className={cn("font-bold text-lg mb-1", user.rank === 1 ? "text-2xl" : "text-on-surface")}>{user.name}</h3>
                <p className={cn("text-xs mb-6", user.rank === 1 ? "text-white/70" : "text-on-surface-variant")}>{user.job}</p>
                <div className={cn(
                  "px-6 py-2 rounded-full font-bold",
                  user.rank === 1 ? "bg-white/20 backdrop-blur-md text-white text-lg" : "bg-white/60 text-primary"
                )}>
                  {user.points} <span className="text-[10px] uppercase ml-1 opacity-70">Điểm Xanh</span>
                </div>
                {user.rank === 1 && (
                  <div className="mt-4 flex items-center gap-2 text-sm font-bold">
                    <Flame size={16} fill="currentColor" className="text-orange-300" />
                    <span>45 Ngày Streak</span>
                  </div>
                )}
              </div>
            </motion.div>
          ))}
        </div>
      </section>

      {/* Main List */}
      <section className="bg-surface-card rounded-[2.5rem] shadow-sm overflow-hidden border border-primary/5">
        <div className="px-10 py-8 bg-surface-container-low/50 flex flex-col md:flex-row justify-between items-center gap-6">
          <h2 className="text-xl font-extrabold text-on-surface">Bảng Xếp Hạng Chi Tiết</h2>
          
          <div className="flex bg-surface-container rounded-full p-1.5 w-full md:w-auto">
            <button className="flex-1 md:flex-none px-6 py-2 bg-primary text-white rounded-full text-xs font-bold uppercase tracking-widest shadow-md">Hàng Tuần</button>
            <button className="flex-1 md:flex-none px-6 py-2 text-on-surface-variant hover:bg-white rounded-full text-xs font-bold uppercase tracking-widest transition-all">Tất Cả</button>
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="text-on-surface-variant/50 border-b border-surface-container">
                <th className="px-10 py-5 text-[10px] font-black uppercase tracking-[0.2em]">Hạng</th>
                <th className="px-10 py-5 text-[10px] font-black uppercase tracking-[0.2em]">Thành Viên</th>
                <th className="px-10 py-5 text-[10px] font-black uppercase tracking-[0.2em] hidden lg:table-cell">Vị Trí</th>
                <th className="px-10 py-5 text-[10px] font-black uppercase tracking-[0.2em]">Chuỗi</th>
                <th className="px-10 py-5 text-[10px] font-black uppercase tracking-[0.2em] text-right">Điểm Xanh</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-surface-container">
              {LIST_USERS.map((user) => (
                <motion.tr 
                  key={user.rank}
                  whileHover={{ backgroundColor: 'rgba(0,108,74,0.02)' }}
                  className="group transition-colors"
                >
                  <td className="px-10 py-8 font-black text-on-surface-variant/40">#{user.rank}</td>
                  <td className="px-10 py-8">
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-full overflow-hidden shadow-sm group-hover:ring-2 ring-primary transition-all">
                        <img className="w-full h-full object-cover" src={user.avatar} alt={user.name} />
                      </div>
                      <div>
                        <p className="font-bold text-on-surface group-hover:text-primary transition-colors text-lg">{user.name}</p>
                        <p className="text-xs text-on-surface-variant">{user.job}</p>
                      </div>
                    </div>
                  </td>
                  <td className="px-10 py-8 hidden lg:table-cell text-on-surface-variant/70 text-sm italic">
                    <div className="flex items-center gap-1">
                      <MapPin size={14} className="opacity-40" />
                      {user.location}
                    </div>
                  </td>
                  <td className="px-10 py-8">
                    <div className="flex items-center gap-1 font-extrabold text-on-surface">
                      <Flame size={16} fill="currentColor" className="text-orange-500" />
                      {user.streak}
                    </div>
                  </td>
                  <td className="px-10 py-8 text-right font-black text-primary text-xl tracking-tighter">{user.points}</td>
                </motion.tr>
              ))}
            </tbody>
          </table>
        </div>
        
        <div className="p-10 flex justify-center border-t border-surface-container bg-surface-container-low/20">
          <button className="flex items-center gap-3 text-primary font-bold hover:gap-6 transition-all group">
            Xem thêm thành viên 
            <motion.span 
              animate={{ x: [0, 5, 0] }} 
              transition={{ repeat: Infinity, duration: 2 }}
              className="text-xl"
            >→</motion.span>
          </button>
        </div>
      </section>
    </div>
  );
}
