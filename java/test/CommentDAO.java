package test;

import java.sql.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class CommentDAO {

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
	//댓글 달기
	public void addComemnt(String car,String id,String comment, String time) {
		connect();
		String sql = "insert into review_table values (?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, car);
			pstmt.setString(2, id);
			pstmt.setString(3, comment);
			pstmt.setString(4, time);
			pstmt.setInt(5, 0);
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
//			return false;
		} finally {
			disconnect();
		}
//		return true;
	}
	//유저별 댓글 불러오기
	public ArrayList<CommentVO> getCommentuserList(String user) {
		connect();
		ArrayList<CommentVO> addrlist = new ArrayList<CommentVO>();
		String sql = "select * from review_table ";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentVO ab = new CommentVO();
				ab.setUserid(rs.getString("USER_ID"));
				ab.setCarid(rs.getString("CAR_ID"));
				ab.setTime(rs.getString("TIME"));
				ab.setComment(rs.getString("COMMENT"));
				ab.setLikenum(rs.getInt("LIKE_NUM"));
				if(user.equals(rs.getString("USER_ID"))) {
				addrlist.add(ab);}
					
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return addrlist;
	}
	// 자동차별 댓글리스트 불러오기
	public ArrayList<CommentVO> getCommentCarList(String carname) {
		connect();
		ArrayList<CommentVO> addrlist = new ArrayList<CommentVO>();
		String sql = "select * from review_table ";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(carname!=null) {
			while(rs.next()) {
				CommentVO ab = new CommentVO();
				ab.setUserid(rs.getString("USER_ID"));
				ab.setCarid(rs.getString("CAR_ID"));
				ab.setTime(rs.getString("TIME"));
				ab.setComment(rs.getString("COMMENT"));
				ab.setLikenum(rs.getInt("LIKE_NUM"));
				if(carname.equals(rs.getString("CAR_ID"))) {
				addrlist.add(ab);}	
				}
			}
			else {
				System.out.println("carid가 없습니다.");
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return addrlist;
	}
	// 차이름 불러오기(select form용)
	public List<String> getCarIds() {
        List<String> carIds = new ArrayList<>();
        connect();
        String sql = "select distinct CAR_ID from review_table";
        
        try {
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                carIds.add(rs.getString("CAR_ID"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return carIds;
    }
	//댓글 삭제
	public void delcomment(String carId, String username) {
        connect();
        String sql = "DELETE FROM review_table WHERE CAR_ID = ? AND USER_ID = ?";      
        try {
        	 pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, carId);
             pstmt.setString(2, username);
             pstmt.executeUpdate();  
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            disconnect();
        }
    }
	//댓글 update
	public void upcomment(String carId, String username, String newComment) {
	    connect();
	    String sql = "UPDATE review_table SET COMMENT = ? WHERE CAR_ID = ? AND USER_ID = ?";
	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, newComment);
	        pstmt.setString(2, carId);
	        pstmt.setString(3, username);
	        pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        disconnect();
	    }
	}
}
