<%@page import="_04_rentcar.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
		String id = request.getParameter("id");
		String pw1 = request.getParameter("pw1");

		int result = MemberDAO.getInstance().deleteCheck(id, pw1);	
		// 아이디 비밀번호 맞을떄
		if(result == 1){
			MemberDAO.getInstance().deleteMember(id);
	%>
		<script>
			alert("회원 탈퇴 성공!");
			location.href="01_carMain.jsp";
		</script>
	<%		
		}else{
	%>
		<script>
			alert("id와 pw를 확인하세요.");
			history.go(-1);
		</script>
	<%		
		}
	%>
	
	
	
	
	
</body>
</html>