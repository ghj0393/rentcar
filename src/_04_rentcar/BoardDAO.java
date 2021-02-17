package _04_rentcar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

public class BoardDAO {
	private BoardDAO() {}
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {return instance;}
	
	
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
	
	// 전체 게시글 수 리턴
	public int AllBoardCount() {
		int result = 0;
		try {
			conn = getConnection();
			
			String sql = "SELECT COUNT(*) FROM board;";
			pstmt = conn.prepareStatement(sql);
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
	
//	// 게시글 목록 출력
//	public ArrayList<BoardDTO> getBoardList(int startPage) {
//		
//		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
//		
//		try {
//			conn = getConnection();
//			
//			String sql = "select * from board ORDER BY ref DESC , re_level LIMIT ?, ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, start);
//			pstmt.setInt(2, end - start);
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				boardDTO dto = new boardDTO();
//				
//				dto.setNum(rs.getInt("num"));
//				dto.setWriter(rs.getString("writer"));
//				dto.setTitle(rs.getString("title"));
//				dto.setPw(rs.getString("pw"));
//				dto.setReg_date(rs.getString("reg_date"));
//				dto.setRef(rs.getInt("ref"));
//				dto.setRe_step(rs.getInt("re_step"));
//				dto.setRe_level(rs.getInt("re_level"));
//				dto.setReadcount(rs.getInt("readcount"));
//				dto.setContent(rs.getString("content"));
//				
//				boardlist.add(dto);
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//		}finally {
//			if(rs != null) {try{rs.close();}catch(SQLException e) {}}
//			if(pstmt != null) {try{pstmt.close();}catch(SQLException e) {}}
//			if(conn != null) {try{conn.close();}catch(SQLException e) {}}
//		}
//		return boardList;
//	}
	
	// id로 해당 회원 정보 리턴
	public MemberBean getMember(String id) {
		MemberBean member = new MemberBean();
		try {
			conn = getConnection();
			
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member.setId(rs.getString(1));
				member.setPw1(rs.getString(2));
				member.setEmail(rs.getString(3));
				member.setTel(rs.getString(4));
				member.setHobby(rs.getString(5));
				member.setJob(rs.getString(6));
				member.setAge(rs.getString(7));
				member.setInfo(rs.getString(8));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try{rs.close();}catch(SQLException e) {}}
			if(pstmt != null) {try{pstmt.close();}catch(SQLException e) {}}
			if(conn != null) {try{conn.close();}catch(SQLException e) {}}
		}
		return member;
	}
	// 게시글 등록하기
	public void boardWrite(BoardDTO board, MemberBean member) {
		try {
			board.setId(member.getId());
			board.setPw(member.getPw1());
			board.setEmail(member.getEmail());
			// 자동 셋팅 해줘야 하는 부분,
			// num, ref, reStep,reLevel, readCount, regDate
			// db에서 저장되있는 값 중에서 최대값들을 가져와서 +1 해주기.
			int num = 0;
			int ref = 0;
			Timestamp regDate = new Timestamp(System.currentTimeMillis());
			board.setRegDate(regDate);
			
			conn = getConnection();
			// 게시글 가장 마지막글의 고유번호 + 1
			String numSql = "SELECT MAX(num) FROM board";
			pstmt = conn.prepareStatement(numSql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			// 게시글 가장 마지막글의 ref + 1
			String refSql = "SELECT MAX(ref) FROM board";
			pstmt = conn.prepareStatement(refSql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ref = rs.getInt(1) + 1;
			}
			
			String sql = "INSERT INTO board(num, id, email, subject, pw, content, ref, re_step, re_level, read_count, reg_date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, board.getId());
			pstmt.setString(3, board.getEmail());
			pstmt.setString(4, board.getSubject());
			pstmt.setString(5, board.getPw());
			pstmt.setString(6, board.getContent());
			pstmt.setInt(7, ref);
			pstmt.setInt(8, 1);
			pstmt.setInt(9, 1);
			pstmt.setInt(10, 0);
			pstmt.setTimestamp(11, board.getRegDate());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try{rs.close();}catch(SQLException e) {}}
			if(pstmt != null) {try{pstmt.close();}catch(SQLException e) {}}
			if(conn != null) {try{conn.close();}catch(SQLException e) {}}
		}
	}
	
	// 제목 클릭했을 때 해당게시글 정보 보여주는 메서드
	public BoardDTO getCheckOneBoardInfo(String id, int num){
		BoardDTO board = null;
		try {
			conn = getConnection();
			String sql = "SELECT * FROM board WHERE id=? AND num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt(1));
				board.setId(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setPw(rs.getString(5));
				board.setContent(rs.getString(6));
				board.setRef(rs.getInt(7));
				board.setReStep(rs.getInt(8));
				board.setReLevel(rs.getInt(9));
				board.setReadCount(rs.getInt(10));
				board.setRegDate(rs.getTimestamp(11));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return board;
	}
	// 본인 게시글 여부 상관없이 보여주는 게시글
	public BoardDTO getOneBoardInfo(int num) {
		BoardDTO board = null;
		try {
			conn = getConnection();
			
			// 게시판 조회수 증가시키기
			String sql = "UPDATE board SET read_count = read_count+1 WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "SELECT * FROM board WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt(1));
				board.setId(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setPw(rs.getString(5));
				board.setContent(rs.getString(6));
				board.setRef(rs.getInt(7));
				board.setReStep(rs.getInt(8));
				board.setReLevel(rs.getInt(9));
				board.setReadCount(rs.getInt(10));
				board.setRegDate(rs.getTimestamp(11));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return board;
	}
	// 조회수 증가하지 않는 게시글 정보 반환
	public BoardDTO getUpateBoard(int num) {
		BoardDTO board = null;
		try {
			conn = getConnection();
			
			String sql = "SELECT * FROM board WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt(1));
				board.setId(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setPw(rs.getString(5));
				board.setContent(rs.getString(6));
				board.setRef(rs.getInt(7));
				board.setReStep(rs.getInt(8));
				board.setReLevel(rs.getInt(9));
				board.setReadCount(rs.getInt(10));
				board.setRegDate(rs.getTimestamp(11));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return board;
	}
	
	// 비밀번호 체크 0 일경우 틀린 값
	public int checkPw(String pw, int num) {
		int result = 0;
		try {
			conn = getConnection();
			
			String sql = "SELECT COUNT(*) FROM board WHERE pw=? AND num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setInt(2, num);
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
	// 해당 내용 수정하기
	public void setUpdateBoard(int num, String subject, String content) {
		try {
			conn = getConnection();
			String sql = "UPDATE board SET subject=?, content=? WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {try{pstmt.close();}catch(SQLException e) {}}
			if(conn != null) {try{conn.close();}catch(SQLException e) {}}
		}
	}
	
	// 게시글 삭제
	public void boardDelete(String pw, int num) {
		try {
			conn = getConnection();
			String sql = "DELETE FROM board WHERE pw=? AND num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 답글 달기
	public void writeAnswer(BoardDTO dto) {
		// 부모의  ref, re_step, re_level 값에 re_step, re_level 값1증가하기
		int ref = dto.getRef();
		int re_step = dto.getReStep()+1;
		int re_level = dto.getReLevel()+1;

		int num = 0;
		System.out.println(dto);

		try {
			conn = getConnection();

			String numSql = "SELECT MAX(num) FROM board";
			pstmt = conn.prepareStatement(numSql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}
			// 부모의 ref와 같으면서 부모의 relevel보다 큰값들 + 1하기 
			String levelsql = "UPDATE board SET re_Level=re_Level+1  WHERE ref=? AND re_Level>?";

			pstmt = conn.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, dto.getReLevel());

			pstmt.executeUpdate();

			String sql = "INSERT INTO board (num , id, email, subject, pw, content, ref, re_Step, re_Level, read_count, reg_date) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,0,now())";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getPw());
			pstmt.setString(6, dto.getContent());
			pstmt.setInt(7, ref);
			pstmt.setInt(8, re_step);
			pstmt.setInt(9, re_level);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(conn!=null)
				try {conn.close();}catch(SQLException sqle) {}
			if(pstmt!=null)
				try {pstmt.close();}catch(SQLException sqle) {}
			if(rs!=null)
				try {rs.close();}catch(SQLException sqle) {}
		}
	}
	
	// 게시글 전체 개수 반환
	public int getAllCount() {
		int count = 0;
		try {
			conn = getConnection();
			
			String sql = "SELECT COUNT(*) FROM board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(conn!=null)
				try {conn.close();}catch(SQLException sqle) {}
			if(pstmt!=null)
				try {pstmt.close();}catch(SQLException sqle) {}
			if(rs!=null)
				try {rs.close();}catch(SQLException sqle) {}
		}
		return count;
	}
	// 게시판 10개 가져오기
	public ArrayList<BoardDTO> getAllBoardlist(int start, int end){
		ArrayList<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		
		try {
			conn = getConnection();
			
			String sql = "select * from board ORDER BY ref DESC , re_Level LIMIT ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end - start);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setPw(rs.getString("pw"));
				dto.setContent(rs.getString("content"));
				dto.setRef(rs.getInt("ref"));
				dto.setReStep(rs.getInt("re_Step"));
				dto.setReLevel(rs.getInt("re_Level"));
				dto.setReadCount(rs.getInt("read_Count"));
				dto.setRegDate(rs.getTimestamp("reg_date"));
				boardlist.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null)
				try {conn.close();}catch(SQLException sqle) {}
			if(pstmt!=null)
				try {pstmt.close();}catch(SQLException sqle) {}
			if(rs!=null)
				try {rs.close();}catch(SQLException sqle) {}
		}
		return boardlist;
	}
	
}





















