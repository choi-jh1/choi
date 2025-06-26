<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.UsersDAO" %>
<%@ page import="matPick.bean.ContentDAO" %>
<%@ page import="matPick.bean.ContentDTO" %>
<%@ page import="java.util.ArrayList" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class = "matPick.bean.UsersDTO" id = "dto" />
<jsp:setProperty name = "dto" property = "*"/>
<!-- jQuery -->
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
     <!-- Summernote -->
     <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
     <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<head>
  <meta charset="UTF-8" />
  <title>MAT.PICK</title>
  <link rel="stylesheet" type="text/css" href="../resources/login.css"> 
<style>
	    body {
	      font-family: 'Arial', sans-serif;
	      background: url('../resources/bgImg.png') no-repeat center center fixed;
	      background-size: cover;
	      margin: 0;
	      padding: 0;
	    }

		        .write-box {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            box-sizing: border-box;
        }

        .write-box h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .write-box select,
        .write-box input[type="text"],
        .write-box textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 16px;
        }

        .write-box button {
            padding: 10px 20px;
            background-color: #f9967a;
            color: black;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
		 
		 
		 
		 
        .note-editable {
            resize: none !important;
        }

        .note-resizebar {
            display: none !important;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
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

    .search-box {
      display: flex;
      align-items: center;
      border: 2px solid black;
      padding: 5px;
      width: 500px;
      height: 32px;
      margin: 0 30px;
    }

    .search-box input {
      border: none;
      outline: none;
      width: 100%;
      font-size: 14px;
    }

    .search-box img {
      width: 16px;
      height: 16px;
      margin-right: 6px;
    }

    .category-buttons {
      display: flex;
      justify-content: center;
      gap: 40px;
      margin: 40px 0;
      width: 100%;
    }
    .join-box {
      display: flex;
      justify-content: space-between;
      gap: 6px; 
      	
    }

    .category-buttons button {
      padding: 30px 45px;
      border: 2px solid black;
      font-size: 18px;
      background-color: white;
      cursor: pointer;
    }
	  .write-box * {
	    box-sizing: border-box;
	  }
	
	  .write-box input[type="text"],
	  .write-box select,
	  .write-box textarea,
	  .write-box .note-editor {
	    width: 100%;
	    font-size: 16px;
	    padding: 10px;
	    margin-bottom: 15px;
	  }
    .post-area {
      display: flex;
      width: 100%;
    }

    .posts {
      flex: 5;
      border: 2px solid black;
      border-radius: 12px;
      padding: 10px;
      background: white;
    }

    .posts-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }

    .post-tabs button {
      margin-right: 1px;
      font-size: 14px;
      padding: 5px 10px;
    }

    .write-controls {
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .write-controls select {
      font-size: 14px;
    }

    .write-controls button {
      font-size: 14px;
      padding: 5px 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }

    th, td {
      border: 1px solid black;
      text-align: center;
      padding: 5px;
    }

    .sidebar {
      flex: 1;
      border: 2px solid black;
      margin-left: 10px;
      padding: 10px;
      background: white;
    }

    .activity-title {
      font-weight: bold;
      border-bottom: 1px solid black;
      padding-bottom: 5px;
    }

    .activity-list {
      list-style: circle;
      padding-left: 25px;
      margin: 10px 0;
    }

    .congrats-btn {
      display: block;
      margin-top: 10px;
      font-size: 14px;
      width: 100%;
      background: white;
      border: 2px solid black;
      cursor: pointer;
    }

    .search-bottom {
      border: 2px solid black;
      margin: 20px 0;
      padding: 5px;
      display: flex;
      align-items: center;
      gap: 5px;
      background: white;
      width: 100%;
    }

    .search-bottom select, .search-bottom input {
      font-size: 14px;
      padding: 4px;
    }

    .search-bottom input {
      width: 100%;
      border: none;
    }

    #writeForm {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      border: 2px solid black;
      padding: 20px;
      background-color: white;
      z-index: 999;
      width: 400px;
    }

    #writeForm input, #writeForm select, #writeForm textarea {
      width: 100%;
      margin-bottom: 8px;
      padding: 5px;
      font-size: 14px;
    }

    #writeForm button {
      width: 48%;
      padding: 8px;
      margin-top: 5px;
    }

    #writeForm .buttons {
      display: flex;
      justify-content: space-between;
    }

    .footer {
      margin-top: 20px;
      text-align: center;
      border-top: 2px solid black;
      padding: 15px;
      width: 100%;
    }
      .note-editor {
    width: 100% !important;
  }

  .note-toolbar {
    display: flex !important;
    flex-wrap: wrap !important;
    justify-content: start !important;
    gap: 5px;
  }

  .note-editing-area {
    width: 100%;
  }

  .write-box {
    width: 100%;
    max-width: 800px;
    margin: auto;
    box-sizing: border-box;
  }
    
</style>
</head>
<%
	int num = Integer.parseInt(request.getParameter("num") );
	String pageNum = request.getParameter("pageNum");
	String sid = (String)session.getAttribute("sid");
	String role = (String)session.getAttribute("role");
	
	ContentDAO dao = ContentDAO.getInstance();
	ContentDTO c_dto = dao.updateContent(num);
	UsersDAO u_dao = UsersDAO.getInstance();
	
