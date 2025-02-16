<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="OpneApi.HistoryService, OpneApi.LocationHistory , java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>위치 저장</title>
</head>
<body>
<%
    String latitudeParam = request.getParameter("latitude");
    String longitudeParam = request.getParameter("longitude");

    if (latitudeParam != null && longitudeParam != null) {
        double latitude = Double.parseDouble(latitudeParam);
        double longitude = Double.parseDouble(longitudeParam);

        HistoryService historyService = new HistoryService();
        historyService.createHistory(latitude, longitude);

    } else {
        out.print("");
    }
%>
</body>
</html>
