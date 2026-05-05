package com.greenlife.dao;

import com.greenlife.model.Goal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GoalDAO {
    public List<Goal> getGoalsByUserId(int userId) {
        List<Goal> goals = new ArrayList<>();
        String sql = "SELECT * FROM Goals WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                goals.add(new Goal(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("title"),
                    rs.getString("category"),
                    rs.getString("description"),
                    rs.getTimestamp("end_date") != null ? new java.util.Date(rs.getTimestamp("end_date").getTime()) : null,
                    rs.getInt("target_progress"),
                    rs.getInt("current_progress"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return goals;
    }

    public List<Goal> getAllGoals() {
        List<Goal> goals = new ArrayList<>();
        String sql = "SELECT * FROM Goals";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                goals.add(new Goal(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("title"),
                    rs.getString("category"),
                    rs.getString("description"),
                    rs.getTimestamp("end_date") != null ? new java.util.Date(rs.getTimestamp("end_date").getTime()) : null,
                    rs.getInt("target_progress"),
                    rs.getInt("current_progress"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return goals;
    }

    public boolean addGoal(Goal goal) {
        String sql = "INSERT INTO Goals (user_id, title, category, description, end_date, target_progress, status) VALUES (?, ?, ?, ?, ?, ?, 'PENDING')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, goal.getUserId());
            ps.setString(2, goal.getTitle());
            ps.setString(3, goal.getCategory());
            ps.setString(4, goal.getDescription());
            if (goal.getEndDate() != null) {
                ps.setTimestamp(5, new java.sql.Timestamp(goal.getEndDate().getTime()));
            } else {
                ps.setNull(5, java.sql.Types.TIMESTAMP);
            }
            ps.setInt(6, goal.getTargetProgress());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProgress(int goalId) {
        // Increment progress by 1. Keep it capped at target_progress.
        // Also update status to 'COMPLETED' if current_progress >= target_progress.
        String sql = "UPDATE Goals SET current_progress = current_progress + 1, " +
                     "status = CASE WHEN current_progress + 1 >= target_progress THEN 'COMPLETED' ELSE status END " +
                     "WHERE id = ? AND current_progress < target_progress";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, goalId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Goal getGoalById(int goalId) {
        String sql = "SELECT * FROM Goals WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, goalId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Goal(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("title"),
                    rs.getString("category"),
                    rs.getString("description"),
                    rs.getTimestamp("end_date") != null ? new java.util.Date(rs.getTimestamp("end_date").getTime()) : null,
                    rs.getInt("target_progress"),
                    rs.getInt("current_progress"),
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Goal> getPendingGoals() {
        List<Goal> goals = new ArrayList<>();
        String sql = "SELECT * FROM Goals WHERE status = 'PENDING'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                goals.add(new Goal(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("title"),
                    rs.getString("category"),
                    rs.getString("description"),
                    rs.getTimestamp("end_date") != null ? new java.util.Date(rs.getTimestamp("end_date").getTime()) : null,
                    rs.getInt("target_progress"),
                    rs.getInt("current_progress"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return goals;
    }

    public boolean updateGoalStatus(int goalId, String status) {
        String sql = "UPDATE Goals SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, goalId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getActiveGoalsCount() {
        String sql = "SELECT COUNT(*) FROM Goals WHERE status IN ('PENDING', 'IN_PROGRESS')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {}
        return 0;
    }

    public int getCompletedGoalsCount() {
        String sql = "SELECT COUNT(*) FROM Goals WHERE status = 'COMPLETED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {}
        return 0;
    }

    // Returns mapping: Category Name -> Integer array [0: Total Goals, 1: Completed Goals]
    public java.util.Map<String, int[]> getCategoryStats() {
        java.util.Map<String, int[]> stats = new java.util.HashMap<>();
        String sql = "SELECT category, COUNT(*) as total, " +
                     "SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) as completed " +
                     "FROM Goals GROUP BY category";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getString("category"), new int[]{rs.getInt("total"), rs.getInt("completed")});
            }
        } catch (Exception e) {}
        return stats;
    }
    public boolean deleteGoal(int goalId) {
        String sql = "DELETE FROM Goals WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, goalId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Goal> getCompletedGoalsByUserId(int userId) {
        List<Goal> goals = new ArrayList<>();
        String sql = "SELECT * FROM Goals WHERE user_id = ? AND status = 'COMPLETED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                goals.add(new Goal(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("title"),
                    rs.getString("category"),
                    rs.getString("description"),
                    rs.getTimestamp("end_date") != null ? new java.util.Date(rs.getTimestamp("end_date").getTime()) : null,
                    rs.getInt("target_progress"),
                    rs.getInt("current_progress"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return goals;
    }

    public java.util.Map<String, Integer> getCompletionStats(String range) {
        java.util.Map<String, Integer> stats = new java.util.LinkedHashMap<>();
        int days = "month".equals(range) ? 30 : 7;
        
        String sql = "SELECT CAST(max_created_at AS DATE) as dDate, COUNT(*) as cnt " +
                     "FROM ( " +
                     "    SELECT goal_id, MAX(created_at) as max_created_at " +
                     "    FROM Progress " +
                     "    WHERE goal_id IN (SELECT id FROM Goals WHERE status = 'COMPLETED') " +
                     "    GROUP BY goal_id " +
                     ") t " +
                     "WHERE max_created_at >= DATEADD(day, ?, GETDATE()) " +
                     "GROUP BY CAST(max_created_at AS DATE) " +
                     "ORDER BY dDate";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, -days);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                stats.put(rs.getDate("dDate").toString(), rs.getInt("cnt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }

    public List<java.util.Map<String, Object>> getCompletedGoalsWithUserInfo() {
        List<java.util.Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT g.*, u.fullName, u.username, t.completion_date " +
                     "FROM Goals g " +
                     "JOIN Users u ON g.user_id = u.id " +
                     "JOIN ( " +
                     "    SELECT goal_id, MAX(created_at) as completion_date " +
                     "    FROM Progress " +
                     "    GROUP BY goal_id " +
                     ") t ON g.id = t.goal_id " +
                     "WHERE g.status = 'COMPLETED' " +
                     "ORDER BY t.completion_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                java.util.Map<String, Object> map = new java.util.HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("title", rs.getString("title"));
                map.put("category", rs.getString("category"));
                map.put("fullName", rs.getString("fullName"));
                map.put("username", rs.getString("username"));
                map.put("completion_date", rs.getTimestamp("completion_date"));
                map.put("target_progress", rs.getInt("target_progress"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
