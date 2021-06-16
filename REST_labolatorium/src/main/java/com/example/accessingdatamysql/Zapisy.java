package com.example.accessingdatamysql;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.sql.Date;

@Entity // This tells Hibernate to make a table out of this class
public class Zapisy {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer zapId;

    private Integer czuId;

    private Date zapCzas;

    private String zapOpis;

    private Float zapWartosc;

    public Integer getZapId() {
        return zapId;
    }

    public void setZapId(Integer zapId) {
        this.zapId = zapId;
    }

    public Integer getCzuId() {
        return czuId;
    }

    public void setCzuId(Integer czuId) {
        this.czuId = czuId;
    }

    public Date getZapCzas() {
        return zapCzas;
    }

    public void setZapCzas(Date zapCzas) {
        this.zapCzas = zapCzas;
    }

    public String getZapOpis() {
        return zapOpis;
    }

    public void setZapOpis(String zapOpis) {
        this.zapOpis = zapOpis;
    }

    public Float getZapWartosc() {
        return zapWartosc;
    }

    public void setZapWartosc(Float zapWartosc) {
        this.zapWartosc = zapWartosc;
    }
}