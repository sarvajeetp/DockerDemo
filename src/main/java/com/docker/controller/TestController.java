package com.docker.controller;

import com.docker.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class TestController {
    @Autowired
    TestService testService;

    @GetMapping("get/{id}")
    public String fetchValue(@PathVariable String id) {
        try {
            System.out.println(id);
            return "welcome " + testService.fetchValFromDB(id);
        } catch (Exception var5) {
            return "Error: "+var5.getMessage();
        }
    }

    @GetMapping("add/{userId}/{userName}")
    public String addValue(@PathVariable String userId, @PathVariable String userName) {
        try {
            return testService.addValueToDB(userId, userName) != null ? "Added" : "Please check error in server";
        } catch (Exception ex) {
            return "Error: " + ex.getMessage();
        }
    }

}
