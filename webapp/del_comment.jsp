<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="test.CommentDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    request.setCharacterEncoding("UTF-8");
    
    // Ensure that userid and carid are not null before proceeding
    String userid = request.getParameter("userid");
    String carid = request.getParameter("carid");
 

    if (userid != null && carid != null) {
        CommentDAO cdao = new CommentDAO();
        cdao.delcomment(carid, userid);

        %>
        <script type="text/javascript">
            alert("삭제 완료");
            window.location.href = "mypage.jsp";
        </script>
        <%
    } else {
        %>
        <script type="text/javascript">
            alert("유효하지 않은 요청입니다.");
            window.location.href = "mypage.jsp";
        </script>
        <%
    }
%>
</body>
</html>
