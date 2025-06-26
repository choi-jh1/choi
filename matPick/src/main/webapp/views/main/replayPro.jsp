<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="matPick.bean.CommentsDAO" %>
<jsp:useBean class="matPick.bean.CommentsDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />

<%
	int num = Integer.parseInt(request.getParameter("num"));

	CommentsDAO dao = CommentsDAO.getInstance();
	int result = dao.commentInsert(dto);
	
	if(result==1){%>
		<script>
		if(window.opener){
			window.opener.location.reload();
		}
		window.close();
		</script>
	<%	}%>
%>