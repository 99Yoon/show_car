<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*, java.util.Date, test.*" %>
<!DOCTYPE html>
<html>
<%
    request.setCharacterEncoding("UTF-8");
    String carId = request.getParameter("carId");
    String username = (String)session.getAttribute("user");
    CarDAO cdao = new CarDAO();
    UserDAO udao = new UserDAO();
    String carname = cdao.getCarNameById(carId);
    session.setAttribute("carName", carname);

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
    String currentTime = sdf.format(new Date());

    if (carId != null && !carId.isEmpty()) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbc_url = "jdbc:mysql://localhost/jspdb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
            connection = DriverManager.getConnection(jdbc_url, "jspbook", "passwd");

            String query = "SELECT * FROM car WHERE CAR_ID = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, carId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String carName = resultSet.getString("CAR_NAME");
                String carType = resultSet.getString("CAR_TYPE");
                String carBrand = resultSet.getString("CAR_BRAND");
                String carFuel = resultSet.getString("CAR_FUEL");
                String carPrice = resultSet.getString("CAR_PRICE");
                String carLink = resultSet.getString("CAR_LINK");
                byte[] imageData = resultSet.getBytes("CAR_PICTURE");
                String base64Image = Base64.getEncoder().encodeToString(imageData);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .title {
            display: flex;
            justify-content: space-between;
            width: 100%;
            margin-bottom: 20px;
        }

        .added-title {
            font-size: 24px;
            font-weight: bold;
            align-self: flex-start;
        }

        .home-link {
            color: #007bff;
            text-decoration: none;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .home-link:hover {
            background-color: #0056b3;
            color: #fff;
        }

        h2 {
            color: #007bff;
        }

        div {
            margin-top: 20px;
        }

        p {
            margin: 10px 0;
        }

        img {
            max-width: 100%;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }

        form {
            margin-top: 20px;
        }

        textarea {
            width: 100%;
            margin-top: 10px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        h3 {
            margin-top: 20px;
            color: #007bff;
        }

        p.review {
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 8px;
            margin: 10px 0;
        }

        p.review span {
            font-weight: bold;
        }

        .back-link {
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            align-self: flex-end;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">
        <div class="added-title">Show Car</div>
        <a href="main.jsp" class="home-link">홈으로</a>
    </div>
    <h2>Car Details</h2>
    <div>
        <p>차량명: <%= carName %> </p>
        <p>차량종류: <%= carType %></p>
        <p>제조사: <%= carBrand %></p>
        <p>유종: <%= carFuel %></p>
        <p>가격: <%= carPrice %>만원</p>
        <img src="data:image/jpeg;base64, <%= base64Image %>" alt="Car Image">
        <p>Link: <a href="<%= carLink %>" target="_blank">더 많은 정보</a></p>
    </div>

    <form action="carDetails.jsp" method="post">
        <input type="hidden" name="carId" value="<%= carId %>">
        <label for="review">리뷰 작성:</label><br>
        <textarea id="review" name="review" rows="4" cols="50"></textarea><br>
        <input type="submit" value="리뷰 제출">
    </form>

    <h3>사용자 리뷰</h3>
    <div>
        <% 
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String review = request.getParameter("review");
                CommentDAO commentDAO = new CommentDAO();
                commentDAO.addComemnt(carName, username, review, currentTime);
            }

            List<CommentVO> comments = new CommentDAO().getCommentCarList(carName);
            for (CommentVO vo : comments) {
                String comment = vo.getComment();
                String time = vo.getTime();
                String user = vo.getUserid();
                String uname = udao.getUserNameById(user);
        %>
        <p class="review">
            <span>이름: <%= uname %></span> - <%= comment %> (<%= time %>)
        </p>
        <% } %>
    </div>
</div>

</body>
</html>

<%
            } else {
                out.println("<p>차량을 찾을 수 없습니다</p>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) {
                try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (preparedStatement != null) {
                try { preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    } else {
        out.println("<p>유효하지 않은 차량 ID입니다</p>");
    }
%>
</body>
</html>
