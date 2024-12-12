package com.example.demo.game4;

import java.time.LocalDateTime;

public class Game4Result {
    private int id;                     // 게임 결과 id
    private int bombExplodedTime;       // 폭탄 터진 시간 (10~30초)
    private LocalDateTime gameDate;     // 게임 날짜

    public Game4Result() { }

    public Game4Result(int id, int bombExplodedTime, LocalDateTime gameDate) {
        this.id = id;
        this.bombExplodedTime = bombExplodedTime;
        this.gameDate = gameDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBombExplodedTime() {
        return bombExplodedTime;
    }

    public void setBombExplodedTime(int bombExplodedTime) {
        this.bombExplodedTime = bombExplodedTime;
    }

    public LocalDateTime getGameDate() {
        return gameDate;
    }

    public void setGameDate(LocalDateTime gameDate) {
        this.gameDate = gameDate;
    }
}
