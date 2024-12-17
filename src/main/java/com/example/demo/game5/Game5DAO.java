package com.example.demo.game5;

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
public class Game5DAO {

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

    // 1. 게임 결과 저장
    public void saveGame5Result(int participantCount, int winnerApartmentFloor, int winnerUserNumber) {
        Connection conn = open();
        String sql = "INSERT INTO game5_results (participant_count, winner_apartment_floor, winner_user_number, game_start_time) VALUES (?, ?, ?, ?)";
        try (conn; PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, participantCount);
            pstmt.setInt(2, winnerApartmentFloor);
            pstmt.setInt(3, winnerUserNumber);
            pstmt.setObject(4, LocalDateTime.now());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 저장 중 에러 발생");
        }
    }

    // 2. 모든 게임 결과 조회
    public List<Game5Result> getAllGame5Results() {
        Connection conn = open();
        String sql = "SELECT id, participant_count, winner_apartment_floor, winner_user_number, game_start_time FROM game5_results ORDER BY game_start_time DESC";
        List<Game5Result> results = new ArrayList<>();

        try (conn; PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Game5Result result = new Game5Result();
                result.setId(rs.getInt("id"));
                result.setParticipantCount(rs.getInt("participant_count"));
                result.setWinnerApartmentFloor(rs.getInt("winner_apartment_floor"));
                result.setWinnerUserNumber(rs.getInt("winner_user_number"));
                result.setGameStartTime(rs.getTimestamp("game_start_time").toLocalDateTime());
                results.add(result);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 조회 중 에러 발생");
        }
        return results;
    }

    // 3. 모든 게임 결과 삭제
    public void deleteAllGame5Results() {
        Connection conn = open();
        String sql = "DELETE FROM game5_results; ALTER TABLE game5_results AUTO_INCREMENT = 1";

        try (conn; PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 초기화 중 에러 발생");
        }
    }

    // 4. 특정 게임 결과 삭제
    public void delGame5Result(int id) {
        Connection conn = open();
        String sql = "DELETE FROM game5_results WHERE id = ?";

        try (conn; PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
