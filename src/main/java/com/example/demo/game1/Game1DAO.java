package com.example.demo.game1;

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
public class Game1DAO {

    private final DataSource dataSource;

    public Game1DAO(DataSource dataSource) {
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

    // 1. 게임 결과 저장
    public void saveGame1Result(int participantCount, int gameRound) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO game1_results (participant_count, game_round, game_date) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, participantCount);
            pstmt.setInt(2, gameRound);
            pstmt.setObject(3, LocalDateTime.now());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 저장 중 에러 발생");
        }
    }

    // 2. 모든 게임 결과 조회
    public List<Game1Result> getAllGame1Results() throws Exception {
        Connection conn = open();
        String sql = "SELECT id, participant_count, game_round, game_date FROM game1_results ORDER BY game_date DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Game1Result> results = new ArrayList<>();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                Game1Result gameResult = new Game1Result();
                gameResult.setId(rs.getInt("id"));
                gameResult.setParticipantCount(rs.getInt("participant_count"));
                gameResult.setGameRound(rs.getInt("game_round"));
                gameResult.setGameDate(rs.getTimestamp("game_date").toLocalDateTime());
                results.add(gameResult);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 조회 중 에러 발생");
        }
        return results;
    }

    // 3. 모든 게임 결과 삭제
    public void deleteAllGame1Results() throws Exception {
    	Connection conn = open();
        String deleteSql = "DELETE FROM game1_results";
        String alterSql = "ALTER TABLE game1_results AUTO_INCREMENT = 1";

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

    // 4. 특정 게임 결과 삭제
    public void delGame1Result(int id) throws SQLException {
        Connection conn = open();
        String sql = "DELETE FROM game1_results WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, id);

            if (pstmt.executeUpdate() == 0) {
                throw new SQLException("해당 ID의 데이터가 존재하지 않습니다.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 삭제 중 에러 발생");
        }
    }
}
