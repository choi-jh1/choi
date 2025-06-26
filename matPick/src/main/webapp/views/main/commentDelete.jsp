<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.CommentsDAO" %>


<%
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));
	int num = Integer.parseInt(request.getParameter("num"));

	CommentsDAO dao = CommentsDAO.getInstance();
	int result = dao.commentDelete(commentNum);
	
	if(result==1){%>
		<script>
			window.location="boardContent.jsp?num=<%=num%>";
		</script>
<%	}
%>