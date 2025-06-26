<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.CommentsDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class="matPick.bean.CommentsDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />

<%

	int num = Integer.parseInt(request.getParameter("num"));
	CommentsDAO dao = CommentsDAO.getInstance();
	int result = dao.commentInsert(dto);
	
	if(result==1){%>
		<script>
			window.location="boardContent.jsp?num=<%=num%>";
		</script>
<%	}%>