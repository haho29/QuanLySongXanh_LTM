package com.greenlife.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.greenlife.dao.UserDAO;
import com.greenlife.model.User;
import java.util.List;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> topUsers = userDAO.getTopUsersByPoints(20);
        request.setAttribute("topUsers", topUsers);
        
        request.getRequestDispatcher("/views/leaderboard.jsp").forward(request, response);
    }
}
