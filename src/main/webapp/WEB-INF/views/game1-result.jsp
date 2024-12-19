<!DOCTYPE html>
<html>
<head>
    <title>게임 결과</title>
</head>
<body>
    <h1>게임 결과</h1>
    <form action="/game1/deleteAll" method="post">
        <button type="submit">모든 결과 삭제</button>
    </form>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>참가자 수</th>
            <th>총알이 발사된 라운드</th>
            <th>게임 날짜</th>
            <th>삭제</th>
        </tr>
        <c:forEach var="result" items="${results}">
            <tr>
                <td>${result.id}</td>
                <td>${result.participantCount}</td>
                <td>${result.gameRound}</td>
                <td>${result.gameDate}</td>
                <td>
                    <form action="/game1/delete/${result.id}" method="post">
                        <button type="submit">삭제</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <a href="/game1">게임 실행하기</a>
</body>
</html>
