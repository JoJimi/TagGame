package com.example.demo.game4;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.game2.Game2Result;
import com.example.demo.game2.Game2Service;

@Controller
@RequestMapping("/game4")
public class Game4Controller {

	private final Game4Service game4Service;

    public Game4Controller(Game4Service game4Service) {
        this.game4Service = game4Service;
    }
    
    // 게임 결과 (game2.jsp로 게임 결과 보냄)
    @PostMapping("/play")
    public String playGame(@RequestParam Model model) throws Exception {
        int result = game4Service.playGame();
        model.addAttribute("result", result);
        
        return "game4";
    }

    // 게임 전체 리스트 (game2-result.jsp로 DB에 저장되어 있는 게임 전체 리스트 보냄)
    @GetMapping("/results")
    public String showResults(Model model) throws Exception {
        List<Game4Result> results = game4Service.getGameResults();
        model.addAttribute("results", results);
        
        return "game4-result";
    }
	
	// 게임 결과 전체 삭제
    @PostMapping("/deleteAll")
    public String deleteAllResults(RedirectAttributes redirectAttributes) throws Exception {
        game4Service.deleteAllGameResults();

        // 최신 게임 결과를 리다이렉트로 전달
        List<Game4Result> results = game4Service.getGameResults();
        redirectAttributes.addFlashAttribute("results", results);
        
        return "redirect:/game4/results";
    }

    // 특정 게임 결과 삭제
    @PostMapping("/delete/{aid}")
    public String deleteGameResult(@PathVariable int aid, RedirectAttributes redirectAttributes) throws Exception {
        game4Service.deleteGameResult(aid);

        // 최신 게임 결과를 리다이렉트로 전달
        List<Game4Result> results = game4Service.getGameResults();
        redirectAttributes.addFlashAttribute("results", results);
        
        return "redirect:/game4/results";
    }
    
}