%>

	
<%	if( sid == null ) {	%>
		<script>
			alert("로그인 후 글수정 가능");
			window.location="../user/loginForm.jsp";
		</script>
<% 	}	%>
<body>
	<div class="container">
		<div class="header">
				<img src="../resources/logo.png" alt="로고 이미지" class="logo" onclick="window.location='../main/mainPage.jsp'">
			<div class="search-box">
	        	<img src="https://upload.wikimedia.org/wikipedia/commons/5/55/Magnifying_glass_icon.svg" alt="Search Icon">
	        	<input type="text" placeholder="통합검색..">
	      	</div>
	      	
<%	      	
	dto = u_dao.myPage(sid);
	// 로그인 안됐을 때
		if( sid == null ){%>
		<div class="login-box">
			<h2>맛은 픽하는 시대 MAT.PICK</h2>
			<button class="login-main" onclick="window.location='../user/loginForm.jsp'">로그인</button>
	       <div class="join-box">
	           <button class="login-sub" type="button" onclick="window.location='../user/userInsertForm.jsp'">회원가입</button>
	           <button class="login-sub" type="button" onclick="window.location='../user/find.jsp'">아이디/비밀번호 찾기</button>
	       </div>
	   </div>
	
	<%    	// 쿠키 검사 후 자동로그인 여부 판단
		String cid = null, cpw = null, cauto = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				if (c.getName().equals("cid")) cid = c.getValue();
				if (c.getName().equals("cpw")) cpw = c.getValue();
				if (c.getName().equals("cauto")) cauto = c.getValue();
			}
		}
		if ("1".equals(cauto) && cid != null && cpw != null) {
			response.sendRedirect("loginPro.jsp");
		}
	// 관리자가 로그인 했을 때
	}else if(role != null && role.equals("admin")){ %>
		<div class="login-box">
		<div><strong><%=sid %>님, 환영합니다.</strong></div>
		<p><%=dto.getEmail() %></p>
	  	<strong>환영합니다.</strong>
		<button class="login-main" onclick="window.location='../admin/userList.jsp'">관리자페이지</button>
		<button class="login-main" onclick="window.location='../user/logout.jsp'">로그아웃</button>
	</div>
	<%	//유저가 로그인 했을 때
	}else{%>
	<div class="login-box">
	 <div><strong><%=sid%>님,</strong></div>
	 <p><%=dto.getEmail() %></p>
	 <strong>환영합니다.</strong>
	 <button class="login-main" onclick="window.location='../user/myPage.jsp'">마이페이지</button>
	 <button class="login-main" onclick="window.location='../user/logout.jsp'">로그아웃</button>
	</div> 
	<%} %>
		</div>


	<form action="boardUpdatePro.jsp?pageNum=<%=pageNum %>" method="post">
	  	<div class="post-area">
	    	<div class="posts">
	      	<div class="write-box">
				
				<!-- 카테고리 분류 -->
				<div>
				    <label for="category">카테고리</label>
				    <select id="category" name="category" required>
				        <option value="한식" <%= c_dto.getCategory().equals("한식") ? "selected" : "" %>>한식</option>
				        <option value="중식" <%= c_dto.getCategory().equals("중식") ? "selected" : "" %>>중식</option>
				        <option value="일식" <%= c_dto.getCategory().equals("일식") ? "selected" : "" %>>일식</option>
				        <option value="분식" <%= c_dto.getCategory().equals("분식") ? "selected" : "" %>>분식</option>
				        <option value="양식" <%= c_dto.getCategory().equals("양식") ? "selected" : "" %>>양식</option>
				        <option value="혼밥" <%= c_dto.getCategory().equals("혼밥") ? "selected" : "" %>>혼밥</option>
				    </select>
				</div> 
				
	        	<!-- 제목 -->
	        	<div class="form-group">
	          		<label for="writeTitle">제목</label>
	          		<input type="text" id="writeTitle" name="title" value="<%=c_dto.getTitle() %>" />
	       	 	</div>
	
	        	<!-- 내용 -->
	        	<div class="form-group">
	          		<label for="summernote">내용</label>
	          		<textarea id="summernote" name="content"><%=c_dto.getContent() %></textarea>
	        	</div>
	
	        	<!-- Hidden 필드들 -->
	        		<input type="hidden" name="writer" value="<%=sid %>">
	        		<input type="hidden" name="num" value="<%=c_dto.getNum() %>">
	
	        	<!-- 버튼 -->
	        	<div class="form-group" style="text-align:center;">
	          		<button type="submit" style="padding: 10px 20px;background-color: #f9967a;color: black;border: none;border-radius: 6px;">글수정</button>
	          		<button type="button" style="padding: 10px 20px;background-color: #f9967a;color: black;border: none;border-radius: 6px;" onclick="window.location='../main/mainPage.jsp'">글목록</button>
	        	</div>
	
	      	</div>
	    	</div>
		</div>
	</form>

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
			height: 600,
			placeholder: '내용을 입력하세요...',
			lang: 'ko-KR'
		});
	});
</script>