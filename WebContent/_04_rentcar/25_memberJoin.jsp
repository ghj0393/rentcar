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
	<form method="post" action="26_memberJoinPro.jsp">
		<h2>회원가입</h2>
		<table border="1">
			<tr>
				<td >ID</td>
				<td>
					<input type="text" name="id"/>
				</td>
			</tr>
			<tr>
				<td>PW</td>
				<td>
				<input type="text" name="pw1"/>
				</td>
			</tr>
			<tr>
				<td>email</td>
				<td>
				<input type="email" name="email"/>
				</td>
			</tr>
			<tr>
				<td>tel</td>
				<td>
				<input type="number" name="tel"/>
				</td>
			</tr>
			<tr>
				<td>hobby</td>
				<td>
					<input type="text" name="hobby"/>
				</td>
			</tr>
			<tr>
				<td>job</td>
				<td>
					<input type="text" name="job"/>
				</td>
			</tr>
			<tr>
				<td>age</td>
				<td>
					<input type="number" name="age"/>
				</td>
			</tr>
			<tr>
				<td>info</td>
				<td>
					<input type="text" name="info"/>
				</td>
			</tr>
		</table>
		<br>
		<input type="submit" value="회원가입">
		<input type="reset" value="다시작성">
		<input type="button" value="메인으로" onclick="location.href='01_carMain.jsp'"> 
	</form>
</div>
</body>
</html>