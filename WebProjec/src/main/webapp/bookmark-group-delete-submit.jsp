<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="OpneApi.BookmarkGroupService" %>
<%@ page pageEncoding="UTF-8" %>

<%
    int bookmark_id = Integer.parseInt(request.getParameter("id"));

    BookmarkGroupService service = new BookmarkGroupService();
    service.deleteBookmark(bookmark_id);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 그룹 삭제 완료</title>
    <script>
        alert("북마크 그룹 정보를 삭제하셨습니다.");
        window.location.href = "bookmark-group.jsp";
    </script>
</head>
<body>
</body>
</html>
