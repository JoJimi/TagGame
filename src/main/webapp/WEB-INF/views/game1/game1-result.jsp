<body>
    <h1>게임 결과</h1>

    <!-- 성공 메시지 -->
    <c:if test="${message != null}">
        <p style="color:green">${message}</p>
    </c:if>

    <!-- 오류 메시지 -->
    <c:if test="${error != null}">
        <p style="color:red">${error}</p>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>참여 인원</th>
                <th>몇 번째 방아쇠</th>
                <th>게임 시간</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${results}">
                <tr>
                    <td>${result.id}</td>
                    <td>${result.playerCount}</td>
                    <td>${result.triggerCount}</td>
                    <td>${result.gameDate}</td>
                    <td>
                        <form action="/game1/delete/${result.id}" method="post">
                            <button type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <form action="/game1/deleteAll" method="post">
        <button type="submit">모든 결과 삭제</button>
    </form>
    <a href="/game1/">게임 다시 하기</a>
</body>
