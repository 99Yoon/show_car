package test;

import java.sql.*;
import java.util.*;
import java.util.ArrayList;


public class CarDAO {

    private Connection conn;
    private ResultSet rs;
    private PreparedStatement pstmt;

    public CarDAO() {
        try {
            String jdbc_url = "jdbc:mysql://localhost/jspdb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.conn = DriverManager.getConnection(jdbc_url, "jspbook", "passwd");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public int getNext() {
        String sql = "SELECT COALESCE(MAX(CAR_ID), 0) FROM car";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1; // 첫번 째 게시물인 경우
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // 데이터 베이스 오류
    }

    public ArrayList<CarVO> getCarList(int start, int itemsPerPage) {
        String sql = "SELECT * FROM car ORDER BY CAR_ID DESC LIMIT ?, ?";
        ArrayList<CarVO> carList = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start);
            pstmt.setInt(2, itemsPerPage);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CarVO car = new CarVO();
                car.setImagedata(rs.getBytes("car_picture"));
                car.setId(rs.getString("CAR_ID"));
                car.setCarName(rs.getString("CAR_NAME"));
                car.setManufacturer(rs.getString("CAR_BRAND"));
                car.setFuelType(rs.getString("CAR_FUEL"));
                car.setPrice(rs.getString("CAR_PRICE"));
                car.setCarType(rs.getString("CAR_TYPE"));
                carList.add(car);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return carList;
    }

