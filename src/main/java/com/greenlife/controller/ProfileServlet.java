package com.greenlife.controller;

import com.greenlife.dao.GoalDAO;
import com.greenlife.dao.UserDAO;
import com.greenlife.model.Goal;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO;
    private GoalDAO goalDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        goalDAO = new GoalDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch all goals for the user
        List<Goal> allGoals = goalDAO.getGoalsByUserId(user.getId());
        
        // Filter goals in progress vs completed
        List<Goal> activeGoals = allGoals.stream()
            .filter(g -> !"COMPLETED".equals(g.getStatus()))
            .collect(Collectors.toList());
        
        long completedCount = allGoals.stream()
            .filter(g -> "COMPLETED".equals(g.getStatus()))
            .count();

        // Fetch points and streak
        int totalPoints = userDAO.getUserPoints(user.getId());
        int streak = userDAO.calculateStreak(user.getId());

        // Fetch top users for mini-leaderboard
        List<User> topUsers = userDAO.getTopUsersByPoints(12);

        // Set attributes
        request.setAttribute("activeGoals", activeGoals);
        request.setAttribute("inProgressCount", activeGoals.size());
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("totalPoints", totalPoints);
        request.setAttribute("streak", streak);
        request.setAttribute("topUsers", topUsers);

        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
}
