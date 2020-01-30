package com.docker.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class User {
    public User(){}
    public User(Long id, String name){
        this.id = id;
        this.name = name;
    }

    @Id
    @Column( name= "id")
    public Long id;

    @Column (name = "name")
    public String name;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}
