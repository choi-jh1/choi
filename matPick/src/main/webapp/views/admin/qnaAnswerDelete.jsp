<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.QnaAnswerDAO" %>
<%@ page import="matPick.bean.QnaAnswerDTO" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));

	QnaAnswerDAO dao = QnaAnswerDAO.getInstance();
	int result = dao.deleteAnswer(num,qnaNum);
	
	if(result==1){%>
		<script>
			window.location="../user/qnaContent.jsp?num=<%=num%>";
		</script>
<%	}
%>