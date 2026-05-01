package com.greenlife.controller;

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
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/stats")
public class AdminStatsServlet extends HttpServlet {
    private UserDAO userDAO;
    private ProgressDAO progressDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        progressDAO = new ProgressDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("currentUser");
            if (user != null && user.isAdmin()) {
                String topic = request.getParameter("topic");
                String range = request.getParameter("range");
                
                if (topic == null) topic = "users";
                if (range == null) range = "week";

                Map<String, Integer> stats;
                if ("checkins".equals(topic)) {
                    stats = progressDAO.getCheckinStats(range);
                } else if ("points".equals(topic)) {
                    stats = progressDAO.getPointsStats(range);
                } else {
                    stats = userDAO.getNewUsersStats(range);
                }

                // Process data to match exactly last N days for the chart
                int days = "month".equals(range) ? 30 : 7;
                List<String> labels = new ArrayList<>();
                List<Integer> data = new ArrayList<>();
                
                LocalDate today = LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                DateTimeFormatter labelFormatter = DateTimeFormatter.ofPattern("dd/MM");

                int total = 0;
                int max = -1;
                String maxLabel = "";

                for (int i = days - 1; i >= 0; i--) {
                    LocalDate d = today.minusDays(i);
                    String dStr = d.format(formatter);
                    String lStr = d.format(labelFormatter);
                    labels.add("\"" + lStr + "\"");
                    
                    int val = stats.getOrDefault(dStr, 0);
                    data.add(val);
                    
                    total += val;
                    if (val > max) {
                        max = val;
                        maxLabel = lStr;
                    }
                }
                
                int avg = days > 0 ? total / days : 0;

                response.setContentType("application/json; charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{");
                out.print("\"labels\": [" + String.join(",", labels) + "],");
                
                // Construct string array for data
                StringBuilder dataSb = new StringBuilder();
                for (int i = 0; i < data.size(); i++) {
                    dataSb.append(data.get(i));
                    if (i < data.size() - 1) dataSb.append(",");
                }
                out.print("\"data\": [" + dataSb.toString() + "],");
                out.print("\"total\": " + total + ",");
                out.print("\"average\": " + avg + ",");
                out.print("\"max\": " + max + ",");
                out.print("\"maxLabel\": \"" + maxLabel + "\"");
                out.print("}");
                out.flush();
                return;
            }
        }
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
    }
}
