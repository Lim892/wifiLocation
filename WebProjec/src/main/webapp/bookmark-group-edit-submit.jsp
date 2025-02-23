<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="OpneApi.BookmarkGroupService, OpneApi.BookmarkGroupInfo" %>

<%
    String bookname = request.getParameter("bookname");
    int orderint = Integer.parseInt(request.getParameter("orderint"));
    int bookmark_id = Integer.parseInt(request.getParameter("id"));

    BookmarkGroupInfo bookmark = new BookmarkGroupInfo();
    bookmark.setBookmark_Id(bookmark_id);
    bookmark.setBookmarkName(bookname);
    bookmark.setOrderint(orderint);

    BookmarkGroupService service = new BookmarkGroupService();

    try {
        service.updateBookmark(bookmark);
        out.println("<script>alert('북마크 그룹 정보를 수정하였습니다.');</script>");
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 그룹 수정 완료</title>
    <script>
        window.location.href = "bookmark-group.jsp";
    </script>
</head>
<body>
</body>
</html>
