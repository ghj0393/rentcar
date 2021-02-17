<%@page import="_04_rentcar.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
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
		// 게시글 총 개수 리턴
		int num = BoardDAO.getInstance().AllBoardCount();
		
		// 전체 게시글 리턴
		//ArrayList<BoardDTO> boardList = BoardDAO.getInstance().getBoardList(startPage);
	%>
<%
	String id=(String)session.getAttribute("id");
	
	int pageSize= 10;
	String pageNum_ = request.getParameter("pageNum");
	int pageNum = 1;
	if(pageNum_ != null){
		pageNum = Integer.parseInt(pageNum_);
	}
	int count = 0;
	int number = 0;
	
	int curPage = pageNum;
	count = BoardDAO.getInstance().getAllCount();
	
	int startRow = (curPage - 1) * pageSize;
	int endRow = curPage * pageSize;
	ArrayList<BoardDTO> boardlist = BoardDAO.getInstance().getAllBoardlist(startRow, endRow);
	
	//number = count - (curPage - 1) * pageSize;
%>
	<div align="center">
		<h2>자유 게시판(<%=num %>개)</h2>
		<table border="1">
			<tr height="40">
				<td width="100" align="center">번호</td>
				<td width="150" align="center">작성자</td>
				<td width="300" align="center">제목</td>
				<td width="300" align="center">작성일</td>
				<td width="100" align="center">조회수</td>
			</tr>
			<%
				for(int i=0; i<boardlist.size(); i++){
					BoardDTO board = boardlist.get(i);
			%>
				<tr height="40">
					<td width="100" align="center">
					<%=board.getNum() %></td>
					<td width="150" align="center">
					<%=board.getId() %></td>
					<td width="300" align="left">
					<%
						for(int j=0; j<board.getReStep()-1; j++){
					%>
							&nbsp;&nbsp;
					<%
						}
					%>	
						<a href="01_carMain.jsp?center=19_boardInfo.jsp&num=<%=board.getNum()%>">
						<%=board.getSubject() %>
						</a>
					</td>
					<td width="300" align="center">
					<%=board.getRegDate() %></td>
					<td width="100" align="center">
					<%=board.getReadCount() %></td>
				</tr>			
			<%		
				}
			%>
			
		</table>
		<tr height="40">
			<td colspan="5" align="center">
			<%
			if(count > 0){
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);	
				int startPage = 1;
				// 1, 11, 21, 31...
				if(curPage % pageSize != 0){
					startPage = (int)(curPage / pageSize) * pageSize + 1;
				}else{
					startPage = ((int)(curPage / pageSize )- 1) * pageSize + 1;
				}
				// 10, 20, 30, 40...
				int endPage = startPage + pageSize - 1;	
				if(endPage > pageCount) endPage = pageCount;
					
				if(startPage > 10){
				%>
					<a href="01_carMain.jsp?center=16_freeBoard.jsp?pageNum=<%= startPage - 10 %>"> [이전] </a>
				<%
				}
				for(int i=startPage; i<=endPage; i++){
				%>
					<a style="<%=(curPage==i?"color: orange;":"")%>" 
					href="01_carMain.jsp?center=16_freeBoard.jsp?pageNum=<%= i %>"> [<%= i %>] </a>
				<%
				}
				if(endPage < pageCount){
				%>
					<a href="01_carMain.jsp?center=16_freeBoard.jsp?pageNum=<%= startPage + 10 %>"> [다음] </a>
				<%
				}
			}
			 %>
				<input type="button" value="게시글 작성" 
				onclick="location.href='01_carMain.jsp?center=17_boardWrite.jsp'">
			</td>
		</tr>	
		
</div>
</body>
</html>











