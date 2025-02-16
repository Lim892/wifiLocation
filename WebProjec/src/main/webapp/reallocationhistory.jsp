<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="OpneApi.HistoryService, OpneApi.LocationHistory, java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>위치 히스토리 목록</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        .delete-button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>위치 히스토리 목록</h1>
    <a href="index.jsp">홈</a> | <a href="reallocationhistory.jsp">위치 히스토리 목록</a> | <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
    <br><br>
    <table>
        <tr>
            <th>ID</th>
            <th>Y좌표</th>
            <th>X좌표</th>
            <th>조회일자</th>
            <th>비고</th>
        </tr>
        <%
            HistoryService historyService = new HistoryService();
            List<LocationHistory> historyList = historyService.readHistory();
            int id = 1;
            for (LocationHistory history : historyList) {
        %>
        <tr>
            <td><%= id++ %></td>
            <td><%= history.getXCoordinate() %></td>
            <td><%= history.getYCoordinate() %></td>
            <td><%= history.getCheckDate() %></td>
            <td>
                <form action="deleteHistory.jsp" method="post">
                    <input type="hidden" name="checkdate" value="<%= history.getCheckDate() %>">
                    <input type="submit" value="삭제" class="delete-button">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
