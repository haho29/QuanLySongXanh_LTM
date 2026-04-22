package com.greenlife.controller;

import com.greenlife.dao.GoalDAO;
import com.greenlife.dao.ProgressDAO;
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

    @Override
    public void init() {
        goalDAO = new GoalDAO();
        progressDAO = new ProgressDAO();
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
        
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}
