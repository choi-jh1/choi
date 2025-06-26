<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.UsersDAO"%>
<%@ page import = "matPick.bean.UsersDTO"%>
<%@ page import = "matPick.bean.MailUtil" %>
<%
	String email = request.getParameter("email");
	String id = request.getParameter("id");
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO dto = dao.findPw(email, id);
	if(dto != null){ // 일치하는 값이 있을경우 -> 임시 비밀번호 생성 -> 메일로 전송 -> db에 업데이트하는 로직
		String tempPw = dao.generateTempPw(); // 임시 비밀번호 생성
		dao.updatePw(id, email, tempPw); 	  // db에 임시 비밀번호로 업데이트
		MailUtil.sendTempPw(email, tempPw);
%>	
	<script>
		alert("임시 비밀번호가 발송되었습니다.");
		window.location="../user/loginForm.jsp";
	</script>

	
<%	}else{%>
	<script>
		alert("일치하는 회원정보가 없습니다.");
		history.go(-1);
	</script>
<% }%>

