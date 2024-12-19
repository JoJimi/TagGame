<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아파트 게임</title>
    <style>
        body {
            font-family: 'Comic Sans MS', cursive, sans-serif;
            margin: 20px;
            background-color: #f0f8ff;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .game-container {
            width: 100%;
            max-width: 500px;
            background: linear-gradient(135deg, #ffcccb, #87ceeb);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        h1 {
            font-size: 2.5em;
            color: #ff4500;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.1em;
            margin-bottom: 20px;
            color: #555;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            font-size: 1.2em;
            margin-bottom: 8px;
        }
        input[type="number"] {
            width: 95%;
            padding: 12px;
            font-size: 1em;
            border: 2px solid #ccc;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        button {
            width: 100%;
            padding: 15px;
            font-size: 1.2em;
            color: white;
            background: #ff4500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background: #e63900;
        }
        .secondary-button {
            margin-top: 10px;
            background: #007bff;
        }
        .secondary-button:hover {
            background: #0056b3;
        }
    </style>
    <script>
        function validateWinnerFloor() {
            const participantCount = document.getElementById("participantCount").value;
            const winnerApartmentFloor = document.getElementById("winnerApartmentFloor");
            const maxFloor = participantCount * 2;

            if (participantCount && winnerApartmentFloor.value > maxFloor) {
                alert("당첨 아파트 층 수는 사용자 수의 2배를 초과할 수 없습니다.");
                winnerApartmentFloor.value = "";
            }
        }

        function setupValidation() {
            const participantInput = document.getElementById("participantCount");
            const winnerInput = document.getElementById("winnerApartmentFloor");

            participantInput.addEventListener("input", () => {
                if (winnerInput.value) validateWinnerFloor();
            });

            winnerInput.addEventListener("input", validateWinnerFloor);
        }

        document.addEventListener("DOMContentLoaded", setupValidation);
    </script>
</head>
<body>
    <div class="game-container">
        <h1>🏢 아파트 게임</h1>
        <p>사용자 수와 당첨 층 수를 입력하고 게임을 시작하세요!</p>

        <form action="/game5/play" method="post">
            <label for="participantCount">👥 사용자 수:</label>
            <input type="number" id="participantCount" name="participantCount" min="2" max="15" placeholder="2 ~ 15명의 사용자 수 입력" required>

            <label for="winnerApartmentFloor">🎯 당첨 아파트 층 수:</label>
            <input type="number" id="winnerApartmentFloor" name="winnerApartmentFloor" min="1" placeholder="당첨 층 수 입력" required>

            <button type="submit">🚀 게임 시작</button>
        </form>

        <form action="/game5/results" method="get">
            <button type="submit" class="secondary-button">📜 게임 기록 보기</button>
        </form>
    </div>
</body>
</html>
