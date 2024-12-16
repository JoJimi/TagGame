<body>
    <h1>Game 1: 러시안 룰렛</h1>
    <form action="/game1/play" method="post">
        <label for="playerCount">참여할 사람 수:</label>
        <input type="number" id="playerCount" name="playerCount" min="1" required>
        <button type="submit">게임 시작</button>
    </form>
    
    <!-- 결과 메시지 -->
    <c:if test="${result != null}">
        <p>${result}</p>
    </c:if>

    <!-- 오류 메시지 -->
    <c:if test="${error != null}">
        <p style="color:red">${error}</p>
    </c:if>
</body>
