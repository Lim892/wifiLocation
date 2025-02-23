<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 그룹 추가</title>
    <style>
        body {
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
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



        label {
            display: inline-block;
            width: 100px;
            margin-bottom: 10px;
            color: white;
            background-color: green;
            padding: 5px;
        }
        input[type="text"], input[type="number"] {
            padding: 5px;
            margin-right: 10px;
            width: 150px;
        }
        .button-group {
            display: inline-flex;
            align-items: center;
        }
        button {
            background-color: grey; /* 회색 배경 */
            color: black; /* 검은색 글자 */
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        button:hover {
            background-color: #6c757d; /* Hover 시 약간 더 어두운 회색 */
        }
        a {
            text-decoration: underline;
            color: black; /* 검은색 글자 */
        }
    </style>
</head>
<body>

<h2>북마크 그룹 이름 추가</h2>
<nav>
        <a href="index.jsp">홈</a>
        <a href="reallocationhistory.jsp">와이파이 히스토리 목록</a>
        <a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
        <a href="bookmark-list.jsp">즐겨 찾기 보기 </a>
        <a href="bookmark-group.jsp">즐겨 찾기 그룹 관리</a>
    </nav>




<form action="bookmark-group-add-submit.jsp" method="post">
    <label for="bookmarkname">북마크 이름</label>
    <input type="text" id="bookmarkname" name="bookmarkname" required><br>
    <label for="orderint">순서</label>
    <input type="number" id="orderint" name="orderint" required><br>
    <div class="button-group">
        <button type="submit">추가</button>
        <a href="bookmark-group.jsp">돌아가기</a>
    </div>
</form>

</body>
</html>
