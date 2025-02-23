<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.util.List, OpneApi.BookmarkGroupService, OpneApi.BookmarkGroupInfo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>와이파이 상세 정보</title>
    <style>
        body {
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
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
        }
        table {
            background-color: #ffffff;
            width: 50%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            background-color: #ffffff;
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
        .bookmark-header {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin-bottom: 10px;
        }
        .bookmark-header label {
            margin-right: 10px;
        }
        .bookmark-header button {
            margin-left: 10px;
        }
    </style>
</head>
<body>

<nav>
    <a href="index.jsp">홈</a>
    <a href="reallocationhistory.jsp">와이파이 히스토리 목록</a>
    <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
    <a href="bookmark-list.jsp">즐겨 찾기 보기</a>
    <a href="bookmark-group.jsp">즐겨 찾기 그룹 관리</a>
</nav>

<h2>와이파이 상세 정보</h2>

<div class="bookmark-header">
    <label for="bookmarkGroup">북마크 그룹 이름:</label>
    <select id="bookmarkGroup" onchange="updateBookmarkGroup()">
        <%
            BookmarkGroupService groupService = new BookmarkGroupService();
            List<BookmarkGroupInfo> groupList = groupService.getAllBookmarksOrdered();
            for (BookmarkGroupInfo group : groupList) {
        %>
            <option value="<%= group.getBookmark_Id() %>" data-name="<%= group.getBookmarkName() %>"><%= group.getBookmarkName() %></option>
        <%
            }
        %>
    </select>
    <button onclick="addBookmark()">즐겨찾기 추가</button>
</div>

<table>
    <tbody>
<%
    String managementNumber = request.getParameter("management_number");
    String distanceParam = request.getParameter("distance");

    if (managementNumber != null && !managementNumber.isEmpty()) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mariadb://192.168.0.6:3306/wifidb", "testuser", "zerobase");

            String query = "SELECT * FROM wifi_information_table WHERE management_number = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, managementNumber);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
%>
                <tr>
                    <th>거리(km)</th>
                    <td><%= distanceParam != null ? String.format("%.2f", Double.parseDouble(distanceParam)) : "N/A" %></td>
                </tr>
                <tr>
                    <th>관리번호</th>
                    <td id="managementNumber"><%= rs.getString("management_number") %></td>
                </tr>
                <tr>
                    <th>자치구</th>
                    <td><%= rs.getString("gugun") %></td>
                </tr>
                <tr>
                    <th>와이파이명</th>
                    <td id="wifiName"><%= rs.getString("wifiname") %></td>
                </tr>
                <tr>
                    <th>도로명주소</th>
                    <td><%= rs.getString("doroAddress") %></td>
                </tr>
                <tr>
                    <th>상세주소</th>
                    <td><%= rs.getString("detailAddress") %></td>
                </tr>
                <tr>
                    <th>설치위치(층)</th>
                    <td><%= rs.getString("floor") %></td>
                </tr>
                <tr>
                    <th>설치유형</th>
                    <td><%= rs.getString("install_Type") %></td>
                </tr>
                <tr>
                    <th>설치기관</th>
                    <td><%= rs.getString("organization") %></td>
                </tr>
                <tr>
                    <th>서비스구분</th>
                    <td><%= rs.getString("service") %></td>
                </tr>
                <tr>
                    <th>망종류</th>
                    <td><%= rs.getString("net_Type") %></td>
                </tr>
                <tr>
                    <th>설치년도</th>
                    <td><%= rs.getString("install_Year") %></td>
                </tr>
                <tr>
                    <th>실내외구분</th>
                    <td><%= rs.getString("outindivision") %></td>
                </tr>
                <tr>
                    <th>WIFI접속환경</th>
                    <td><%= rs.getString("wifi_Connect") %></td>
                </tr>
                <tr>
                    <th>LAT</th>
                    <td><%= rs.getString("y_coordinate") %></td>
                </tr>
                <tr>
                    <th>LNT</th>
                    <td><%= rs.getString("x_coordinate") %></td>
                </tr>
                <tr>
                    <th>작업일자</th>
                    <td><%= rs.getString("workDate") %></td>
                </tr>
<%
            } else {
%>
                <tr>
                    <td colspan="2" class="message">해당 관리번호에 대한 와이파이 정보를 찾을 수 없습니다.</td>
                </tr>
<%
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
%>
            <tr>
                <td colspan="2" class="message">데이터베이스 연결 중 오류가 발생했습니다.</td>
            </tr>
<%
        }
    } else {
%>
        <tr>
            <td colspan="2" class="message">관리번호를 입력해주세요.</td>
        </tr>
<%
    }
%>
    </tbody>
</table>

<script>
    function updateBookmarkGroup() {
        var bookmarkGroup = document.getElementById("bookmarkGroup");
        var selectedOption = bookmarkGroup.options[bookmarkGroup.selectedIndex];
        document.getElementById("selectedBookmarkGroupName").value = selectedOption.getAttribute("data-name");
    }

    function addBookmark() {
        var bookmarkGroup = document.getElementById("bookmarkGroup").value;
        var bookmarkGroupName = document.getElementById("selectedBookmarkGroupName").value;
        var managementNumber = document.getElementById("managementNumber").innerText;
        var wifiName = document.getElementById("wifiName").innerText;

        window.location.href = "bookmark-list-add-submit.jsp?bookmark_id=" + bookmarkGroup + "&bookmarkgroupname=" + bookmarkGroupName + "&management_number=" + managementNumber + "&wifiname=" + wifiName;
    }

    document.addEventListener("DOMContentLoaded", updateBookmarkGroup);
</script>

<input type="hidden" id="selectedBookmarkGroupName" name="selectedBookmarkGroupName" value="">

</body>
</html>
