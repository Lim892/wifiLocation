<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="OpneApi.WifiService, OpneApi.WifiInfo, java.util.List, OpneApi.HistoryService, OpneApi.LocationHistory" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>와이파이 정보 구하기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
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
            background-color: #4CAF50; /* Green */
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
    </style>
    <script>
        function getUserLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError);
            } else {
                alert("Geolocation is not supported by this browser.");
            }
        }

        function showPosition(position) {
            document.getElementById("latitude").value = position.coords.latitude;
            document.getElementById("longitude").value = position.coords.longitude;

            const latitude = position.coords.latitude;
            const longitude = position.coords.longitude;

            fetch(`mylocationhistory.jsp?latitude=${latitude}&longitude=${longitude}`)
                .then(response => response.text())
                .then(result => console.log(result))
                .catch(error => console.error('Error:', error));
        }

        function showError(error) {
            switch(error.code) {
                case error.PERMISSION_DENIED:
                    alert("User denied the request for Geolocation.");
                    break;
                case error.POSITION_UNAVAILABLE:
                    alert("Location information is unavailable.");
                    break;
                case error.TIMEOUT:
                    alert("The request to get user location timed out.");
                    break;
                case error.UNKNOWN_ERROR:
                    alert("An unknown error occurred.");
                    break;
            }
        }

        function viewNearbyWifi() {
            const latitude = document.getElementById("latitude").value;
            const longitude = document.getElementById("longitude").value;

            if (latitude && longitude) {
                window.location.href = `index.jsp?latitude=${latitude}&longitude=${longitude}`;
            } else {
                alert("위치 정보를 입력한 후에 조회해 주세요.");
            }
        }
    </script>
</head>
<body>
    <h2>와이파이 정보 구하기</h2>
    <nav>
        <a href="index.jsp">홈</a>
        <a href="reallocationhistory.jsp">와이파이 히스토리 목록</a>
        <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
    </nav>
    <label for="latitude">LAT:</label>
    <input type="text" id="latitude" value="0.0">
    <label for="longitude">LNT:</label>
    <input type="text" id="longitude" value="0.0">
    <button onclick="getUserLocation()">내 위치 가져오기</button>
    <button onclick="viewNearbyWifi()">근처 WIFI 정보 보기</button>
    <table>
        <thead>
            <tr>
                <th>거리(Km)</th>
                <th>관리번호</th>
                <th>자치구</th>
                <th>와이파이명</th>
                <th>도로명주소</th>
                <th>상세주소</th>
                <th>설치위치(층)</th>
                <th>설치유형</th>
                <th>설치기관</th>
                <th>서비스구분</th>
                <th>망종류</th>
                <th>설치년도</th>
                <th>실내외구분</th>
                <th>WIFI접속환경</th>
                <th>LAT</th>
                <th>LNT</th>
                <th>작업일자</th>
            </tr>
        </thead>
        <tbody id="results">
<%
    String latitudeParam = request.getParameter("latitude");
    String longitudeParam = request.getParameter("longitude");

    if (latitudeParam != null && longitudeParam != null) {
        double latitude = Double.parseDouble(latitudeParam);
        double longitude = Double.parseDouble(longitudeParam);

        WifiService wifiService = new WifiService();
        List<WifiInfo> wifiList = wifiService.getNearbyWifi(latitude, longitude);

        for (WifiInfo wifi : wifiList) {
%>
            <tr>
                <td><%= String.format("%.2f", wifi.getDistance()) %></td>
                <td><%= wifi.getManagementNumber() %></td>
                <td><%= wifi.getGugun() %></td>
                <td><%= wifi.getWifiName() %></td>
                <td><%= wifi.getDoroAddress() %></td>
                <td><%= wifi.getDetailAddress() %></td>
                <td><%= wifi.getFloor() %></td>
                <td><%= wifi.getInstallType() %></td>
                <td><%= wifi.getOrganization() %></td>
                <td><%= wifi.getService() %></td>
                <td><%= wifi.getNetType() %></td>
                <td><%= wifi.getInstallYear() %></td>
                <td><%= wifi.getOutindivision() %></td>
                <td><%= wifi.getWifiConnect() %></td>
                <td><%= wifi.getY_coordinate() %></td>
                <td><%= wifi.getX_coordinate() %></td>
                <td><%= wifi.getWorkDate() %></td>
            </tr>
<%
        }
    } else {
%>
            <tr>
                <td colspan="17" class="message">위치 정보를 입력한 후에 조회해 주세요.</td>
            </tr>
<%
    }
%>
        </tbody>
    </table>
</body>
</html>

