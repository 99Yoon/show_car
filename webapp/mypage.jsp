<!-- mypage.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="test.*,java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<%
    request.setCharacterEncoding("UTF-8");
    String user = (String)session.getAttribute("user");
%>
<jsp:useBean id="cdao" class="test.CommentDAO" scope="session" />
<jsp:useBean id="udao" class="test.UserDAO" scope="session" />
<html>
<head>
    <meta charset="UTF-8">
    <title>Show Car - 모든 차를 한 번에!</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
        integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
        crossorigin="anonymous">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            width: 100%;
        }

        .added-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .login-button,
        .mypage-button,
        .add-car-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-right: 5px;
        }

        .login-button:hover,
        .mypage-button:hover,
        .add-car-button:hover {
            background-color: #0056b3;
        }

        .user-info-container {
            margin-top: 20px;
        }

        .table-container {
            margin-top: 20px;
            text-align: center;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        .edit-form-container {
            display: none;
        }

        .edit-form {
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="title">
            <div class="added-title">Show Car</div>
            <a href="main.jsp" class="login-button">홈으로</a>
        </div>

        <div class="user-info-container">
            <% if (user != null) { %>
                <h2>나의 정보</h2>
                <%
                    UserVO userInfo = udao.getUserInfo(user);
                %>
                <p>유저이름: <%= userInfo.getUsername() %></p>
                <p>유저이메일: <%= userInfo.getUseremail() %></p>
                <button onclick="showEditUserForm()">수정</button>
                <div id="editUserForm" class="edit-form-container">
                    <form id="userForm" action="update_user.jsp" method="post" class="edit-form">
                        <input type="hidden" id="editUserId" name="userid" value="<%= user %>">
                        <p>유저이름: <input type="text" id="editUserName" name="name" value="<%= userInfo.getUsername() %>"></p>
                        <p>유저이메일: <input type="text" id="editUserEmail" name="email" value="<%= userInfo.getUseremail() %>"></p>
                        <input type="submit" value="수정확인">
                    </form>
                </div>
            <% } %>
        </div>

        <h2>나의 댓글</h2>
        <div class="table-container">
            <c:if test="${not empty cdao.getCommentuserList(user)}">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>CAR</th>
                        <th>comment</th>
                        <th>time</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                    <c:forEach var="vo" items="${cdao.getCommentuserList(user)}">
                        <tr>
                            <td>${vo.userid}</td>
                            <td>${vo.carid}</td>
                            <td>${vo.comment}</td>
                            <td>${vo.time}</td>
                            <td><a href="#" onclick="showEditCommentForm('${vo.carid}', '${vo.comment}')">수정</a></td>
                            <td><a href="del_comment.jsp?userid=${URLEncoder.encode(vo.userid, 'UTF-8')}&carid=${URLEncoder.encode(vo.carid, 'UTF-8')}">삭제</a></td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
            <div id="editForm" class="edit-form-container">
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function showEditCommentForm(carId, comment) {
            var editFormContainer = document.getElementById('editForm');
            editFormContainer.innerHTML = '';

            var editForm = document.createElement('form');
            editForm.action = 'update_comment.jsp';
            editForm.method = 'post';
            editForm.className = 'edit-form';

            // 코멘트 ID(hidden 필드)
            var commentIdInput = document.createElement('input');
            commentIdInput.type = 'hidden';
            commentIdInput.name = 'commentId';
            commentIdInput.value = carId;

            // 유저 ID(hidden 필드)
            var userIdInput = document.createElement('input');
            userIdInput.type = 'hidden';
            userIdInput.name = 'userid';
            userIdInput.value = '<%= user %>';

            // 수정할 내용 입력 필드
            var commentInput = document.createElement('input');
            commentInput.type = 'text';
            commentInput.name = 'comment';
            commentInput.value = comment;

            // 확인 버튼
            var submitButton = document.createElement('input');
            submitButton.type = 'button';
            submitButton.value = '수정확인';
            submitButton.onclick = function() {
                editForm.submit();
            };

            // 폼에 요소 추가
            editForm.appendChild(commentIdInput);
            editForm.appendChild(userIdInput);
            editForm.appendChild(commentInput);
            editForm.appendChild(submitButton);
            

            // 폼 컨테이너에 폼 추가
            editFormContainer.appendChild(editForm);

            // 폼 표시
            editFormContainer.style.display = 'block';
        }
    </script>
    <script type="text/javascript">
        function showEditUserForm() {
            document.getElementById('editUserForm').style.display = 'block';
        }
    </script>
</body>
</html>
