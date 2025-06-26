<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="matPick.bean.QnaDAO" %>
<%@ page import="matPick.bean.QnaDTO" %>


<%
	String path = "D:/cjh/upload";
	int max = 1024*1024*10;
	String enc = "UTF-8";

	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	String title = mr.getParameter("title");
	String img = mr.getFilesystemName("img");
	String writer = mr.getParameter("writer");
	String content = mr.getParameter("content");

	QnaDTO dto = new QnaDTO();
	dto.setTitle(title);
	dto.setImg(img);
	dto.setWriter(writer);
	dto.setContent(content);

	QnaDAO dao = QnaDAO.getInstance();
	int result = dao.boardInsert(dto);
	if (result == 1){ %>
		<script>
			alert("글이 등록되었습니다.");
			window.location="../user/userQnaList.jsp";
		</script>	
<% } %>

