package com.greenlife.controller;

import com.greenlife.dao.EcoTipDAO;
import com.greenlife.model.EcoTip;
import com.greenlife.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/eco-tips")
public class AdminEcoTipsServlet extends HttpServlet {
    private EcoTipDAO ecoTipDAO;

    @Override
    public void init() {
        ecoTipDAO = new EcoTipDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<EcoTip> tips = ecoTipDAO.getAllTips();
        request.setAttribute("tips", tips);
        request.getRequestDispatcher("/views/admin/eco-tips.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String category = request.getParameter("category");
            int points = Integer.parseInt(request.getParameter("points"));
            
            EcoTip tip = new EcoTip(0, title, content, category, points);
            ecoTipDAO.addTip(tip);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String category = request.getParameter("category");
            int points = Integer.parseInt(request.getParameter("points"));
            
            EcoTip tip = new EcoTip(id, title, content, category, points);
            ecoTipDAO.updateTip(tip);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ecoTipDAO.deleteTip(id);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/eco-tips");
    }
}
