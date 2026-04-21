package com.greenlife.controller;

import com.greenlife.dao.ProgressDAO;
import com.greenlife.model.Progress;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import com.greenlife.dao.GoalDAO;
import com.greenlife.model.Goal;

@WebServlet("/progress")
public class ProgressServlet extends HttpServlet {
    private ProgressDAO progressDAO;
    private GoalDAO goalDAO;

    @Override
    public void init() {
        progressDAO = new ProgressDAO();
        goalDAO = new GoalDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Progress> progressList = progressDAO.getProgressByUserId(user.getId());
        List<Goal> userGoals = goalDAO.getGoalsByUserId(user.getId());
        
        long completedGoalsCount = userGoals.stream()
                .filter(g -> "COMPLETED".equals(g.getStatus()))
                .count();

        int totalActions = progressDAO.getTotalActivityCount(user.getId());
        int totalPoints = progressDAO.getTotalPoints(user.getId());
        
        List<Integer> chartData = progressDAO.getChartDataForLast7Days(user.getId());
        int streak = progressDAO.getCurrentStreak(user.getId());

        request.setAttribute("progressList", progressList);
        request.setAttribute("totalActions", totalActions);
        request.setAttribute("completedGoals", completedGoalsCount);
        request.setAttribute("totalPoints", totalPoints);
        request.setAttribute("chartData", chartData);
        request.setAttribute("streak", streak);
        request.setAttribute("totalGoals", userGoals.size());
        request.setAttribute("userGoals", userGoals); // Added for export modal list
        
        // Calculate a dummy mock completion percentage for pie chart
        int percentage = userGoals.isEmpty() ? 0 : (int) ((completedGoalsCount * 100) / userGoals.size());
        request.setAttribute("completionPercentage", percentage);

        // Calculate environmental impacts dynamically
        double co2Saved = totalPoints * 0.5;
        double waterSaved = totalPoints * 5.0;
        int plasticSaved = (int) (totalPoints * 0.2);
        request.setAttribute("co2Saved", String.format(java.util.Locale.US, "%.1f", co2Saved));
        request.setAttribute("waterSaved", (int) waterSaved);
        request.setAttribute("plasticSaved", plasticSaved);

        request.getRequestDispatcher("/views/progress.jsp").forward(request, response);
    }
}
