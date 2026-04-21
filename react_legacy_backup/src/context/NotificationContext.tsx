import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';

export interface Notification {
  id: string;
  title: string;
  message: string;
  type: 'goal' | 'activity' | 'system';
  timestamp: Date;
  read: boolean;
}

interface NotificationContextType {
  notifications: Notification[];
  unreadCount: number;
  addNotification: (notification: Omit<Notification, 'id' | 'timestamp' | 'read'>) => void;
  markAsRead: (id: string) => void;
  markAllAsRead: () => void;
  requestPushPermission: () => Promise<boolean>;
}

const NotificationContext = createContext<NotificationContextType | undefined>(undefined);

export function NotificationProvider({ children }: { children: ReactNode }) {
  const [notifications, setNotifications] = useState<Notification[]>(() => {
    const saved = localStorage.getItem('greenlife_notifications');
    if (saved) {
      try {
        const parsed = JSON.parse(saved);
        return parsed.map((n: any) => ({ ...n, timestamp: new Date(n.timestamp) }));
      } catch (e) {
        return [];
      }
    }
    return [];
  });

  useEffect(() => {
    localStorage.setItem('greenlife_notifications', JSON.stringify(notifications));
  }, [notifications]);

  const unreadCount = notifications.filter(n => !n.read).length;

  const addNotification = (n: Omit<Notification, 'id' | 'timestamp' | 'read'>) => {
    const newNotification: Notification = {
      ...n,
      id: Math.random().toString(36).substring(2, 9),
      timestamp: new Date(),
      read: false,
    };
    
    setNotifications(prev => {
      const updated = [newNotification, ...prev];
      return updated.slice(0, 50); // Keep last 50
    });

    // Trigger browser notification if permitted
    if ('Notification' in window && Notification.permission === 'granted') {
      new window.Notification(n.title, {
        body: n.message,
        icon: '/favicon.ico', // Fallback to favicon
      });
    }
  };

  const markAsRead = (id: string) => {
    setNotifications(prev => prev.map(n => n.id === id ? { ...n, read: true } : n));
  };

  const markAllAsRead = () => {
    setNotifications(prev => prev.map(n => ({ ...n, read: true })));
  };

  const requestPushPermission = async () => {
    if (!('Notification' in window)) {
      console.warn("Trình duyệt không hỗ trợ thông báo đẩy.");
      return false;
    }

    const permission = await window.Notification.requestPermission();
    if (permission === 'granted') {
      addNotification({
        title: 'Thông báo đẩy đã được kích hoạt',
        message: 'Bạn sẽ nhận được nhắc nhở về mục tiêu và hoạt động xanh mới trực tiếp trên trình duyệt.',
        type: 'system'
      });
      return true;
    }
    return false;
  };

  // Initial welcome and Periodic Activity Simulator
  useEffect(() => {
    if (notifications.length === 0) {
      addNotification({
        title: 'Chào mừng bạn đến với GreenLife!',
        message: 'Hãy bắt đầu hành trình sống xanh của bạn bằng cách đặt mục tiêu đầu tiên.',
        type: 'system'
      });
    }

    // Simulate a random "Green Activity" every 3 minutes (180000ms)
    // Only if the window is active to avoid annoyance in background for this local demo
    const interval = setInterval(() => {
      const activities = [
        "Cuộc thi 'Giờ Trái Đất' vừa bắt đầu. Tham gia ngay!",
        "Thành viên Phương Anh vừa đạt hạng #1 BXH. Bạn có muốn bứt phá?",
        "Hôm nay trời đẹp, hãy thử đi bộ đi học để nhận 100 XP nhé!",
        "Phòng trào 'Ký túc xá không rác thải nhựa' đang được hưởng ứng mạnh mẽ."
      ];
      const randomMsg = activities[Math.floor(Math.random() * activities.length)];
      
      addNotification({
        title: 'Hoạt Động Xanh Mới',
        message: randomMsg,
        type: 'activity'
      });
    }, 180000);

    return () => clearInterval(interval);
  }, []);

  return (
    <NotificationContext.Provider value={{ 
      notifications, 
      unreadCount, 
      addNotification, 
      markAsRead, 
      markAllAsRead,
      requestPushPermission
    }}>
      {children}
    </NotificationContext.Provider>
  );
}

export function useNotifications() {
  const context = useContext(NotificationContext);
  if (context === undefined) {
    throw new Error('useNotifications must be used within a NotificationProvider');
  }
  return context;
}
