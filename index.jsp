<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalTime" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>COMP367 Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            text-align: center;
        }
        .welcome {
            font-size: 24px;
            margin-top: 100px;
        }
    </style>
</head>
<body>
    <div class="welcome">
        <%
            LocalTime currentTime = LocalTime.now();
            int hour = currentTime.getHour();
            String greeting = (hour < 12) ? "Good morning" : "Good afternoon";
            String name = "Your Name"; // modified via github issue
        %>
        <%= greeting %>, <%= name %>, Welcome to COMP367
    </div>
</body>
</html>
