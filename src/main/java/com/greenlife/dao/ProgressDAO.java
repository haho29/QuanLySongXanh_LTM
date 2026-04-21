package com.greenlife.dao;

import com.greenlife.model.Progress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProgressDAO {
    public List<Progress> getProgressByUserId(int userId) {
        List<Progress> list = new ArrayList<>();
        String sql = "SELECT * FROM Progress WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Progress(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("goal_id"),
                    rs.getString("activity_name"),
                    rs.getInt("points_earned"),
                    rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addProgress(Progress progress) {
        String sql = "INSERT INTO Progress (user_id, goal_id, activity_name, points_earned) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, progress.getUserId());
            ps.setInt(2, progress.getGoalId());
            ps.setString(3, progress.getActivityName());
            ps.setInt(4, progress.getPointsEarned());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int getTotalPoints(int userId) {
        String sql = "SELECT SUM(points_earned) as total FROM Progress WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalActivityCount(int userId) {
        String sql = "SELECT COUNT(*) as total FROM Progress WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Integer> getChartDataForLast7Days(int userId) {
        List<Integer> data = new ArrayList<>();
        for(int i=0; i<7; i++) data.add(0);
        
        String sql = "SELECT DATEDIFF(day, created_at, GETDATE()) as days_ago, SUM(points_earned) as total " +
                     "FROM Progress " +
                     "WHERE user_id = ? AND created_at >= DATEADD(day, -6, CAST(GETDATE() AS DATE)) " +
                     "GROUP BY DATEDIFF(day, created_at, GETDATE())";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int daysAgo = rs.getInt("days_ago");
                if (daysAgo >= 0 && daysAgo < 7) {
                    data.set(6 - daysAgo, rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    public int getCurrentStreak(int userId) {
        // Mock streak based on total activity for now, 
        // real implementation would check consecutive dates
        return getTotalActivityCount(userId) / 2 + 1;
    }
}
