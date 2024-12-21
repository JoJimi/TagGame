<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>폭탄 돌리기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
            padding: 20px;
        }
        h1 {
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .player-input {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px; /* 간격 조정 */
            margin-bottom: 20px;
        }
        .player-row {
            display: flex;
            align-items: center;
            gap: 10px; /* 입력 칸과 버튼 간격 */
        }
        .player-input input[type="text"] {
            width: 300px;
            padding: 10px;
            font-size: 16px;
        }
        .btn {
            padding: 10px 20px;
            margin-top: 20px;
            font-size: 16px;
            color: white;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .remove-btn {
            padding: 5px 10px;
            font-size: 14px;
            color: white;
            background-color: #FF4C4C;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .remove-btn:hover {
            background-color: #c0392b;
        }
    </style>
	<script>
        function addPlayerInput() {
            const container = document.getElementById('player-input-container');
            
            const row = document.createElement('div');
            row.classList.add('player-row');
            
            const input = document.createElement('input');
            input.type = 'text';
            input.name = 'players';
            input.placeholder = '플레이어 이름';

            const removeButton = document.createElement('button');
            removeButton.type = 'button';
            removeButton.classList.add('remove-btn');
            removeButton.textContent = '삭제';
            removeButton.onclick = () => {
                container.removeChild(row);
            };
            
            row.appendChild(input);
            row.appendChild(removeButton);
            container.appendChild(row);
        }
    </script>
</head>
<body>
    <h1>폭탄 돌리기</h1>
    <form action="/game4/start" method="POST">
        <div id="player-input-container" class="player-input">
            <div class="player-row">
                <input type="text" name="players" placeholder="플레이어 이름">
            </div>
        </div>
        <button type="button" class="btn" onclick="addPlayerInput()">플레이어 추가</button>
        <button type="submit" class="btn">게임 시작</button>
    </form>
</body>
</html>
