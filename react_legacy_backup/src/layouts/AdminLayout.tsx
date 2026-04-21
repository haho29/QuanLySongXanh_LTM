import React from 'react';
import { NavLink, useNavigate, Outlet } from 'react-router-dom';
import { LayoutDashboard, Users, Target, Home, LogOut, Leaf } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { cn } from '../lib/utils';
import { motion } from 'motion/react';

export default function AdminLayout() {
  const { logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/admin/login');
  };

  const menuItems = [
    { name: 'Tổng Quan', path: '/admin/dashboard', icon: <LayoutDashboard size={20} /> },
    { name: 'Người Dùng', path: '/admin/users', icon: <Users size={20} /> },
    { name: 'Mục Tiêu', path: '/admin/goals', icon: <Target size={20} /> },
  ];

  return (
    <div className="flex min-h-screen bg-surface-container-low">
      {/* Sidebar */}
      <aside className="w-80 bg-primary-dark text-white flex flex-col p-8 fixed h-full z-50">
        <div 
          onClick={() => navigate('/admin/dashboard')}
          className="flex items-center gap-3 mb-12 cursor-pointer hover:opacity-80 transition-opacity"
        >
          <div className="w-10 h-10 bg-primary/20 text-primary rounded-xl flex items-center justify-center">
            <Leaf size={24} />
          </div>
          <div>
            <h1 className="text-xl font-black italic mb-0">GreenLife</h1>
            <p className="text-[10px] font-bold text-primary tracking-widest uppercase opacity-60">Admin Panel</p>
          </div>
        </div>

        <div className="flex items-center gap-4 p-4 bg-white/5 rounded-3xl mb-12 border border-white/5">
          <div className="w-12 h-12 rounded-2xl overflow-hidden shadow-lg border-2 border-primary/20">
             <img src="https://picsum.photos/seed/admin/200" alt="Admin" className="w-full h-full object-cover" />
          </div>
          <div>
            <h3 className="font-bold text-sm">admin</h3>
            <p className="text-[10px] text-primary font-bold uppercase tracking-tight">Quản trị viên</p>
          </div>
        </div>

        <nav className="flex-1 space-y-2">
          {menuItems.map((item) => (
            <NavLink
              key={item.path}
              to={item.path}
              className={({ isActive }) => 
                cn(
                  "flex items-center gap-4 px-6 py-4 rounded-2xl font-bold transition-all",
                  isActive 
                    ? "bg-primary text-white shadow-xl shadow-primary/20 scale-[1.02]" 
                    : "text-white/40 hover:text-white hover:bg-white/5"
                )
              }
            >
              {item.icon}
              {item.name}
            </NavLink>
          ))}
        </nav>

        <div className="pt-8 mt-8 border-t border-white/5 space-y-2">
           <button 
             onClick={() => navigate('/admin/dashboard')}
             className="flex items-center gap-4 px-6 py-4 text-white/40 hover:text-white transition-colors w-full rounded-2xl font-bold"
           >
             <Home size={20} /> Trang Chủ Admin
           </button>
           <button 
             onClick={handleLogout}
             className="flex items-center gap-4 px-6 py-4 text-orange-400 hover:text-orange-300 transition-colors w-full rounded-2xl font-bold"
           >
             <LogOut size={20} /> Đăng Xuất
           </button>
        </div>
      </aside>

      {/* Main Content Area */}
      <main className="flex-1 ml-80 p-12 overflow-y-auto">
        <Outlet />
      </main>
    </div>
  );
}
