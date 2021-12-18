package com.cbd;

import java.util.List;

public class Address {
    private String building;
    private List<Float> coord;
    private String rua;
    private Integer zipcode;

    public Address(String building, List<Float> coord, String rua, Integer zipcode) {
        this.building = building;
        this.coord = coord;
        this.rua = rua;
        this.zipcode = zipcode;
    }

    public String getBuilding() {
        return building;
    }

    public List<Float> getCoord() {
        return coord;
    }

    public String getRua() {
        return rua;
    }

    public Integer getZipcode() {
        return zipcode;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public void setCoord(List<Float> coord) {
        this.coord = coord;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public void setZipcode(Integer zipcode) {
        this.zipcode = zipcode;
    }
}
