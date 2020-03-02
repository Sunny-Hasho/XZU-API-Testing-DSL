package com.xzu.demo.model;

public class UpdateRequest {
    private String role;
    
    public UpdateRequest() {}
    
    public UpdateRequest(String role) {
        this.role = role;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
}
