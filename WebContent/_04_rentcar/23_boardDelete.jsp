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
		int num = Integer.parseInt(request.getParameter("num"));
	%>
<div align="center">
	<form method="post" action="24_boardDeletePro.jsp">
		<h2>게시글 삭제</h2>
		<table border="1">
			<tr height="40">
				<td align="center" colspan="2">계정 확인</td>
			</tr>
			<tr height="40">
				<td>PW 확인</td>
				<td>
					<input type="text" name="pw">
				</td>
			</tr>
		</table>
			<br>
			<input type="hidden" value=<%=num %> name="num">
			<input type="submit" value="삭제하기">
			<input type="button" value="목록으로" onclick="location.href='01_carMain.jsp?center=16_freeBoard.jsp'">
	</form>
</div>
</body>
</html>









