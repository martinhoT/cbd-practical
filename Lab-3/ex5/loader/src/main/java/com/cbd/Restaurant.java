package com.cbd;

import java.util.List;

public class Restaurant {

    private Address address;
    private String localidade;
    private String gastronomia;
    private List<Grade> grades;
    private String nome;
    private String restaurant_id;

    public Restaurant(Address address, String localidade, String gastronomia, List<Grade> grades, String nome, String restaurant_id) {
        this.address = address;
        this.localidade = localidade;
        this.gastronomia = gastronomia;
        this.grades = grades;
        this.nome = nome;
        this.restaurant_id = restaurant_id;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getLocalidade() {
        return localidade;
    }

    public void setLocalidade(String localidade) {
        this.localidade = localidade;
    }

    public String getGastronomia() {
        return gastronomia;
    }

    public void setGastronomia(String gastronomia) {
        this.gastronomia = gastronomia;
    }

    public List<Grade> getGrades() {
        return grades;
    }

    public void setGrades(List<Grade> grades) {
        this.grades = grades;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getRestaurant_id() {
        return restaurant_id;
    }

    public void setRestaurant_id(String restaurant_id) {
        this.restaurant_id = restaurant_id;
    }
}
