package com.example.accessingdatamysql;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity // This tells Hibernate to make a table out of this class
public class Stanowiska {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer staId;

    private String staNazwa;

    private String staOpis;

    public Integer getStaId() {
        return staId;
    }

    public void setStaId(Integer staId) {
        this.staId = staId;
    }

    public String getStaNazwa() {
        return staNazwa;
    }

    public void setStaNazwa(String staNazwa) {
        this.staNazwa = staNazwa;
    }

    public String getStaOpis() {
        return staOpis;
    }

    public void setStaOpis(String staOpis) {
        this.staOpis = staOpis;
    }
}