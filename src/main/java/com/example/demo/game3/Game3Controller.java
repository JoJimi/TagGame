package com.example.demo.game3;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/game3")
public class Game3Controller {

    private final Game3Service game3Service;

    public Game3Controller(Game3Service game3Service) {
        this.game3Service = game3Service;
    }
    
    // 게임 결과 저장 (game3.jsp로 결과 전달)
    @PostMapping("/play")
    @ResponseBody
    public Map<String, String> playGame(@RequestBody List<String> participants) throws Exception {
        Map<String, String> result = new HashMap<>();
        try {
            String winnerName = game3Service.playgame(participants);
            result.put("winnerName", winnerName);
            result.put("message", "게임 결과가 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            result.put("error", "게임 실행 중 오류: " + e.getMessage());
        }
        return result;
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
