package com.greenlife.controller;

import com.greenlife.dao.GoalDAO;
import com.greenlife.dao.ProgressDAO;
import com.greenlife.dao.UserDAO;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private GoalDAO goalDAO;
    private ProgressDAO progressDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        goalDAO = new GoalDAO();
        progressDAO = new ProgressDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("currentUser");
            if (user != null) {
                // Fetch stats for personalized home page
                int totalPoints = progressDAO.getTotalPoints(user.getId());
                int userActiveGoals = (int) goalDAO.getGoalsByUserId(user.getId()).stream()
                                            .filter(g -> !"COMPLETED".equals(g.getStatus()))
                                            .count();
                int streak = progressDAO.getCurrentStreak(user.getId());
                
                request.setAttribute("userPoints", totalPoints);
                request.setAttribute("userActiveGoals", userActiveGoals);
                request.setAttribute("userStreak", streak);
            }
        }
        
        // System-wide stats for all visitors
        int totalUsers = userDAO.getTotalUsersCount();
        int totalGoals = goalDAO.getAllGoals().size();
        int completedGoals = goalDAO.getCompletedGoalsCount();
        int completionRate = totalGoals > 0 ? (int)((double)completedGoals / totalGoals * 100) : 0;
        int totalEcoActions = progressDAO.getTotalCheckinsCount();
        
        // Make sure it doesn't look empty when the app just launched
        request.setAttribute("sysTotalUsers", totalUsers > 0 ? totalUsers : 1);
        request.setAttribute("sysTotalGoals", totalGoals > 0 ? totalGoals : 1);
        request.setAttribute("sysCompletionRate", completionRate > 0 ? completionRate : 100);
        request.setAttribute("sysEcoActions", totalEcoActions > 0 ? totalEcoActions : 1);
        
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}
