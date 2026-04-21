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
        return new User(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("fullName"),
            rs.getString("email"),
            rs.getString("job"),
            rs.getString("location"),
            rs.getString("role")
        );
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
}
