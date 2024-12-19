<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.example.demo.game6.Game6Result" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이전 게임 결과</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }
        h1 {
            text-align: center;
        }
        .accordion {
            background-color: #f1f1f1;
            color: #444;
            cursor: pointer;
            padding: 10px;
            width: 100%;
            text-align: left;
            border: none;
            outline: none;
            transition: background-color 0.4s;
            margin-bottom: 5px;
        }
        .active, .accordion:hover {
            background-color: #ddd;
        }
        .panel {
            padding: 0 15px;
            display: none;
            background-color: white;
            overflow: hidden;
            border: 1px solid #ddd;
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
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
        .button-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>이전 게임 결과</h1>

    <%
        List<Game6Result> results = (List<Game6Result>) request.getAttribute("results");

        // 게임 ID 별로 결과를 그룹화
        Map<Integer, List<Game6Result>> groupedResults = new LinkedHashMap<>();
        if (results != null) {
            for (Game6Result result : results) {
                groupedResults
                    .computeIfAbsent(result.getGameId(), k -> new ArrayList<>())
                    .add(result);
            }
        }

        // 날짜 포맷 설정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    %>

    <% if (groupedResults.isEmpty()) { %>
        <p style="text-align: center; font-size: 16px;">저장된 게임 결과가 없습니다.</p>
    <% } else { %>
        <% for (Map.Entry<Integer, List<Game6Result>> entry : groupedResults.entrySet()) { %>
            <!-- Accordion Button for Each Game ID -->
            <button class="accordion">게임 ID: <%= entry.getKey() %></button>
            <div class="panel">
                <table>
                    <tr>
                        <th>참여자</th>
                        <th>결과</th>
                        <th>날짜</th>
                    </tr>
                    <% for (Game6Result result : entry.getValue()) { %>
                        <tr>
                            <td><%= result.getName() %></td>
                            <td><%= result.getContent() %></td>
                            <td><%= result.getGameDate().format(formatter) %></td>
                        </tr>
                    <% } %>
                </table>
                <!-- Delete Entire Game -->
                <form method="post" action="/game6/delete/<%= entry.getKey() %>" style="text-align: center; margin-top: 10px;">
                    <button type="submit" class="delete-button">이 게임 삭제</button>
                </form>
            </div>
        <% } %>
    <% } %>

    <!-- 모든 결과 삭제와 돌아가기 버튼 -->
    <div class="button-container">
        <form method="post" action="/game6/deleteAll">
            <button type="submit">모든 게임 결과 삭제</button>
        </form>
        <form method="get" action="${pageContext.request.contextPath}/game6">
            <button type="submit">돌아가기</button>
        </form>
    </div>

    <!-- Accordion Script -->
    <script>
        const acc = document.getElementsByClassName("accordion");
        for (let i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function() {
                this.classList.toggle("active");
                const panel = this.nextElementSibling;
                if (panel.style.display === "block") {
                    panel.style.display = "none";
                } else {
                    panel.style.display = "block";
                }
            });
        }
    </script>
</body>
</html>
