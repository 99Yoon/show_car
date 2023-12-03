<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="test.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="uvo" class="test.UserVO" />
<jsp:useBean id="udao" class="test.UserDAO" scope="application"/>
<%
	String id = request.getParameter("username");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String nickname = request.getParameter("nickname");
	
    boolean registrationSuccess = udao.add(id,password,email,nickname);
    if (registrationSuccess) {
        // 회원가입이 성공한 경우
%>
        <script type="text/javascript">
            alert("회원가입이 완료되었습니다.");
            window.location.href = "main.jsp";
        </script>
<%
    } else {
        // 회원가입이 실패한 경우
%>
        <script type="text/javascript">
            alert("회원가입에 실패했습니다. 다시 시도해주세요.");
            window.history.back();
        </script>
<%
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register Member</title>
</head>
<body>
    <!-- 해당 부분은 회원가입이 성공했을 때는 보이지 않을 것이므로 필요 없습니다. -->
</body>
</html>
