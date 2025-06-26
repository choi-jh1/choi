<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.UsersDAO" %>
<jsp:useBean class = "matPick.bean.UsersDTO" id = "dto" />
<jsp:setProperty name = "dto" property = "*"/>

<%
	String sid = (String)session.getAttribute("sid");
	UsersDAO dao = UsersDAO.getInstance();
	dto.setId(sid);
	Cookie[] cookies = request.getCookies();
	int result = dao.deleteUsers(dto);
	if( result == 1 ){
		session.invalidate();
		for( Cookie c : cookies ){
			if( c.getName().equals("cid") || c.getName().equals("cpw") || c.getName().equals("cauto")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
		
%>
	<script>
		alert("회원탈퇴가 완료되었습니다.");
		window.location="../main/mainPage.jsp";
	</script>
<% 	}else{%>
	<script>
		alert("비밀번호를 확인해주세요.");
		history.go(-1);
	</script>

<% 	}%>