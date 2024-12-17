package com.example.demo.game3;

import java.time.LocalDateTime;

public class Game3Result {
    private int id;                    // 게임 결과 ID
    private int participantCount;      // 참여한 사람 수
    private String winnerName;         // 당첨자 이름
    private LocalDateTime gameDate;    // 게임 날짜

    public Game3Result() { }

    public Game3Result(int id, int participantCount, String winnerName, LocalDateTime gameDate) {
        this.id = id;
        this.participantCount = participantCount;
        this.winnerName = winnerName;
        this.gameDate = gameDate;
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

    public String getWinnerName() {
        return winnerName;
    }

    public void setWinnerName(String winnerName) {
        this.winnerName = winnerName;
    }

    public LocalDateTime getGameDate() {
        return gameDate;
    }

    public void setGameDate(LocalDateTime gameDate) {
        this.gameDate = gameDate;
    }
}
