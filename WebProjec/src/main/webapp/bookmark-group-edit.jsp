<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="OpneApi.BookmarkGroupService, OpneApi.BookmarkGroupInfo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 그룹 수정</title>
    <style>
        body {
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
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
        label {
            display: inline-block;
            width: 100px;
            margin-bottom: 10px;
            color: white;
            background-color: green;
            padding: 5px;
        }
        input[type="text"], input[type="number"] {
            padding: 5px;
            margin-right: 10px;
            width: 150px;
        }
        .button-group {
            display: inline-flex;
            align-items: center;
        }
        button {
            background-color: grey;
            color: black;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        a {
            text-decoration: underline;
            color: black;
        }
    </style>
</head>
<body>

<h2>북마크 그룹 수정</h2>
<nav>
        <a href="index.jsp">홈</a>
        <a href="reallocationhistory.jsp">와이파이 히스토리 목록</a>
        <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
        <a href="bookmark-list.jsp">즐겨 찾기 보기 </a>
        <a href="bookmark-group.jsp">즐겨 찾기 그룹 관리</a>
    </nav>




<%
    int bookmark_id = Integer.parseInt(request.getParameter("id"));
    BookmarkGroupService service = new BookmarkGroupService();
    BookmarkGroupInfo bookmark = service.readBookmark(bookmark_id);
%>
<form action="bookmark-group-edit-submit.jsp" method="post">
    <input type="hidden" name="id" value="<%= bookmark.getBookmark_Id() %>">
    <label for="bookname">북마크 이름</label>
    <input type="text" id="bookname" name="bookname" value="<%= bookmark.getBookmarkName() %>" required><br>
    <label for="orderint">순서</label>
    <input type="number" id="orderint" name="orderint" value="<%= bookmark.getOrderint() %>" required><br>
    <div class="button-group">
        <button type="submit">수정</button>
        <a href="bookmark-group.jsp">돌아가기</a>
    </div>
</form>

</body>
</html>