    public boolean nextPage(int start) {
        String sql = "SELECT * FROM car WHERE CAR_ID > ? LIMIT 1";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addCar(CarVO car) {
        String sql = "INSERT INTO car VALUES (?,?,?,?,?,?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, car.getId());
            pstmt.setString(2, car.getCarName());
            pstmt.setString(3, car.getManufacturer());
            pstmt.setString(4, car.getFuelType());
            pstmt.setString(5, car.getPrice());
            pstmt.setString(6, car.getCarType());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalPages(int itemsPerPage) {
        String sql = "SELECT CEIL(COUNT(*) / ?) FROM car";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, itemsPerPage);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public String getCarNameById(String carId) {
        String sql = "SELECT CAR_NAME FROM car WHERE CAR_ID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, carId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("CAR_NAME");
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // CAR_ID를 찾지 못하거나 데이터베이스 오류가 있는 경우 처리
    }
    public String getIdByCarName(String carName) {
        String sql = "SELECT CAR_ID FROM car WHERE CAR_NAME = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, carName);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("CAR_ID");
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // CAR_NAME를 찾지 못하거나 데이터베이스 오류가 있는 경우 처리
    }

    public ArrayList<CarVO> getFilteredCarList(String selectedManufacturer, String selectedFuelType, String selectedCarType, int start, int itemsPerPage) {
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM car WHERE 1=1");
        // 필터 조건이 선택된 경우에만 SQL에 조건 추가
        if (selectedManufacturer != null && !selectedManufacturer.isEmpty()) {
            sqlBuilder.append(" AND CAR_BRAND = ?");
        }
        if (selectedFuelType != null && !selectedFuelType.isEmpty()) {
            sqlBuilder.append(" AND CAR_FUEL = ?");
        }
        if (selectedCarType != null && !selectedCarType.isEmpty()) {
            sqlBuilder.append(" AND CAR_TYPE = ?");
        }
        
        sqlBuilder.append(" ORDER BY CAR_ID DESC LIMIT ?, ?");
        ArrayList<CarVO> filteredCarList = new ArrayList<>();

        try {
            PreparedStatement pstmt = conn.prepareStatement(sqlBuilder.toString());

            // 필터 값 설정
            int parameterIndex = 1;
            if (selectedManufacturer != null && !selectedManufacturer.isEmpty()) {
                pstmt.setString(parameterIndex++, selectedManufacturer);
            }
            if (selectedFuelType != null && !selectedFuelType.isEmpty()) {
                pstmt.setString(parameterIndex++, selectedFuelType);
            }
            if (selectedCarType != null && !selectedCarType.isEmpty()) {
                pstmt.setString(parameterIndex++, selectedCarType);
            }
            
            pstmt.setInt(parameterIndex++, start);
            pstmt.setInt(parameterIndex++, itemsPerPage);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                CarVO car = new CarVO();
                car.setImagedata(rs.getBytes("car_picture"));
                car.setId(rs.getString("CAR_ID"));
                car.setCarName(rs.getString("CAR_NAME"));
                car.setManufacturer(rs.getString("CAR_BRAND"));
                car.setFuelType(rs.getString("CAR_FUEL"));
                car.setPrice(rs.getString("CAR_PRICE"));
                car.setCarType(rs.getString("CAR_TYPE"));
                filteredCarList.add(car);
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return filteredCarList;
    }

    // 새로운 메서드: 필터를 적용한 총 페이지 수 가져오기
    public int getTotalFilteredPages(String selectedManufacturer, String selectedFuelType, String selectedCarType, int itemsPerPage) {
        StringBuilder sqlBuilder = new StringBuilder("SELECT CEIL(COUNT(*) / ?) FROM car WHERE 1=1");

        // 필터 조건이 선택된 경우에만 SQL에 조건 추가
        if (selectedManufacturer != null && !selectedManufacturer.isEmpty()) {
            sqlBuilder.append(" AND CAR_BRAND = ?");
        }
        if (selectedFuelType != null && !selectedFuelType.isEmpty()) {
            sqlBuilder.append(" AND CAR_FUEL = ?");
        }
        if (selectedCarType != null && !selectedCarType.isEmpty()) {
            sqlBuilder.append(" AND CAR_TYPE = ?");
        }
       

        try {
            PreparedStatement pstmt = conn.prepareStatement(sqlBuilder.toString());

            // 필터 값 설정
            int parameterIndex = 1;
            if (selectedManufacturer != null && !selectedManufacturer.isEmpty()) {
                pstmt.setString(parameterIndex++, selectedManufacturer);
            }
            if (selectedFuelType != null && !selectedFuelType.isEmpty()) {
                pstmt.setString(parameterIndex++, selectedFuelType);
            }
            if (selectedCarType != null && !selectedCarType.isEmpty()) {
                pstmt.setString(parameterIndex++, selectedCarType);
            }         
           
            pstmt.setInt(parameterIndex++, itemsPerPage);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public List<String> getCarBrands() {
        List<String> carBrands = new ArrayList<>();
  
        String sql = "SELECT DISTINCT CAR_BRAND FROM car";
        
        try {
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                carBrands.add(rs.getString("CAR_BRAND"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return carBrands;
    }

    public List<String> getCarFuelTypes() {
        List<String> carFuelTypes = new ArrayList<>();
       
        String sql = "SELECT DISTINCT CAR_FUEL FROM car";
        
        try {
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                carFuelTypes.add(rs.getString("CAR_FUEL"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
      
        }
        return carFuelTypes;
    }

    public List<String> getCarTypes() {
        List<String> carTypes = new ArrayList<>();
      
        String sql = "SELECT DISTINCT CAR_TYPE FROM car";
        
        try {
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                carTypes.add(rs.getString("CAR_TYPE"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return carTypes;
    }
    public void insertCar(int id ,String carname,String brand,String type, String fuel,String price, String link,byte[] imageData) {
        String sql = "INSERT INTO car (CAR_ID, CAR_NAME,CAR_BRAND, CAR_TYPE, CAR_FUEL, CAR_PRICE,CAR_LINK,Car_picture) VALUES (?, ?, ?, ?, ?, ?,?,?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.setString(2, carname);
            pstmt.setString(3, brand);
            pstmt.setString(4, type);
            pstmt.setString(5, fuel);
            pstmt.setString(6, price);
            pstmt.setString(7, link);	
            pstmt.setBytes(8, imageData);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}