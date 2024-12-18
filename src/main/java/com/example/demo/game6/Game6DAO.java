package com.example.demo.game6;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

@Repository
public class Game6DAO {

    private final DataSource dataSource;

    public Game6DAO(DataSource dataSource) {
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
    
    // 현재 게임 ID 가져오기
    public int getCurrentGameId() throws SQLException {
        String sql = "SELECT COALESCE(MAX(game_id), 0) AS max_game_id FROM game6_results"; 
        // COALESCE는 NULL 값을 0으로 대체하여, 값이 없으면 0을 반환합니다.

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("max_game_id") + 1;  // 최댓값에 1을 더해서 반환
            } else {
                return 1;  // 값이 없다면 1부터 시작
            }
        }
    }

    // 1. 게임 결과 저장
    public void saveGame6Result(int gameId, String name, String content, LocalDateTime gameDate) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO game6_results (game_id, name, content, game_date) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, gameId); 
            pstmt.setString(2, name);
            pstmt.setString(3, content);
            pstmt.setObject(4, gameDate);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 2. 모든 게임 결과 조회
    public List<Game6Result> getAllGame6Results() throws Exception {
        Connection conn = open();
        String sql = "SELECT id, game_id, name, content, game_date FROM game6_results ORDER BY game_date DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        
        ResultSet rs = pstmt.executeQuery();
        List<Game6Result> results = new ArrayList<>();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                Game6Result result = new Game6Result();
                result.setId(rs.getInt("id"));
                result.setGameId(rs.getInt("game_id"));
                result.setName(rs.getString("name"));
                result.setContent(rs.getString("content"));
                result.setGameDate(rs.getTimestamp("game_date").toLocalDateTime());
                results.add(result);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }

    // 3. 특정 게임 ID에 해당하는 결과 삭제
    public void deleteGame6ResultByGameId(int gameId) throws SQLException {
        Connection conn = open();
        String sql = "DELETE FROM game6_results WHERE game_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, gameId);
            if (pstmt.executeUpdate() == 0) {
                throw new SQLException("DB 에러");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 에러");
        }
    }

    // 4. 모든 게임 결과 삭제 및 ID 초기화
    public void deleteAllGame6Results() throws SQLException {
        Connection conn = open();
        String deleteSql = "DELETE FROM game6_results";
        String alterSql = "ALTER TABLE game6_results AUTO_INCREMENT = 1";

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

}
