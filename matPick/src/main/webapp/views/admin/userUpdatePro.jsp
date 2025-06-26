<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.UsersDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class="matPick.bean.UsersDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />

<%
	String id = request.getParameter("id");
	UsersDAO dao = UsersDAO.getInstance();
	int result = dao.userUpdate(dto,id);
	
	if(result == 1){	%>
		<script>
			alert("수정되었습니다.");
			if(window.opener){
				window.opener.location.reload();
			}
			window.close();
		</script>
		<%
		
	}
%>