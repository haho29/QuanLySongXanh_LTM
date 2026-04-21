package com.greenlife.controller;

import com.greenlife.dao.GoalDAO;
import com.greenlife.model.Goal;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import com.greenlife.dao.ProgressDAO;
import com.greenlife.model.Progress;

@WebServlet("/goals")
public class GoalsServlet extends HttpServlet {
    private GoalDAO goalDAO;
    private ProgressDAO progressDAO;

    @Override
    public void init() {
        goalDAO = new GoalDAO();
        progressDAO = new ProgressDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<Goal> goals = goalDAO.getGoalsByUserId(user.getId());
        request.setAttribute("goals", goals);
        request.getRequestDispatcher("/views/goals.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String title = request.getParameter("title");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String endDateStr = request.getParameter("end_date");
            
            java.util.Date endDate = null;
            if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                try {
                    endDate = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(endDateStr);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // Accept both 'target_progress' (from JSP) and 'target' as fallback
            String targetParam = request.getParameter("target_progress");
            if(targetParam == null) targetParam = request.getParameter("target");
            
            int target = targetParam != null ? Integer.parseInt(targetParam) : 30; // updated to 30 based on new design default
            Goal newGoal = new Goal(0, user.getId(), title, category, description, endDate, target, 0, "PENDING");
            goalDAO.addGoal(newGoal);
        } else if ("check_in".equals(action)) {
            String goalIdParam = request.getParameter("goal_id");
            if(goalIdParam == null) goalIdParam = request.getParameter("goalId");
            int goalId = Integer.parseInt(goalIdParam);
            String title = request.getParameter("title");
            
            // Update Goal
            goalDAO.updateProgress(goalId);
            // Add Progress log
            progressDAO.addProgress(new Progress(0, user.getId(), goalId, title != null ? ("Check-in: " + title) : "Check-in mục tiêu", 10, null));
        }

        // Redirect back to goals
        response.sendRedirect(request.getContextPath() + "/goals");
    }
}
