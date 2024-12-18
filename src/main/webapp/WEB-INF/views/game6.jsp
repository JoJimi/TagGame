<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>랜덤 박스 게임</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 100%;
            margin: 0 auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            overflow-x: auto;
        }
        h1 {
            color: #007bff;
            margin-bottom: 20px;
        }
        .input-group {
            margin: 10px 0;
        }
        input {
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100px;
            text-align: center;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .button-group {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 10px; /* 버튼 간격 */
		    margin-top: 20px;
		}
        .ladder-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px auto;
            gap: 50px;
            position: relative;
        }
        .ladder-column {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
        }
        .vertical-line {
            width: 5px;
            height: 400px;
            background: #007bff;
            position: relative;
        }
        .horizontal-line {
            height: 5px;
            background: #ff0000;
            position: absolute;
        }
        .question-img {
            width: 40px;
            height: 40px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        #startGameButton {
            display: none;
        }
        #playGameButton {
            display: block;
        }
        .results {
            margin-top: 20px;
            font-size: 18px;
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

            // 입력 검증
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

            // `startPoints`와 `endPoints` 값 가져오기
            startPoints = Array.from(startInputs).map(input => input.value.trim());
            endPoints = Array.from(endInputs).map(input => input.value.trim());

            // `endPoints` 배열 섞기
            shuffleArray(endPoints);
            
            // 동적으로 `form` 생성 및 데이터 전송
            const form = document.createElement("form");
            form.method = "POST";
            form.action = "/game6/play";

            // `startPoints`와 `endPoints`를 폼 데이터로 추가
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

            // 폼을 body에 추가 후 제출
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
            <input type="number" id="playerCount" min="2" max="15">
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
