package _04_rentcar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
	private MemberDAO() {}
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {return instance;}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// Connection 연결하기
	public Connection getConnection() {
		String dbURL = "jdbc:mysql://localhost:3306/rentcardb04?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "335645";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbId, dbPw);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	// id, pw확인
	public int checkJoin(String id) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM member WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try{rs.close();}catch(SQLException e) {}}
			if(pstmt != null) {try{pstmt.close();}catch(SQLException e) {}}
			if(conn != null) {try{conn.close();}catch(SQLException e) {}}
		}
		return result;
	}
	
	// 회원가입
	public void joinMember(MemberBean member) {
		try{
			conn = getConnection();
			String sql = "INSERT INTO member "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw1());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getHobby());
			pstmt.setString(6, member.getJob());
			pstmt.setString(7, member.getAge());
			pstmt.setString(8, member.getInfo());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {try{pstmt.close();}catch(SQLException e) {}}
			if(conn != null) {try{conn.close();}catch(SQLException e) {}}
		}
	}
	
	// 삭제 체크하기
	public int deleteCheck(String id, String pw1) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM member WHERE id=? AND pw1=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw1);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null) {try{conn.close();}catch(SQLException e) {}}
			if(pstmt != null) {try{pstmt.close();}catch(SQLException e) {}}
			if(rs != null) {try{rs.close();}catch(SQLException e) {}}
		}
		return result;
	}
	// 회원 삭제
	public void deleteMember(String id) {
		try {
			conn = getConnection();
			String sql = "DELETE FROM member WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null) {try{conn.close();}catch(SQLException e) {}}
			if(pstmt != null) {try{pstmt.close();}catch(SQLException e) {}}
			if(rs != null) {try{rs.close();}catch(SQLException e) {}}
		}
	}
	
}






















