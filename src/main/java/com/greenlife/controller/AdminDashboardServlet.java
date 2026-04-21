package com.greenlife.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.greenlife.model.User;
import com.greenlife.dao.UserDAO;
import com.greenlife.dao.GoalDAO;
import com.greenlife.dao.ProgressDAO;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private UserDAO userDAO;
    private GoalDAO goalDAO;
    private ProgressDAO progressDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        goalDAO = new GoalDAO();
        progressDAO = new ProgressDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("currentUser");
            if (user != null && user.isAdmin()) {
                // Fetch dynamic stats for dashboard
                
                // 1. Top 4 Cards Stats
                request.setAttribute("totalUsersCount", userDAO.getTotalUsersCount());
                request.setAttribute("newUsersThisWeek", userDAO.getNewUsersThisWeekCount());
                request.setAttribute("activeGoalsCount", goalDAO.getActiveGoalsCount());
                request.setAttribute("completedGoalsCount", goalDAO.getCompletedGoalsCount());
                
                double co2Reduced = progressDAO.getCO2ReducedThisMonth();
                request.setAttribute("co2ReducedThisMonth", String.format("%.1f", co2Reduced));
                
                // 2. Main Stats (Category)
                request.setAttribute("categoryStats", goalDAO.getCategoryStats());
                
                // 3. Recent Activities
                request.setAttribute("recentActivities", progressDAO.getRecentActivities(6));
                
                // 4. Top Active Users
                request.setAttribute("topUsers", userDAO.getTopUsersByPoints(5));

                request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
