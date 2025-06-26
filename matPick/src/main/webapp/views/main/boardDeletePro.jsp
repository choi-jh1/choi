<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.ContentDAO" %>
<jsp:useBean class="matPick.bean.ContentDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />
<%	request.setCharacterEncoding("UTF-8");%>
<%
	int num = dto.getNum();
	String pageNum = request.getParameter("pageNum");
	
	ContentDAO dao = ContentDAO.getInstance();
	int result = dao.ContentDelete(num);
	
	if( result == 1 ) {
%>	<script>
		alert("글 삭제 완료");
		window.location="../main/mainPage.jsp";
	</script>
<%	} else {	%>
	<script>
		alert("글 삭제 실패");
		history.go(-1);
	</script>
<%	}	%>