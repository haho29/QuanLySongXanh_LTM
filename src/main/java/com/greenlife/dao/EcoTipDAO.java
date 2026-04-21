package com.greenlife.dao;

import com.greenlife.model.EcoTip;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EcoTipDAO {
    public List<EcoTip> getAllTips() {
        List<EcoTip> tips = new ArrayList<>();
        String sql = "SELECT * FROM EcoTips";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                tips.add(new EcoTip(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("category"),
                    rs.getInt("points")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tips;
    }

    public List<EcoTip> getTipsByCategory(String category) {
        List<EcoTip> tips = new ArrayList<>();
        String sql = "SELECT * FROM EcoTips WHERE category = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tips.add(new EcoTip(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("category"),
                    rs.getInt("points")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tips;
    }

    public boolean addTip(EcoTip tip) {
        String sql = "INSERT INTO EcoTips (title, content, category, points) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tip.getTitle());
            ps.setString(2, tip.getContent());
            ps.setString(3, tip.getCategory());
            ps.setInt(4, tip.getPoints());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateTip(EcoTip tip) {
        String sql = "UPDATE EcoTips SET title = ?, content = ?, category = ?, points = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tip.getTitle());
            ps.setString(2, tip.getContent());
            ps.setString(3, tip.getCategory());
            ps.setInt(4, tip.getPoints());
            ps.setInt(5, tip.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteTip(int id) {
        String sql = "DELETE FROM EcoTips WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
