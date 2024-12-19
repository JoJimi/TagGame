package com.example.demo.game2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Game2DAO {

    private final DataSource dataSource;

    public Game2DAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public Connection open() {
        try {
            return dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get database connection.");
        }
    }
    
    public void saveGame2Result(String userName, String userChoice, String computerChoice, String result) throws Exception {
    	Connection conn = open();
        String sql = "INSERT INTO game2_results (user_name, user_choice, computer_choice, result, game_date) VALUES (?, ?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
        try (conn; pstmt) {
            pstmt.setString(1, userName);
            pstmt.setString(2, userChoice);
            pstmt.setString(3, computerChoice);
            pstmt.setString(4, result);
            pstmt.setObject(5, LocalDateTime.now());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Game2Result> getAllGame2Results() throws Exception {
    	Connection conn = open();
        String sql = "SELECT user_name, user_choice, computer_choice, result, game_date FROM game2_results ORDER BY game_date DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		List<Game2Result> results = new ArrayList<>();
        
		try (conn; pstmt; rs) {
            while (rs.next()) {
                Game2Result gameResult = new Game2Result();
                gameResult.setUserName(rs.getString("user_name"));
                gameResult.setUserChoice(rs.getString("user_choice"));
                gameResult.setComputerChoice(rs.getString("computer_choice"));
                gameResult.setResult(rs.getString("result"));
                gameResult.setGameDate(rs.getTimestamp("game_date").toLocalDateTime());
                results.add(gameResult);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }
    
    public void deleteAllGame2Results() throws Exception {
    	Connection conn = open();
        String deleteSql = "DELETE FROM game2_results";
        String alterSql = "ALTER TABLE game2_results AUTO_INCREMENT = 1";

        try {
            conn.setAutoCommit(false); // 트랜잭션 시작

            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.executeUpdate();
            }

            try (PreparedStatement alterStmt = conn.prepareStatement(alterSql)) {
                alterStmt.executeUpdate();
            }

            conn.commit(); // 트랜잭션 커밋
        } catch (SQLException e) {
            conn.rollback(); // 오류 시 롤백
            e.printStackTrace();
            throw new RuntimeException("DB 에러");
        } finally {
            conn.setAutoCommit(true); // 원상 복구
            conn.close();
        }
    }
    
    public void delGame2Result(int aid) throws SQLException{
		 Connection conn = open();
		 
		 String sql= "DELETE FROM game2_result where aid=?";
		 PreparedStatement pstmt= conn.prepareStatement(sql);
		 
		 try(conn; pstmt) {
			 pstmt.setInt(1, aid);

			 if(pstmt.executeUpdate() == 0) {
				 throw new SQLException("DB 에러");
			 }
		 }
	}
    
}
