package com.example.demo.game1;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/game1")
public class Game1Controller {

    private final Game1Service game1Service;

    public Game1Controller(Game1Service game1Service) {
        this.game1Service = game1Service;
    }

    // 1. 게임 실행 (game1.jsp로 랜덤으로 결정된 게임 라운드 전달)
    @PostMapping("/play")
    public String playGame(@RequestParam int participantCount, Model model) throws Exception {
        // 게임 실행
        int gameRound = game1Service.playGame(participantCount);

        // 게임 실행 결과를 모델에 추가
        model.addAttribute("gameRound", gameRound);

        return "game1";
    }

    // 2. 모든 게임 결과 조회 (game1-result.jsp로 결과 전달)
    @GetMapping("/results")
    public String showResults(Model model) throws Exception {
        // 저장된 게임 결과 가져오기
        List<Game1Result> results = game1Service.getGameResults();

        // 결과를 모델에 추가
        model.addAttribute("results", results);

        return "game1-result";
    }

    // 3. 모든 게임 결과 삭제
    @PostMapping("/deleteAll")
    public String deleteAllResults(RedirectAttributes redirectAttributes) throws Exception {
        // 모든 게임 결과 삭제
        game1Service.deleteAllGameResults();

        // 최신 게임 결과를 리다이렉트로 전달
        List<Game1Result> results = game1Service.getGameResults();
        redirectAttributes.addFlashAttribute("results", results);

        return "redirect:/game1/results";
    }

    // 4. 특정 게임 결과 삭제
    @PostMapping("/delete/{id}")
    public String deleteGameResult(@PathVariable int id, RedirectAttributes redirectAttributes) throws Exception {
        // 특정 게임 결과 삭제
        game1Service.deleteGameResult(id);

        // 최신 게임 결과를 리다이렉트로 전달
        List<Game1Result> results = game1Service.getGameResults();
        redirectAttributes.addFlashAttribute("results", results);

        return "redirect:/game1/results";
    }
}
