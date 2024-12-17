<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>전체 게임 기록</title>
</head>
<body>
  <h1>전체 게임 기록</h1>
  <table border="1">
    <thead>
      <tr>
        <th>사용자 이름</th>
        <th>사용자 선택</th>
        <th>컴퓨터 선택</th>
        <th>결과</th>
        <th>날짜</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="record" items="${results}">
        <tr>
          <td>${record.userName}</td>
          <td>${record.userChoice}</td>
          <td>${record.computerChoice}</td>
          <td>${record.result}</td>
          <td>${record.gameDate}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- 게임 화면으로 돌아가기 -->
  <div style="margin-top: 20px; text-align: center;">
    <a href="/game2">게임 화면으로 돌아가기</a>
  </div>
</body>
</html>