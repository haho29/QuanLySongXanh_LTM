package com.greenlife.model;

import java.util.Date;

public class Progress {
    private int id;
    private int userId;
    private int goalId;
    private String activityName;
    private int pointsEarned;
    private Date createdAt;

    public Progress() {}

    public Progress(int id, int userId, int goalId, String activityName, int pointsEarned, Date createdAt) {
        this.id = id;
        this.userId = userId;
        this.goalId = goalId;
        this.activityName = activityName;
        this.pointsEarned = pointsEarned;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getGoalId() { return goalId; }
    public void setGoalId(int goalId) { this.goalId = goalId; }
    public String getActivityName() { return activityName; }
    public void setActivityName(String activityName) { this.activityName = activityName; }
    public int getPointsEarned() { return pointsEarned; }
    public void setPointsEarned(int pointsEarned) { this.pointsEarned = pointsEarned; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
