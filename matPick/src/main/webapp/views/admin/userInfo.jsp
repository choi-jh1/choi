<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="matPick.bean.UsersDAO" %>
<%@ page import="matPick.bean.UsersDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<style>
	table{
		margin-left:50px;
		border-collapse:collapse;
		border:1px solid black;
		width:300px;
		align:center;
		margin-bottom:10px;
	}
	th, td {
    	border: 1px solid #ddd;
    	padding-left:10px;
    }
    th{
    	align:left
    	width:100px;
    	background-color:#f9967a;
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
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String id = request.getParameter("id");
	String role = (String)session.getAttribute("role");
	// 사용자 접근 제한
	if(role==null || !role.equals("admin")){
	%>
		<script>
			alert("접근할수 없습니다.");
			window.location="../main/mainPage.jsp";
		</script>
<%	}
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO dto = dao.userInfo(id);
%>

<center><h3><%=id %>님 정보</h3></center>
<table>
	<tr height=40 >
		<th >아이디</th>
		<td><%=id %></td>
	</tr>
	<tr height=40>
		<th >닉네임</th>
		<td><%=dto.getNick() %></td>
	</tr>
	<tr height=40>
		<th >이름</th>
		<td><%=dto.getName() %></td>
	</tr>
	<tr height=40>
		<th >이메일</th>
		<td><%=dto.getEmail() %></td>
	</tr>
	<tr height=40>
		<th >생년월일</th>
		<td><%=sdf.format(dto.getBirth_date()) %></td>
	</tr>
	<tr height=40>
		<th >상태</th>
		<td><%if((dto.getStatus()).equals("active")){%>
				정상
<% 			}else if((dto.getStatus()).equals("suspended")){%>
				정지
<%			}else{%>
				탈퇴
<%			}%>
		</td>
	</tr>
</table>

<div class="btn-group" style="text-align:center">

	<button onclick="window.close()">닫기</button>
	<button onclick="window.location='userUpdateForm.jsp?id=<%=id%>'">회원정보 수정</button>
</div>