<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="test.UserDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userid = request.getParameter("userid");
	String userpw = request.getParameter("userpw");
	
	UserDAO udao = new UserDAO();
	boolean result = udao.login(userid, userpw);
	int lgtype =udao.logintype(userid, userpw);
	String username = udao.getUsername(userid, userpw);
	if(result){
		session.setAttribute("usertype", lgtype);
		session.setAttribute("user", userid);
		session.setAttribute("username", username);
%>
	<script type="text/javascript">
		alert("로그인 완료");
		window.location.href = "main.jsp";
	</script>

	<%
	
	}else{
	%>
	<script type="text/javascript">
		alert("로그인 실패");
		window.history.back();
	</script>
	<%
	}
	%>

</body>
</html>