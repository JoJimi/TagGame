package com.example.demo.game4;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
public class Game4DAO {
	
	@Autowired
    private DataSource dataSource;

    public Connection open() {
        try {
            return dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get database connection.");
        }
    }
    
    public void saveGame4Result(int bombExplodedTime) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO game4_results (bomb_exploded_time, game_date) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, bombExplodedTime);
            pstmt.setObject(2, LocalDateTime.now());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Game4Result> getAllGame4Results() throws Exception {
        Connection conn = open();
        String sql = "SELECT id, bomb_exploded_time, game_date FROM game4_results ORDER BY game_date DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        ResultSet rs = pstmt.executeQuery();
        List<Game4Result> results = new ArrayList<>();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                Game4Result gameResult = new Game4Result();
                gameResult.setId(rs.getInt("id"));
                gameResult.setBombExplodedTime(rs.getInt("bomb_exploded_time"));
                gameResult.setGameDate(rs.getTimestamp("game_date").toLocalDateTime());
                results.add(gameResult);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }
    
    public void deleteAllGame4Results() throws Exception {
    	Connection conn = open();
        String deleteSql = "DELETE FROM game4_results";
        String alterSql = "ALTER TABLE game4_results AUTO_INCREMENT = 1";

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
    
    public void delGame4Result(int aid) throws SQLException{
		 Connection conn = open();
		 
		 String sql= "DELETE FROM game4_result where aid=?";
		 PreparedStatement pstmt= conn.prepareStatement(sql);
		 
		 try(conn; pstmt) {
			 pstmt.setInt(1, aid);

			 if(pstmt.executeUpdate() == 0) {
				 throw new SQLException("DB 에러");
			 }
		 }catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 에러");
        }
	}   
}
