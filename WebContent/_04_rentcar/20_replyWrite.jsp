<%@page import="_04_rentcar.BoardDTO"%>
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
		int num = Integer.parseInt(request.getParameter("num"));
		BoardDTO bean = BoardDAO.getInstance().getUpateBoard(num);
		
		int ref = bean.getRef();
		int re_step =  bean.getReStep();
		int re_level = bean.getReLevel();
		
	%>
	<br><br>
	<h2>댓글 작성하기</h2>
	<form action="20_replyWritePro.jsp" method="post" accept-charset="UTF-8" >
		<table border="1" style="border-collapse:collapse;">
			<tr height="50">
				<th width="200" align="center"> 작성자 </th>
				<td width="400"> <%=bean.getId() %> </td>
			</tr>
			<tr height="50">
				<th width="200" align="center"> 제목 </th>
				<td width="400"> <input type="text" name="subject" value="[답변]" size="50"> </td>
			</tr>
			<tr height="50">
				<th width="200" align="center"> 비밀번호 </th>
				<td width="400"> <input type="password" name="pw" size="20"> </td>
			</tr>
			<tr height="50">
				<th width="200" align="center"> 내용 </th>
				<td width="400"> <textarea rows="10" cols="50" name="content"></textarea> </td>
			</tr>
		
			<tr height="40">
				<td align="center" colspan="2">
					<input type="hidden" name="ref" value=<%= ref %>>
					<input type="hidden" name="re_step" value=<%= re_step %>>
					<input type="hidden" name="re_level" value=<%= re_level %>>
					<input type="hidden" name="id" value=<%= bean.getId() %>>
					<input type="submit" value="답글쓰기"> &nbsp;
					<input type="reset" value="다시쓰기">&nbsp;
					<input type="button" onclick="location.href='01_carMain.jsp?center=09_carAllList.jsp'" value="전체글보기" />
				</td>			
			</tr>
		</table>
	</form>
	<br><br>
</body>
</html>