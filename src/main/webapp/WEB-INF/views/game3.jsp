<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/menu.css">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<title>랜덤 룰렛 게임</title>
</head>
<body>
	<h1>랜덤 룰렛 게임</h1>
	<div id="menu">
		<!-- 이름 추가 영역 -->
		<div id="addDiv">
			<input type="text" id="menuAdd" placeholder="이름을 입력하세요" />
			<button onclick="addParticipant()">이름 추가</button>
		</div>

		<!-- 돌림판 캔버스 -->
		<canvas width="300" height="300"></canvas>

		<!-- 돌림판 돌리는 버튼 -->
		<form id="gameForm" action="/game3/play" method="POST">
			<input type="hidden" name="participants" id="participantsInput" />
			<button type="button" onclick="startGame()">돌려돌려 돌림판</button>
		</form>

		<!-- 결과 표시 -->
		<div id="result">
			<h2>
				당첨자: 
				<span id="winnerName">
					<%= request.getAttribute("winnerName") != null ? request.getAttribute("winnerName") : "" %>
				</span>
			</h2>
		</div>
	</div>

	<!-- 룰렛 관련 JS -->
	<script>
        const $c = document.querySelector("canvas");
        const ctx = $c.getContext(`2d`);
        const product = [];
        const colors = [];

        const newMake = () => {
            const [cw, ch] = [$c.width / 2, $c.height / 2];
            const arc = Math.PI / (product.length / 2);  
            for (let i = 0; i < product.length; i++) {
                ctx.beginPath();
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

        const startGame = () => {
            if (product.length === 0) {
                alert("참여자를 추가하세요.");
                return;
            }

            const participantsInput = document.getElementById("participantsInput");
            participantsInput.value = product.join(",");

            const form = document.getElementById("gameForm");
            form.submit();
        };

        const addParticipant = () => {
            const menuAdd = document.querySelector('#menuAdd');
            if (menuAdd.value !== undefined && menuAdd.value !== "") {
                product.push(menuAdd.value);
                let r = Math.floor(Math.random() * 256);
                let g = Math.floor(Math.random() * 256);
                let b = Math.floor(Math.random() * 256);
                colors.push("rgb(" + r + "," + g + "," + b + ")");
                newMake();
                menuAdd.value = "";
            } else {
                alert("이름을 입력한 후 추가하세요.");
            }
        };

        newMake();
    </script>
</body>
</html>