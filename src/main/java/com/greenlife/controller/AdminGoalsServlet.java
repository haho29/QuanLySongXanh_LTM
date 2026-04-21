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

@WebServlet("/admin/goals")
public class AdminGoalsServlet extends HttpServlet {
    private GoalDAO goalDAO;

    @Override
    public void init() {
        goalDAO = new GoalDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Goal> pendingGoals = goalDAO.getPendingGoals();
        List<Goal> allGoals = goalDAO.getAllGoals(); // Still fetch all for other tabs if any
        request.setAttribute("pendingGoals", pendingGoals);
        request.setAttribute("goals", allGoals);
        request.getRequestDispatcher("/views/admin/goals.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String goalIdStr = request.getParameter("goal_id");
        
        if (goalIdStr != null && !goalIdStr.isEmpty()) {
            int goalId = Integer.parseInt(goalIdStr);
            if ("approve".equals(action)) {
                goalDAO.updateGoalStatus(goalId, "IN_PROGRESS");
            } else if ("reject".equals(action)) {
                goalDAO.updateGoalStatus(goalId, "REJECTED");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/goals");
    }
}
