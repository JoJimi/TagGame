<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>랜덤 박스 게임</title>
    <style>
        /* 기존 스타일 유지 */
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
        .results-section {
            margin-top: 30px;
            text-align: left;
        }
        .results-section h2 {
            font-size: 24px;
            color: #ff6f61;
            margin-bottom: 15px;
        }
        .results {
            display: grid;
            gap: 10px;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        }
        .result-card {
            background: #ff8a80;
            color: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(255, 138, 128, 0.3);
            text-align: center;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .result-card span {
            margin: 0 5px;
            font-weight: bold;
        }
        #startGameButton {
            display: none;
        }
        #playGameButton {
            display: block;
        }
        /* Alert styles */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            text-align: center;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
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

            // Ensure ladderContainer has width to calculate gap
            ladderContainer.style.width = "100%";
            const containerWidth = ladderContainer.offsetWidth - 50;
            const gapWidth = count > 1 ? containerWidth / (count - 1) : 0;

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
                questionImg.src = "/images/question.png"; // 이미지 경로 확인 필요
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
            document.getElementById("saveGameButton").style.display = "none"; // Hide save button initially
            document.getElementById("resultsSection").style.display = "none"; // 결과 섹션 숨기기
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

            // Display results
            const resultsContainer = document.getElementById("results");
            resultsContainer.innerHTML = ""; // Clear previous results

            for (let i = 0; i < playerCount; i++) {
                const resultCard = document.createElement("div");
                resultCard.className = "result-card";

                const startSpan = document.createElement("span");
                startSpan.textContent = startPoints[i];

                const arrowSpan = document.createElement("span");
                arrowSpan.textContent = "→";

                const endSpan = document.createElement("span");
                endSpan.textContent = endPoints[i];

                resultCard.appendChild(startSpan);
                resultCard.appendChild(arrowSpan);
                resultCard.appendChild(endSpan);

                resultsContainer.appendChild(resultCard);
            }

            // Show results section
            document.getElementById("resultsSection").style.display = "block";

            // Hide the start game button and show the save game button
            document.getElementById("startGameButton").style.display = "none";
            document.getElementById("saveGameButton").style.display = "inline-block";
        }

        function populateAndSubmitForm() {
            const form = document.getElementById("saveGameForm");
            form.innerHTML = ''; // Clear any existing inputs

            // Add startPoints
            startPoints.forEach(point => {
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "startPoints";
                input.value = point;
                form.appendChild(input);
            });

            // Add endPoints
            endPoints.forEach(point => {
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "endPoints";
                input.value = point;
                form.appendChild(input);
            });

            // Submit the form
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
            document.getElementById("saveGameButton").style.display = "none";
            generateLadder(count);
        }
    </script>
</head>
<body>
<div class="container">
    <h1>랜덤 박스 게임</h1>
    
    <!-- Display flash messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form onsubmit="handleFormSubmit(event)">
        <div class="input-group">
            <label for="playerCount">참여자 수:</label>
            <input type="number" id="playerCount" min="2" max="15" placeholder="2~15명" required>
            <button type="submit">확인</button>
        </div>
    </form>

    <div id="ladder" class="ladder-container"></div>

    <div class="button-group">
        <button id="startGameButton" type="button" onclick="generateRandomBox()">랜덤 박스 생성</button>
        <!-- 게임 기록 버튼은 서버와 연동되어 있으므로 유지 -->
        <form action="/game6/results" method="get" style="display: inline;">
            <button id="playGameButton" type="submit">게임 기록</button>
        </form>
        <form action="/" method="get" style="display: inline;">
            <button type="submit">🏠 홈으로</button>
        </form>
        <!-- Save Game Button -->
        <button id="saveGameButton" type="button" onclick="populateAndSubmitForm()" style="display: none;">게임 결과 저장</button>
    </div>

    <!-- 결과 섹션 추가 -->
    <div id="resultsSection" class="results-section" style="display: none;">
        <h2>게임 결과</h2>
        <div id="results" class="results"></div>
    </div>

    <!-- Hidden form to save game results -->
    <form id="saveGameForm" action="/game6/play" method="post" style="display:none;">
        <!-- Hidden inputs will be added dynamically via JavaScript -->
    </form>
</div>
</body>
</html>
