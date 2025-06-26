<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "matPick.bean.UsersDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class = "matPick.bean.UsersDTO" id = "dto" />
<jsp:setProperty name = "dto" property= "*" />

<%
	String birth = request.getParameter("birth_date");
	if(birth != null && !birth.isEmpty()) {
		dto.setBirth_date(birth);
	}
	
	UsersDAO dao = UsersDAO.getInstance();
	int result = dao.insertUsers(dto);
	if(result != 1){ %>
		<script>
			alert("다시 작성해주세요");
			history.go(-1);
		</script>
<% 	}else{ %>
		<script>
			alert("회원가입 되었습니다");
			window.location="../main/mainPage.jsp";
		</script>	
<%	} %>