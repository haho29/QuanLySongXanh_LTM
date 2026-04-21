package com.greenlife.controller;

import com.greenlife.dao.EcoTipDAO;
import com.greenlife.model.EcoTip;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/eco-tips")
public class EcoTipsServlet extends HttpServlet {
    private EcoTipDAO ecoTipDAO;

    @Override
    public void init() {
        ecoTipDAO = new EcoTipDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        List<EcoTip> tips;
        if (category != null && !category.trim().isEmpty() && !"all".equalsIgnoreCase(category)) {
            tips = ecoTipDAO.getTipsByCategory(category);
        } else {
            tips = ecoTipDAO.getAllTips();
        }
        request.setAttribute("tips", tips);
        request.setAttribute("paramCategory", category != null ? category : "all");
        request.getRequestDispatcher("/views/eco-tips.jsp").forward(request, response);
    }
}
