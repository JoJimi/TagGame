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
/* 이미지 선택 UI 스타일링 */
.image-choices {
	display: flex;
	justify-content: center;
	align-items: flex-end;
	gap: 20px;
	margin: 20px 0;
}

.image-choice {
	cursor: pointer;
	border: 2px solid transparent;
	border-radius: 8px;
	padding: 5px; /* 이미지와 경계선 사이 여백 */
	transition: border-color 0.3s;
	box-sizing: border-box; /* padding이 경계선 내부에 포함되도록 설정 */
}

.image-choice.selected {
	border-color: #007bff;
}

.image-choice img {
	width: 50px;
	height: auto;
}

button {
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="game-container">
		<h1>가위바위보 게임</h1>
		<form action="/game2/play" method="post">
			<!-- 사용자 이름 입력 -->
			<label for="userName">사용자 이름:</label> <input type="text"
				id="userName" name="userName" required>

			<!-- 가위, 바위, 보 이미지 선택 -->
			<p>가위, 바위, 보 중 하나를 선택하세요:</p>
			<div class="image-choices">
				<!-- 이미지 선택 영역 -->
				<label class="image-choice" id="choice-scissors"> <input
					type="radio" name="userChoice" value="scissors" hidden> <img
					src="/images/scissors0.jpg" alt="가위">
				</label> <label class="image-choice" id="choice-rock"> <input
					type="radio" name="userChoice" value="rock" hidden> <img
					src="/images/rock0.jpg" alt="바위">
				</label> <label class="image-choice" id="choice-paper"> <input
					type="radio" name="userChoice" value="paper" hidden> <img
					src="/images/paper0.jpg" alt="보">
				</label>
			</div>

			<!-- 게임 시작 버튼 -->
			<!-- 부모 요소에 text-align 적용 -->
			<div style="text-align: right; margin-top: 20px;">
				<button type="submit">게임 시작</button>
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
					<img src="/images/${userChoice}1.jpg" alt="${userChoice}"
						class="choice-image">
				</div>

				<!-- 컴퓨터 선택 이미지 -->
				<div class="choice">
					<h3>컴퓨터</h3>
					<img src="/images/${computerChoice}2.jpg" alt="${computerChoice}"
						class="choice-image">
				</div>
			</div>

			<p style="text-align: center; font-size: 20px;">
				<strong>${result}</strong>
			</p>
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