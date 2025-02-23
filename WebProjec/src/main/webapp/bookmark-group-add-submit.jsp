<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="OpneApi.BookmarkGroupService" %>
<%@ page import="OpneApi.BookmarkGroupInfo" %>
<%@ page pageEncoding="UTF-8" %>

<%
    String bookmarkName = request.getParameter("bookmarkname");
    int orderInt = Integer.parseInt(request.getParameter("orderint"));

    BookmarkGroupInfo bookmark = new BookmarkGroupInfo();
    bookmark.setBookmarkName(bookmarkName);
    bookmark.setOrderint(orderInt);

    BookmarkGroupService service = new BookmarkGroupService();
    service.createBookmark(bookmark);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 그룹 추가 완료</title>
    <script>
        alert("북마크 그룹 정보를 추가하였습니다.");
        window.location.href = "bookmark-group.jsp";
    </script>
</head>
<body>
</body>
</html>
