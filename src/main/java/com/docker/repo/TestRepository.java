package com.docker.repo;

import com.docker.entity.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface TestRepository extends CrudRepository<User, Long> {
    Optional<User> getById(Long id);
}
