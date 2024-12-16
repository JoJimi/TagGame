<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사다리 게임 결과</title>
</head>
<body>
    <h1>사다리 게임 결과</h1>
    
    <!-- 입력 폼: 사용자 수를 입력받고 게임 시작 -->
    <form action="/game6/play" method="post">
        <label for="playerCount">사람 수 입력:</label>
        <input type="number" name="playerCount" min="2" required>
        <button type="submit">게임 시작</button>
    </form>

    <hr>

    <!-- 게임 결과 출력 -->
    <c:if test="${not empty gameResults}">
        <h2>게임 결과</h2>
        <ul>
            <c:forEach var="result" items="${gameResults}">
                <li>${result}</li>
            </c:forEach>
        </ul>
    </c:if>

    <!-- 에러 메시지 출력 -->
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
</body>
</html>
