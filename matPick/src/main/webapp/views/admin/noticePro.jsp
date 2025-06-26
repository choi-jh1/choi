<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.NoticeDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class="matPick.bean.NoticeDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />

<%
	

	NoticeDAO dao = NoticeDAO.getInstance();
	int result = dao.insertNotice(dto);
	
	if(result == 1){ %>
		<script>
			alert("작성이 완료되었습니다.");
			window.location="noticeList.jsp";
		</script>
<%	}
%>
