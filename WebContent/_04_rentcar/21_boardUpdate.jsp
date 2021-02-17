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
	<%
		// 게시글번호
		int num = Integer.parseInt(request.getParameter("num"));
		BoardDTO board = BoardDAO.getInstance().getUpateBoard(num);
	%>	
	<div align="center">
		<form method="post" action="22_boardUpdatePro.jsp">
			<h2>게시글 수정</h2>
			<table border="1">
				<tr height="40">
					<td width="100" align="center">번호</td>
					<td width="100" align="center"><%=board.getNum() %></td>
					<td width="100" align="center">조회수</td>
					<td width="100" align="center"><%=board.getReadCount() %></td>
				</tr>
				<tr height="40">
					<td width="100" align="center">작성자</td>
					<td width="500" align="center"><%=board.getId() %></td>
					<td width="100" align="center">비밀번호 확인</td>
					<td width="500" align="center">
						<input style="width:100%; height:50px; type="text" name="pw">
					</td>
				</tr>
				<tr height="40">
					<td width="100" align="center">제목</td>
					<td colspan="3" width="500" align="center">
						<input style="width:100%; height:50px; type="text" name="subject" value=<%=board.getSubject() %>>
					</td>
				</tr>
				<tr height="40">
					<td width="100" align="center">작성일</td>
					<td colspan="3" width="500" align="center"><%=board.getRegDate() %></td>
				</tr>
				<tr>
					<td width="100" align="center">내용</td>
					<td colspan="3" height="300" width="500">
						<textarea rows="20" style="width:100%" name="content">
							<%=board.getContent() %>
						</textarea>
					</td>
				</tr>
			</table>
			<input type="hidden" value=<%=board.getNum() %> name="num">
			<input type="submit" value="수정하기">
			<input type="button" value="목록으로" onclick="location.href='01_carMain.jsp?center=16_freeBoard.jsp'">
		</form>
	</div>
</body>
</html>