package com.example.accessingdatamysql;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity // This tells Hibernate to make a table out of this class
public class Czujniki {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer czuId;

    private String czuNazwa;

    private Float czuWartosc;

    private Integer staId;

    public Integer getCzuId() {
        return czuId;
    }

    public void setCzuId(Integer czuId) {
        this.czuId = czuId;
    }

    public String getCzuNazwa() {
        return czuNazwa;
    }

    public void setCzuNazwa(String czuNazwa) {
        this.czuNazwa = czuNazwa;
    }

    public Float getCzuWartosc() {
        return czuWartosc;
    }

    public void setCzuWartosc(Float czuWartosc) {
        this.czuWartosc = czuWartosc;
    }

    public Integer getStaId() {
        return staId;
    }

    public void setStaId(Integer staId) {
        this.staId = staId;
    }
}

