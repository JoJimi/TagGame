package com.example.demo.game2;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class Game2Service {

    private final Game2DAO game2DAO;

    public Game2Service(Game2DAO game2DAO) {
        this.game2DAO = game2DAO;
    }

    // 가위바위보 게임 결과
    public String playGame(String userName, String userChoice) throws Exception {
        // 컴퓨터 선택 (영어값 사용)
        String[] choices = {"scissors", "rock", "paper"};
        String computerChoice = choices[new Random().nextInt(choices.length)];

        // 결과 계산
        String result;
        if (userChoice.equals(computerChoice)) {
            result = "무승부";
        } else if ((userChoice.equals("scissors") && computerChoice.equals("paper")) ||
                   (userChoice.equals("rock") && computerChoice.equals("scissors")) ||
                   (userChoice.equals("paper") && computerChoice.equals("rock"))) {
            result = "승리";
        } else {
            result = "패배";
        }

        // 게임 결과를 DB에 저장
        game2DAO.saveGame2Result(userName, userChoice, computerChoice, result);

        // 결과값 반환
        return result;
    }

    // 가장 최근의 컴퓨터 선택값 가져오기
    public String getLastComputerChoice() throws Exception {
        List<Game2Result> results = game2DAO.getAllGame2Results();
        if (!results.isEmpty()) {
            return results.get(0).getComputerChoice(); // 가장 최근 기록 반환
        }
        return "정보 없음"; // 데이터가 없을 경우 반환값
    }

    // 전체 게임 결과 리스트
    public List<Game2Result> getGameResults() throws Exception {
        return game2DAO.getAllGame2Results();
    }

    // 전체 게임 결과 삭제
    public void deleteAllGameResults() throws Exception {
        game2DAO.deleteAllGame2Results();
    }

    // 특정 게임 결과 삭제
    public void deleteGameResult(int aid) throws Exception {
        game2DAO.delGame2Result(aid);
    }
}