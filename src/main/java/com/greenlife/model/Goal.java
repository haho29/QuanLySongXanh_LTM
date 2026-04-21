package com.greenlife.model;

public class Goal {
    private int id;
    private int userId;
    private String title;
    private String category;
    private String description;
    private java.util.Date endDate;
    private int targetProgress;
    private int currentProgress;
    private String status;

    public Goal() {}

    public Goal(int id, int userId, String title, String category, String description, java.util.Date endDate, int targetProgress, int currentProgress, String status) {
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.category = category;
        this.description = description;
        this.endDate = endDate;
        this.targetProgress = targetProgress;
        this.currentProgress = currentProgress;
        this.status = status;
    }
    
    // Legacy constructor for backward compatibility just in case
    public Goal(int id, int userId, String title, int targetProgress, int currentProgress, String status) {
        this(id, userId, title, null, null, null, targetProgress, currentProgress, status);
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public java.util.Date getEndDate() { return endDate; }
    public void setEndDate(java.util.Date endDate) { this.endDate = endDate; }
    public int getTargetProgress() { return targetProgress; }
    public void setTargetProgress(int targetProgress) { this.targetProgress = targetProgress; }
    public int getCurrentProgress() { return currentProgress; }
    public void setCurrentProgress(int currentProgress) { this.currentProgress = currentProgress; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
