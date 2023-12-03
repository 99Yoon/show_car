<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="test.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    request.setCharacterEncoding("UTF-8");
    String carname = request.getParameter("carname");
    CarDAO cardao = new CarDAO();
    String carId = cardao.getIdByCarName(carname);

    if (carId != null) {
        // Redirect to carDetails.jsp with the carId parameter
        response.sendRedirect("carDetails.jsp?carId=" + carId);
    } else {
        // Handle the case where carId is not found
%>
        <html>
        <head>
            <meta charset="UTF-8">
        </head>
        <body>
            <script type="text/javascript">
                alert("차량을 찾을 수 없습니다.");
                window.history.back();
            </script>
        </body>
        </html>
<%
    }
%>
