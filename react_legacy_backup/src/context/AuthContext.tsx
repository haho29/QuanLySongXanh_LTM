import React, { createContext, useContext, useState, ReactNode, useEffect } from 'react';

interface UserProfile {
  username: string;
  fullName: string;
  email: string;
  job?: string;
  location?: string;
  isAdmin: boolean;
}

interface AuthContextType {
  user: UserProfile | null;
  isAdmin: boolean;
  login: (username: string, password: string) => { success: boolean, error?: string };
  register: (userData: any) => { success: boolean, error?: string };
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<UserProfile | null>(() => {
    const savedUser = localStorage.getItem('greenlife_current_user');
    return savedUser ? JSON.parse(savedUser) : null;
  });

  const [users, setUsers] = useState<any[]>(() => {
    const savedUsers = localStorage.getItem('greenlife_users_list');
    // Default demo user
    const defaultUser = { username: 'demo@greenlife.vn', password: 'demo123', fullName: 'Demo User', email: 'demo@greenlife.vn', isAdmin: false };
    return savedUsers ? JSON.parse(savedUsers) : [defaultUser];
  });

  useEffect(() => {
    localStorage.setItem('greenlife_users_list', JSON.stringify(users));
  }, [users]);

  useEffect(() => {
    if (user) {
      localStorage.setItem('greenlife_current_user', JSON.stringify(user));
      localStorage.setItem('greenlife_is_admin', user.isAdmin ? 'true' : 'false');
    } else {
      localStorage.removeItem('greenlife_current_user');
      localStorage.removeItem('greenlife_is_admin');
    }
  }, [user]);

  const login = (username: string, password: string) => {
    // Admin check
    if (username === 'admin' && password === 'admin123') {
      const adminUser = { username: 'admin', fullName: 'Administrator', email: 'admin@greenlife.vn', isAdmin: true };
      setUser(adminUser);
      return { success: true };
    }

    // User check
    const foundUser = users.find(u => u.username === username || u.email === username);
    
    if (!foundUser) {
      return { success: false, error: 'Tên đăng nhập không tồn tại. Vui lòng tạo tài khoản mới!' };
    }

    if (foundUser.password !== password) {
      return { success: false, error: 'Mật khẩu không chính xác.' };
    }

    const { password: _, ...profile } = foundUser;
    setUser(profile);
    return { success: true };
  };

  const register = (userData: any) => {
    const userExists = users.some(u => u.email === userData.email || u.username === userData.email);
    if (userExists) {
      return { success: false, error: 'Email hoặc tên đăng nhập đã tồn tại.' };
    }

    const newUser = { 
      ...userData, 
      username: userData.email, // Use email as username for simplicity
      isAdmin: false 
    };

    setUsers(prev => [...prev, newUser]);
    return { success: true };
  };

  const logout = () => {
    setUser(null);
  };

  const isAdmin = user?.isAdmin || false;

  return (
    <AuthContext.Provider value={{ user, isAdmin, login, register, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
