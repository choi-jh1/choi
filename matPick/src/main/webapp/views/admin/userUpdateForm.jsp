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
    select{
    	width:60px;
    	height:20px;
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
	if(role==null || !role.equals("admin")){%>
		<script>
			alert("접근할수 없습니다.");
			window.location="../main/mainPage.jsp";
		</script>
<%	}

	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO dto = dao.userInfo(id);
%>

<center><h3><%=id %>님 정보</h3></center>
<form action="userUpdatePro.jsp?id=<%=id %>" method="post">
	<table>
		<tr height=40 >
			<th >아이디</th>
			<td><%=id %></td>
		</tr>
		<tr height=40>
			<th>비밀번호</th>
			<td><input type="password" name="pw" value="<%=dto.getPw() %>" /></td>
		</tr>
		<tr height=40>
			<th >닉네임</th>
			<td><input type="text" name="nick" value="<%=dto.getNick()%>"/></td>
		</tr>
		<tr height=40>
			<th >이름</th>
			<td><%=dto.getName() %></td>
		</tr>
		<tr height=40>
			<th >이메일</th>
			<td><input type="text" name="email" value="<%=dto.getEmail() %>"/></td>
		</tr>
		<tr height=40>
			<th >생년월일</th>
			<td><%=sdf.format(dto.getBirth_date()) %></td>
		</tr>
		<tr height=40>
			<th >상태</th>
			<td>
				<select name="status" >
					<option value="active">정상</option>
					<option value="suspended">정지</option>
					<option value="delete">삭제</option>
				</select>
			</td>
		</tr>
	</table>


<div class="btn-group" style="text-align:center">
	<button type="button" onclick="window.close()">닫기</button>
	<button type="submit">완료</button>
</div>
</form>