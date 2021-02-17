
<%@page import="_04_rentcar.RentcarDao"%>
<%@page import="_04_rentcar.RentcarBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8"); // 한글 처리
	%>

	<jsp:useBean id="rbean" class="_04_rentcar.CarReserveBean">
		<jsp:setProperty name="rbean" property="*" />
	</jsp:useBean>

	<%
		// 로그인 처리
		String id = (String) session.getAttribute("id");
		if (id == null) {
	%>
		<script type="text/javascript">
			alert("로그인 후 예약이 가능 합니다.");
			location.href = '01_carMain.jsp?center=05_memberLogin.jsp';
		</script>
	<%
		}
	%>
		
	
 <%
 	// 현재 날짜와 대여날짜 비교
	// 날짜 비교
	Date d1 = new Date();
	Date d2 = new Date();
	
	// 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	d1 = sdf.parse(rbean.getRday());	// 이미 new Date().toISOString().substring(0,10);를 통해서 날짜포맷을 했음 -- 대여날짜
	d2 = sdf.parse(sdf.format(d2));		// format() 메서느는 SimpleDateFormat과 같은 역할(yyyy-MM-dd) -- 현재 날짜

	// 날짜비교 메서드 사용
	int compare = d1.compareTo(d2);
	// 예약하려는 날짜가 현재 날짜보다 이전이라면 -1 왼쪽값이 오른쪽 값보다 작으면 음수
	// 예약하려는 날짜와 현재 날짜가 같다면 0
	// 예약하려는 날짜가 현재 날짜보다 이후라면 1을 리턴
	// System.out.println(compare);
	if(compare < 0){
		// 오늘보다 이전 날짜를 선택했을 시
%>
	<script type="text/javascript">
		alert("현재 시스템 날짜보다 이전 날짜는 선택할 수 없음");
		history.go(-1);
	</script>			
<%		
	} 
%> 



<%
 	// 결과적으로 아무런 문제가 없다면 데이터 저장 후 결과 페이지 보여주기
 	// 아이디 값이 빈 클래스에 없기에
 	String id1 = (String)session.getAttribute("id");
 	rbean.setId(id1);
 	
 	// 데이터 베이스에 빈 클래스 저장
 	RentcarDao rdao = RentcarDao.getInstance();
 	rdao.setReserveCar(rbean);
 	
 	// 차량 정보 얻어오기 -- 차량고유 번호 보내서 해당 차량정보 얻기
 	RentcarBean cbean = rdao.getOneCar(rbean.getNo());
 	
 	// 차량 총 금액 = 차량가격 * 차량수량 * 대여일수
 	int totalCar = cbean.getPrice() * rbean.getQty() * rbean.getDday();
 	
 	// 옵션 금액
 	// 선택 시(1), 10,000원 추가 - 하루에 10,000원
 	// userin - 보험
 	int usein = 0;
 	if(rbean.getUsein() == 1){ usein = 10000; }
 	// usewifi - 와이파이
 	int usewifi = 0;
 	if(rbean.getUsewifi() == 1){ usewifi = 10000; }
 	// useseat - 시트
 	int useseat = 0;
 	if(rbean.getUseseat() == 1){ useseat = 10000; }
 	// 네비게이션은 무료임
 	// 옵션 총 가격 = (차량수 * 대여일) * (보험비 + 와이파이비 + 시트비)
 	int totalOption = (rbean.getQty() * rbean.getDday() * (usein + usewifi + useseat));
 %>

	<div align="center">
		<table>
			<tr height="100">
				<td align="center"> 
					<font size="6" color="gray"> 차량 예약 완료 화면 </font> 
				</td>
			</tr>
			<tr height="100">
				<td align="center"> 
					<img src="img/<%= cbean.getImg() %>" width="470" />
				</td>
			</tr>	
			<tr height="50">
				<td align="center">
					<font size="5" color="red"> 차량 총예약 금액 <%= totalCar %> 원 </font>
				</td>
			</tr>
			<tr height="50">
				<td align="center">
					<font size="5" color="red"> 차량 총옵션 금액 <%= totalOption %> 원 </font>
				</td>
			</tr>			
			<tr height="50">
				<td align="center">
					<font size="5" color="red"> 차량 총 금액 <%= totalOption + totalCar %> 원 </font>
				</td>
			</tr>	
		</table>
	</div>
</body>
</html>











