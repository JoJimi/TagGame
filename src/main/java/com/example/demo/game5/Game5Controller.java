package com.example.demo.game5;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.SQLException;
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
    public String playGame(@RequestParam int participantCount, @RequestParam int winnerApartmentFloor, Model model) throws Exception{
        Map<Integer, List<Integer>> participantFloors = game5Service.playGame(participantCount, winnerApartmentFloor);

        // 참여자 번호 당 배정받은 층 수를 model에 저장해서 넘겨준다.
        model.addAttribute("participantFloors", participantFloors);
        model.addAttribute("participantCount", participantCount);
        model.addAttribute("winnerApartmentFloor", winnerApartmentFloor);

        return "game5-play"; 
    }

    // 2. 모든 게임 결과 조회 (game5-result.jsp로 결과 전달)
    @GetMapping("/results")
    public String showResults(Model model) throws Exception {
        List<Game5Result> results = game5Service.getGameResults();
        model.addAttribute("results", results);

        return "game5-result"; // 모든 게임 결과를 보여줄 JSP
    }

    // 3. 모든 게임 결과 삭제
    @PostMapping("/deleteAll")
    public String deleteAllResults(RedirectAttributes redirectAttributes)throws Exception {
        game5Service.deleteAllGameResults();

        redirectAttributes.addFlashAttribute("message", "모든 게임 결과가 삭제되었습니다.");
        return "redirect:/game5/results";
    }

    // 4. 특정 게임 결과 삭제
    @PostMapping("/delete/{id}")
    public String deleteGameResult(@PathVariable int id, RedirectAttributes redirectAttributes) throws Exception {
        game5Service.deleteGameResult(id);

        redirectAttributes.addFlashAttribute("message", "선택한 게임의 모든 결과가 삭제되었습니다.");
        return "redirect:/game5/results";
    }
}