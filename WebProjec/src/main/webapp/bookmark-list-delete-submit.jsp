<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="OpneApi.BookmarkListService" %>

<%
    int bookmarkId = Integer.parseInt(request.getParameter("bookmark_id"));
    String managementNumber = request.getParameter("management_number");

    BookmarkListService service = new BookmarkListService();
    try {
        service.deleteBookmark(bookmarkId, managementNumber);
        out.println("<script>alert('북마크 정보를 삭제하였습니다.'); window.location.href='bookmark-list.jsp';</script>");
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.location.href='bookmark-list.jsp';</script>");
    }
%>
