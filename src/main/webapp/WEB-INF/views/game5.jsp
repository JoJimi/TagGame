<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아파트 게임</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f9;
            color: #333;
        }
        h1 {
            text-align: center;
            color: #007bff;
        }
        form {
            max-width: 400px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="number"] {
            width: 95%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .link-container {
            text-align: center;
            margin-top: 20px;
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
    <h1>아파트 게임 실행</h1>

    <form action="/game5/play" method="post">
        <label for="participantCount">사용자 수:</label>
        <input type="number" id="participantCount" name="participantCount" min="2" max="15"  placeholder="참여할 사용자 수를 입력하세요" required>

        <label for="winnerApartmentFloor">당첨 아파트 층 수:</label>
        <input type="number" id="winnerApartmentFloor" name="winnerApartmentFloor" min="1" placeholder="당첨 층 수를 입력하세요" required>

        <button type="submit">게임 실행</button>
    </form>

    <div class="link-container">
        <form action="/game5/results" method="get">
            <button type="submit">게임 기록</button>
        </form>
    </div>
</body>
</html>
