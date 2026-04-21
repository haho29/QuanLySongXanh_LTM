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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String job = request.getParameter("job");
        String location = request.getParameter("location");
        String password = request.getParameter("password");
        
        // Tạo object User (fullName mặc định bằng username)
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setFullName(username); 
        newUser.setEmail(email);
        newUser.setJob(job);
        newUser.setLocation(location);
        newUser.setPassword(password);
        
        boolean isSuccess = userDAO.register(newUser);
        if (isSuccess) {
            // Đăng ký thành công, yêu cầu người dùng đăng nhập lại
            request.setAttribute("successMessage", "Tạo tài khoản thành công! Vui lòng đăng nhập để tiếp tục.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        } else {
            // Đăng ký thất bại
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc email đã tồn tại. Xin vui lòng thử lại.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
