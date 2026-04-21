import React, { useState } from 'react';
import { motion } from 'motion/react';
import { Search, Filter, Mail, MapPin, ChevronRight, Activity, Globe, MoreVertical } from 'lucide-react';
import { cn } from '../lib/utils';

const USERS_DATA = [
  { id: 1, name: 'Trần Thị Lan', email: 'tran.thi.lan@greenlife.vn', job: 'Giáo viên', location: 'Hà Nội', points: '2,150', goals: 8, status: 'Hoạt động', avatar: 'https://picsum.photos/seed/user1/200' },
  { id: 2, name: 'Lê Văn Hùng', email: 'le.van.hung@greenlife.vn', job: 'Kỹ sư phần mềm', location: 'TP. HCM', points: '1,890', goals: 6, status: 'Hoạt động', avatar: 'https://picsum.photos/seed/user2/200' },
  { id: 3, name: 'Nguyễn Minh Khoa', email: 'nguyen.minh.khoa@greenlife.vn', job: 'Kỹ sư Môi trường', location: 'TP. HCM', points: '1,240', goals: 4, status: 'Hoạt động', avatar: 'https://picsum.photos/seed/user3/200' },
  { id: 4, name: 'Phạm Thu Hà', email: 'pham.thu.ha@greenlife.vn', job: 'Chủ tiệm cà phê', location: 'Đà Nẵng', points: '1,180', goals: 3, status: 'Hoạt động', avatar: 'https://picsum.photos/seed/user4/200' },
  { id: 5, name: 'Hoàng Đức Minh', email: 'hoang.duc.minh@greenlife.vn', job: 'Lập trình viên', location: 'Hà Nội', points: '980', goals: 3, status: 'Hoạt động', avatar: 'https://picsum.photos/seed/user5/200' },
  { id: 6, name: 'Nguyễn Thị Mai', email: 'nguyen.thi.mai@greenlife.vn', job: 'Nhân viên văn phòng', location: 'Cần Thơ', points: '870', goals: 2, status: 'Hoạt động', avatar: 'https://picsum.photos/seed/user6/200' },
  { id: 7, name: 'Võ Thành Tùng', email: 'vo.thanh.tung@greenlife.vn', job: 'Bác sĩ', location: 'Huế', points: '820', goals: 2, status: 'Hoạt động', avatar: 'https://picsum.photos/seed/user7/200' },
  { id: 8, name: 'Đặng Thị Hương', email: 'dang.thi.huong@greenlife.vn', job: 'Kế toán', location: 'Hải Phòng', points: '760', goals: 2, status: 'Hoạt động', avatar: 'https://picsum.photos/seed/user8/200' },
  { id: 9, name: 'Bùi Quang Hải', email: 'bui.quang.hai@greenlife.vn', job: 'Kiến trúc sư', location: 'TP. HCM', points: '690', goals: 1, status: 'Không HĐ', avatar: 'https://picsum.photos/seed/user9/200' },
  { id: 10, name: 'Lý Thị Ngọc', email: 'ly.thi.ngoc@greenlife.vn', job: 'Nhà thiết kế', location: 'Đà Nẵng', points: '640', goals: 1, status: 'Không HĐ', avatar: 'https://picsum.photos/seed/user10/200' },
];

