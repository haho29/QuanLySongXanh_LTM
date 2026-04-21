package com.greenlife.model;

public class User {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String job;
    private String location;
    private String role;
    
    // Virtual fields for Leaderboard UI
    private int points;
    private int runStreak;

    public User() {}

    public User(int id, String username, String password, String fullName, String email, String job, String location, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.job = job;
        this.location = location;
        this.role = role;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getJob() { return job; }
    public void setJob(String job) { this.job = job; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public boolean isAdmin() {
        return "ADMIN".equals(this.role);
    }
    
    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }
    public int getRunStreak() { return runStreak; }
    public void setRunStreak(int runStreak) { this.runStreak = runStreak; }
}
