<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.UsersDAO" %>
<% 
	String sid = (String)session.getAttribute("sid");
	UsersDAO dao = UsersDAO.getInstance();
	int result = dao.cancelWithdraw(sid);
	if(result==1){ %>
		<script>
			alert("탈퇴 취소가 되었습니다.");
			window.location="myPage.jsp";
		</script>
<%	}%>