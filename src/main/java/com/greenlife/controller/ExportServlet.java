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
        if (filter == null || filter.equals("all") || filter.equals("users")) {
            out.println("--- DANH SÁCH TẤT CẢ NGƯỜI DÙNG ---");
            out.println("ID,Tên đăng nhập,Họ tên,Email,Nghề nghiệp,Địa điểm,Vai trò");
            List<User> users = userDAO.getAllUsers();
            for (User u : users) {
                out.printf("%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                        u.getId(), escapeCSV(u.getUsername()), escapeCSV(u.getFullName()), escapeCSV(u.getEmail()),
                        escapeCSV(u.getJob()), escapeCSV(u.getLocation()), escapeCSV(u.getRole()));
            }
            out.println();
        }

        if (filter == null || filter.equals("all") || filter.equals("goals") || filter.equals("categories")) {
            out.println("--- DANH SÁCH TẤT CẢ MỤC TIÊU ---");
            out.println("ID,ID Người Dùng,Tiêu Đề,Danh Mục,Mô tả,Ngày kết thúc,Cần đạt,Đã đạt,Trạng Thái");
            List<Goal> goals = goalDAO.getAllGoals();
            for (Goal g : goals) {
                out.printf("%d,%d,\"%s\",\"%s\",\"%s\",\"%s\",%d,%d,\"%s\"\n",
                        g.getId(), g.getUserId(), escapeCSV(g.getTitle()), escapeCSV(g.getCategory()),
                        escapeCSV(g.getDescription()), escapeCSV(g.getEndDate() != null ? g.getEndDate().toString() : ""),
                        g.getTargetProgress(), g.getCurrentProgress(), escapeCSV(g.getStatus()));
            }
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
