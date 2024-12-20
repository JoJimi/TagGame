<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>랜덤 박스 게임</title>
    <style>
        body {
            font-family: 'Press Start 2P', cursive;
            background-color: #f0f0f0;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background: linear-gradient(145deg, #ffffff, #e0e0e0);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        h1 {
            font-size: 48px;
            color: #ff6f61;
            text-shadow: 1px 2px 4px rgba(255, 111, 97, 0.7);
        }
        .input-group {
            margin: 20px 0;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        input[type="number"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 18px;
            width: 150px;
            text-align: center;
            background: #fff;
            color: #333;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        button {
            background: linear-gradient(145deg, #ff6f61, #ff8a80);
            color: white;
            font-size: 16px;
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        button:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(255, 138, 128, 0.5);
        }
        button:active {
            transform: scale(0.95);
        }
        .ladder-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 30px;
        }
        .ladder-column {
            text-align: center;
        }
        .vertical-line {
            width: 6px;
            height: 400px;
            background: linear-gradient(180deg, #ffcc00, #ff6f61);
            margin: 10px auto;
            border-radius: 3px;
            position: relative;
        }
        .question-img {
            width: 50px;
            height: 50px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            animation: bounce 1.5s infinite;
        }
        @keyframes bounce {
            0%, 100% {
                transform: translate(-50%, -50%) scale(1);
            }
            50% {
                transform: translate(-50%, -45%) scale(1.1);
            }
        }
        input[type="text"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            width: 100px;
            text-align: center;
            background: #f7f7f7;
            color: #333;
        }
        .button-group {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        .results {
            margin-top: 20px;
            display: grid;
            gap: 15px;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        }
        .result-card {
            background: #ff8a80;
            color: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(255, 138, 128, 0.3);
            text-align: center;
        }
        .result-card span {
            display: block;
            font-size: 18px;
            font-weight: bold;
        }
        #startGameButton {
            display: none;
        }
        #playGameButton {
            display: block;
        }
    </style>
    <script>
        let playerCount = 0;
        let ladderMap = [];
        let startPoints = [];
        let endPoints = [];

        function generateLadder(count) {
            playerCount = count;
            ladderMap = Array.from({ length: 400 }, () => Array(count).fill(false));
            startPoints = Array(count).fill("");
            endPoints = Array(count).fill("");

            const ladderContainer = document.getElementById("ladder");
            ladderContainer.innerHTML = "";

            const containerWidth = ladderContainer.offsetWidth - 50;
            const gapWidth = containerWidth / (count - 1);

            for (let i = 0; i < count; i++) {
                const ladderColumn = document.createElement("div");
                ladderColumn.className = "ladder-column";
                ladderColumn.style.marginLeft = i === 0 ? "0px" : `${gapWidth}px`;

                const startInput = document.createElement("input");
                startInput.type = "text";
                startInput.placeholder = "출발지";
                startInput.className = "start-input";

                startInput.addEventListener("input", (event) => {
                    startPoints[i] = event.target.value;
                });

                ladderColumn.appendChild(startInput);

                const verticalLine = document.createElement("div");
                verticalLine.className = "vertical-line";
                verticalLine.dataset.column = i;

                const questionImg = document.createElement("img");
                questionImg.src = "/images/question.png";
                questionImg.className = "question-img";
                verticalLine.appendChild(questionImg);

                ladderColumn.appendChild(verticalLine);

                const endInput = document.createElement("input");
                endInput.type = "text";
                endInput.placeholder = "도착지";
                endInput.className = "end-input";

                endInput.addEventListener("input", (event) => {
                    endPoints[i] = event.target.value;
                });

                ladderColumn.appendChild(endInput);

                ladderContainer.appendChild(ladderColumn);
            }

            document.getElementById("startGameButton").style.display = "inline-block";
            document.getElementById("playGameButton").style.display = "inline-block";
            document.getElementById("results").innerHTML = "";
        }

        function shuffleArray(array) {
            for (let i = array.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [array[i], array[j]] = [array[j], array[i]];
            }
        }

        function generateRandomBox() {
            const startInputs = document.querySelectorAll(".start-input");
            const endInputs = document.querySelectorAll(".end-input");

            for (let i = 0; i < startInputs.length; i++) {
                if (!startInputs[i].value.trim()) {
                    alert("출발지를 입력해주세요.");
                    return;
                }
                if (!endInputs[i].value.trim()) {
                    alert("도착지를 입력해주세요.");
                    return;
                }
            }

            startPoints = Array.from(startInputs).map(input => input.value.trim());
            endPoints = Array.from(endInputs).map(input => input.value.trim());

            shuffleArray(endPoints);

            const form = document.createElement("form");
            form.method = "POST";
            form.action = "/game6/play";

            startPoints.forEach((point, index) => {
                const inputStart = document.createElement("input");
                inputStart.type = "hidden";
                inputStart.name = "startPoints";
                inputStart.value = point;
                form.appendChild(inputStart);

                const inputEnd = document.createElement("input");
                inputEnd.type = "hidden";
                inputEnd.name = "endPoints";
                inputEnd.value = endPoints[index];
                form.appendChild(inputEnd);
            });

            document.body.appendChild(form);
            form.submit();
        }

        function handleFormSubmit(event) {
            event.preventDefault();
            const count = parseInt(document.getElementById("playerCount").value);
            if (isNaN(count) || count < 2 || count > 15) {
                alert("참여자 수는 2명에서 15명 사이로 입력해주세요.");
                return;
            }
            document.getElementById("startGameButton").style.display = "none";
            document.getElementById("playGameButton").style.display = "none";
            generateLadder(count);
        }
    </script>
</head>
<body>
<div class="container">
    <h1>랜덤 박스 게임</h1>
    <form onsubmit="handleFormSubmit(event)">
        <div class="input-group">
            <label for="playerCount">참여자 수:</label>
            <input type="number" id="playerCount" min="2" max="15" placeholder="2~15명">
            <button type="submit">확인</button>
        </div>
    </form>

    <div id="ladder" class="ladder-container"></div>

    <div class="button-group">
        <button id="startGameButton" type="button" onclick="generateRandomBox()">랜덤 박스 생성</button>
        <form action="/game6/results" method="get" style="display: inline;">
            <button id="playGameButton" type="submit">게임 기록</button>
        </form>
    </div>

    <div id="results" class="results"></div>
</div>
</body>
</html>
