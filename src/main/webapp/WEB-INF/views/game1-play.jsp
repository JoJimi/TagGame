<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>러시안 룰렛 플레이</title>
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
            cursor: url('/images/gun_cursor.png') 36 36, auto; /* 커서 이미지 */
        }
		/* 게임 제목 스타일 */
		h1 {
		    margin-top: 20px;
		    font-size: 42px;
		    color: #ecf0f1;
		    text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.5);
		}
		
		/* 남은 발사 횟수 스타일 */
		.status {
		    font-size: 24px;
		    margin: 15px 0 30px;
		    color: #e74c3c;
		    font-weight: bold;
		    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
		    padding: 10px;
		    background: rgba(0, 0, 0, 0.2);
		    display: inline-block;
		    border-radius: 5px;
		}
		
		/* 원탁 디자인 */
		.table {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    height: 400px;
		    width: 400px;
		    border-radius: 50%;
		    border: 3px solid #ecf0f1;
		    box-shadow: inset 0 4px 6px rgba(255, 255, 255, 0.1), 0 6px 12px rgba(0, 0, 0, 0.3);
		    position: relative;
		    margin: 30px auto;
		    background: radial-gradient(circle, #34495e, #2c3e50);
		}
		
		/* 플레이어 디자인 */
		.player {
		    position: absolute;
		    width: 60px;
		    height: 60px;
		    background-color: #27ae60;
		    border-radius: 50%;
		    text-align: center;
		    line-height: 60px;
		    color: white;
		    font-weight: bold;
		    font-size: 18px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
		    cursor: url('/images/gun_cursor.png') 36 36, pointer;
		    transition: transform 0.2s, background-color 0.3s, box-shadow 0.3s;
		}
		
		.player:hover {
		    transform: scale(1.1);
		    background-color: #2ecc71;
		    box-shadow: 0 6px 12px rgba(0, 255, 0, 0.3);
		}
		
		.player.dead {
		    background-color: #c0392b;
		    cursor: not-allowed;
		    box-shadow: 0 4px 8px rgba(255, 0, 0, 0.3);
		}
		
		.player.dead:hover {
		    transform: none;
		    background-color: #c0392b;
		    box-shadow: 0 4px 8px rgba(255, 0, 0, 0.3);
		}
		
		/* 게임 종료 메시지 */
		.game-over {
		    font-size: 28px;
		    color: #f1c40f;
		    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.8);
		    margin-top: 20px;
		}
		
		/* 다시 시작 버튼 스타일 */
		.restart-button {
		    display: inline-block;
		    margin-top: 20px;
		    padding: 12px 24px;
		    font-size: 20px;
		    font-weight: bold;
		    color: #ecf0f1;
		    background: #e74c3c;
		    border: none;
		    border-radius: 8px;
		    cursor: pointer;
		    text-decoration: none;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
		    transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
		}
		
		.restart-button:hover {
		    background: #c0392b;
		    transform: scale(1.1);
		    box-shadow: 0 6px 12px rgba(255, 0, 0, 0.3);
		}
		.back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 24px;
            font-size: 20px;
            font-weight: bold;
            color: #ecf0f1;
            background: #3498db;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
            margin-left: 10px; /* "다시 시작하기" 버튼과 간격 */
        }

        .back-button:hover {
            background: #2980b9;
            transform: scale(1.1);
            box-shadow: 0 6px 12px rgba(0, 0, 255, 0.3);
        }

        .button-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px; /* 버튼 간격 조정 */
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <!-- 게임 제목 -->
    <h1>러시안 룰렛 게임</h1>

    <!-- 남은 발사 횟수 -->
    <div class="status">남은 발사 횟수: ${remainingBullets}</div>

    <!-- 원탁 -->
    <div class="table">
        <c:forEach var="player" items="${players}" varStatus="status">
            <div class="player ${player ? '' : 'dead'}" 
                 style="transform: rotate(${status.index * (360 / participantCount)}deg) translate(0, -180px);" 
                 data-id="${status.index + 1}">
                ${status.index + 1}
            </div>
        </c:forEach>
    </div>

    <!-- 게임 종료 메시지 -->
    <c:if test="${gameOver}">
        <div class="game-over">${message}</div>
        <div class="button-container">
            <a href="/game1" class="restart-button">다시 시작하기</a>
            <a href="/" class="back-button">돌아가기</a>
        </div>
    </c:if>

    <!-- 숨겨진 폼 -->
    <c:if test="${!gameOver}">
        <form id="selectPlayerForm" action="/game1/play/select" method="post" style="display: none;">
		    <input type="hidden" name="playerId" id="playerId">
		    <input type="hidden" name="participantCount" value="${participantCount}">
		    <input type="hidden" name="players" value='${players}'>
		    <input type="hidden" name="remainingBullets" value="${remainingBullets}">
		    <!-- bulletList를 JSON 문자열로 변환 -->
		    <input type="hidden" name="bulletList" value='${bulletList}'>
		</form>
    </c:if>

    <script>
        document.querySelectorAll('.player').forEach(player => {
            player.addEventListener('click', function () {
                if (this.classList.contains('dead')) {
                    console.log("이미 사망한 플레이어입니다:", this.dataset.id);
                    return; // 이미 사망한 플레이어는 클릭 불가
                }
                console.log("플레이어 선택됨:", this.dataset.id);
                document.getElementById('playerId').value = this.dataset.id;
                document.getElementById('selectPlayerForm').submit();
            });
        });
    </script>
</body>
</html>