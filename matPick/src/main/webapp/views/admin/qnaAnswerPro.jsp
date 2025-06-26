<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="matPick.bean.QnaAnswerDAO" %>
<jsp:useBean class="matPick.bean.QnaAnswerDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />

<%
	int num = Integer.parseInt(request.getParameter("num"));

	QnaAnswerDAO dao = QnaAnswerDAO.getInstance();
	int result = dao.answerInsert(dto,num);
	
	if(result == 1 ){	%>
		<script>
			window.location="../user/qnaContent.jsp?num=<%=num%>";
		</script>
	<%}%>