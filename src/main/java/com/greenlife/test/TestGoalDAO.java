package com.greenlife.test;

import com.greenlife.dao.GoalDAO;
import com.greenlife.model.Goal;
import java.util.List;

public class TestGoalDAO {
    public static void main(String[] args) {
        GoalDAO goalDAO = new GoalDAO();
        List<Goal> goals = goalDAO.getGoalsByUserId(2);
        System.out.println("Number of goals for user 2: " + goals.size());
        for (Goal g : goals) {
            System.out.println("Goal: " + g.getTitle());
        }
    }
}
