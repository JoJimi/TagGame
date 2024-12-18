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

    // 러시안 룰렛 게임 실행
    public int playGame(int participantCount) throws Exception {
        if (participantCount <= 0) {
            throw new IllegalArgumentException("참가자 수는 1명 이상이어야 합니다.");
        }

        // 총알이 발사될 라운드를 랜덤하게 결정
        int bulletRound = new Random().nextInt(participantCount * 3) + 1;

        // 결과를 DB에 저장
        game1DAO.saveGame1Result(participantCount, bulletRound);

        return bulletRound; // 게임 결과 반환
    }

    // 모든 게임 결과 조회
    public List<Game1Result> getGameResults() throws Exception {
        return game1DAO.getAllGame1Results();
    }

    // 모든 게임 결과 삭제
    public void deleteAllGameResults() throws Exception {
        game1DAO.deleteAllGame1Results();
    }

    // 특정 게임 결과 삭제
    public void deleteGameResult(int id) throws Exception {
        game1DAO.delGame1Result(id);
    }
}
