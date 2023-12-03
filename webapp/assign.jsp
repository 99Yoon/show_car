<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign Up - Show Car</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
          crossorigin="anonymous">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
        }

        .signup-container {
            max-width: 400px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            margin-top: 100px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .signup-container h2 {
            text-align: center;
            color: #007bff;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            margin-top: 5px;
            margin-bottom: 20px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

        .signup-button, .login-button {
            width: 100%;
            padding: 10px;
            font-size: 18px;
            cursor: pointer;
        }

        .signup-button {
            background-color: #007bff;
            color: #fff;
        }

        .signup-button:hover {
            background-color: #0056b3;
        }

        .login-button {
            background-color: #28a745;
            color: #fff;
        }

        .login-button:hover {
            background-color: #218838;
        }

        .mt-2 {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="signup-container">
    <h2 class="mb-4">Sign Up</h2>
    <form action="member_add.jsp" method="post">
        <div class="form-group">
            <label for="username">아이디</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="form-group">
        	<label for="nickname">이름</label>
        	<input type="text" class="form-control" id="nickname"name="nickname" required>
        </div>
        <button type="submit" class="btn btn-primary signup-button">Sign Up</button>

        <!-- Login 버튼과 Sign Up 버튼 사이에 간격을 주기 위한 클래스 추가 -->
        <div class="mt-2"></div>

        <button type="button" class="btn btn-success login-button" onclick="location.href='login.jsp'">Login</button>
    </form>
</div>

</body>
</html>