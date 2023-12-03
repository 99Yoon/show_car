<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="test.*,java.text.*,java.util.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<%
    String user = (String)session.getAttribute("user");
    UserDAO udao= new UserDAO();
    String username = udao.getUserNameById(user);

    int pagenum = 1;
    String pageStr = request.getParameter("page");
    if (pageStr != null) {
        try {
            pagenum = Integer.parseInt(pageStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    CarDAO carDAO = new CarDAO();
    int itemsPerPage = 10;
    int start = Math.max(0, (pagenum - 1) * itemsPerPage);

    String selectedManufacturer = request.getParameter("manufacturer");
    String selectedFuelType = request.getParameter("fuelType");
    String selectedCarType = request.getParameter("carType");
    String carNameSearch = null;

    ArrayList<CarVO> filteredCarList = carDAO.getFilteredCarList(selectedManufacturer, selectedFuelType, selectedCarType, start, itemsPerPage);
    int totalFilteredPages = carDAO.getTotalFilteredPages(selectedManufacturer, selectedFuelType, selectedCarType, itemsPerPage);

    int totalPages = carDAO.getTotalPages(itemsPerPage);
    ArrayList<CarVO> carList = carDAO.getCarList(start, itemsPerPage);
    boolean hasNextPage = carDAO.nextPage(start);
    boolean hasPrevPage = pagenum > 1;
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Show Car - 모든 차를 한 번에!</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }

        .container {
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

        .login-button, .mypage-button, .add-car-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-right: 2px; 
        }

        .login-button:hover, .mypage-button:hover, .add-car-button:hover {
            background-color: #0056b3;
        }

        .search-bar {
            width: 100%;
        }

        .car-list {
            list-style: none;
            padding: 0;
            width: 100%;
        }

        .car-item {
            margin-bottom: 20px;	
        }

        .car-item:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .car-item:not(:last-child) {
            border-bottom: 1px solid #ddd;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            width: 100%;
        }

        .pagination a {
            margin: 0 5px;
        }

        .pagination a.active {
            background-color: #007bff;
            color: #fff;
        }

        .pagination a.disabled {
            pointer-events: none;
            color: #6c757d;
            background-color: #e9ecef;
            border-color: #dee2e6;
        }

        .car-details {
            display: flex;
            align-items: center;
        }

        .car-image {
            width: 150px;
            height: auto;
            margin-right: 20px;
            border-top-left-radius: 8px;
            border-bottom-left-radius: 8px;
            overflow: hidden;
        }

        .car-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .text-details {
            flex-grow: 1;
            padding: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">
        <div class="added-title">Show Car</div>
        <% if (username != null && !username.isEmpty()) { %>
            <a href="logout.jsp" class="login-button">로그아웃</a>
            <a href="mypage.jsp" class="mypage-button">마이페이지</a>
            <a href="car_add.jsp" class="add-car-button">차량 추가</a>
        <% } else { %>
            <a href="login_form.html" class="login-button">로그인</a>
        <% } %>
    </div>

    <form action="trans.jsp" method="get" class="form-inline">
    <div class="input-group mb-3">
        <input type="text" class="form-control search-bar" name="carname" placeholder="차량 검색">
        <div class="input-group-append">
            <button type="submit" class="btn btn-outline-secondary search-button">검색</button>
        </div>
    </div>
	</form>
    
    <form action="main.jsp" method="get" class="form-inline">
        <div class="filter-options d-flex">
            <label for="manufacturer" class="mr-2">제조사:</label>
            <select name="manufacturer" id="manufacturer" class="mr-3">
                <option value="" selected>전체</option>
                <% List<String> manufacturers = new CarDAO().getCarBrands(); %>
                <% for (String manufacturer : manufacturers) { %>
                    <option value="<%= manufacturer %>"><%= manufacturer %></option>
                <% } %>
            </select>

            <label for="fuelType" class="mr-2">연료 유형:</label>
            <select name="fuelType" id="fuelType" class="mr-3">
                <option value="" selected>전체</option>
                <% List<String> fuelTypes = new CarDAO().getCarFuelTypes(); %>
                <% for (String fuelType : fuelTypes) { %>
                    <option value="<%= fuelType %>"><%= fuelType %></option>
                <% } %>
            </select>

            <label for="carType" class="mr-2">차량 종류:</label>
            <select name="carType" id="carType" class="mr-3">
                <option value="" selected>전체</option>
                <% List<String> carTypes = new CarDAO().getCarTypes(); %>
                <% for (String carType : carTypes) { %>
                    <option value="<%= carType %>"><%= carType %></option>
                <% } %>
            </select>

            <button type="submit" class="btn btn-outline-secondary search-button">검색</button>
        </div>
    </form>

    <hr>

    <ul class="car-list">
        <% if (filteredCarList != null && !filteredCarList.isEmpty()) { %>
            <% for (CarVO car : filteredCarList) { %>
                <li class="car-item">
                    <div class="car-details">
                        <% if (car.getImagedata() != null) { %>
                            <div class="car-image">
                                <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(car.getImagedata()) %>" alt="Car Image" width="200" height="100">
                            </div>
                        <% } %>
                        <div class="text-details">
                            <p>Car Name: <%= car.getCarName() %></p> 
                            <p>Manufacturer: <%= car.getManufacturer() %></p>  
                            <p>Fuel Type: <%= car.getFuelType() %></p> 
                            <p>Price: <%= car.getPrice() %>만원</p> 
                            <p>Car Type: <%= car.getCarType() %></p>
                            <p><a href="carDetails.jsp?carId=<%= car.getId() %>" class="btn btn-info">자세히 보기</a><p>
                        </div>
                    </div>
                    <hr>
                </li>
            <% } %>
        <% } else { %>
            <li class="car-item">검색 결과가 없습니다.</li>
        <% } %>
    </ul>

    <div class="pagination">
        <% if (hasPrevPage) { %>
            <a href="main.jsp?page=<%= pagenum - 1 %>" class="btn btn-outline-dark rounded-pill">이전 페이지</a>
        <% } %>
        <% for (int i = 1; i <= totalPages; i++) { %>
            <a href="main.jsp?page=<%= i %>" class="btn btn-outline-dark rounded-pill<%= i == pagenum ? " active" : "" %>"><%= i %></a>
        <% } %>
        <% if (hasNextPage && !filteredCarList.isEmpty() && pagenum < totalFilteredPages) { %>
            <a href="main.jsp?page=<%= pagenum + 1 %>" class="btn btn-outline-dark rounded-pill">다음 페이지</a>
        <% } else { %>
            <a href="#" class="btn btn-outline-dark rounded-pill disabled">다음 페이지</a>
        <% } %>
    </div>
</div>
</body>
</html>