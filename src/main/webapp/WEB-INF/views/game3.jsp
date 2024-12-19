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
		<button type="button" onclick="rRotate()">돌려돌려 돌림판</button>

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

            for (let i = 1, len = product.length; i <= len; i++) {
                deg.push((360 / len) * i - 180);
            }

            let num = 0;
            document.body.append(hiddenInput);
            const setNum = hiddenInput.value = rRandom();

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