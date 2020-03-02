package com.xzu.demo.controller;

import com.xzu.demo.model.*;
import com.xzu.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * XZU Demo API Controller
 * Provides REST endpoints for testing the XZU compiler
 */
@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class ApiController {

    @Autowired
    private UserService userService;

    /**
     * POST /api/login
     * Test Case 1: Login with username and password
     */
    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest request) {
        if (request.getUsername() == null || request.getPassword() == null) {
            return ResponseEntity.badRequest().build();
        }
        
        if ("admin".equals(request.getUsername()) && "1234".equals(request.getPassword())) {
            LoginResponse response = new LoginResponse();
            response.setToken("jwt-token-12345");
            response.setUsername(request.getUsername());
            response.setRole("ADMIN");
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.status(401).build();
        }
    }

    /**
     * GET /api/users/{id}
     * Test Case 2: Get user by ID
     */
    @GetMapping("/users/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Integer id) {
        if (id == 42) {
            User user = new User();
            user.setId(42);
            user.setUsername("admin");
            user.setRole("USER");
            return ResponseEntity.ok(user);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * PUT /api/users/{id}
     * Test Case 3: Update user
     */
    @PutMapping("/users/{id}")
    public ResponseEntity<Map<String, Object>> updateUser(@PathVariable Integer id, @RequestBody UpdateRequest request) {
        Map<String, Object> response = new HashMap<>();
        response.put("updated", true);
        response.put("id", id);
        response.put("role", request.getRole());
        
        return ResponseEntity.ok()
            .header("Content-Type", "application/json")
            .header("X-App", "XZU")
            .body(response);
    }
    
    /**
     * DELETE /api/users/{id}
     * Test Case 4: Delete user
     */
    @DeleteMapping("/users/{id}")
    public ResponseEntity<Map<String, Object>> deleteUser(@PathVariable Integer id) {
        Map<String, Object> response = new HashMap<>();
        response.put("deleted", true);
        response.put("id", id);
        
        return ResponseEntity.ok()
            .header("Content-Type", "application/json")
            .header("X-App", "XZU")
            .body(response);
    }
}
