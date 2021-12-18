package com.cbd;

public class Grade {
    private Long date;
    private String grade;
    private Integer score;

    public Grade(Long date, String grade, Integer score) {
        this.date = date;
        this.grade = grade;
        this.score = score;
    }

    public Long getDate() {
        return date;
    }

    public void setDate(Long date) {
        this.date = date;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
}
