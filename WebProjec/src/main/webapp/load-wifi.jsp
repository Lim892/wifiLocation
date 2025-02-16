<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="OpneApi.apicode" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE html>
<html>
<head>
    <title>와이파이 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 20%;
            background-color: #ffffff;
        }
        h1 {
            font-size: 24px;
            color: #000;
            margin-bottom: 20px;
        }
        a {
            font-size: 16px;
            color: #6a0dad;
            text-decoration: none;
            border: 1px solid #6a0dad;
            padding: 10px 15px;
            border-radius: 5px;
            background-color: #f8f8ff;
        }
        a:hover {
            text-decoration: underline;
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
<%
    int totalRecordCount = 0;
    int start = 1;
    int batchSize = 1000;
    int totalDataSize = 26000;

    while (start <= totalDataSize) {
        int end = start + batchSize - 1;
        if (end > totalDataSize) {
            end = totalDataSize;
        }
        try {
            int recordCount = apicode.datainsert(start, end);
            totalRecordCount += recordCount;
            start = end + 1;
        } catch (IOException e) {
            e.printStackTrace();
            out.println("<h1>와이파이 정보 삽입 중 오류가 발생했습니다.</h1>");
            break;
        }
    }

    out.println("<h1>" + totalRecordCount + "개의 WIFI 정보를 정상적으로 저장하였습니다.</h1>");
%>
    <a href="index.jsp">홈으로 가기</a>
</body>
</html>
