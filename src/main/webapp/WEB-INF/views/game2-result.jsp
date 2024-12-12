<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>전체 게임 결과</title>
  <link rel="stylesheet" href="/css/style.css">
</head>
<body>
  <div class="result-container">
    <h1>전체 게임 결과</h1>
    <table border="1">
      <thead>
        <tr>
          <th>게임 ID</th>
          <th>사용자 이름</th>
          <th>사용자 선택</th>
          <th>컴퓨터 선택</th>
          <th>결과</th>
          <th>게임 날짜</th>
          <th>삭제</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="result" items="${results}">
          <tr>
            <td>${result.id}</td>
            <td>${result.userName}</td>
            <td>${result.userChoice}</td>
            <td>${result.computerChoice}</td>
            <td>${result.result}</td>
            <td>${result.gameDate}</td>
            <td>
              <form action="/game2/delete/${result.id}" method="post">
                <button type="submit">삭제</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- 전체 삭제 -->
    <form action="/game2/deleteAll" method="post">
      <button type="submit">전체 삭제</button>
    </form>

    <a href="/game2">게임으로 돌아가기</a>
  </div>
</body>
</html>