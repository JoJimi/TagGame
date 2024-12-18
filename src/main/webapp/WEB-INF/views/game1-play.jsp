<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>러시안 룰렛 플레이</title>
    <style>
        body {
    		cursor: url('/images/gun_cursor.png') 36 36, auto; /* 총 이미지로 변경 */
		}
		
        .table {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 400px;
            width: 400px;
            border-radius: 50%;
            border: 2px solid black;
            position: relative;
            margin: 50px auto;
        }

        .player {
            position: absolute;
            width: 50px;
            height: 50px;
            background-color: green;
            border-radius: 50%;
            text-align: center;
            line-height: 50px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transform-origin: center;
            cursor: url('/images/gun_cursor.png') 36 36, pointer; /* 플레이어 위에서도 총 이미지 */         
        }

        .player.dead {
            background-color: red;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <h1>러시안 룰렛 게임</h1>

	<p>남은 발사 횟수: ${remainingBullets}</p>

    <div class="table">
	    <c:forEach var="player" items="${players}" varStatus="status">
	        <div class="player ${player ? '' : 'dead'}" 
	             style="transform: rotate(${status.index * (360 / participantCount)}deg) translate(0, -180px);" 
	             data-id="${status.index + 1}">
	            ${status.index + 1}
	        </div>
	    </c:forEach>
	</div>

    <c:if test="${gameOver}">
        <h2 style="color:red;">${message}</h2>
        <a href="/game1">다시 시작하기</a>
    </c:if>

	<c:if test="${!gameOver}">
	    <form id="selectPlayerForm" action="/game1/play/select" method="post" style="display: none;">
	        <input type="hidden" name="playerId" id="playerId">
	        <input type="hidden" name="participantCount" value="${participantCount}">
	        <input type="hidden" name="bulletRound" value="${bulletRound}">
	        <input type="hidden" name="players" value='${players}'>
	        <input type="hidden" name="remainingBullets" value="${remainingBullets}">
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
