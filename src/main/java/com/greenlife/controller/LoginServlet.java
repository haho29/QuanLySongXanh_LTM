package com.greenlife.controller;

import com.greenlife.dao.UserDAO;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userOrEmail = request.getParameter("username");
        String pass = request.getParameter("password");
        
        // Trim inputs to avoid whitespace issues
        userOrEmail = (userOrEmail != null) ? userOrEmail.trim() : "";
        pass = (pass != null) ? pass.trim() : "";
        
        User user = userDAO.login(userOrEmail, pass);
        if (user != null) {
            if ("INACTIVE".equals(user.getStatus())) {
                request.setAttribute("errorMessage", "Tài khoản của bạn đã bị khóa hoặc chưa kích hoạt.");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
                return;
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            
            if (user.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        } else {
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không chính xác.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
