<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.UsersDAO" %>
<%@ page import = "matPick.bean.UsersDTO" %>

<%
	UsersDAO dao = UsersDAO.getInstance();
	String email = request.getParameter("email");  // 받는 값이 email 하나 이므로 setProperty 대신 파라미터로 값을 받아옴
	UsersDTO dto = dao.findId(email); // dao에서 이 메서드의 리턴타입은 UsersDTO
	

	if(dto == null){ // email과 일치하는 아이디가 없을 경우 %>
		<script>
			alert("가입된 아이디가 없습니다.");
			history.go(-1);
		</script>
<%	}else{ // email과 일치하는 아이디가 있을 때%>
		<script>
			alert("고객님의 정보와 일치하는 아이디는 <%=dto.getId()%>입니다.");
			window.location="../user/loginForm.jsp";
		</script>
<%  } %>

