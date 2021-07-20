package com.cesco.api.cesnetapi.ec.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HealthCheck {
    
    @GetMapping("/health")
    @ResponseBody
    public String health() {
        return "OK";
    }
}
