package com.example.demo.game2;

import org.springframework.beans.factory.annotation.Autowired;
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
        String[] choices = {"가위", "바위", "보"};
        String computerChoice = choices[new Random().nextInt(choices.length)];

        String result;
        if (userChoice.equals(computerChoice)) {
            result = "무승부";
        } else if ((userChoice.equals("가위") && computerChoice.equals("보")) ||
                   (userChoice.equals("바위") && computerChoice.equals("가위")) ||
                   (userChoice.equals("보") && computerChoice.equals("바위"))) {
            result = "승리";
        } else {
            result = "패배";
        }

        game2DAO.saveGame2Result(userName, userChoice, computerChoice, result);
        return result;
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
