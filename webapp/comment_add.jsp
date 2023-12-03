<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="test.CommentDAO,test.CommentVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");
	String carId = request.getParameter("carid");
	String username = request.getParameter("username");
	String time = request.getParameter("time");
	String comment = request.getParameter("comment");
	
	CommentVO commentVO = new CommentVO();
    commentVO.setCarid(carId);
    commentVO.setUserid(username);
    commentVO.setTime(time);
    commentVO.setComment(comment);
%>
<jsp:useBean id="cdao" class="test.CommentDAO" scope="session" />
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
        if (comment != null) {
        	cdao.addComemnt(carId,username,comment,time);
        %>
       <script type="text/javascript">
		alert("등록");
		 window.location.href = "car_comment.jsp?carid=" + encodeURIComponent('<%= carId %>');
		</script>    
        <%
       	 } else {
        %>
        <script type="text/javascript">
			alert("코멘트가 비어있음");
			window.history.back();
		</script>
        <%
            }
        %>	

</body>
</html>