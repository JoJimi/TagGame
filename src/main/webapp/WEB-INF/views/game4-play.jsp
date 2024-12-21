<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>폭탄 돌리기 게임</title>
    <style>
        /* 전체 레이아웃 / 폰트 */
        body {
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;
            font-family: 'Noto Sans', sans-serif; 
            color: #333;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        /* 폭탄 돌리기 영역 (#game) */
        #game {
            position: relative;
            width: 100%;
            height: 400px;
            border: 2px solid #ccc;
            border-radius: 8px;
            display: flex;
            overflow: hidden; 
            justify-content: space-around;
            align-items: center;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        
        /* 플레이어 목록 래퍼 (#players) */
        #players {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px; /* 아래쪽 여백 */
        }
        
        /* 플레이어 스타일 (.player) */
        .player {
            width: 100px;
            height: 100px;
            background-color: #3498db; /* 파란색 계열 */
            color: #fff;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            box-shadow: 0 4px 6px rgba(0,0,0,0.15);
            transition: background-color 0.3s ease;
        }
        
        /* 폭탄 스타일 (#bomb) */
        #bomb {
            position: absolute; /* 부모(#game)를 기준으로 절대 배치 */
            transition: transform 0.5s ease-in-out; /* 부드러운 이동 애니메이션 */
            width: 50px;
            height: 50px;
            z-index: 10;
            font-size: 24px;
            text-align: center;
            line-height: 50px;
            background-color: red;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
        }

        /* 당첨자 표시 영역 (#winner) */
        #winner {
            margin-top: 20px;
            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
            color: #e74c3c; /* 진한 빨간 계열 */
            min-height: 30px; /* 영역 확보 (비어있을 때 레이아웃 흔들림 방지) */
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

    <!-- 당첨자 표시 영역 -->
    <div id="winner"></div>

    <script>
        const players = document.querySelectorAll('.player');
        const bomb = document.getElementById('bomb');
        const winnerDisplay = document.getElementById('winner');

        let timer;
        let explosionTime;
        let targetPlayerIndex = null; // 현재 폭탄이 있는 플레이어 인덱스

        // 폭탄 이동 함수
        function moveBomb() {
            if (players.length === 0) {
                console.error("플레이어가 없습니다.");
                return;
            }

            // 랜덤 인덱스 (중복 방지)
            let randomIndex;
            do {
                randomIndex = Math.floor(Math.random() * players.length);
            } while (randomIndex === targetPlayerIndex);

            targetPlayerIndex = randomIndex;

            const targetPlayer = players[targetPlayerIndex];
            const playerRect = targetPlayer.getBoundingClientRect();
            const gameRect   = document.getElementById("game").getBoundingClientRect();

            // 부모(#game)가 position:relative; 라고 가정
            // 폭탄은 absolute로 #game 내에 배치
            bomb.style.position = "absolute";

            // #game 내부 좌표 계산
            const centerX = (playerRect.left - gameRect.left) + (playerRect.width / 2);
            const centerY = (playerRect.top  - gameRect.top)  + (playerRect.height / 2);

            // 폭탄 가운데를 플레이어 가운데에 맞추기
            const finalX = centerX - (bomb.offsetWidth / 2);
            const finalY = centerY - (bomb.offsetHeight / 2);

            // left, top 설정
            bomb.style.left = `\${finalX}px`;
            bomb.style.top  = `\${finalY}px`;
        }

        // 폭탄 클릭 이벤트
        bomb.addEventListener('click', () => {
            console.log("폭탄이 클릭되었습니다!");
            if (!timer) {
                startBombTimer();
            }
            moveBomb();
        });

        // 폭탄 터짐 함수
        function explodeBomb() {
            clearTimeout(timer);
            timer = null;

            if (targetPlayerIndex !== null) {
                const targetPlayer = players[targetPlayerIndex];
                targetPlayer.style.backgroundColor = '#e74c3c'; // 붉은색 강조
                targetPlayer.textContent += " 💥"; // 터진 표시
                bomb.style.display = 'none'; // 폭탄 숨기기
                
                const winnerName = targetPlayer.textContent.replace(' 💥','');
                console.log(`폭탄이 터졌습니다! 당첨자: \${winnerName}`);

                // 당첨자 화면 표시
                winnerDisplay.textContent = `당첨자: \${winnerName}`;
            } else {
                console.log("폭탄이 터질 플레이어가 없습니다.");
            }
        }

        // 폭탄 타이머 (10~30초 랜덤)
        function startBombTimer() {
            explosionTime = Math.floor(Math.random() * 21) + 10;
            console.log(`폭탄은 \${explosionTime}초 후에 터질 예정입니다.`);

            timer = setTimeout(() => {
                explodeBomb();
            }, explosionTime * 1000);
        }

        // 초기 폭탄 위치 (첫 번째 플레이어)
        window.addEventListener('load', () => {
            if (players.length > 0) {
                targetPlayerIndex = 0;
                moveBomb();
            }
        });
    </script>
</body>
</html>
