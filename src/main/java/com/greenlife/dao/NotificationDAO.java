package com.greenlife.dao;

import com.greenlife.model.Notification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    public List<Notification> getNotificationsByUserId(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT TOP 10 * FROM Notifications WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractNotification(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) FROM Notifications WHERE user_id = ? AND is_read = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean addNotification(Notification notification) {
        String sql = "INSERT INTO Notifications (user_id, title, content, type, is_read, created_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, notification.getUserId());
            ps.setString(2, notification.getTitle());
            ps.setString(3, notification.getContent());
            ps.setString(4, notification.getType() != null ? notification.getType() : "INFO");
            ps.setBoolean(5, notification.isRead());
            ps.setTimestamp(6, new Timestamp(notification.getCreatedAt() != null ? notification.getCreatedAt().getTime() : System.currentTimeMillis()));
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean markAllAsRead(int userId) {
        String sql = "UPDATE Notifications SET is_read = 1 WHERE user_id = ? AND is_read = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Notification extractNotification(ResultSet rs) throws Exception {
        return new Notification(
            rs.getInt("id"),
            rs.getInt("user_id"),
            rs.getString("title"),
            rs.getString("content"),
            rs.getString("type"),
            rs.getBoolean("is_read"),
            rs.getTimestamp("created_at") != null ? new java.util.Date(rs.getTimestamp("created_at").getTime()) : new java.util.Date()
        );
    }
}
