package com.example.demo.game6;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class Game6Service {

    private final Game6DAO game6DAO;

    public Game6Service(Game6DAO game6DAO) {
        this.game6DAO = game6DAO;
    }

    // 사다리 타기의 결과를 DB에 저장
    public void playGame(String[] startPoints, String[] endPoints) throws Exception {
        int gameId = game6DAO.getCurrentGameId();  // 현재 게임 ID를 가져옴

        for (int i = 0; i < startPoints.length; i++) {
            String user = startPoints[i];
            String result = endPoints[i];

            // 게임 ID와 함께 결과를 데이터베이스에 저장
            game6DAO.saveGame6Result(gameId, user, result, java.time.LocalDateTime.now());
        }

    }

    // 전체 게임 결과 리스트
    public List<Game6Result> getGameResults() throws Exception {
        return game6DAO.getAllGame6Results();
    }

    // 전체 게임 결과 삭제
    public void deleteAllGameResults() throws Exception {
        game6DAO.deleteAllGame6Results();
    }

    // 특정 게임 ID에 해당하는 결과 삭제
    public void deleteGameResultsByGameId(int gameId) throws Exception {
        game6DAO.deleteGame6ResultByGameId(gameId);
    }
}
