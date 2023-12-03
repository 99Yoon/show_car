<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*, java.util.Date, test.*" %>
<!DOCTYPE html>
<html>
<%
    Object usertypeObject = session.getAttribute("usertype");
    int adtype = (usertypeObject != null) ? (int) usertypeObject : -1;

    if(adtype!= 1){
%>
    <script type="text/javascript">
        alert("권한 없음!");
        window.location.href = "main.jsp";
    </script>
<%
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Car - 차량 추가</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        .title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .added-title {
            font-size: 24px;
            font-weight: bold;
        }

        .home-link {
            color: #007bff;
            text-decoration: none;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .home-link:hover {
            background-color: #0056b3;
            color: #fff;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .submit-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submit-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">
        <div class="added-title">Show Car</div>
        <h2>차량 추가</h2>
        <a href="main.jsp" class="home-link">홈으로</a>
    </div>
    <form action="http://localhost:8080/testbook/FileUploadServlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="carId">차량 ID(숫자):</label>
            <input type="text" class="form-control" id="carId" name="carId" required>
        </div>
        <div class="form-group">
            <label for="carName">차량 이름:</label>
            <input type="text" class="form-control" id="carName" name="carName" required>
        </div>
        <div class="form-group">
            <label for="carBrand">차량 브랜드:</label>
            <input type="text" class="form-control" id="carBrand" name="carBrand" required>
        </div>
        <div class="form-group">
            <label for="carType">차량 종류:</label>
            <input type="text" class="form-control" id="carType" name="carType" required>
        </div>
        <div class="form-group">
            <label for="carFuel">차량 연료:</label>
            <input type="text" class="form-control" id="carFuel" name="carFuel" required>
        </div>
        <div class="form-group">
            <label for="carPrice">차량 가격(만원단위):</label>
            <input type="text" class="form-control" id="carPrice" name="carPrice" required>
        </div>
        <div class="form-group">
            <label for="carLink">차량 링크:</label>
            <input type="text" class="form-control" id="carLink" name="carLink">
        </div>
        <div class="form-group">
            <label for="carImage">차량 이미지:</label>
            <input type="file" class="form-control" id="carImage" name="carImage" accept="image/*" required>
        </div>
        <button type="submit" class="btn btn-primary submit-button">추가하기</button>
    </form>
</div>

</body>
</html>
