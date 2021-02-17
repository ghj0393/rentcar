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
		String id = (String)session.getAttribute("id");
	
		if(id == null){
	%>
		<script>
			alert("로그인 후 이용가능합니다.");
			history.go(-1);
		</script>
	<%		
		}else{
		// 게시글 작성할 때 ,, 제목, 이메일, 내용	
	%>
		<div align="center">
			<form method="post" action="18_boardWritePro.jsp">
				<h2>게시글 작성</h2>
				<table border="1">
					<tr height="50" align="center">
						<td width="100">제 목</td>
						<td width="1500">
							<input type="text" name="subject" 
							style="width:100%; height:50px;">
						</td>
					</tr>
					<tr height="200" align="center">
						<td width="100">내 용</td>
						<td>
							<textarea rows="20" style="width:100%"
							name="content" >내용</textarea>
						</td>
					</tr>
				</table>
				<tr>
					<td align="center">
						<input type="submit" value="작성하기">
						<input type="reset" value="다시 작성하기">
						<input type="button" value="목록으로" onclick="location.href='01_carMain.jsp?center=16_freeBoard.jsp'">
					</td>
				</tr>
			</form>
		</div>	
	<%		
		}
	%>	
	
	
	
	











</body>
</html>



















