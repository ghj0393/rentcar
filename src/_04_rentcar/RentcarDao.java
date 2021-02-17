package _04_rentcar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class RentcarDao {
	private RentcarDao() {}
	private static RentcarDao instance = new RentcarDao();
	public static RentcarDao getInstance() { return instance; }

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public Connection getConnection() {
		String dbURL = "jdbc:mysql://localhost:3306/rentcardb04?serverTimezone=UTC&useSSL=false";
		String dbID = "root";
		String dbPassword = "335645";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	// 로그인 확인
	public int getMember(String id, String pw) {

		int result = 0; 

		conn = getConnection();
		try {

			String sql = "SELECT COUNT(*) FROM member WHERE id=? and pw1=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1); 
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {try {conn.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		}
		return result;
	}

	// 자동차 3개 저장
	public Vector<RentcarBean> getSelectCar() {
		
		Vector<RentcarBean> v = new Vector<RentcarBean>();

		try {
			conn = getConnection();
			// 자동차 no로 내림차순으로 뽑기 최신순.
			String sql = "SELECT * FROM rentcar ORDER BY no DESC";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next()) {
				
				RentcarBean bean = new RentcarBean();
				bean.setNo(rs.getInt(1));			// no
				bean.setName(rs.getString(2));		// name
				bean.setCategory(rs.getInt(3));		// category
				bean.setPrice(rs.getInt(4));		// price
				bean.setUsepeople(rs.getInt(5));	// use_people
				bean.setCompany(rs.getString(6));	// company
				bean.setImg(rs.getString(7));		// img
				bean.setInfo(rs.getString(8));		// info
				
				v.add(bean);
				count++;
				// 3개까지만 저장
				if (count > 2)
					break; 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {try {conn.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		}
		return v;
	}

	// 이미지 클릭시 자동차 값 한개 받기
	public RentcarBean getOneCar(int no) {
		
		RentcarBean bean = new RentcarBean();
		conn = getConnection();

		try {
			String sql = "SELECT * FROM rentcar WHERE no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {try {conn.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		}
		return bean;
	}

	// 예약차량 예약테이블에 저장하기
	public void setReserveCar(CarReserveBean bean) {

		conn = getConnection();
		int num = 0;
		try {
			// reserve_seq 번호 불러오기, 마지막 차량번호에 + 1해서 추가등록하기 위해서
			String numSql = "SELECT MAX(reserve_seq) FROM car_reserve";
			pstmt = conn.prepareStatement(numSql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				// 마지막 차량번호에 + 1해주기
				num = rs.getInt(1) + 1; 
			}
			// car_reserve 테이블에 새로 추가하는 쿼리문
			String sql = "INSERT INTO car_reserve (reserve_seq , no, id, qty, d_day, r_day, "
					+ "use_in, use_wifi, use_navi, use_seat)" + " VALUES(?, ?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, num);
			pstmt.setInt(2, bean.getNo());
			pstmt.setString(3, bean.getId());
			pstmt.setInt(4, bean.getQty());
			pstmt.setInt(5, bean.getDday());
			pstmt.setString(6, bean.getRday());
			pstmt.setInt(7, bean.getUsein());
			pstmt.setInt(8, bean.getUsewifi());
			pstmt.setInt(9, bean.getUsenavi());
			pstmt.setInt(10, bean.getUseseat());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {try {conn.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
		}
	}

	// 자동차 전체 리스트
	public Vector<RentcarBean> getAllCar() {
		Vector<RentcarBean> v = new Vector<>();
		
		RentcarBean bean = null;

		conn = getConnection();
		try {
			String sql = "SELECT * FROM rentcar";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				bean = new RentcarBean();
				
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				
				v.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {try {conn.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		}
		return v;
	}

	// 소형, 중형, 대형 중 해당 카테고리 자동차만 배열로 만들어서 반환
	public Vector<RentcarBean> getCategoryCar(int cate) {

		Vector<RentcarBean> v = new Vector<>();
		
		RentcarBean bean = null;

		conn = getConnection();
		try {
			// 렌트카 중 해당 카테고리 차를 뽑는 쿼리문
			String sql = "SELECT * FROM rentcar WHERE category=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cate);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				bean = new RentcarBean();
				
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				
				v.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {try {conn.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		}
		return v;
	}

	// 해당 아이디가 예약한 차량정보 가져오기 
	public Vector<CarViewBean> getAllReserve(String id) {

		Vector<CarViewBean> v = new Vector<>();
		CarViewBean bean = null;

		conn = getConnection();

		try {
			// 랜트카 정보와 랜트카 예약정보를 합친 컬럼을 구하는 쿼리문
			String sql = "SELECT * FROM rentcar a2 JOIN car_reserve a1  "
					+ "ON a1.id = ? and curdate() <= date_format(a1.r_day , '%y-%m-%d')"
					+ " and a1.no = a2.no;";
			System.out.println(id);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				// CarViewBean은 예약확인 창에서 보여줄 정보만 담은 객체 -- 차량고유번호 같은 것들은 보여줄 필요없다.
				bean = new CarViewBean();
				
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(4));
				bean.setImg(rs.getString(7));
				// 예약번호 꼭 넣기 - 삭제할 때 필요함
				bean.setReserve_seq(rs.getInt(9));
				bean.setQty(rs.getInt(12));
				bean.setDday(rs.getInt(13));
				bean.setRday(rs.getString(14));
				bean.setUsein(rs.getInt(15));
				bean.setUsewifi(rs.getInt(16));
				bean.setUsenavi(rs.getInt(17));
				bean.setUseseat(rs.getInt(18));		
				v.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {try {conn.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		}
		return v;
	}

	// 예약삭제 메서드 -- 고유넘버를 비교안하면 같은 날짜에 등록학 차량 모두 삭제됨
	public void carRemoveReserve(String id, String rday, int reserve_seq) {

		conn = getConnection();

		try {

			String sql = "DELETE FROM car_reserve WHERE id=? AND r_day=? AND reserve_seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, rday);
			pstmt.setInt(3, reserve_seq);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {try {conn.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
		}
	}
}


















