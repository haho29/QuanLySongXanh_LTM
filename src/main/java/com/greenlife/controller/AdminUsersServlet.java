package com.greenlife.controller;

import com.greenlife.dao.UserDAO;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String search = request.getParameter("search");
        String status = request.getParameter("status");

        List<User> list = userDAO.getUsersAdmin(search, status);
        request.setAttribute("users", list);
        request.setAttribute("paramSearch", search != null ? search : "");
        request.setAttribute("paramStatus", status != null ? status : "all");

        request.getRequestDispatcher("/views/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                userDAO.deleteUser(userId);
            } catch (NumberFormatException e) {
                // Ignore
            }
        } else if ("toggle_status".equals(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String newStatus = request.getParameter("newStatus");
                userDAO.updateUserStatus(userId, newStatus);
            } catch (Exception e) {}
        }
        
        // redirect to GET retaining filters
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        String qs = "";
        if (search != null && !search.isEmpty()) qs += "search=" + search + "&";
        if (status != null && !status.isEmpty()) qs += "status=" + status;
        
        response.sendRedirect(request.getContextPath() + "/admin/users" + (!qs.isEmpty() ? "?" + qs : ""));
    }
}
