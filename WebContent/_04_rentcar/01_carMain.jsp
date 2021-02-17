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
	<%
		String center = request.getParameter("center");
		if(center == null){	
			center = "04_center.jsp";		
		}
		String check = request.getParameter("num");
		int num = 0;
		if(check != null){
			num = Integer.parseInt(check);
		}
		String pageNum_ = request.getParameter("pageNum");
		int pageNum = 1;
		if(pageNum_ != null){
			pageNum = Integer.parseInt(pageNum_);
		}
	%>

	<table>
		<%-- top 부분 --%>
		<tr height="120" align="center">
			<td align="center" width="1000">
				<jsp:include page="02_top.jsp" />
			</td>
		</tr>
		<%-- center 부분 --%>
		<tr align="center">
			<td align="center" width="1000">
				<jsp:include page="<%=center %>">
					<jsp:param name="num" value="<%=num %>" />
					<jsp:param name="pageNum" value="<%=pageNum %>" />
				</jsp:include>
			</td>
		</tr>
		<%-- bottom 부분 --%>
		<tr height="100" align="center">
			<td align="center" width="1000">
				<jsp:include page="03_bottom.jsp" />
			</td>
		</tr>
	</table>
</div>
</body>
</html>