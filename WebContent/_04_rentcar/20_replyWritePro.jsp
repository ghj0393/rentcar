<%@page import="_04_rentcar.BoardDAO"%>
<%@page import="_04_rentcar.BoardDTO"%>
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
	request.setCharacterEncoding("UTF-8");
%>

<%
	int ref = Integer.parseInt(request.getParameter("ref"));
	int reStep = Integer.parseInt(request.getParameter("re_step"));
	int reLevel = Integer.parseInt(request.getParameter("re_level"));
	String id = request.getParameter("id");
	String subject = request.getParameter("subject");
	String pw = request.getParameter("pw");
	String content = request.getParameter("content");
	
	BoardDTO dto = new BoardDTO();
	
	dto.setRef(ref);
	dto.setReStep(reStep);
	dto.setReLevel(reLevel);
	dto.setId(id);
	dto.setSubject(subject);
	dto.setPw(pw);
	dto.setContent(content);

	BoardDAO.getInstance().writeAnswer(dto);
	response.sendRedirect("01_carMain.jsp?center=16_freeBoard.jsp");

%>
</body>
</html>