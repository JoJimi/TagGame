<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>러시안 룰렛 게임</title>
    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 게임 제목 */
        h1 {
            font-size: 42px;
            color: #f1c40f;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.8);
            margin-bottom: 20px;
        }

        /* 입력 폼 스타일 */
        form {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            display: inline-block;
        }

        /* 입력 필드 */
        input[type="number"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 10px;
            width: 80px;
            text-align: center;
        }

        /* 버튼 스타일 */
        button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #e74c3c;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s, transform 0.2s;
        }

        button:hover {
            background-color: #c0392b;
            transform: scale(1.05);
        }

        /* 설명 텍스트 */
        .info {
            margin-top: 20px;
            font-size: 18px;
            color: #ecf0f1;
        }
    </style>
</head>
<body>
    <!-- 게임 제목 -->
    <h1>러시안 룰렛 게임</h1>

    <!-- 입력 폼 -->
    <form action="/game1/play" method="post">
        <label for="participantCount" style="font-size: 18px; font-weight: bold; color: #ecf0f1;">참가자 수:</label>
        <input type="number" id="participantCount" name="participantCount" min="1" required>
        <button type="submit">게임 시작</button>
    </form>

    <!-- 추가 설명 -->
    <div class="info">
        <p>참가자 수를 입력하고 게임을 시작하세요!</p>
    </div>
</body>
</html>
