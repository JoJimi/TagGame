package com.example.demo.game1;

import java.time.LocalDateTime;

public class Game1Result {
    private int id;                     // 게임 결과 ID
    private int participantCount;       // 참여한 사람 수
    private int gameRound;              // 진행한 게임 수
    private LocalDateTime gameDate;     // 게임 날짜

    public Game1Result() { }

    public Game1Result(int id, int participantCount, int gameRound, LocalDateTime gameDate) {
        this.id = id;
        this.participantCount = participantCount;
        this.gameRound = gameRound;
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

    public int getGameRound() {
        return gameRound;
    }

    public void setGameRound(int gameRound) {
        this.gameRound = gameRound;
    }

    public LocalDateTime getGameDate() {
        return gameDate;
    }

    public void setGameDate(LocalDateTime gameDate) {
        this.gameDate = gameDate;
    }
}
