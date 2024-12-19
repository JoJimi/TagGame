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
</style>
</head>
<body>
	<h1>랜덤 룰렛 게임</h1>
	<div id="menu">
		<!-- 돌림판 캔버스 -->
		<canvas width="300" height="300"></canvas>

		<!-- 돌림판 돌리는 버튼 -->
		<button type="button" onclick="rotate()">돌려돌려 돌림판</button>

		<!-- 이름 추가 영역 -->
		<div id="addDiv">
			<input type="text" id="menuAdd" placeholder="이름을 입력하세요" />
			<button onclick="add()">이름 추가</button>
		</div>

		<!-- 결과 표시 -->
		<div id="result">
			<h2>
				당첨자: 
				<span id="winnerName"></span>
			</h2>
		</div>
	</div>

	<!-- 룰렛 관련 JS -->
	<script>
        const $c = document.querySelector("canvas");
        const ctx = $c.getContext(`2d`);
        const menuAdd = document.querySelector('#menuAdd');
        const product = [];
        const colors = [];

        // 원판 UI 생성
        const newMake = () => {
            const [cw, ch] = [$c.width / 2, $c.height / 2];
            const arc = Math.PI / (product.length / 2);  
            ctx.clearRect(0, 0, $c.width, $c.height); // 캔버스 초기화

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

        // 원판 회전 함수
        const rotate = () => {
            $c.style.transform = `initial`;
            $c.style.transition = `initial`;
            const alpha = Math.floor(Math.random() * 100);

            setTimeout(() => {    
                const ran = Math.floor(Math.random() * product.length); // 랜덤 섹터 선택
                const arc = 360 / product.length; // 섹터 각도 계산
                const rotate = (ran * arc) + 3600 + (arc * 3) - (arc / 4) + alpha; // 회전 각도 계산
                $c.style.transform = `rotate(-${rotate}deg)`; // 회전 적용
                $c.style.transition = `2s`;

                // 2초 후 당첨자 표시
                setTimeout(() => {
                    const winnerName = product[ran];
                    document.getElementById("winnerName").innerText = winnerName;
                    alert(`당첨자는 ${winnerName}입니다!`);
                }, 2000);
            }, 1);
        };

        // 이름 추가
        const add = () => {
            if (menuAdd.value != undefined && menuAdd.value != "") {
                product.push(menuAdd.value);
                let r = Math.floor(Math.random() * 256);
                let g = Math.floor(Math.random() * 256);
                let b = Math.floor(Math.random() * 256);
                colors.push("rgb(" + r + "," + g + "," + b + ")");
                newMake();
                menuAdd.value = "";
            } else {
                alert("이름을 입력한 후 버튼을 클릭 해 주세요");
            }
        };

        newMake();
    </script>
</body>
</html>