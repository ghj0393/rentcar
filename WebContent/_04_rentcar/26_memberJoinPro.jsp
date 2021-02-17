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
	<jsp:useBean id="member" class="_04_rentcar.MemberBean">
		<jsp:setProperty name="member" property="*"/>
	</jsp:useBean>
	
	<%
		int result = MemberDAO.getInstance().checkJoin(member.getId());
		// 아이디 중복일 때 
		if(result == 1){
	%>
		<script>
			alert("중복된 ID입니다.");
			history.go(-1);
		</script>
	<%		
		// 가입 가능할 때
		}else if(result == 0){
			MemberDAO.getInstance().joinMember(member);
	%>
		<script>
			alert("회원가입 성공!");
		</script>
	<%
		}
	%>
	<script>
		location.href="01_carMain.jsp";
	</script>
	
</body>
</html>













