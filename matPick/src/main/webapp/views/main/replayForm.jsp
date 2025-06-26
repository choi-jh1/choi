<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<style>
        }
    .btn-group {
      text-align: right;
      width: 100%;
 
    }
    .btn-group button {
      background-color: #f9967a;
      color: black;
      border: none;
      padding: 8px 14px;
      border-radius: 6px;
      margin-left: 10px;
      cursor: pointer;
    }
 </style>
<%
	String sid = (String)session.getAttribute("sid");


	int num = Integer.parseInt(request.getParameter("num"));
	int ref = Integer.parseInt(request.getParameter("ref"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));
%>
<form action="replayPro.jsp" method="post">
	<input type="hidden" name="commentNum" value="<%=commentNum %>" /> 
	<input type="hidden" name="ref" value="<%=ref %>" /> 
	<input type="hidden" name="re_level" value="<%=re_level %>" />
	<input type="hidden" name="re_step" value="<%=re_step %>" />
	<input type="hidden" name="writer" value="<%=sid %>" />
	<input type="hidden" name="num" value="<%=num %>" />
	작성자 : <%=sid %><br>
	<textarea name="content" cols=22 rows=8></textarea>

	<div class="button-group">
		<button type="submit">등록</button>
		<button type="button" onclick="window.close()" >취소</button>
	</div>

</form>