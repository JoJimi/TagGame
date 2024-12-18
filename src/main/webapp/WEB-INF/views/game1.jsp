<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>러시안 룰렛 게임</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            text-align: center;
        }
        form {
            margin: 20px;
        }
        input, button {
            padding: 10px;
            margin: 5px;
        }
        h1 {
            color: darkred;
        }
        .result {
            color: green;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <h1>러시안 룰렛</h1>
    <form action="/game1/play" method="post">
        <label>참가자 수:</label>
        <input type="number" name="participantCount" min="1" required>
        <button type="submit">게임 시작</button>
    </form>
</body>
</html>

