package com.example.demo.game6;

import java.time.LocalDateTime;

public class Game6Result {
	
	private int id; 				// 게임 결과 id
	private int gameId;				// 게임 id
	private String name; 			// 당첨자 이름
	private String content; 		// 당첨된 내용 
	private LocalDateTime gameDate; // 게임 시작 시간

	public Game6Result() { }

	public Game6Result(int id, int gameId, String name, String content, LocalDateTime gameDate) {
		this.id = id;
		this.gameId = gameId;
		this.name = name;
		this.content = content;
		this.gameDate = gameDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getGameId() {
		return gameId;
	}

	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getGameDate() {
		return gameDate;
	}

	public void setGameDate(LocalDateTime gameDate) {
		this.gameDate = gameDate;
	}
}
