package com.docker.service;

import com.docker.entity.User;
import com.docker.repo.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class TestService {
    @Autowired
    private TestRepository testRepository;

    public String fetchValFromDB(String id) {
        Optional<User> byId = testRepository.getById(Long.valueOf(id));
        return byId.isPresent()?byId.get().getName():"Stranger";
    }

    public User addValueToDB(String id, String name){
        return testRepository.save(new User(Long.valueOf(id), name));
    }
}
