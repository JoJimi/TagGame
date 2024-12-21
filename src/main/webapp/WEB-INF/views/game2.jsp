<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>가위바위보 게임</title>
<link rel="stylesheet" href="/css/style.css">
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f3f4f6;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.game-container {
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 90%;
    max-width: 600px;
    padding: 20px;
}

h1 {
    text-align: center;
    margin-bottom: 20px;
    color: #333333;
}

label {
    font-size: 16px;
    display: block;
    margin-bottom: 10px;
    color: #555555;
}

input[type="text"] {
    width: 95%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #cccccc;
    border-radius: 5px;
    font-size: 16px;
}

.image-choices {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 20px;
    margin: 20px 0;
}

.image-choice {
    cursor: pointer;
    border: 2px solid transparent;
    border-radius: 10px;
    padding: 10px;
    transition: transform 0.3s, border-color 0.3s;
}

.image-choice:hover {
    transform: scale(1.1);
}

.image-choice.selected {
    border-color: #007bff;
    background-color: #f0f8ff;
}

.image-choice img {
    width: 60px;
    height: auto;
}

button {
    padding: 10px 20px;
    font-size: 16px;
    color: #ffffff;
    background-color: #007bff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

button:hover {
    background-color: #0056b3;
}

button:disabled {
    background-color: #cccccc;
    cursor: not-allowed;
}

.choices-row {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin-top: 20px;
}

.choice {
    text-align: center;
}

.choice img {
    width: 80px;
    height: auto;
    margin-top: 10px;
}

.result {
    margin-top: 20px;
    text-align: center;
    color: #333333;
}

.result p {
    font-size: 20px;
    margin-top: 10px;
    font-weight: bold;
}
</style>
</head>
<body>
	<div class="game-container">
		<h1>가위바위보 게임</h1>
		<form action="/game2/play" method="post">
			<!-- 사용자 이름 입력 -->
			<label for="userName">사용자 이름:</label>
			<input type="text" id="userName" name="userName" required>

			<!-- 가위, 바위, 보 이미지 선택 -->
			<p>가위, 바위, 보 중 하나를 선택하세요:</p>
			<div class="image-choices">
				<!-- 이미지 선택 영역 -->
				<label class="image-choice" id="choice-scissors">
					<input type="radio" name="userChoice" value="scissors" hidden>
					<img src="/images/scissors0.jpg" alt="가위">
				</label>
				<label class="image-choice" id="choice-rock">
					<input type="radio" name="userChoice" value="rock" hidden>
					<img src="/images/rock0.jpg" alt="바위">
				</label>
				<label class="image-choice" id="choice-paper">
					<input type="radio" name="userChoice" value="paper" hidden>
					<img src="/images/paper0.jpg" alt="보">
				</label>
			</div>

			<!-- 버튼 영역 -->
			<div style="display: flex; justify-content: space-between; margin-top: 20px;">
				<!-- 게임 시작 버튼 -->
				<form action="/game2/play" method="post">
					<button type="submit">게임 시작</button>
				</form>

				<!-- 게임 기록 버튼 -->
				<form action="/game2/results" method="get">
					<button type="submit">게임 기록</button>
				</form>
			</div>
		</form>
		<hr>

		<!-- 게임 결과 표시 -->
		<div class="result">
			<h2>게임 결과</h2>
			<div class="choices-row">
				<!-- 사용자 선택 이미지 -->
				<div class="choice">
					<h3>사용자</h3>
					<img src="/images/${userChoice}1.jpg" alt="${userChoice}" class="choice-image">
				</div>

				<!-- 컴퓨터 선택 이미지 -->
				<div class="choice">
					<h3>컴퓨터</h3>
					<img src="/images/${computerChoice}2.jpg" alt="${computerChoice}" class="choice-image">
				</div>
			</div>

			<p><strong>${result}</strong></p>
		</div>
	</div>

	<script>
		// 이미지 선택 시 선택된 스타일 적용
		const choices = document.querySelectorAll('.image-choice');
		choices.forEach(choice => {
			choice.addEventListener('click', () => {
				// 모든 선택에서 'selected' 클래스 제거
				choices.forEach(c => c.classList.remove('selected'));

				// 클릭된 선택에 'selected' 클래스 추가
				choice.classList.add('selected');

				// 내부 라디오 버튼 선택
				choice.querySelector('input').checked = true;
			});
		});
	</script>
</body>
</html>