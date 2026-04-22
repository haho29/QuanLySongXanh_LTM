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
import com.greenlife.dao.UserDAO;
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
    private UserDAO userDAO;

    @Override
    public void init() {
        goalDAO = new GoalDAO();
        progressDAO = new ProgressDAO();
        notificationDAO = new NotificationDAO();
        userDAO = new UserDAO();
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

            String targetParam = request.getParameter("target_progress");
            if(targetParam == null) targetParam = request.getParameter("target");
            
            int target = targetParam != null ? Integer.parseInt(targetParam) : 30;
            Goal newGoal = new Goal(0, user.getId(), title, category, description, endDate, target, 0, "PENDING");
            goalDAO.addGoal(newGoal);
        } else if ("check_in".equals(action)) {
            String goalIdParam = request.getParameter("goal_id");
            if (goalIdParam == null || goalIdParam.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Không tìm thấy thông tin mục tiêu để check-in.");
                response.sendRedirect(request.getContextPath() + "/goals");
                return;
            }

            try {
                int goalId = Integer.parseInt(goalIdParam);
                String title = request.getParameter("title");
                String notes = request.getParameter("notes");
                
                System.out.println("[GoalsServlet] Checking in goalId: " + goalId + ", title: " + title);
                
                // 1. Check if already checked in today
                if (progressDAO.hasCheckedInToday(user.getId(), goalId)) {
                    System.out.println("[GoalsServlet] Already checked in today for userId: " + user.getId() + ", goalId: " + goalId);
                    request.getSession().setAttribute("error", "Bạn đã check-in mục tiêu này trong hôm nay rồi. Hãy quay lại vào ngày mai nhé!");
                    response.sendRedirect(request.getContextPath() + "/goals");
                    return;
                }
                
                // 2. Handle image upload
                String imageUrl = null;
                try {
                    Part filePart = request.getPart("image");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
                        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "checkins";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            boolean created = uploadDir.mkdirs();
                            System.out.println("[GoalsServlet] Upload directory created: " + created + " at " + uploadPath);
                        }
                        
                        filePart.write(uploadPath + File.separator + fileName);
                        imageUrl = "uploads/checkins/" + fileName;
                        System.out.println("[GoalsServlet] Image uploaded to: " + imageUrl);
                    }
                } catch (Exception e) {
                    System.err.println("[GoalsServlet] Error uploading image: " + e.getMessage());
                }
 
                // 3. Update Goal & Log Progress
                boolean updated = goalDAO.updateProgress(goalId);
                boolean logged = progressDAO.addProgress(new Progress(0, user.getId(), goalId, 
                    title != null ? ("Check-in: " + title) : "Check-in mục tiêu", 10, notes, imageUrl, null));
                
                System.out.println("[GoalsServlet] DB Update Result - Goal: " + updated + ", Progress Log: " + logged);

                if (logged) {
                    // 4. Calculate current streak
                    int currentStreak = userDAO.calculateStreak(user.getId());
                    String streakMsg = currentStreak > 1 ? (" Chuỗi hiện tại: " + currentStreak + " ngày! 🔥") : "";
 
                    // 5. Add Notification
                    notificationDAO.addNotification(new Notification(
                        0, user.getId(), "Cập nhật tiến độ", 
                        "Bạn vừa check-in: " + (title != null ? title : "mục tiêu") + ". +10 điểm xanh!" + streakMsg, 
                        "POINTS", false, new java.util.Date()
                    ));
                    request.getSession().setAttribute("success", "Check-in thành công! +10 điểm xanh." + streakMsg);
                } else {
                    request.getSession().setAttribute("error", "Có lỗi xảy ra khi lưu nhật ký tiến độ. Vui lòng thử lại.");
                }
            } catch (NumberFormatException e) {
                System.err.println("[GoalsServlet] Invalid goalId format: " + goalIdParam);
                request.getSession().setAttribute("error", "ID mục tiêu không hợp lệ.");
            } catch (Exception e) {
                System.err.println("[GoalsServlet] General error during check-in: " + e.getMessage());
                e.printStackTrace();
                request.getSession().setAttribute("error", "Lỗi xác nhận check-in: " + e.getMessage());
            }
        } else if ("delete".equals(action)) {
            try {
                int goalId = Integer.parseInt(request.getParameter("goal_id"));
                if (goalDAO.deleteGoal(goalId)) {
                    request.getSession().setAttribute("success", "Đã xóa mục tiêu thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể xóa mục tiêu này.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
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
