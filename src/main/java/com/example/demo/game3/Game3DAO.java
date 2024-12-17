package com.example.demo.game3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Game3DAO {

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

    // 게임 결과 저장
    public void saveGame3Result(int participantCount, String winnerName) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO game3_results (participant_count, winner_name, game_date) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, participantCount);
            pstmt.setString(2, winnerName);
            pstmt.setObject(3, LocalDateTime.now());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 에러");
        }
    }

    // 게임 결과 모두 조회
    public List<Game3Result> getAllGame3Results() throws Exception {
        Connection conn = open();
        String sql = "SELECT id, participant_count, winner_name, game_date FROM game3_results ORDER BY game_date DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Game3Result> results = new ArrayList<>();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                Game3Result gameResult = new Game3Result();
                gameResult.setId(rs.getInt("id"));
                gameResult.setParticipantCount(rs.getInt("participant_count"));
                gameResult.setWinnerName(rs.getString("winner_name"));
                gameResult.setGameDate(rs.getTimestamp("game_date").toLocalDateTime());
                results.add(gameResult);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 에러");
        }
        return results;
    }

    // 게임 결과 전체 삭제
    public void deleteAllGame3Results() throws Exception {
        Connection conn = open();
        String sql = "DELETE FROM game3_results; ALTER TABLE game3_results AUTO_INCREMENT = 1";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 에러");
        }
    }

    // 특정 게임 결과 삭제
    public void deleteGame3Result(int id) throws SQLException {
        Connection conn = open();
        String sql = "DELETE FROM game3_results WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, id);

            if (pstmt.executeUpdate() == 0) {
                throw new SQLException("DB 에러: 삭제할 ID가 존재하지 않습니다.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 에러");
        }
    }
}
