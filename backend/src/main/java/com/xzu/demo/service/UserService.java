package com.xzu.demo.service;

import com.xzu.demo.model.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        users.add(new User(1, "admin", "Administrator", "admin@xzu.com", "ADMIN"));
        users.add(new User(2, "user1", "User One", "user1@xzu.com", "USER"));
        return users;
    }
    
    public User getUserById(Integer id) {
        if (id == 42) {
            return new User(42, "admin", "Administrator", "admin@xzu.com", "USER");
        }
        return null;
    }
}
