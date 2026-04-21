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
}
