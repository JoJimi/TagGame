<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.example.demo.game3.Game3Result" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게임 3 결과</title>
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
    <h1>게임 3 결과</h1>

    <%
        List<Game3Result> results = (List<Game3Result>) request.getAttribute("results");

        // 날짜 포맷 설정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    %>

    <% if (results == null || results.isEmpty()) { %>
        <p style="text-align: center; font-size: 16px;">저장된 게임 결과가 없습니다.</p>
    <% } else { %>
        <table>
            <tr>
                <th>ID</th>
                <th>참여자 수</th>
                <th>당첨자</th>
                <th>게임 날짜</th>
                <th>삭제</th>
            </tr>
            <% for (Game3Result result : results) { %>
                <tr>
                    <td><%= result.getId() %></td>
                    <td><%= result.getParticipantCount() %></td>
                    <td><%= result.getWinnerName() %></td>
                    <td><%= result.getGameDate().format(formatter) %></td>
                    <td>
                        <form method="post" action="/game3/delete/<%= result.getId() %>" style="margin: 0;">
                            <button type="submit" class="delete-button">삭제</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } %>

    <!-- 모든 결과 삭제 -->
    <form method="post" action="/game3/deleteAll" style="text-align: center; margin-top: 20px;">
        <button type="submit">모든 게임 결과 삭제</button>
    </form>

    <!-- 돌아가기 -->
    <div style="text-align: center; margin-top: 10px;">
        <form method="get" action="${pageContext.request.contextPath}/game3">
            <button type="submit">돌아가기</button>
        </form>
    </div>
</body>
</html>