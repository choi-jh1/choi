    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 	request.setCharacterEncoding("UTF-8"); %>
<%@ page import="matPick.bean.ContentDAO" %>
<jsp:useBean class="matPick.bean.ContentDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />

<%
	ContentDAO dao = ContentDAO.getInstance();
	String sid =(String)session.getAttribute("sid");
	


	
	// DB 작업
	int result = dao.contentInsert(dto);
	
	if( result == 1 ) {
%>		<script>
			alert("게시글 등록 완료");
			window.location="mainPage.jsp";
		</script>
<%	} else {	%>
		<script>
			alert("게시글 등록 실패");
			history.go(-1);
		</script>
<%	} %>
