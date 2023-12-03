<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="test.*" %>
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
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String userid = request.getParameter("userid");
	
	UserDAO udao = new UserDAO();
	boolean result = udao.updateUserInfo(userid,name,email);
	if(result){
		session.setAttribute("username", name);
%>
	<script type="text/javascript">
		alert("수정 완료");
		window.location.href = "mypage.jsp";
	</script>

	<%
	
	}else{
	%>
	<script type="text/javascript">
		alert("수정 실패");
		window.history.back();
	</script>
	<%
	}
	%>

</body>
</html>