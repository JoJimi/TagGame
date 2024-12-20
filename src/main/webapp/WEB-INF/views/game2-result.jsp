<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게임 2 결과</title>
  <style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f9f9f9;
    }
    h1 {
        text-align: center;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    table, th, td {
        border: 1px solid #ddd;
    }
    th, td {
        padding: 10px;
        text-align: center;
    }
    button {
        padding: 10px 20px;
        background-color: #007bff;
        color: #fff;
        border: none;
        cursor: pointer;
    }
    button:hover {
        background-color: #0056b3;
    }
    .delete-button {
        background-color: #dc3545;
    }
    .delete-button:hover {
        background-color: #c82333;
    }
  </style>
</head>
<body>
  <h1>게임 2 결과</h1>

  <table>
    <thead>
      <tr>
        <th>사용자 이름</th>
        <th>사용자 선택</th>
        <th>컴퓨터 선택</th>
        <th>결과</th>
        <th>날짜</th>
        <th>삭제</th>
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
          <td>
            <form method="post" action="/game2/delete/${record.id}" style="margin: 0;">
              <button type="submit" class="delete-button">삭제</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- 모든 결과 삭제 -->
  <div style="margin-top: 20px; text-align: center;">
    <form method="post" action="/game2/deleteAll">
      <button type="submit">모든 결과 삭제</button>
    </form>
  </div>

  <!-- 게임 화면으로 돌아가기 -->
  <div style="margin-top: 20px; text-align: center;">
    <a href="/game2">게임 화면으로 돌아가기</a>
  </div>
</body>
</html>