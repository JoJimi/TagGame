package com.example.demo.game2;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Game2Controller {
	@GetMapping("/game2")
    public String game2() {
        return "game2"; 
    }
}
