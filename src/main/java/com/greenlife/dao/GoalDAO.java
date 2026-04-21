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
}
