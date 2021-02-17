<%@page import="_04_rentcar.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<%
		String pw = request.getParameter("pw");
		int num = Integer.parseInt(request.getParameter("num"));
		
		int result = BoardDAO.getInstance().checkPw(pw, num);
	
		//비밀번호가 틀렸을 경우
		if(result == 0){
	%>
		<script>
			alert("pw를 확인하세요.");
			history.go(-1);
		</script>
	<%		
		}
		// pw가 맞을 경우
		else if(result == 1){
			BoardDAO.getInstance().boardDelete(pw, num);
		}
	%>
	<script type="text/javascript">
		location.href="01_carMain.jsp?center=16_freeBoard.jsp";
	</script>

</body>
</html>










