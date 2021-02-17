<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<form method="post" action="28_memberDeletePro.jsp">
		<h2>회원 탈퇴</h2>
		<table border="1">
			<tr>
				<td>ID 확인</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>PW 확인</td>
				<td><input type="text" name="pw1"></td>
			</tr>
		</table>
		<br>
		<input type="submit" value="삭제하기">
		<input type="button" value="메인으로" onclick="location.href='01_carMain.jsp'">
	</form>
</div>
</body>
</html>