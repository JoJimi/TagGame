package com.example.demo.game1;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.Collections;
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

        int remainingBullets = participantCount; // 남은 발사 횟수는 참가자 수와 동일

        // 총알 리스트 생성
        List<Boolean> bulletList = new ArrayList<>();
        for (int i = 0; i < remainingBullets - 1; i++) {
            bulletList.add(false); // 빈 발사
        }
        bulletList.add(true); // 총알 발사
        Collections.shuffle(bulletList); // 총알 리스트 셔플

        // 모델 데이터 추가
        model.addAttribute("participantCount", participantCount);
        model.addAttribute("players", players);
        model.addAttribute("bulletList", bulletList); // 셔플된 총알 리스트 전달
        model.addAttribute("remainingBullets", remainingBullets);
        model.addAttribute("gameOver", false);

        return "game1-play";
    }

    // 3. 플레이어 선택 및 결과 처리
    @PostMapping("/play/select")
    public String playGame(@RequestParam int participantCount,
                           @RequestParam int playerId,
                           @RequestParam String players,
                           @RequestParam String bulletList, // JSON 문자열로 전달
                           @RequestParam int remainingBullets,
                           Model model) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();

        // players JSON 변환
        List<Boolean> playerList = objectMapper.readValue(players, new TypeReference<List<Boolean>>() {});

        // bulletList JSON 변환
        List<Boolean> bulletListConverted = objectMapper.readValue(bulletList, new TypeReference<List<Boolean>>() {});

        // 현재 발사 결과 가져오기
        boolean isDead = bulletListConverted.get(remainingBullets - 1);

        // 플레이어 상태 업데이트
        if (isDead) {
            playerList.set(playerId - 1, false); // 해당 플레이어 죽음
        }

        // 남은 발사 횟수 감소
        remainingBullets--;

        // 모델 데이터 갱신
        model.addAttribute("players", playerList);
        model.addAttribute("participantCount", participantCount);
        model.addAttribute("bulletList", bulletListConverted); // 총알 리스트 유지
        model.addAttribute("remainingBullets", remainingBullets);

        if (isDead) {
            model.addAttribute("gameOver", true);
            model.addAttribute("message", "플레이어 " + playerId + "이 총에 맞았습니다! 게임 종료!");
        } else if (remainingBullets == 0) {
            model.addAttribute("gameOver", true);
            model.addAttribute("message", "총알을 맞을 사람이 없습니다! 게임 종료!");
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