export default function AdminUsers() {
  const [activeFilter, setActiveFilter] = useState('Tất cả');
  const [searchQuery, setSearchQuery] = useState('');

  const filters = ['Tất cả', 'Hoạt động', 'Không hoạt động'];

  const filteredUsers = USERS_DATA.filter(user => {
    const matchesSearch = user.name.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          user.email.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesFilter = activeFilter === 'Tất cả' || user.status.toLowerCase() === activeFilter.toLowerCase().replace(' ', '');
    return matchesSearch && matchesFilter;
  });

  return (
    <div className="space-y-12">
      <header>
        <h1 className="text-4xl font-black text-primary-dark tracking-tighter mb-2 italic">Quản Lý Người Dùng</h1>
        <p className="text-on-surface-variant font-medium italic text-sm">Tổng cộng 12 người dùng trong hệ thống</p>
      </header>

      <section className="bg-white p-12 rounded-[3.5rem] border border-primary/5 shadow-sm">
         <div className="flex flex-col md:flex-row justify-between items-center gap-8 mb-12">
            <div className="relative w-full md:max-w-md">
               <Search className="absolute left-6 top-1/2 -translate-y-1/2 text-on-surface-variant/40" size={18} />
               <input 
                 type="text"
                 value={searchQuery}
                 onChange={(e) => setSearchQuery(e.target.value)}
                 placeholder="Tìm kiếm người dùng..."
                 className="w-full bg-surface-container border-none rounded-2xl py-4 pl-14 pr-8 text-sm outline-none focus:ring-2 focus:ring-primary transition-all"
               />
            </div>

            <div className="flex gap-4 items-center">
               <div className="flex gap-2 bg-surface-container p-1 rounded-2xl">
                 {filters.map(f => (
                   <button 
                     key={f}
                     onClick={() => setActiveFilter(f)}
                     className={cn(
                       "px-6 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-widest transition-all",
                       activeFilter === f ? 'bg-white shadow-lg text-primary' : 'text-on-surface-variant hover:text-primary'
                     )}
                   >
                     {f}
                   </button>
                 ))}
               </div>
               <span className="text-[10px] font-bold text-on-surface-variant/40 ml-4 font-mono">Hiển thị <span className="text-on-surface font-black">{filteredUsers.length}</span> người dùng</span>
            </div>
         </div>

         <div className="overflow-x-auto">
            <table className="w-full">
               <thead>
                  <tr className="border-b border-surface-container">
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Người Dùng</th>
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Nghề Nghiệp</th>
                     <th className="text-left py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Địa Điểm</th>
                     <th className="text-right py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Điểm Xanh</th>
                     <th className="text-right py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Mục Tiêu</th>
                     <th className="text-center py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Trạng Thái</th>
                     <th className="text-right py-6 text-[10px] font-black uppercase text-on-surface-variant/40 tracking-widest px-4">Thao Tác</th>
                  </tr>
               </thead>
               <tbody>
                  {filteredUsers.map((user) => (
                    <tr key={user.id} className="border-b border-surface-container/50 hover:bg-surface-container-low transition-colors group">
                       <td className="py-6 px-4">
                          <div className="flex items-center gap-4">
                             <div className="w-12 h-12 rounded-2xl overflow-hidden shadow-sm group-hover:scale-110 transition-transform">
                                <img src={user.avatar} alt={user.name} className="w-full h-full object-cover" />
                             </div>
                             <div>
                                <p className="font-bold text-on-surface group-hover:text-primary">{user.name}</p>
                                <p className="text-[10px] text-on-surface-variant/40 italic font-medium">{user.email}</p>
                             </div>
                          </div>
                       </td>
                       <td className="py-6 px-4 text-sm text-on-surface-variant font-medium">{user.job}</td>
                       <td className="py-6 px-4 text-sm text-on-surface-variant font-medium">
                          <div className="flex items-center gap-2">
                             <MapPin size={14} className="opacity-30" /> {user.location}
                          </div>
                       </td>
                       <td className="py-6 px-4 text-right font-black text-emerald-600">{user.points}</td>
                       <td className="py-6 px-4 text-right font-bold text-on-surface">{user.goals}</td>
                       <td className="py-6 px-4 text-center">
                          <span className={cn(
                            "px-4 py-1.5 text-[10px] font-black rounded-full italic ring-1",
                            user.status === 'Hoạt động' ? "bg-emerald-50 text-emerald-600 ring-emerald-100" : "bg-surface-container text-on-surface-variant/60 ring-surface-container"
                          )}>
                             &bull; {user.status}
                          </span>
                       </td>
                       <td className="py-6 px-4 text-right">
                          <button className="text-xs font-black text-primary hover:text-primary-dark transition-colors italic px-4 py-2 hover:bg-primary/5 rounded-xl">
                             Xem chi tiết
                          </button>
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
