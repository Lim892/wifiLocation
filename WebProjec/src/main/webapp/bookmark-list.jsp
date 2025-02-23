<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="OpneApi.BookmarkListService, OpneApi.BookmarkListInfo" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 리스트</title>
    <style>
        body {
            background-color: #f9f9f9;
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
</head>
<body>

<h2>북마크 리스트</h2>
<nav>
        <a href="index.jsp">홈</a>
        <a href="reallocationhistory.jsp">와이파이 히스토리 목록</a>
        <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
        <a href="bookmark-list.jsp">즐겨 찾기 보기 </a>
        <a href="bookmark-group.jsp">즐겨 찾기 그룹 관리</a>
    </nav>




<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>북마크 이름</th>
            <th>와이파이명</th>
            <th>리스트 등록일자</th>
            <th>비고</th>
        </tr>
    </thead>
    <tbody>
        <%
            BookmarkListService listService = new BookmarkListService();
            List<BookmarkListInfo> bookmarkList = listService.getAllBookmarks();
            for (BookmarkListInfo bookmark : bookmarkList) {
        %>
            <tr>
                <td><%= bookmark.getBookmark_Id() %></td>
                <td><%= bookmark.getBookmarkName() %></td>
                <td><%= bookmark.getWifiName() %></td>
                <td><%= bookmark.getListRegisterDate() %></td>
                <td>
                    <a href="bookmark-list-delete-submit.jsp?bookmark_id=<%= bookmark.getBookmark_Id() %>&management_number=<%= bookmark.getManagement_Number() %>">삭제</a>
                </td>
            </tr>
        <%
            }
        %>
    </tbody>
</table>

</body>
</html>
