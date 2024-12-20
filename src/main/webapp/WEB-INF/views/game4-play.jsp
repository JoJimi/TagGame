<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>폭탄 돌리기 게임</title>
    <style>
        #game {
		    position: relative;
		    width: 100%;
		    height: 400px;
		    border: 1px solid #ccc;
		    display: flex;
		    overflow: hidden; /* 영역을 벗어나는 폭탄 숨김 방지 */
		    justify-content: space-around; /* 플레이어 위치를 일렬로 */
		    align-items: center;
		}
		
		#players {
		    display: flex;
		    justify-content: center;
		    gap: 20px; /* 플레이어 간격 */
		    margin-bottom: 30px;
		}
		
		.player {
		    width: 100px;
		    height: 100px;
		    background-color: lightblue;
		    border-radius: 50%;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    position: relative;
		}

		
		.player:hover {
		    background-color: #2ecc71;
		}
		
		#bomb {
		    position: absolute; /* 위치를 절대값으로 설정 */
		    transition: transform 0.5s ease-in-out; /* 부드러운 이동 애니메이션 */
		    width: 50px;
		    height: 50px;
		    z-index: 10; /* 다른 요소 위에 표시 */
		    font-size: 24px;
		    text-align: center;
		    line-height: 50px;
		    background-color: red;
		    border-radius: 50%;
		    color: white;
		    cursor: pointer;
		}

    </style>
</head>
<body>
    <h1>폭탄 돌리기 게임</h1>
    <div id="gameArea">
        <div id="game">
		    <!-- 플레이어 목록 -->
		    <div id="players">
		        <c:forEach var="player" items="${players}" varStatus="status">
		            <div class="player" data-index="${status.index}">
		                ${player}
		            </div>
		        </c:forEach>
		    </div>
		
		    <!-- 폭탄 -->
		    <div class="bomb" id="bomb">💣</div>
		</div>
    </div>

    <script>
	    const players = document.querySelectorAll('.player'); // 플레이어 목록
	    const bomb = document.getElementById('bomb'); // 폭탄
	    console.log(players); // 플레이어 목록 출력
	    console.log(bomb);    // 폭탄 출력
	    let timer; // 폭탄 터질 타이머
	    let explosionTime; // 폭탄 터질 시간 저장
	    let targetPlayerIndex = null; // 현재 폭탄이 있는 플레이어의 인덱스
	
	    // 폭탄 이동 함수
	    function moveBomb() {
		    if (players.length === 0) {
		        console.error("플레이어가 없습니다.");
		        return;
		    }
		
		    let randomIndex;
		    do {
		        randomIndex = Math.floor(Math.random() * players.length);
		    } while (randomIndex === targetPlayerIndex);
		
		    targetPlayerIndex = randomIndex;
		    const targetPlayer = players[targetPlayerIndex];
		    const playerRect = targetPlayer.getBoundingClientRect();
		    const gameRect = document.getElementById('game').getBoundingClientRect();
		    console.log(playerRect); // 플레이어의 좌표 확인
		    console.log(gameRect);   // 게임 영역의 좌표 확인
		
		    if (!playerRect || !gameRect) {
		        console.error("Rect 계산 실패");
		        return;
		    }
		
		    // 좌표 계산
		    const centerX = playerRect.left + playerRect.width / 2 - gameRect.left;
		    const centerY = playerRect.top + playerRect.height / 2 - gameRect.top;
		
		    console.log(`폭탄이 이동되었습니다! 새로운 위치: ${targetPlayer.textContent}`);
		    console.log(`Calculated Position - X: ${centerX}, Y: ${centerY}`);
		
		    bomb.style.transform = ''; // 초기화
		    bomb.style.transform = `translate(${centerX - bomb.offsetWidth / 2}px, ${centerY - bomb.offsetHeight / 2}px)`;
		}
		
	    // 폭탄 클릭 이벤트
		bomb.addEventListener('click', () => {
		    console.log("폭탄이 클릭되었습니다!");
		    if (!timer) {
		        startBombTimer();
		    }
		    moveBomb(); // 폭탄 이동
		});
	
	    // 폭탄 터짐 함수
	    function explodeBomb() {
	        clearTimeout(timer); // 타이머 초기화
	        timer = null;
	
	        if (targetPlayerIndex !== null) {
	            const targetPlayer = players[targetPlayerIndex];
	            targetPlayer.style.backgroundColor = 'red'; // 터진 플레이어 강조
	            targetPlayer.textContent += " 💥"; // 터진 표시
	            bomb.style.display = 'none'; // 폭탄 숨기기
	            console.log(`폭탄이 터졌습니다! 당첨자: ${targetPlayer.textContent}`);
	        } else {
	            console.log("폭탄이 터질 플레이어가 없습니다.");
	        }
	    }
	
	    // 폭탄 타이머 시작
	    function startBombTimer() {
	        explosionTime = Math.floor(Math.random() * 21) + 10; // 10~30초 랜덤
	        console.log(`폭탄은 ${explosionTime}초 후에 터질 예정입니다.`);
	
	        timer = setTimeout(() => {
	            explodeBomb();
	        }, explosionTime * 1000); // 밀리초로 변환
	    }
	
	    // 초기 폭탄 위치를 첫 번째 플레이어 위로 이동
	    window.addEventListener('load', () => {
            if (players.length > 0) {
                targetPlayerIndex = 0; // 첫 번째 플레이어로 초기화
                moveBomb();
            }
        });
	</script>

</body>
</html>
