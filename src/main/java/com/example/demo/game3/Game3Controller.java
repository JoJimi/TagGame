package com.example.demo.game3;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/game3")
public class Game3Controller {

    private final Game3Service game3Service;

    public Game3Controller(Game3Service game3Service) {
        this.game3Service = game3Service;
    }

    // 게임 결과 저장 (game3.jsp로 결과 전달)
    @PostMapping("/play")
    public String playGame(@RequestParam List<String> participants, Model model) throws Exception {
    	try {
            // 랜덤으로 당첨자 선정 및 결과 저장
            String winnerName = game3Service.playgame(participants);
            
            // 모델에 당첨자와 메시지 전달
            model.addAttribute("winnerName", winnerName);
            model.addAttribute("message", "게임 결과가 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            model.addAttribute("error", "게임 실행 중 오류가 발생했습니다: " + e.getMessage());
        }

        return "game3"; // game3.jsp 화면으로 이동
    }

    // 게임 전체 결과 조회 (game3-result.jsp로 DB에 저장된 결과 전달)
    @GetMapping("/results")
    public String showResults(Model model) throws Exception {
        List<Game3Result> results = game3Service.getGameResults();
        model.addAttribute("results", results);
        return "game3-result"; // game3-result.jsp 화면으로 이동
    }

    // 게임 결과 전체 삭제
    @PostMapping("/deleteAll")
    public String deleteAllResults(RedirectAttributes redirectAttributes) throws Exception {
        game3Service.deleteAllGameResults();
        redirectAttributes.addFlashAttribute("message", "모든 게임 결과가 삭제되었습니다.");
        return "redirect:/game3/results"; // 결과 화면으로 리다이렉트
    }

    // 특정 게임 결과 삭제
    @PostMapping("/delete/{id}")
    public String deleteGameResult(@PathVariable int id, RedirectAttributes redirectAttributes) throws Exception {
        game3Service.deleteGameResult(id);
        redirectAttributes.addFlashAttribute("message", "선택한 게임 결과가 삭제되었습니다.");
        return "redirect:/game3/results"; // 결과 화면으로 리다이렉트
    }
}
