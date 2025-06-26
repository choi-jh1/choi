<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.CommentsDAO" %>

<%
int num = Integer.parseInt(request.getParameter("num"));

	CommentsDAO dao1 = CommentsDAO.getInstance();
	dao1.commentDelete(num);
%>
<script>
	window.location = "../user/qnaContent.jsp";
</script>