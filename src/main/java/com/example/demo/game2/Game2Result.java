package com.example.demo.game2;

import java.time.LocalDateTime;

public class Game2Result {
	private int id; 					// 게임 결과 id
    private String userName; 			// 사용자 이름
    private String userChoice; 			// 사용자가 선택한 가위, 바위, 보
    private String computerChoice; 		// 컴퓨터가 선택한 가위, 바위, 보
    private String result; 				// 게임 결과 (승리, 패배, 무승부)
    private LocalDateTime gameDate; 	// 게임 날짜

    public Game2Result() { }

    public Game2Result(int id, String userName, String userChoice, String computerChoice, String result, LocalDateTime gameDate) {
        this.id = id;
        this.userName = userName;
        this.userChoice = userChoice;
        this.computerChoice = computerChoice;
        this.result = result;
        this.gameDate = gameDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserChoice() {
        return userChoice;
    }

    public void setUserChoice(String userChoice) {
        this.userChoice = userChoice;
    }

    public String getComputerChoice() {
        return computerChoice;
    }

    public void setComputerChoice(String computerChoice) {
        this.computerChoice = computerChoice;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public LocalDateTime getGameDate() {
        return gameDate;
    }

    public void setGameDate(LocalDateTime localDateTime) {
        this.gameDate = localDateTime;
    }
}
