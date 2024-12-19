<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게임 실행 결과</title>
    <style>
        body {
            font-family: 'Press Start 2P', 'Comic Sans MS', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #89cff0, #b0e0e6);
            color: #000;
            text-shadow: 0 1px 3px rgba(255, 255, 255, 0.8);
        }
        h1 {
            text-align: center;
            color: #ffdf00;
            font-size: 3em;
            margin-top: 20px;
            animation: glow 1s infinite alternate;
        }
        @keyframes glow {
            from {
                text-shadow: 0 0 10px #ffdf00, 0 0 20px #ffdf00, 0 0 30px #ffdf00;
            }
            to {
                text-shadow: 0 0 20px #f0e68c, 0 0 30px #f0e68c, 0 0 40px #f0e68c;
            }
        }
        .result {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.3);
        }
        .winner {
            font-weight: bold;
            text-shadow: 0 1px 4px rgba(255, 160, 122, 0.8);
        }
        .floor-table {
            margin: 20px 0;
            border-collapse: collapse;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 8px;
            overflow: hidden;
            animation: slide-in 1s ease-in-out;
        }
        @keyframes slide-in {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .floor-table th, .floor-table td {
            border: 1px solid #ccc;
            padding: 15px;
            text-align: center;
        }
        .floor-table th {
            background: #ffb347;
            color: #000;
            font-size: 1.2em;
        }
        .floor-table tr:nth-child(even) {
            background: #fdfd96;
        }
        .floor-table tr:hover {
            background: #ffe4b5;
            color: #000;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .button-container button {
            padding: 15px 30px;
            background: linear-gradient(45deg, #f4a460, #ffa07a);
            color: #000;
            border: none;
            border-radius: 25px;
            font-size: 1.2em;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .button-container button:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
        }
        .winner-row {
            background: linear-gradient(90deg, #ffcccb, #fdfd96);
            color: #ff0000;
            font-weight: bold;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% {
                box-shadow: 0 0 10px rgba(255, 223, 0, 0.6);
            }
            50% {
                box-shadow: 0 0 20px rgba(255, 223, 0, 0.8);
            }
        }
    </style>
</head>
<body>
    <h1>🎮 게임 실행 결과 🎮</h1>

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
                    <th>층</th>
                    <th>참여자</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (Map.Entry<Integer, List<Integer>> entry : floorParticipants.entrySet()) {
                        int floor = entry.getKey();
                        List<Integer> participants = entry.getValue();
                        boolean isWinnerFloor = (floor == winnerApartmentFloor);
                %>
                <tr class="<%= isWinnerFloor ? "winner-row" : "" %>">
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
                <button>🔄 다시 하기</button>
            </form>
            <form action="/game5/results" method="get" style="display: inline;">
                <button>📜 게임 기록</button>
            </form>
        </div>
    </div>
</body>
</html>
