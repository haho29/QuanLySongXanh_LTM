package com.greenlife.model;

public class EcoTip {
    private int id;
    private String title;
    private String content;
    private String category;
    private int points;

    public EcoTip() {}

    public EcoTip(int id, String title, String content, String category, int points) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.points = points;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }
}
