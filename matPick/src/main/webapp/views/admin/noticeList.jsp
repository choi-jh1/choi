<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.NoticeDAO" %>
<%@ page import="matPick.bean.NoticeDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>MAT.PICK</title>
	<link rel="stylesheet" type="text/css" href="../resources/login.css"> 
	<style>
	        .nav {
      display: flex;
      gap: 40px;
    }
      .nav h1 {
     font-size: 24px;        /* 기존 20px → 24px */
     font-weight: bold;      /* 굵게 */
     margin: 0;
     cursor: pointer;
     padding: 0 10px;        /* 좌우 여백 */
     transition: color 0.2s;
   }
   .nav h1:hover {
     color: #00c73c;         /* 마우스 오버 시 강조 색상 */
   }
	.container {
	    max-width: 1000px;
	    margin: 0 auto;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
    }

    .header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    width: 100%;
	    padding: 30px;
	    border-bottom: 2px solid black;
	    box-sizing: border-box;
    }
    .logo {
      width: 180px;
      cursor: pointer;
    }
    
    body {
    	font-family: 'Arial', sans-serif;
      background: url('../resources/bgImg.png') no-repeat center center fixed;
      background-size: cover;
      margin: 0;
      padding: 0;
    }
    .footer {
	      margin-top: 20px;
	      text-align: center;
	      border-top: 2px solid black;
	      padding: 15px;
	      width: 100%;
	
    }
    
   .join-box {
      display: flex;
      justify-content: space-between;
      gap: 6px;   
  }
    .cate {
    	cursor: pointer;
    }
    .notice td{
    	background-color:white;
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
    .posts {
	  width: 100%;
	  background: none;
    }
    .list {
      width: 100%;
      border-collapse: collapse;
    }
    .list th, .list td {
      padding: 10px;
      text-align: center;
      border: 1px solid black;
      border-left: none;
	  border-right: none;
	  border-bottom: 1px solid #bbb;
    }
    .list th {
      background-color: #f9967a;
      
 	}
	</style>

</head>
<body>
<%
	String sid = (String)session.getAttribute("sid");
	String role = (String)session.getAttribute("role");
	// 사용자 접근 제한
	if(role==null || !role.equals("admin")){
	%>
		<script>
			alert("접근할수 없습니다.");
			window.location="../main/mainPage.jsp";
		</script>
	<%	}
	
	NoticeDAO dao = NoticeDAO.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	ArrayList<NoticeDTO> list = dao.noticeList();
	int count = dao.noticeCount();
%>
<div class="container">
  <div class="header">
    <img src="../resources/logo.png" alt="로고" class="logo" onclick="window.location='../main/mainPage.jsp'">
    <div class="nav">
      <h1 onclick="location.href='../admin/userList.jsp'">유저목록</h1>
      <h1 onclick="location.href='../admin/noticeList.jsp'">공지사항</h1>
      <h1 onclick="location.href='adminQnaList.jsp'">건의/문의</h1>
    </div>
		<div class="login-box">
			<div><strong><%=sid %>님, 환영합니다.</strong></div>
			<button class="login-main" onclick="window.location='../admin/userList.jsp'">관리자페이지</button>
			<button class="login-main" onclick="window.location='../user/logout.jsp'">로그아웃</button>
		</div>
  </div>


<table width=1000 align=center>
	<tr>
		<td>
			공지사항 수 : <%=count %>
		</td>
		<td align=right valign=bottom>
			<div class="btn-group">
			<button onclick="window.location='noticeForm.jsp'">글쓰기</button>
			</div>
		</td>
	</tr>
</table>

    <div class="posts">
      <table class="list">
        <thead>
          <tr>
            <th>번호</th>
            <th>공지사항 제목</th>
            <th>작성자</th>
            <th>등록일</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody>
          <%
          	for(NoticeDTO dto : list){ %>
          <tr align=center >
		<td width=60><%=dto.getType() %></td>
		<td>
			<a href="noticeContent.jsp?num=<%=dto.getNum()%>">
				<strong><%=dto.getTitle() %></strong>
			</a>
		</td>
		<td width=100><%=dto.getWriter() %></td>
		<td width=200><%=sdf.format(dto.getReg())%></td>
		<td align=center width=150>
			<div class="btn-group" style="text-align:center">
			<button onclick="window.location='../admin/noticeUpdate.jsp?num=<%=dto.getNum() %>'" >수정</button>
			<button onclick="confirmDelete(<%=dto.getNum() %>)" >삭제</button>
			</div>
		</td>
	</tr>
          <% } %>
        </tbody>
      </table>
    </div>



   <div class="footer" style="text-align: center; font-size: 12px; color: #666; padding: 20px 0;">
     <p>© 2025 MAT.PICK Team. Designed & Developed by 수한, 석범, 정환, 재희</p>
     <p>
       <a href="#" style="color: #999; margin-right: 10px;">이용약관</a> |
       <a href="#" style="color: #999;">개인정보처리방침</a>
     </p>
     <p style="font-size: 11px; color: #aaa;">프로젝트 기간: 2025.06.02 ~ 2025.06.23 | Ver. 1.0</p>
   </div>
</div>
<script>
	function confirmDelete(num){
		// 확인은 true 취소는 false
		const isConfirm = confirm("삭제하시겠습니까?");
		
		if(isConfirm){
			window.location="noticeDelete.jsp?num="+num;
		}
	}
</script>
</body>
</html>
