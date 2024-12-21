<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/menu.css">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<title>랜덤 룰렛 게임</title>
<style>
body {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	margin: 0;
	background-color: #f7f7f7;
}

h1 {
	margin: 0;
	padding: 20px;
	font-size: 24px;
	text-align: center;
}

#menu {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
	position: relative;
}

canvas {
	margin-top: 20px;
	transition: transform 2s ease-out; /* 부드러운 회전 효과 */
}

button {
	margin-top: 10px;
	padding: 10px 20px;
	background-color: #febf00;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
}

button:active {
	background-color: #444;
	color: #fff;
}

.hidden-input {
	display: none; /* 완전히 숨김 */
	visibility: hidden; /* 요소 가시성 제거 */
	position: absolute; /* 화면에서 벗어나게 배치 */
	top: -9999px;
	left: -9999px;
}
</style>
</head>
<body>
	<h1>랜덤 룰렛 게임</h1>
	<div id="menu">
		<!-- 룰렛 캔버스 -->
		<canvas width="300" height="300"></canvas>

		<!-- 돌림판 돌리는 버튼 -->
		<button type="button" onclick="rRotate()">돌려돌려 돌림판</button>

		<!-- 이름 추가 영역 -->
		<div id="addDiv">
			<input type="text" id="menuAdd" placeholder="이름을 입력하세요" />
			<button onclick="add()">이름 추가</button>
		</div>

		<!-- 결과 표시 -->
		<div id="result">
			<h2>
				당첨자: <span id="winnerName"></span>
			</h2>
		</div>

		<!-- 결과 조회 버튼 -->
		<div style="text-align: center; margin-top: 20px;">
			<form method="get"
				action="${pageContext.request.contextPath}/game3/results">
				<button type="submit">게임 결과 모음</button>
			</form>
		</div>
	</div>

	<!-- 룰렛 관련 JS -->
	<script>
        const $c = document.querySelector("canvas");
        const ctx = $c.getContext(`2d`);
        const menuAdd = document.querySelector('#menuAdd');
        const product = [];
        const colors = [];
        const hiddenInput = document.createElement("input");
        hiddenInput.className = "hidden-input";

        // 랜덤 숫자 생성
        const rRandom = () => {
            const min = Math.ceil(0);
            const max = Math.floor(product.length - 1);
            return Math.floor(Math.random() * (max - min)) + min;
        };

        // 원판 UI 생성
        const newMake = () => {
    const [cw, ch] = [$c.width / 2, $c.height / 2];
    const arc = Math.PI / (product.length / 2);  
    ctx.clearRect(0, 0, $c.width, $c.height); // 캔버스 초기화

    // 흰색 배경 원 추가
    ctx.beginPath();
    ctx.fillStyle = "#ffffff"; // 흰색
    ctx.arc(cw, ch, cw, 0, Math.PI * 2); // 원의 전체 둘레를 그림
    ctx.fill();
    ctx.closePath();

    for (let i = 0; i < product.length; i++) {
        ctx.beginPath();
        if (colors.length == 0) {
            for (var l = 0; l < product.length; l++) {
                let r = Math.floor(Math.random() * 256);
                let g = Math.floor(Math.random() * 256);
                let b = Math.floor(Math.random() * 256);
                colors.push("rgb(" + r + "," + g + "," + b + ")");
            }
        }
        ctx.fillStyle = colors[i % colors.length];
        ctx.moveTo(cw, ch);
        ctx.arc(cw, ch, cw, arc * (i - 1), arc * i);
        ctx.fill();
        ctx.closePath();
    }

    ctx.fillStyle = "#fff";
    ctx.font = "18px Pretendard";
    ctx.textAlign = "center";

    for (let i = 0; i < product.length; i++) {
        const angle = (arc * i) + (arc / 2);

        ctx.save();

        ctx.translate(
            cw + Math.cos(angle) * (cw - 50),
            ch + Math.sin(angle) * (ch - 50)
        );

        ctx.rotate(angle + Math.PI / 2);

        product[i].split(" ").forEach((text, j) => {
            ctx.fillText(text, 0, 30 * j);
        });

        ctx.restore();
    }
};

        // 룰렛 회전
        const rRotate = () => {
            const panel = $c;
            const btn = document.querySelector("button[onclick='rRotate()']");
            const deg = [];
            const sectionAngle = 360 / product.length;

         // deg 배열 생성
            for (let i = 1, len = product.length; i <= len; i++) {
            	deg.push((360 / len) * i - 180);
            }

            let num = 0;
            
         // 기존 hiddenInput 삭제 후 재생성
            if (document.body.contains(hiddenInput)) {
                hiddenInput.remove();
            }
            document.body.append(hiddenInput);

            const setNum = Math.floor(Math.random() * product.length); // 랜덤 섹터 선택
            const rotateAngle = 3600 + deg[setNum]; // 회전 각도 설정

            if (setNum === -1) return; // 항목이 없을 경우 종료

            panel.style.transform = `rotate(${rotateAngle}deg)`;
            panel.style.transition = "transform 2s ease-out";
            btn.disabled = true;

            // 애니메이션 설정
            const ani = setInterval(() => {
                num++;
                panel.style.transform = "rotate(" + 360 * num + "deg)";
                btn.disabled = true;
                btn.style.pointerEvents = "none";

                if (num === 50) {
                    clearInterval(ani);
                    panel.style.transform = `rotate(${deg[setNum]}deg)`;

                    setTimeout(() => {
                    	alert("당첨 완료!");
                    	
                    	// AJAX 요청으로 당첨 결과 저장
                        $.ajax({
                            url: '/game3/play',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify(product),
                            success: (response) => {
                                alert("게임 결과가 저장되었습니다!");
                            },
                            error: (xhr, status, error) => {
                                alert("게임 결과 저장 중 오류가 발생했습니다: " + error);
                            },
                            complete: () => {
                                btn.disabled = false; // 버튼 다시 활성화
                            }
                        });
                    	
                    	
                        const winnerName = product[setNum];
                        document.getElementById("winnerName").innerText = winnerName;
                        btn.disabled = false;
                        btn.style.pointerEvents = "auto";
                        hiddenInput.remove();
                    }, 2000);
                }
            }, 50);
        };

        // 이름 추가
        const add = () => {
            if (menuAdd.value != undefined && menuAdd.value != "") {
                product.push(menuAdd.value);
                let r = Math.floor(Math.random() * 256);
                let g = Math.floor(Math.random() * 256);
                let b = Math.floor(Math.random() * 256);
                colors.push("rgb(" + r + "," + g + "," + b + ")");                newMake();
                menuAdd.value = "";
            } else {
                alert("이름을 입력한 후 버튼을 클릭 해 주세요");
            }
        };

        newMake();
    </script>
</body>
</html>