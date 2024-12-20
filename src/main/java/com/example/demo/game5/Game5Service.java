package com.example.demo.game5;

import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class Game5Service {

    private final Game5DAO game5DAO;

    public Game5Service(Game5DAO game5DAO) {
        this.game5DAO = game5DAO;
    }

    public Map<Integer, List<Integer>> playGame(int participantCount, int winnerApartmentFloor) throws Exception {
        int totalFloors = participantCount * 2; // 총 아파트 층 수
        int winnerUserNumber = -1;

        Map<Integer, List<Integer>> participantFloors = new HashMap<>(); // 참여자와 층수 매핑
        Set<Integer> assignedFloors = new HashSet<>(); // 중복 방지를 위한 층수 저장소
        
        Random random = new Random();

        // 각 참여자에게 두 개의 랜덤한 층 배정
        for (int participant = 1; participant <= participantCount; participant++) {
        	List<Integer> floors = new ArrayList<>();
            while (floors.size() < 2) {
                int floor = random.nextInt(totalFloors) + 1; // 1부터 totalFloors 사이의 값
                
                if (!assignedFloors.contains(floor)) { // 중복 확인
                    floors.add(floor);
                    assignedFloors.add(floor);
                    if(winnerApartmentFloor == floor) {
                    	winnerUserNumber = participant;
                    }
                }
            }
            
            participantFloors.put(participant, floors); // 참여자 번호와 배정된 층 저장
        }
        game5DAO.saveGame5Result(participantCount, winnerApartmentFloor, winnerUserNumber);

        return participantFloors; // 모든 참여자의 배정된 층수 반환
    }

    // 2. 모든 게임 결과 조회
    public List<Game5Result> getGameResults() throws Exception {
        return game5DAO.getAllGame5Results();
    }

    // 3. 모든 게임 결과 삭제
    public void deleteAllGameResults() throws SQLException {
        game5DAO.deleteAllGame5Results();
    }

    // 4. 특정 게임 결과 삭제
    public void deleteGameResult(int id) throws Exception {
        game5DAO.delGame5Result(id);
    }
}
