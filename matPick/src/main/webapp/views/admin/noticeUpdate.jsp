<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.NoticeDAO" %>
<%@ page import="matPick.bean.NoticeDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>MAT.PICK</title>
	    <!-- jQuery -->
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
     <!-- Summernote -->
     <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
     <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
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
    .login-box {
      border: 2px solid black;
      padding: 15px;
      font-size: 12px;
      width: 140px;
    }

    .login-box input {
      width: 100%;
      margin-bottom: 5px;
      padding: 2px;
    }

    .login-box button, .login-box a {
      font-size: 12px;
      width: 100%;
      margin-top: 5px;
    }
    .login-main {
     margin-top: 5px;
     margin-bottom: 5px;
     width: 100%;
     padding: 6px;
     background-color: #f9967a;
     color: black;
     border: none;
     border-radius: 4px;
     font-weight: bold;
     cursor: pointer;
   }
   .login-sub {
     flex: 1;
     padding: 6px 0px;
     background-color: #f9967a;
     color: black;
     border: none;
     border-radius: 4px;
     font-size: 12px;
     cursor: pointer;
   }    
   .join-box {
      display: flex;
      justify-content: space-between;
      gap: 6px;   
  }
    .cate {
    	cursor: pointer;
    }
		.write{
		border-collapse:collapse;
		border:1px solid black;
		width:800px;
		align:center;
		height:800px;
	}
	.write td {
    	border:1px solid black;
    }
    .input-title{
    	width: 100%;
    	height:100%;
    	box-sizing: border-box;
    	font-size:24px;
    }
    .input-content{
    	width: 100%;
    	height:100%;
    	box-sizing: border-box;
    	font-size:18px;
    }
    .write td:first-child{
    	background-color:#d3d3d3;
    }
       .note-editable {
         resize: none !important;   /* 크기 조절 막기 */
         overflow: auto;            /* 필요시 스크롤 */
    }
    .note-resizebar{
          display: none !important;
    }
     
        .write-box {
    width: 100%;
    max-width: 800px;
    margin: auto;
    box-sizing: border-box;
  }
      .posts {
      flex: 5;
      border: 2px solid black;
      padding: 10px;
      background: white;
      
    }
    	.title-font{
		width:750px;
		height:50px;
		font-size:30px;
		border:1px solid black;
		font-weight: bold;
	}
		.notice{
		font-size:30px;
		height:50px;
		font-weight: bold;
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


	int num = Integer.parseInt(request.getParameter("num"));
	
	NoticeDAO dao = NoticeDAO.getInstance();
	
	NoticeDTO dto = dao.noticeInfo(num);
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
		</div>>
  </div>


      <div class="posts">
	  <div class="write-box">
    <form action="noticeUpdatePro.jsp?num=<%=num %>" method="post" >
        <!-- 카테고리 선택 -->
        <div class="notice">
      	<center>[공지 수정]</center>
		</div>
		<hr width=700 color=black>

        <!-- 제목 -->
        <input type="text" name="title" placeholder="제목을 입력하세요" required class="title-font" value="<%= dto.getTitle()%>" />
        <!-- 작성자 (세션) -->
        <input type="hidden" name="writer" value="<%=sid %>">

        <!-- 내용 -->
        <textarea id="summernote" name="content"><%=dto.getContent() %></textarea>

        <div class="form-actions">
        	<div class="btn-group" style="text-align:center; padding: 20px 0;">
	            <button type="button" onclick="history.back()">취소</button>
				<button type="submit">등록</button>
			</div>
        </div>
    </form>
	</div>	  
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
     $(document).ready(function () {
       $('#summernote').summernote({
         height: 800,
         placeholder: '내용을 입력하세요...',
         lang: 'ko-KR'
       });
     });
   </script>
</body>
</html>
    