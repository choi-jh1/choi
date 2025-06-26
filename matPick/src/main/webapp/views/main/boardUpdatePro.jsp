<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.ContentDAO" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class="matPick.bean.ContentDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />
<%
	String pageNum = request.getParameter("pageNum");
	ContentDAO dao = ContentDAO.getInstance();
	int result = dao.contentUpPro(dto);
	
	if( result == 1 ) { 
%>
	<script>
		alert("글이 수정되었습니다.");
		window.location="../main/mainPage.jsp"
	</script>
<%	} else {	%>
	<script>
		alert("글이 수정되지 않았습니다.");
		history.go(-1);
	</script>
<%	}	%>
