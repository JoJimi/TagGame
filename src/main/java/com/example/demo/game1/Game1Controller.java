package com.example.demo.game1;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/game1")
public class Game1Controller {

    private final Random random = new Random();

    // 1. 참가자 수 입력 화면
    @GetMapping
    public String showGamePage() {
        return "game1"; // game1.jsp를 반환
    }

    // 2. 게임 시작 (참가자 수를 받아 원탁 UI 생성)
    @PostMapping("/play")
    public String startGame(@RequestParam int participantCount, Model model) {
        List<Boolean> players = new ArrayList<>();
        for (int i = 0; i < participantCount; i++) {
            players.add(true); // 모든 플레이어 생존 상태로 초기화
        }

        int bulletRound = new Random().nextInt(participantCount) + 1; // 랜덤 총알 위치 결정
        int remainingBullets = participantCount; // 남은 발사 횟수는 참가자 수와 동일

        model.addAttribute("participantCount", participantCount);
        model.addAttribute("players", players);
        model.addAttribute("bulletRound", bulletRound);
        model.addAttribute("remainingBullets", remainingBullets); // 남은 발사 횟수 전달
        model.addAttribute("gameOver", false);

        return "game1-play";
    }

    // 3. 플레이어 선택 및 결과 처리
    @PostMapping("/play/select")
    public String playGame(@RequestParam int participantCount,
                           @RequestParam int playerId,
                           @RequestParam int bulletRound,
                           @RequestParam String players,
                           @RequestParam int remainingBullets, // 남은 발사 횟수
                           Model model) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        List<Boolean> playerList = objectMapper.readValue(players, new TypeReference<List<Boolean>>() {});

        boolean isDead = playerId == bulletRound;

        // 플레이어 상태 업데이트
        playerList.set(playerId - 1, !isDead);

        // 남은 발사 횟수 감소
        remainingBullets--;

        // 모델에 데이터 전달
        model.addAttribute("players", playerList);
        model.addAttribute("participantCount", participantCount);
        model.addAttribute("bulletRound", bulletRound);
        model.addAttribute("remainingBullets", remainingBullets); // 남은 발사 횟수 전달

        if (isDead) {
            model.addAttribute("gameOver", true);
            model.addAttribute("message", "플레이어 " + playerId + "이 총에 맞았습니다! 게임 종료!");
        } else if (remainingBullets == 0) {
            model.addAttribute("gameOver", true);
            model.addAttribute("message", "남은 발사 횟수가 없습니다! 게임 종료!");
        } else {
            model.addAttribute("gameOver", false);
        }

        return "game1-play";
    }
    
    // 4. 초기 플레이어 상태 생성
    private List<Boolean> initializePlayers(int participantCount) {
        List<Boolean> players = new ArrayList<>();
        for (int i = 0; i < participantCount; i++) {
            players.add(true); // true: 생존 상태
        }
        return players;
    }
}
