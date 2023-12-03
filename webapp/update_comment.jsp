<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="test.CommentDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    request.setCharacterEncoding("UTF-8");
    
    String carid = request.getParameter("commentId");
    String comment = request.getParameter("comment");
    String userid = request.getParameter("userid");

    if (userid != null && carid != null && comment !=null) {
        CommentDAO cdao = new CommentDAO();
        cdao.upcomment(carid, userid, comment);

        %>
        <script type="text/javascript">
            alert("수정 완료");
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
