package com.example.demo.game2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/game2")
public class Game2Controller {

	private final Game2Service game2Service;

	public Game2Controller(Game2Service game2Service) {
		this.game2Service = game2Service;
	}

	// 게임 결과 (game2.jsp로 게임 결과 보냄)
	@PostMapping("/play")
	public String playGame(@RequestParam String userName, @RequestParam String userChoice, Model model) throws Exception {
	    String result = game2Service.playGame(userName, userChoice);

	    // 컴퓨터 선택 가져오기
	    String computerChoice = game2Service.getLastComputerChoice();

	    // 결과를 모델에 추가
	    model.addAttribute("userName", userName);
	    model.addAttribute("userChoice", userChoice);
	    model.addAttribute("computerChoice", computerChoice);
	    model.addAttribute("result", result);

	    // 결과 페이지로 이동
	    return "game2";
	}

	// 게임 전체 리스트 (game2-result.jsp로 DB에 저장되어 있는 게임 전체 리스트 보냄)
	@GetMapping("/results")
	public String showResults(Model model) throws Exception {
		List<Game2Result> results = game2Service.getGameResults();
		model.addAttribute("results", results);

		return "game2-result";
	}

	// 게임 결과 전체 삭제
	@PostMapping("/deleteAll")
	public String deleteAllResults(RedirectAttributes redirectAttributes) throws Exception {
		game2Service.deleteAllGameResults();

		// 최신 게임 결과를 리다이렉트로 전달
		List<Game2Result> results = game2Service.getGameResults();
		redirectAttributes.addFlashAttribute("results", results);

		return "redirect:/game2/results";
	}

	// 특정 게임 결과 삭제
	@PostMapping("/delete/{aid}")
	public String deleteGameResult(@PathVariable int aid, RedirectAttributes redirectAttributes) throws Exception {
		game2Service.deleteGameResult(aid);

		// 최신 게임 결과를 리다이렉트로 전달
		List<Game2Result> results = game2Service.getGameResults();
		redirectAttributes.addFlashAttribute("results", results);

		return "redirect:/game2/results";
	}

}
