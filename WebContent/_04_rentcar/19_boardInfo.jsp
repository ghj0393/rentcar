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
		// 현재 로그인 중인 id
		String id = (String)session.getAttribute("id");
		// 클릭한 게시글 번호가 넘어옴
		int num = 0;
		num = Integer.parseInt(request.getParameter("num"));
		if(id == null){
	%>
		<script type="text/javascript">
			alert("로그인 후 게시글 조회가 가능합니다.");
			history.go(-1);
		</script>
	<%		
		}else{
			// 자신의 게시글이 아닌 다른 게시글을 클릭했을 경우
			BoardDTO board = BoardDAO.getInstance().getOneBoardInfo(num);
			// checkBoard가 null이 아니면 로그인 한 사람이 해당 게시글을 작성한 사람임
			BoardDTO checkBoard = BoardDAO.getInstance().getCheckOneBoardInfo(id, num);
	%>
		<div align="center">
			<h2>게시글 정보</h2>
			<table border="1">
				<tr height="40">
					<td width="100" align="center">번호</td>
					<td width="100" align="center"><%=board.getNum() %></td>
					<td width="100" align="center">조회수</td>
					<td width="100" align="center"><%=board.getReadCount() %></td>
				</tr>
				<tr height="40">
					<td width="100" align="center">작성자</td>
					<td colspan="3" width="500" align="center"><%=board.getId() %></td>
				</tr>
				<tr height="40">
					<td width="100" align="center">제목</td>
					<td colspan="3" width="500" align="center"><%=board.getSubject() %></td>
				</tr>
				<tr height="40">
					<td width="100" align="center">작성일</td>
					<td colspan="3" width="500" align="center"><%=board.getRegDate() %></td>
				</tr>
				<tr>
					<td width="100" align="center">내용</td>
					<td colspan="3" height="300" width="500" align="center"><%=board.getContent() %></td>
				</tr>
			</table>
		<%
			if(checkBoard != null){
		%>
			<br>
			<input type="button" value="수정하기" onclick="location.href='01_carMain.jsp?center=21_boardUpdate.jsp&num=<%=board.getNum()%>'">
			<input type="button" value="삭제하기" onclick="location.href='01_carMain.jsp?center=23_boardDelete.jsp&num=<%=board.getNum()%>'">
		<%		
			}
		%>			
			<input type="button" value="댓글 작성하기" onclick="location.href='01_carMain.jsp?center=20_replyWrite.jsp&num=<%=board.getNum()%>'">
			<input type="button" value="목록으로" onclick="location.href='01_carMain.jsp?center=16_freeBoard.jsp'">
		</div>
	<%	
		}
	%>
</body>
</html>








