<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>가위바위보 게임</title>
  <link rel="stylesheet" href="/css/style.css">
</head>
<body>
  <div class="game-container">
    <h1>가위바위보 게임</h1>
    <form action="/game2/play" method="post">
      <!-- 사용자 이름 입력 -->
      <label for="userName">사용자 이름:</label>
      <input type="text" id="userName" name="userName" required>

      <!-- 가위, 바위, 보 선택 -->
      <p>가위, 바위, 보 중 하나를 선택하세요:</p>
      <div class="choices">
        <label>
          <input type="radio" name="userChoice" value="가위" required> 가위
        </label>
        <label>
          <input type="radio" name="userChoice" value="바위"> 바위
        </label>
        <label>
          <input type="radio" name="userChoice" value="보"> 보
        </label>
      </div>

      <!-- 게임 시작 버튼 -->
      <button type="submit">게임 시작</button>
    </form>

    <!-- 게임 결과 표시 -->
    <c:if test="${not empty result}">
      <div class="result">
        <h2>게임 결과</h2>
        <p>${result}</p>
      </div>
    </c:if>

    <!-- 전체 게임 결과 보기 -->
    <a href="/game2/results">전체 결과 보기</a>
  </div>
</body>
</html>