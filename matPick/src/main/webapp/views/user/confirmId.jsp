<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.UsersDAO"%>
<jsp:useBean class="matPick.bean.UsersDTO" id="dto"/>
<jsp:setProperty name="dto" property="*"/>

<%
	UsersDAO dao = UsersDAO.getInstance();
	boolean result = dao.confirmId(dto.getId());
	if(result == true){ // 이미 존재하는 아이디일 경우
%>
	<script>
		opener.document.getElementById("idResult").innerHTML="<font color = 'red'>사용 불가능한 아이디입니다.</font>";
		self.close();
	</script>	
<%  }else{%>
	<script>
		opener.document.getElementById("idResult").innerHTML="<font color = 'orange'>사용 가능한 아이디입니다.</font>";
		self.close();
	</script>

<%  }%> 