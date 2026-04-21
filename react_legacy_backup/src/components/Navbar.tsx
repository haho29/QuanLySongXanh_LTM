import { Link, useLocation, useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'motion/react';
import { Leaf, User, Bell, Check, X, Clock } from 'lucide-react';
import { cn } from '../lib/utils';
import { useState, useRef, useEffect } from 'react';
import { useNotifications } from '../context/NotificationContext';
import { useAuth } from '../context/AuthContext';
import { toast } from 'react-hot-toast';

export default function Navbar() {
  const location = useLocation();
  const navigate = useNavigate();
  const { logout } = useAuth();
  const [showNotifications, setShowNotifications] = useState(false);
  const { notifications, unreadCount, markAsRead, markAllAsRead } = useNotifications();
  const dropdownRef = useRef<HTMLDivElement>(null);

  const navItems = [
    { name: 'Trang Chủ', path: '/' },
    { name: 'Mục Tiêu Xanh', path: '/goals' },
    { name: 'Tiến Độ', path: '/progress' },
    { name: 'Eco Tips', path: '/tips' },
    { name: 'Xếp Hạng', path: '/leaderboard' },
  ];

  const handleLogout = () => {
    logout();
    toast.success('Đã đăng xuất thành công');
    navigate('/admin/login');
  };

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setShowNotifications(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  return (
    <nav className="fixed top-0 w-full z-50 glass border-b border-primary/5">
      <div className="flex justify-between items-center h-20 px-6 lg:px-12 max-w-screen-2xl mx-auto">
        <Link to="/" className="flex items-center gap-2">
          <Leaf className="text-primary w-8 h-8" />
          <span className="text-2xl font-bold tracking-tighter text-primary-dark">GreenLife</span>
        </Link>
        
        <div className="hidden md:flex items-center gap-8 text-sm font-medium">
          {navItems.map((item) => (
            <Link
              key={item.path}
              to={item.path}
              className={cn(
                "transition-colors hover:text-primary",
                location.pathname === item.path 
                  ? "text-primary font-bold border-b-2 border-primary" 
                  : "text-on-surface-variant"
              )}
            >
              {item.name}
            </Link>
          ))}
        </div>

        <div className="flex items-center gap-4 relative" ref={dropdownRef}>
          <button 
            onClick={() => setShowNotifications(!showNotifications)}
            className="relative p-2 text-on-surface-variant hover:text-primary transition-colors focus:outline-none"
          >
            <Bell size={20} />
            {unreadCount > 0 && (
              <span className="absolute top-1 right-1 w-4 h-4 bg-red-500 text-white text-[10px] flex items-center justify-center rounded-full font-bold">
                {unreadCount}
              </span>
            )}
          </button>

          <AnimatePresence>
            {showNotifications && (
              <motion.div
                initial={{ opacity: 0, y: 10, scale: 0.95 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                exit={{ opacity: 0, y: 10, scale: 0.95 }}
                className="absolute right-0 top-14 w-80 md:w-96 bg-white rounded-[2rem] shadow-2xl border border-primary/10 overflow-hidden z-[60]"
              >
                <div className="p-6 border-b border-surface-container flex justify-between items-center">
                  <h3 className="font-extrabold text-on-surface">Thông Báo</h3>
                  {unreadCount > 0 && (
                    <button 
                      onClick={markAllAsRead}
                      className="text-[10px] font-bold text-primary uppercase tracking-widest hover:underline"
                    >
                      Đọc tất cả
                    </button>
                  )}
                </div>

                <div className="max-h-[28rem] overflow-y-auto overflow-x-hidden scrollbar-hide">
                  {notifications.length === 0 ? (
                    <div className="p-12 text-center">
                       <Clock className="w-12 h-12 text-on-surface-variant/20 mx-auto mb-4" />
                       <p className="text-sm text-on-surface-variant italic">Không có thông báo mới nào.</p>
                    </div>
                  ) : (
                    <div className="divide-y divide-surface-container">
                      {notifications.map((n) => (
                        <div 
                          key={n.id} 
                          onClick={() => markAsRead(n.id)}
                          className={cn(
                            "p-6 hover:bg-surface-container transition-colors cursor-pointer relative",
                            !n.read && "bg-primary/[0.02]"
                          )}
                        >
                          {!n.read && (
                            <div className="absolute left-2 top-1/2 -translate-y-1/2 w-1 h-8 bg-primary rounded-full" />
                          )}
                          <div className="flex gap-4">
                            <div className={cn(
                              "w-10 h-10 rounded-xl flex items-center justify-center shrink-0",
                              n.type === 'goal' ? "bg-orange-100 text-orange-600" : 
                              n.type === 'activity' ? "bg-emerald-100 text-emerald-600" : "bg-blue-100 text-blue-600"
                            )}>
                              {n.type === 'goal' ? <Check size={18} /> : 
                               n.type === 'activity' ? <Leaf size={18} /> : <Bell size={18} />}
                            </div>
                            <div className="flex-1 min-w-0">
                              <h4 className="text-sm font-bold text-on-surface mb-1 truncate">{n.title}</h4>
                              <p className="text-xs text-on-surface-variant leading-relaxed line-clamp-2 mb-2">{n.message}</p>
                              <span className="text-[10px] text-on-surface-variant/40 font-bold uppercase tracking-widest">
                                {new Date(n.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                              </span>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>

                <div className="p-4 bg-surface-container-low border-t border-surface-container">
                    <button className="w-full py-3 text-xs font-bold text-on-surface-variant hover:text-primary transition-colors">
                      Xem tất cả lịch sử
                    </button>
                </div>
              </motion.div>
            )}
          </AnimatePresence>

          <Link to="/profile" className="flex items-center gap-3 pl-2">
             <span className="hidden sm:inline text-sm font-medium text-on-surface">Hồ Sơ</span>
             <div className="w-10 h-10 rounded-full overflow-hidden border-2 border-primary/20">
               <img 
                 src="https://picsum.photos/seed/user/100" 
                 alt="User Profile" 
                 className="w-full h-full object-cover"
                 referrerPolicy="no-referrer"
               />
             </div>
          </Link>
          <button 
            onClick={handleLogout}
            className="hidden sm:block px-6 py-2.5 rounded-full font-bold border border-[#fca5a5] text-[#f87171] hover:bg-red-50 transition-all text-sm"
          >
            Đăng Xuất
          </button>
        </div>
      </div>
    </nav>
  );
}
