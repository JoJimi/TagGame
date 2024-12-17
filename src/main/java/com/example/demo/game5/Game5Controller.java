package com.example.demo.game5;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/game5")
public class Game5Controller {

    private final Game5Service game5Service;

    public Game5Controller(Game5Service game5Service) {
        this.game5Service = game5Service;
    }

    // 1. 게임 실행 (game5.jsp로 랜덤으로 배정된 층 정보 전달)
    @PostMapping("/play")
    public String playGame(@RequestParam int participantCount, @RequestParam int winnerApartmentFloor, Model model) {
        Map<Integer, List<Integer>> participantFloors = game5Service.playGame(participantCount, winnerApartmentFloor);

        // 참여자 번호 당 배정받은 층 수를 model에 저장해서 넘겨준다.
        model.addAttribute("participantFloors", participantFloors);
        model.addAttribute("participantCount", participantCount);

        return "game5"; // 게임 결과를 보여줄 JSP
    }

    // 2. 모든 게임 결과 조회 (game5-result.jsp로 결과 전달)
    @GetMapping("/results")
    public String showResults(Model model) {
        // 저장된 게임 결과 가져오기
        List<Game5Result> results = game5Service.getGameResults();

        // 결과를 모델에 추가
        model.addAttribute("results", results);

        return "game5-result"; // 모든 게임 결과를 보여줄 JSP
    }

    // 3. 모든 게임 결과 삭제
    @PostMapping("/deleteAll")
    public String deleteAllResults(RedirectAttributes redirectAttributes) {
        // 모든 게임 결과 삭제
        game5Service.deleteAllGameResults();

        // 결과 페이지 리다이렉트
        redirectAttributes.addFlashAttribute("message", "All game results have been deleted.");
        return "redirect:/game5/results";
    }

    // 4. 특정 게임 결과 삭제
    @PostMapping("/delete/{id}")
    public String deleteGameResult(@PathVariable int id, RedirectAttributes redirectAttributes) {
        // 특정 게임 결과 삭제
        game5Service.deleteGameResult(id);

        // 리다이렉트 메시지 전달
        redirectAttributes.addFlashAttribute("message", "Game result deleted successfully.");
        return "redirect:/game5/results";
    }
}