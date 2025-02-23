<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="OpneApi.BookmarkListService, OpneApi.BookmarkListInfo" %>

<%
    int bookmarkId = Integer.parseInt(request.getParameter("bookmark_id"));
    String bookmarkGroupName = request.getParameter("bookmarkgroupname");
    String managementNumber = request.getParameter("management_number");
    String wifiName = request.getParameter("wifiname");

    BookmarkListInfo bookmark = new BookmarkListInfo();
    bookmark.setBookmark_Id(bookmarkId);
    bookmark.setManagement_Number(managementNumber);
    bookmark.setBookmarkName(bookmarkGroupName);
    bookmark.setWifiName(wifiName);
    bookmark.setListRegisterDate("");

    BookmarkListService service = new BookmarkListService();
    service.insertBookmark(bookmark);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 추가 완료</title>
    <script>
        alert("북마크 정보를 추가하였습니다.");
        window.location.href = "bookmark-list.jsp";
    </script>
</head>
<body>
</body>
</html>
