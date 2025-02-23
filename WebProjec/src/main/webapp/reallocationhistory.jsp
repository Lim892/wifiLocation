<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="OpneApi.HistoryService, OpneApi.LocationHistory, java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>위치 히스토리 목록</title>
    <style>
        <style>
                body {
                    margin: 0;
                    padding: 20px;
                }
                nav {
                    padding: 10px;
                    margin-bottom: 20px;
                    display: flex;
                }
                nav a {
                    color: black;
                    margin-right: 20px;
                    text-decoration: none;
                    position: relative;
                    padding: 0 10px;
                    text-decoration: underline;
                }
                nav a:not(:last-child) {
                    border-right: 1px solid #333;
                }
                h2 {
                    color: #333;
                }
                label {
                    display: inline-block;
                    width: 100px;
                    margin-bottom: 10px;
                }
                input[type="text"] {
                    padding: 5px;
                    margin-right: 10px;
                    width: 150px;
                }
                button {
                    background-color: #4CAF50;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                }
                button:hover {
                    background-color: #45a049;
                }
                table {
                    background-color: #ffffff;
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                }
                th, td {
                    background-color: #ffffff;
                    text-align: left;
                    padding: 8px;
                    border-bottom: 1px solid #ddd;
                }
                th {
                    background-color: #45a049;
                    color: white;
                }
                tr:hover {
                    background-color: #f5f5f5;
                }
                .message {
                    color: #ff0000;
                    margin-top: 20px;
                }
            </style>
    </style>
</head>
<body>
    <h1>위치 히스토리 목록</h1>
    <nav>
            <a href="index.jsp">홈</a>
            <a href="reallocationhistory.jsp">와이파이 히스토리 목록</a>
            <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
            <a href="bookmark-list.jsp">즐겨 찾기 보기 </a>
            <a href="bookmark-group.jsp">즐겨 찾기 그룹 관리</a>
        </nav>
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
