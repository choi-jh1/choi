<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.UsersDAO" %>
<jsp:useBean class="matPick.bean.UsersDTO" id="dto"/>
<jsp:setProperty name="dto" property="*"/>
<%
	String sid = (String)session.getAttribute("sid");
	String pw = request.getParameter("pw");
	UsersDAO dao = UsersDAO.getInstance();
	boolean result = dao.checkPassword(sid, pw);
	if(result){ 
		response.sendRedirect("userUpdateForm.jsp");
    } else{%>
		<script>
      alert("비밀번호가 일치하지 않습니다.");
      history.back();
   		</script>
<%	}%>