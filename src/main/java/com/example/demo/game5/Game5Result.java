package com.example.demo.game5;

import java.time.LocalDateTime;

public class Game5Result {
    private int id;                   // 게임 결과 ID
    private int participantCount;     // 참여한 사용자 수
    private int winnerApartmentFloor; // 당첨 아파트 층
    private int winnerUserNumber;     // 당첨된 사용자 번호
    private LocalDateTime gameStartTime; // 게임 시작 시간

    public Game5Result() { }

    public Game5Result(int id, int participantCount, int winnerApartmentFloor, int winnerUserNumber, LocalDateTime gameStartTime) {
        this.id = id;
        this.participantCount = participantCount;
        this.winnerApartmentFloor = winnerApartmentFloor;
        this.winnerUserNumber = winnerUserNumber;
        this.gameStartTime = gameStartTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParticipantCount() {
        return participantCount;
    }

    public void setParticipantCount(int participantCount) {
        this.participantCount = participantCount;
    }

    public int getWinnerApartmentFloor() {
        return winnerApartmentFloor;
    }

    public void setWinnerApartmentFloor(int winnerApartmentFloor) {
        this.winnerApartmentFloor = winnerApartmentFloor;
    }

    public int getWinnerUserNumber() {
        return winnerUserNumber;
    }

    public void setWinnerUserNumber(int winnerUserNumber) {
        this.winnerUserNumber = winnerUserNumber;
    }

    public LocalDateTime getGameStartTime() {
        return gameStartTime;
    }

    public void setGameStartTime(LocalDateTime gameStartTime) {
        this.gameStartTime = gameStartTime;
    }
    
}
