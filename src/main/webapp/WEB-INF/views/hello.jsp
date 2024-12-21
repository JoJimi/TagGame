<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>게임 선택</title>

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
      display: flex;
      justify-content: center; /* 가로 정렬 */
      align-items: center; /* 세로 정렬 */
      min-height: 100vh; /* 화면 높이 100% */
      box-sizing: border-box;
    }

    .home-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
      box-sizing: border-box;
      text-align: center; /* 텍스트 가운데 정렬 */
    }

    h1 {
      margin-bottom: 20px;
      font-size: 2.5rem; /* 큰 제목 크기 */
      font-weight: 600; /* 두꺼운 글꼴 */
      color: #333;
    }

    .game-grid {
      display: grid;
      gap: 20px;
      margin: 0 auto;
      padding: 0 20px; /* 양옆 여백 */
      box-sizing: border-box;
    }

    .game-card {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-decoration: none;
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 10px;
      width: 130px; /* 고정된 너비 */
      height: 160px; /* 고정된 높이 */
      transition: transform 0.2s, box-shadow 0.2s;
    }

    .game-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .game-image {
      width: 90%;
      height: auto;
      border-radius: 10px;
      margin-top: 10px;
    }

    .game-title {
      margin-top: 10px;
      font-size: 1rem;
      color: #333;
      text-align: center;
      font-weight: 600;
    }

    /* 반응형 배치 */
    @media (min-width: 1024px) {
      .game-grid {
        grid-template-columns: repeat(6, 1fr); /* 1행 6열 */
        justify-content: center;
      }
    }

    @media (min-width: 768px) and (max-width: 1023px) {
      .game-grid {
        grid-template-columns: repeat(3, 1fr); /* 2행 3열 */
        justify-content: center;
      }
    }

    @media (max-width: 767px) {
      .game-grid {
        grid-template-columns: repeat(2, 1fr); /* 3행 2열 */
        justify-content: center;
      }
    }
  </style>
</head>
<body>
  <div class="home-container">
    <h1>Choose Your Game</h1>
    <div class="game-grid">
      <!-- 각 게임 아이템 -->
      <a href="/game1" class="game-card">
        <img src="images/russian.png" alt="Game 1" class="game-image">
        <p class="game-title">러시안 룰렛</p>
      </a>
      <a href="/game2" class="game-card">
        <img src="images/rock.png" alt="Game 2" class="game-image">
        <p class="game-title">가위 바위 보</p>
      </a>
      <a href="/game3" class="game-card">
        <img src="images/roulette.png" alt="Game 3" class="game-image">
        <p class="game-title">랜덤 룰렛</p>
      </a>
      <a href="/game4" class="game-card">
        <img src="images/bomb.png" alt="Game 4" class="game-image">
        <p class="game-title">폭탄 돌리기</p>
      </a>
      <a href="/game5" class="game-card">
        <img src="images/apt.png" alt="Game 5" class="game-image">
        <p class="game-title">아파트게임</p>
      </a>
      <a href="/game6" class="game-card">
        <img src="images/randomBox.jpg" alt="Game 6" class="game-image">
        <p class="game-title">랜덤 박스</p>
      </a>
    </div>
  </div>
</body>
</html>