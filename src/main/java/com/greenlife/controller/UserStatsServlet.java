package com.greenlife.controller;

import com.greenlife.dao.GoalDAO;
import com.greenlife.dao.ProgressDAO;
import com.greenlife.model.Goal;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/user/stats")
public class UserStatsServlet extends HttpServlet {
    private ProgressDAO progressDAO = new ProgressDAO();
    private GoalDAO goalDAO = new GoalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("currentUser");
        String range = request.getParameter("range");
        if (range == null) range = "week";

        // 1. Points Stats
        Map<String, Integer> pointsMap = progressDAO.getPointsStatsByUserId(user.getId(), range);
        int days = "month".equals(range) ? 30 : 7;
        
        List<String> labels = new ArrayList<>();
        List<Integer> pointsData = new ArrayList<>();
        
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter labelFormatter = DateTimeFormatter.ofPattern("dd/MM");

        for (int i = days - 1; i >= 0; i--) {
            LocalDate d = today.minusDays(i);
            String dStr = d.format(formatter);
            labels.add("\"" + d.format(labelFormatter) + "\"");
            pointsData.add(pointsMap.getOrDefault(dStr, 0));
        }

        // 2. Completion by Category
        Map<String, int[]> categoryStats = goalDAO.getCategoryStats(); // This is global, but we can filter or use it as is for UI context
        // Actually, let's get personal category stats
        List<Goal> personalGoals = goalDAO.getGoalsByUserId(user.getId());
        Map<String, Integer> personalCompletedByCat = new HashMap<>();
        for (Goal g : personalGoals) {
            if ("COMPLETED".equals(g.getStatus())) {
                personalCompletedByCat.put(g.getCategory(), personalCompletedByCat.getOrDefault(g.getCategory(), 0) + 1);
            }
        }

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{");
        out.print("\"labels\": [" + String.join(",", labels) + "],");
        
        StringBuilder pointsSb = new StringBuilder();
        for (int i = 0; i < pointsData.size(); i++) {
            pointsSb.append(pointsData.get(i));
            if (i < pointsData.size() - 1) pointsSb.append(",");
        }
        out.print("\"pointsData\": [" + pointsSb.toString() + "],");
        
        // Personal categories
        out.print("\"categories\": {");
        int count = 0;
        for (Map.Entry<String, Integer> entry : personalCompletedByCat.entrySet()) {
            out.print("\"" + entry.getKey() + "\": " + entry.getValue());
            if (++count < personalCompletedByCat.size()) out.print(",");
        }
        out.print("}");
        out.print("}");
        out.flush();
    }
}
