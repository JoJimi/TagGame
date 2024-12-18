<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사다리 타기 게임</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }
        h1 {
            color: #007bff;
            margin-bottom: 20px;
        }
        .input-group {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 10px 0;
        }
        .input-group span {
            font-weight: bold;
            margin-right: 10px;
            color: #333;
        }
        input {
            padding: 8px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 120px;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .ladder {
            display: none; /* 사다리 초기에는 숨김 */
            justify-content: center;
            margin: 20px 0;
        }
        .vertical-line {
            width: 5px;
            height: 400px;
            background: #007bff;
            margin: 0 20px;
            position: relative;
        }
        .horizontal-line {
            position: absolute;
            height: 5px;
            width: 20px;
            background: #ff5722;
            left: 50%;
            transform: translateX(-50%);
        }
        .results {
            display: none;
            justify-content: space-between;
            margin-top: 20px;
        }
        .results div {
            font-weight: bold;
            margin: 0 10px;
        }
    </style>
    <script>
        function startGame() {
            document.getElementById("ladder").style.display = "flex";
            document.getElementById("gameResults").style.display = "flex";
        }
    </script>
</head>
<body>
<div class="container">
    <h1>사다리 타기 게임</h1>

    <!-- 사용자 수 입력 -->
    <form method="get" action="">
        <div class="input-group">
            <span>참여자 수:</span>
            <input type="number" name="playerCount" min="2" required placeholder="최소 2명">
            <button type="submit">확인</button>
        </div>
    </form>

    <%
        String playerCountParam = request.getParameter("playerCount");
        int playerCount = (playerCountParam != null) ? Integer.parseInt(playerCountParam) : 0;

        if (playerCount > 0) {
    %>
    <!-- 참여자와 결과 입력 -->
    <form method="post" action="play">
        <h3>참여자와 결과를 입력하세요:</h3>
        <% for (int i = 1; i <= playerCount; i++) { %>
            <div class="input-group">
                <span>참여자 <%= i %>:</span>
                <input type="text" name="players" placeholder="이름" required>
                <span>결과 <%= i %>:</span>
                <input type="text" name="results" placeholder="결과" required>
            </div>
        <% } %>
        <button type="submit">게임 시작</button>
    </form>
    <% } %>

    <!-- 사다리 표시 -->
    <div id="ladder" class="ladder">
        <% if (playerCount > 0) {
            for (int i = 0; i < playerCount; i++) { %>
                <div class="vertical-line">
                    <% for (int j = 0; j < 10; j++) {
                        if (Math.random() > 0.5) { %>
                            <div class="horizontal-line" style="top: <%= j * 40 %>px;"></div>
                        <% } } %>
                </div>
        <% } } %>
    </div>

    <!-- 게임 결과 표시 -->
    <form method="post" action="/game6/play">
	    <div id="gameResults" class="results">
	    	<h2>결과</h2>
	    	
	        <% 
	            List<String> results = (List<String>) request.getAttribute("results");
	
	            if (results != null) {
	                for (int i = 0; i < results.size(); i++) {
	        %>
	        <div>
	            <%= results.get(i) %>
	        </div>
	        <%      } 
	            }
	        %>
	    </div>
    </form>
    
</div>
</body>
</html>
