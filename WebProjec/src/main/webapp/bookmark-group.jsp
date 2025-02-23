<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="OpneApi.BookmarkGroupService" %>
<%@ page import="OpneApi.BookmarkGroupInfo" %>

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
        .add-button {
            font-size: 14px;
            background-color: #ced4da;
            color: black;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
    </style>
</head>
<body>

<h2>즐겨찾기 그룹 정보</h2>
<nav>
        <a href="index.jsp">홈</a>
        <a href="reallocationhistory.jsp">와이파이 히스토리 목록</a>
        <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
        <a href="bookmark-list.jsp">즐겨 찾기 보기 </a>
        <a href="bookmark-group.jsp">즐겨 찾기 그룹 관리</a>
    </nav>
<a href="bookmark-group-add.jsp" class="add-button">북마크 그룹 이름 추가</a>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>북마크 이름</th>
            <th>순서</th>
            <th>등록일자</th>
            <th>수정일자</th>
            <th>비고</th>
        </tr>
    </thead>
    <tbody>
        <%
            BookmarkGroupService service = new BookmarkGroupService();
            List<BookmarkGroupInfo> bookmarks = service.getAllBookmarksOrdered();
            for (BookmarkGroupInfo bookmark : bookmarks) {
        %>
            <tr>
                <td><%= bookmark.getBookmark_Id() %></td>
                <td><%= bookmark.getBookmarkName() %></td>
                <td><%= bookmark.getOrderint() %></td>
                <td><%= bookmark.getRegisterDate() %></td>
                <td>
                    <%
                        if (bookmark.getEditDate() != null) {
                            out.print(bookmark.getEditDate());
                        }
                    %>
                </td>
                <td>
                    <a href="bookmark-group-edit.jsp?id=<%= bookmark.getBookmark_Id() %>">수정</a>
                    <a href="bookmark-group-delete.jsp?id=<%= bookmark.getBookmark_Id() %>">삭제</a>
                </td>
            </tr>
        <%
            }
        %>
    </tbody>
</table>

</body>
</html>
