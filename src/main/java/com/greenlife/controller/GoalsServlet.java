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
import com.greenlife.dao.NotificationDAO;
import com.greenlife.model.Notification;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;

@WebServlet("/goals")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class GoalsServlet extends HttpServlet {
    private GoalDAO goalDAO;
    private ProgressDAO progressDAO;
    private NotificationDAO notificationDAO;

    @Override
    public void init() {
        goalDAO = new GoalDAO();
        progressDAO = new ProgressDAO();
        notificationDAO = new NotificationDAO();
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
            if(goalIdParam == null) goalIdParam = request.getParameter("id");
            int goalId = Integer.parseInt(goalIdParam);
            String title = request.getParameter("title");
            String notes = request.getParameter("notes");
            
            // Check if already checked in today
            if (progressDAO.hasCheckedInToday(user.getId(), goalId)) {
                request.getSession().setAttribute("error", "Bạn đã check-in mục tiêu này trong hôm nay rồi. Hãy quay lại vào ngày mai nhé!");
                response.sendRedirect(request.getContextPath() + "/goals");
                return;
            }
            
            // Handle image upload
            String imageUrl = null;
            try {
                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "checkins";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    
                    filePart.write(uploadPath + File.separator + fileName);
                    imageUrl = "uploads/checkins/" + fileName;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Update Goal
            goalDAO.updateProgress(goalId);
            // Add Progress log
            progressDAO.addProgress(new Progress(0, user.getId(), goalId, title != null ? ("Check-in: " + title) : "Check-in mục tiêu", 10, notes, imageUrl, null));
            
            // Add Notification
            notificationDAO.addNotification(new Notification(
                0, user.getId(), "Cập nhật tiến độ", 
                "Bạn vừa thực hiện check-in cho mục tiêu: " + (title != null ? title : "Mục tiêu của bạn") + ". +10 điểm xanh!", 
                "POINTS", false, new java.util.Date()
            ));
            
            request.getSession().setAttribute("success", "Check-in thành công! +10 điểm xanh.");
        }

        // Redirect back to goals
        response.sendRedirect(request.getContextPath() + "/goals");
    }
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "unknown";
    }
}
