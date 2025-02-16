<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="OpneApi.HistoryService, OpneApi.LocationHistory , java.util.List, java.util.ArrayList" %>
<%
    String checkdate = request.getParameter("checkdate");
    HistoryService historyService = new HistoryService();
    historyService.deleteHistory(checkdate);
    response.sendRedirect("reallocationhistory.jsp");
%>
