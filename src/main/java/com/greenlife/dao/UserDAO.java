package com.greenlife.dao;

import com.greenlife.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public User login(String emailOrUsername, String password) {
        String sql = "SELECT * FROM Users WHERE (username = ? OR email = ?) AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO Users (username, password, fullName, email, job, location, role) VALUES (?, ?, ?, ?, ?, ?, 'USER')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getJob());
            ps.setString(6, user.getLocation());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private User extractUser(ResultSet rs) throws Exception {
        User u = new User(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("fullName"),
            rs.getString("email"),
            rs.getString("job"),
            rs.getString("location"),
            rs.getString("role"),
            hasColumn(rs, "created_at") && rs.getTimestamp("created_at") != null ? new java.util.Date(rs.getTimestamp("created_at").getTime()) : null
        );
        if (hasColumn(rs, "status")) {
            u.setStatus(rs.getString("status"));
        } else {
            u.setStatus("ACTIVE"); // Default
        }
        if (hasColumn(rs, "goals_count")) {
            u.setGoalsCount(rs.getInt("goals_count"));
        }
        return u;
    }

    private boolean hasColumn(ResultSet rs, String columnName) {
        try {
            rs.findColumn(columnName);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    // Admin statistics: Get user registration counts by day in a given period ('week' or 'month')
    public java.util.Map<String, Integer> getNewUsersStats(String range) {
        java.util.Map<String, Integer> stats = new java.util.LinkedHashMap<>();
        String sql;
        if ("month".equals(range)) {
            // Get last 30 days
            sql = "SELECT CAST(created_at AS DATE) as dDate, COUNT(*) as cnt " +
                  "FROM Users WHERE created_at >= DATEADD(day, -30, GETDATE()) " +
                  "GROUP BY CAST(created_at AS DATE) ORDER BY dDate";
        } else {
            // Get last 7 days ('week' by default)
            sql = "SELECT CAST(created_at AS DATE) as dDate, COUNT(*) as cnt " +
                  "FROM Users WHERE created_at >= DATEADD(day, -7, GETDATE()) " +
                  "GROUP BY CAST(created_at AS DATE) ORDER BY dDate";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String dateStr = rs.getDate("dDate").toString();
                stats.put(dateStr, rs.getInt("cnt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    public List<User> getTopUsersByPoints(int limit) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, ISNULL(SUM(p.points_earned), 0) as total_points " +
                     "FROM Users u " +
                     "LEFT JOIN Progress p ON u.id = p.user_id " +
                     "WHERE u.role = 'USER' " +
                     "GROUP BY u.id, u.username, u.password, u.fullName, u.email, u.job, u.location, u.role " +
                     "ORDER BY total_points DESC";
        // Need to append TOP limit syntax for SQL Server or just read up to 'limit'
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            int count = 0;
            while (rs.next() && count < limit) {
                User u = extractUser(rs);
                u.setPoints(rs.getInt("total_points"));
                // Mock streak for now
                u.setRunStreak((count == 0) ? 14 : (count == 1) ? 12 : (count == 2) ? 8 : 3);
                list.add(u);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalUsersCount() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {}
        return 0;
    }

    public int getNewUsersThisWeekCount() {
        String sql = "SELECT COUNT(*) FROM Users WHERE created_at >= DATEADD(day, -7, GETDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {}
        return 0;
    }

    public List<User> getUsersAdmin(String search, String statusFilter) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT u.*, " +
            "ISNULL((SELECT SUM(points_earned) FROM Progress p WHERE p.user_id = u.id), 0) as total_points, " +
            "(SELECT COUNT(*) FROM Goals g WHERE g.user_id = u.id) as goals_count " +
            "FROM Users u " +
            "WHERE u.role = 'USER' "
        );

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.username LIKE ? OR u.fullName LIKE ?) ");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equalsIgnoreCase("all")) {
            sql.append(" AND u.status = ? ");
        }

        sql.append("ORDER BY u.created_at DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
             
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equalsIgnoreCase("all")) {
                ps.setString(paramIndex++, statusFilter.toUpperCase());
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = extractUser(rs);
                u.setPoints(rs.getInt("total_points"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
