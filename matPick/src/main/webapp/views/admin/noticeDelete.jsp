<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.NoticeDAO" %>

<%
	//파라미터
	int num = Integer.parseInt(request.getParameter("num"));
	
	// 객체 생성
	NoticeDAO dao = NoticeDAO.getInstance();
	int result = dao.noticeDelete(num);
	if(result==1){
%>
		<script>
			alert("삭제가 완료되었습니다.");
			window.location='noticeList.jsp';
		</script>
<%	}%>