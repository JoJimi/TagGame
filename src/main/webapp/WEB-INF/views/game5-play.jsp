<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게임 실행 결과</title>
    <style>
        body {
            font-family: 'Comic Sans MS', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: #fff;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.6);
        }
        h1 {
            text-align: center;
            color: #ffd700;
            font-size: 3em;
            margin-top: 20px;
        }
        .result {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: rgba(0, 0, 0, 0.8);
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
        }
        .winner {
            color: #32cd32;
            font-weight: bold;
            text-shadow: 0 1px 4px rgba(50, 205, 50, 0.8);
        }
        .floor-table {
            margin: 20px 0;
            border-collapse: collapse;
            width: 100%;
            color: #000;
            background: #fdfd96;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        .floor-table th, .floor-table td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        .floor-table th {
            background: #ff4500;
            color: white;
            font-size: 1.2em;
        }
        .floor-table tr:nth-child(even) {
            background: #f7f7f7;
        }
        .floor-table tr:hover {
            background: #ffd700;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .button-container button {
            padding: 10px 25px;
            background: linear-gradient(45deg, #6a11cb, #2575fc);
            color: #fff;
            border: none;
            border-radius: 50px;
            font-size: 1.1em;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            transition: all 0.3s;
            margin: 0 15px;
        }
        .button-container button:hover {
            background: linear-gradient(45deg, #ff6a00, #ee0979);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.5);
        }
    </style>
</head>
<body>
    <h1>게임 실행 결과</h1>

    <div class="result">
        <p><strong>참여자 수:</strong> ${participantCount}</p>
        <p><strong>당첨 아파트 층 수:</strong> <span class="winner">${winnerApartmentFloor}</span></p>

        <% 
            Map<Integer, List<Integer>> participantFloors = (Map<Integer, List<Integer>>) request.getAttribute("participantFloors");
            Map<Integer, List<Integer>> floorParticipants = new java.util.TreeMap<>(java.util.Collections.reverseOrder());
            int winnerApartmentFloor = (int) request.getAttribute("winnerApartmentFloor");
            for (Map.Entry<Integer, List<Integer>> entry : participantFloors.entrySet()) {
                for (int floor : entry.getValue()) {
                    floorParticipants.computeIfAbsent(floor, k -> new java.util.ArrayList<>()).add(entry.getKey());
                }
            }
        %>

        <table class="floor-table">
            <thead>
                <tr>
                    <th>층 번호</th>
                    <th>참여자 이름</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (Map.Entry<Integer, List<Integer>> entry : floorParticipants.entrySet()) {
                        int floor = entry.getKey();
                        List<Integer> participants = entry.getValue();
                        boolean isWinnerFloor = (floor == winnerApartmentFloor);
                %>
                <tr class="<%= isWinnerFloor ? "winner" : "" %>">
                    <td><%= floor %>층</td>
                    <td>
                        <% for (int participant : participants) { %>
                            사용자 <%= participant %><% if (participants.indexOf(participant) != participants.size() - 1) { %>, <% } %>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div class="button-container">
            <form action="/game5" method="get" style="display: inline;">
                <button>다시 하기</button>
            </form>
            <form action="/game5/results" method="get" style="display: inline;">
                <button>게임 기록</button>
            </form>
        </div>
    </div>
</body>
</html>
