package test;

import java.sql.*;
import java.util.*;

public class UserDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/jspdb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC";
	
	void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "jspbook","passwd");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	//로그인
	public boolean add(String id,String password,String email,String name) {
	    connect();
	    String sql = "insert into user_table values (?,?,?,?,?)";
	    
	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, password);
	        pstmt.setString(3, name);
	        pstmt.setString(4, email);
	        pstmt.setInt(5, 0);
	        pstmt.executeUpdate();
	        return true; // 성공적으로 추가되었을 때 true 반환
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false; // 실패했을 때 false 반환
	    } finally {
	        disconnect();
	    }
	}
	
	public ArrayList<UserVO> getUserList() {
		connect();
		ArrayList<UserVO> addrlist = new ArrayList<UserVO>();
		String sql = "select * from user_table ";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				UserVO ab = new UserVO();
				ab.setUserid(rs.getString("USER_ID"));
				ab.setUserpw(rs.getString("USER_PW"));
				ab.setUsername(rs.getString("USER_NAME"));
				ab.setUseremail(rs.getString("USER_EMAIL"));
				addrlist.add(ab);
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return addrlist;
	}
	// 로그인 메서드 추가
    public boolean login(String userid, String userpw) {
        connect();
        boolean result = false;
        String sql = "SELECT * FROM user_table WHERE USER_ID = ? AND USER_PW = ? ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            pstmt.setString(2, userpw);
            ResultSet rs = pstmt.executeQuery();
            result=rs.next();
            rs.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    // logintype 찾기
    public int logintype(String userid, String userpw) {
        connect();
        int userType = -1;
        String sql = "SELECT USER_TYPE FROM user_table WHERE USER_ID = ? AND USER_PW = ? ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            pstmt.setString(2, userpw);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userType = rs.getInt("USER_TYPE");
            }
            rs.close();
            return userType;
        } catch (SQLException e) {
            e.printStackTrace();
            return userType;
        } finally {
            disconnect();
        }
    }
    //아이디 패스워드로 유저이름 찾기
    public String getUsername(String userid, String userpw) {
        connect();
        String username = null;
        String sql = "SELECT USER_NAME FROM user_table WHERE USER_ID = ? AND USER_PW = ? ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            pstmt.setString(2, userpw);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                username = rs.getString("USER_NAME");
            }
            rs.close();
            return username;
        } catch (SQLException e) {
            e.printStackTrace();
            return username;
        } finally {
            disconnect();
        }
    }
    //유저 정보 변경
    public boolean updateUserInfo(String userid, String newUsername, String newUserEmail) {
        connect();
        String sql = "UPDATE user_table SET USER_NAME = ?, USER_EMAIL = ? WHERE USER_ID = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newUsername);
            pstmt.setString(2, newUserEmail);
            pstmt.setString(3, userid);
            int rowCount = pstmt.executeUpdate();
            
            return rowCount > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
 // 유저 아이디로 유저 이름 찾기
    public String getUserNameById(String userId) {
        connect();
        String userName = null;
        String sql = "SELECT USER_NAME FROM user_table WHERE USER_ID = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("USER_NAME");
            }
            rs.close();
            return userName;
        } catch (SQLException e) {
            e.printStackTrace();
            return userName;
        } finally {
            disconnect();
        }
    }
    //유저 id로 정보 얻어오기
    public UserVO getUserInfo(String userId) {
        connect();
        UserVO userInfo = null;
        String sql = "SELECT * FROM user_table WHERE USER_ID = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userInfo = new UserVO();
                userInfo.setUserid(rs.getString("USER_ID"));
                userInfo.setUserpw(rs.getString("USER_PW"));
                userInfo.setUsername(rs.getString("USER_NAME"));
                userInfo.setUseremail(rs.getString("USER_EMAIL"));
                userInfo.setUsertype(rs.getInt("USER_TYPE"));
            }
            rs.close();
            return userInfo;
        } catch (SQLException e) {
            e.printStackTrace();
            return userInfo;
        } finally {
            disconnect();
        }
    }

}
