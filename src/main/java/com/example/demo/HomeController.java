package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {

    @GetMapping("/")
    public String hello() {
        return "hello";
    }
    
    @GetMapping("/game1")
    public String game1() {
        return "game1";
    }
    
    @GetMapping("/game2")
    public String game2() {
        return "game2";
    }
    
    @GetMapping("/game3")
    public String game3() {
        return "game3";
    }
    
    @GetMapping("/game4")
    public String game4() {
        return "game4";
    }
    
    @GetMapping("/game5")
    public String game5() {
        return "game5";
    }
    
    @GetMapping("/game6")
    public String game6() {
        return "game6";
    }
}
