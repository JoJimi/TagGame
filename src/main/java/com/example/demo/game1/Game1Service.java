package com.example.demo.game1;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class Game1Service {

    private final Game1DAO game1DAO;

    public Game1Service(Game1DAO game1DAO) {
        this.game1DAO = game1DAO;
    }

    // 1. 러시안 룰렛 게임 실행
    public int playGame(int participantCount) throws Exception {

        int maxRounds = participantCount * 3;
        int gameRound = new Random().nextInt(maxRounds) + 1;

        game1DAO.saveGame1Result(participantCount, gameRound);

        return gameRound;
    }

    // 2. 모든 게임 결과 조회
    public List<Game1Result> getGameResults() throws Exception {
        return game1DAO.getAllGame1Results();
    }

    // 3. 모든 게임 결과 삭제
    public void deleteAllGameResults() throws Exception {
        game1DAO.deleteAllGame1Results();
    }

    // 4. 특정 게임 결과 삭제
    public void deleteGameResult(int id) throws Exception {
        game1DAO.delGame1Result(id);
    }
}
