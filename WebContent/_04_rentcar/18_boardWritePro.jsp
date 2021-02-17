<%@page import="_04_rentcar.MemberBean"%>
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
	
	<jsp:useBean id="board" class="_04_rentcar.BoardDTO">
		<jsp:setProperty name="board" property="*"/>
	</jsp:useBean>
	
	<%
		String id = (String)session.getAttribute("id");
		MemberBean member = BoardDAO.getInstance().getMember(id);
		
		BoardDAO.getInstance().boardWrite(board, member);
	%>
	<script type="text/javascript">
		location.href="01_carMain.jsp?center=16_freeBoard.jsp";
	</script>



</body>
</html>










