package com.example.demo.game3;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class Game3Service {

    private final Game3DAO game3DAO;

    public Game3Service(Game3DAO game3DAO) {
        this.game3DAO = game3DAO;
    }
    
    public String playgame(List<String> participants) throws Exception {
        if (participants == null || participants.isEmpty()) {
            throw new IllegalArgumentException("참여자 목록이 비어있습니다.");
        }

        // 무작위로 당첨자 선정
        Random random = new Random();
        int winnerIndex = random.nextInt(participants.size());
        String winnerName = participants.get(winnerIndex);

        // DAO를 통해 결과 저장
        game3DAO.saveGame3Result(participants.size(), winnerName);

        // 선정된 당첨자 반환
        return winnerName;
    }

    // 전체 게임 결과 리스트
    public List<Game3Result> getGameResults() throws Exception {
        return game3DAO.getAllGame3Results();
    }
    
    // 전체 게임 결과 삭제
    public void deleteAllGameResults() throws Exception {
        game3DAO.deleteAllGame3Results();
    }
    
    // 특정 게임 결과 삭제
    public void deleteGameResult(int aid) throws Exception {
        game3DAO.deleteGame3Result(aid);
    }
    
}
