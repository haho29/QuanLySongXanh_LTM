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
                    rs.getString("notes"),
                    rs.getString("image_url"),
                    rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addProgress(Progress progress) {
        String sql = "INSERT INTO Progress (user_id, goal_id, activity_name, points_earned, notes, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, progress.getUserId());
            ps.setInt(2, progress.getGoalId());
            ps.setString(3, progress.getActivityName());
            ps.setInt(4, progress.getPointsEarned());
            ps.setString(5, progress.getNotes());
            ps.setString(6, progress.getImageUrl());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hasCheckedInToday(int userId, int goalId) {
        String sql = "SELECT COUNT(*) FROM Progress WHERE user_id = ? AND goal_id = ? AND CAST(created_at AS DATE) = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, goalId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
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

    // Admin statistics: Get checkin count by day in a given period
    public java.util.Map<String, Integer> getCheckinStats(String range) {
        java.util.Map<String, Integer> stats = new java.util.LinkedHashMap<>();
        String sql;
        if ("month".equals(range)) {
            sql = "SELECT CAST(created_at AS DATE) as dDate, COUNT(*) as cnt " +
                  "FROM Progress WHERE created_at >= DATEADD(day, -30, GETDATE()) " +
                  "GROUP BY CAST(created_at AS DATE) ORDER BY dDate";
        } else {
            sql = "SELECT CAST(created_at AS DATE) as dDate, COUNT(*) as cnt " +
                  "FROM Progress WHERE created_at >= DATEADD(day, -7, GETDATE()) " +
                  "GROUP BY CAST(created_at AS DATE) ORDER BY dDate";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getDate("dDate").toString(), rs.getInt("cnt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }

    // Admin statistics: Get total points by day in a given period
    public java.util.Map<String, Integer> getPointsStats(String range) {
        java.util.Map<String, Integer> stats = new java.util.LinkedHashMap<>();
        String sql;
        if ("month".equals(range)) {
            sql = "SELECT CAST(created_at AS DATE) as dDate, SUM(points_earned) as cnt " +
                  "FROM Progress WHERE created_at >= DATEADD(day, -30, GETDATE()) " +
                  "GROUP BY CAST(created_at AS DATE) ORDER BY dDate";
        } else {
            sql = "SELECT CAST(created_at AS DATE) as dDate, SUM(points_earned) as cnt " +
                  "FROM Progress WHERE created_at >= DATEADD(day, -7, GETDATE()) " +
                  "GROUP BY CAST(created_at AS DATE) ORDER BY dDate";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getDate("dDate").toString(), rs.getInt("cnt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }

    public double getCO2ReducedThisMonth() {
        // Assume 1 point = 0.05 ton CO2 reduced (just an arbitrary multiplier to get a nice chart number)
        String sql = "SELECT SUM(points_earned) FROM Progress WHERE created_at >= DATEADD(day, -30, GETDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1) * 0.05;
        } catch (Exception e) {}
        return 0;
    }

    // Returns a list of Map containing: username, activity_name, created_at
    public List<java.util.Map<String, Object>> getRecentActivities(int limit) {
        List<java.util.Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.activity_name, p.created_at, u.fullName " +
                     "FROM Progress p JOIN Users u ON p.user_id = u.id " +
                     "ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            int count = 0;
            while (rs.next() && count < limit) {
                java.util.Map<String, Object> map = new java.util.HashMap<>();
                map.put("fullName", rs.getString("fullName"));
                map.put("activity_name", rs.getString("activity_name"));
                
                java.sql.Timestamp ts = rs.getTimestamp("created_at");
                long diffMinutes = (System.currentTimeMillis() - ts.getTime()) / 60000;
                String timeAgo = diffMinutes < 60 ? diffMinutes + " phút trước" : 
                                 (diffMinutes < 1440 ? (diffMinutes/60) + " giờ trước" : (diffMinutes/1440) + " ngày trước");
                map.put("time_ago", timeAgo);
                
                list.add(map);
                count++;
            }
        } catch (Exception e) {}
        return list;
    }

    public int getTotalCheckinsCount() {
        String sql = "SELECT COUNT(*) FROM Progress";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {}
        return 0;
    }
}
