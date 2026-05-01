package com.greenlife.controller;

import com.greenlife.dao.GoalDAO;
import com.greenlife.dao.ProgressDAO;
import com.greenlife.dao.UserDAO;
import com.greenlife.model.Goal;
import com.greenlife.model.Progress;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/export")
public class ExportServlet extends HttpServlet {

    private GoalDAO goalDAO = new GoalDAO();
    private ProgressDAO progressDAO = new ProgressDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập");
            return;
        }

        String type = request.getParameter("type"); // 'admin' or 'user'
        String filter = request.getParameter("filter"); // optional: 'goals', 'history', 'users', 'all'

        String dateStr = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String filename;

        if ("admin".equals(type) && "ADMIN".equals(currentUser.getRole())) {
            filename = "GreenLife_Admin_BaoCao_" + dateStr + ".csv";
        } else {
            filename = "GreenLife_BaoCao_" + currentUser.getUsername() + "_" + dateStr + ".csv";
        }

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        try (PrintWriter out = response.getWriter()) {
            // Write BOM for UTF-8 so Excel opens Vietnamese characters correctly
            out.write('\ufeff');

            if ("admin".equals(type) && "ADMIN".equals(currentUser.getRole())) {
                exportAdminData(out, filter);
            } else {
                exportUserData(out, filter, currentUser.getId());
            }
        }
    }

    private void exportAdminData(PrintWriter out, String filter) {
        if (filter == null || filter.isEmpty()) {
            filter = "all";
        }
        
        String dateStr = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date());

        if (filter.equals("all") || filter.equals("overview")) {
            out.println("--- TỔNG QUAN HỆ THỐNG ---");
            out.println("Thời gian xuất:," + dateStr);
            out.println("Tổng Người Dùng:," + userDAO.getTotalUsersCount());
            out.println("Tổng Mục Tiêu:," + goalDAO.getAllGoals().size());
            out.println("Tổng Danh Mục:," + goalDAO.getCategoryStats().size());
            out.println("Mục Tiêu Đang Hoạt Động:," + goalDAO.getActiveGoalsCount());
            out.println("Mục Tiêu Hoàn Thành:," + goalDAO.getCompletedGoalsCount());
            out.println();
        }

        if (filter.equals("all") || filter.equals("categories")) {
            out.println("--- DANH SÁCH DANH MỤC ---");
            out.println("Tên Danh Mục,Tổng Mục Tiêu,Mục Tiêu Hoàn Thành");
            java.util.Map<String, int[]> catStats = goalDAO.getCategoryStats();
            for (String cat : catStats.keySet()) {
                int[] vals = catStats.get(cat);
                out.printf("\"%s\",%d,%d\n", escapeCSV(cat), vals[0], vals[1]);
            }
            out.println();
        }

        if (filter.equals("all") || filter.equals("users")) {
            out.println("--- DANH SÁCH NGƯỜI DÙNG ---");
            out.println("ID,Tên đăng nhập,Họ tên,Email,Nghề nghiệp,Địa điểm,Vai trò,Tổng Điểm");
            List<User> users = userDAO.getTopUsersByPoints(100000); // Fetch all users sorted by points
            for (User u : users) {
                out.printf("%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%d\n",
                        u.getId(), escapeCSV(u.getUsername()), escapeCSV(u.getFullName()), escapeCSV(u.getEmail()),
                        escapeCSV(u.getJob()), escapeCSV(u.getLocation()), escapeCSV(u.getRole()), u.getPoints());
            }
            out.println();
        }

        if (filter.equals("weekly_stats") || filter.equals("monthly_stats")) {
            String range = filter.equals("weekly_stats") ? "week" : "month";
            out.println("--- THỐNG KÊ THEO " + (range.equals("week") ? "TUẦN" : "THÁNG") + " ---");
            out.println("Ngày,Lượt Check-in,Điểm Xanh");
            
            java.util.Map<String, Integer> checkins = progressDAO.getCheckinStats(range);
            java.util.Map<String, Integer> points = progressDAO.getPointsStats(range);
            
            for (String date : checkins.keySet()) {
                int cCount = checkins.get(date);
                int pCount = points.getOrDefault(date, 0);
                out.printf("\"%s\",%d,%d\n", escapeCSV(date), cCount, pCount);
            }
            out.println();
        }

        if (filter.equals("all") || filter.equals("community")) {
            out.println("--- BẢNG XẾP HẠNG CỘNG ĐỒNG ---");
            out.println("Hạng,Khu vực,Số Thành Viên,Tổng Điểm Xanh");
            List<java.util.Map<String, Object>> ranking = userDAO.getCommunityRanking();
            for (java.util.Map<String, Object> map : ranking) {
                out.printf("%d,\"%s\",%d,%d\n",
                        (Integer) map.get("rank"), escapeCSV((String) map.get("location")),
                        (Integer) map.get("members"), (Integer) map.get("total_points"));
            }
            out.println();
        }
    }

    private void exportUserData(PrintWriter out, String filter, int userId) {
        if (filter == null || filter.equals("all") || filter.equals("goals")) {
            out.println("--- MỤC TIÊU CÁ NHÂN ---");
            out.println("ID,Tiêu Đề,Danh Mục,Ngày kết thúc,Số lượng cần đạt,Tiến độ hiện tại,Trạng Thái");
            List<Goal> goals = goalDAO.getGoalsByUserId(userId);
            for (Goal g : goals) {
                out.printf("%d,\"%s\",\"%s\",\"%s\",%d,%d,\"%s\"\n",
                        g.getId(), escapeCSV(g.getTitle()), escapeCSV(g.getCategory()),
                        escapeCSV(g.getEndDate() != null ? g.getEndDate().toString() : ""),
                        g.getTargetProgress(), g.getCurrentProgress(), escapeCSV(g.getStatus()));
            }
            out.println();
        }

        if (filter == null || filter.equals("all") || filter.equals("history")) {
            out.println("--- LỊCH SỬ CHECK-IN ---");
            out.println("ID,ID Mục Tiêu,Hành động thực hiện,Điểm Môi trường,Thời gian ghi nhận");
            List<Progress> progressList = progressDAO.getProgressByUserId(userId);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            for (Progress p : progressList) {
                out.printf("%d,%d,\"%s\",%d,\"%s\"\n",
                        p.getId(), p.getGoalId(), escapeCSV(p.getActivityName()), p.getPointsEarned(),
                        escapeCSV(p.getCreatedAt() != null ? sdf.format(p.getCreatedAt()) : ""));
            }
        }
    }

    private String escapeCSV(String value) {
        if (value == null) return "";
        return value.replace("\"", "\"\"");
    }
}
