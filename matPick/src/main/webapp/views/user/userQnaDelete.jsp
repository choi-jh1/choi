<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.QnaDAO" %>
<jsp:useBean class="matPick.bean.QnaDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />
<%@ page import="java.io.File" %>
<%	request.setCharacterEncoding("UTF-8");%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	QnaDAO dao = QnaDAO.getInstance();
	String imgName = dao.imgDelete(num);
	
	String filePath = request.getRealPath("D:/cjh/upload");
	File f = new File(filePath+"/"+imgName);
	f.delete();
%>
<script>
	alert("글이 삭제되었습니다.");
	window.location="userQnaList.jsp?pageNum=<%=pageNum%>";
</script>