package com.greenlife.test;

import com.greenlife.dao.UserDAO;
import com.greenlife.model.User;

public class TestLogin {
    public static void main(String[] args) {
        try {
            UserDAO dao = new UserDAO();
            User u = dao.login("myha", "123456");
            if (u != null) {
                System.out.println("Login success: " + u.getFullName());
            } else {
                System.out.println("Login failed: User not found or wrong password");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
