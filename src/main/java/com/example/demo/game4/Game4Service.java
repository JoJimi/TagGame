package com.example.demo.game4;

import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Service;

import com.example.demo.game2.Game2DAO;
import com.example.demo.game2.Game2Result;

@Service
public class Game4Service {
	
	private final Game4DAO game4DAO;

    public Game4Service(Game4DAO game4DAO) {
        this.game4DAO = game4DAO;
    }
    
    // 폭탄 게임 시작 메서드 (폭탄 터지는 시간을 랜덤으로 설정)
    public int playGame() throws Exception {
        Random random = new Random();
        
        // 10초에서 30초 사이의 랜덤 시간 (초 단위)
        int bombTime = random.nextInt(21) + 10;
        
        game4DAO.saveGame4Result(bombTime);
        return bombTime;
    }
    
	
    // 전체 게임 결과 리스트
    public List<Game4Result> getGameResults() throws Exception {
        return game4DAO.getAllGame4Results();
    }
    
    // 전체 게임 결과 삭제
    public void deleteAllGameResults() throws Exception {
        game4DAO.deleteAllGame4Results();
    }
    
    // 특정 게임 결과 삭제
    public void deleteGameResult(int aid) throws Exception {
        game4DAO.delGame4Result(aid);
    }
}
