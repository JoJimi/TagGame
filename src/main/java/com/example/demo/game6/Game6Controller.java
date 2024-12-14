package com.example.demo.game6;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/game6")
public class Game6Controller {

    private final Game6Service game6Service;

    public Game6Controller(Game6Service game6Service) {
        this.game6Service = game6Service;
    }

    // 사다리 타기 게임 실행 (game6.jsp에서 게임 결과 리스트를 받아 처리)
    @PostMapping("/play")
    public String playGame(@RequestParam("results") List<String>[] results,
                           Model model) throws Exception {

    	if (results == null) {
            model.addAttribute("error", "결과가 비어있습니다.");
            return "game6";
        }
    	
    	List<String> gameResults = game6Service.playGame(results); // gameId는 service에서 처리

        model.addAttribute("gameResults", gameResults);
        return "game6"; 
    }

    // 게임 전체 결과 조회 (game6-result.jsp로 DB에 저장된 전체 결과를 보냄)
    @GetMapping("/results")
    public String showResults(Model model) throws Exception {
        List<Game6Result> results = game6Service.getGameResults(); 
        model.addAttribute("results", results); 

        return "game6-result"; 
    }

    // 모든 게임 결과 삭제
    @PostMapping("/deleteAll")
    public String deleteAllResults(RedirectAttributes redirectAttributes) throws Exception {
        game6Service.deleteAllGameResults();

        redirectAttributes.addFlashAttribute("message", "모든 게임 결과가 삭제되었습니다.");
        return "redirect:/game6/results"; 
    }

    // gameId 별로 특정 게임 결과 삭제
    @PostMapping("/delete/{gameId}")
    public String deleteGameResultsByGameId(@PathVariable int gameId, RedirectAttributes redirectAttributes) throws Exception {
        game6Service.deleteGameResultsByGameId(gameId);

        redirectAttributes.addFlashAttribute("message", "선택한 게임의 모든 결과가 삭제되었습니다.");
        return "redirect:/game6/results"; 
    }
}