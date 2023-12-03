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
	String username = (String)session.getAttribute("user");
        if (username != null) {
        	session.removeAttribute("user");
        	session.removeAttribute("usertype");
        %>
       <script type="text/javascript">
		alert("로그아웃");
		window.location.href = "main.jsp";
		</script>    
        <%
       	 } else {
        %>
        <script type="text/javascript">
			alert("로그인 되어있지 않음");
			window.history.back();
		</script>
        <%
            }
        %>	

</body>
</html>