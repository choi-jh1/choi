<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.QnaDAO"%>
<%@ page import = "matPick.bean.CommentsDAO" %>
<%@ page import = "java.io.File"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
	QnaDAO dao = QnaDAO.getInstance();
	String imgName = dao.imgDelete(num);
	String filePath = "D:/cjh/upload";
	File f = new File(filePath+"/"+imgName);
	f.delete();
	
%>
<script>
	alert("글이 삭제되었습니다.");
	window.location = "userQnaList.jsp";
</script>