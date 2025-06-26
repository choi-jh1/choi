<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "matPick.bean.UsersDAO" %>
<%@ page import = "matPick.bean.ContentDAO" %>
<%@ page import = "matPick.bean.ContentDTO" %>
<%@ page import = "matPick.bean.CommentsDAO" %>
<%@ page import = "matPick.bean.CommentsDTO" %>
<%@ page import = "matPick.bean.NoticeDAO" %>
<%@ page import = "matPick.bean.NoticeDTO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.net.URLEncoder" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class = "matPick.bean.UsersDTO" id = "dto" />
<jsp:setProperty name = "dto" property = "*"/>
    
<!DOCTYPE html>
<html lang="ko">
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

    .login-box {
      border: 2px solid black;
      padding: 15px;
      font-size: 12px;
      width: 140px;
    }

    .join-box {
      display: flex;
      justify-content: space-between;
      gap: 6px;
    }

    .post-area {
      display: flex;
      justify-content: space-between;
      width: 1000px;
      padding-top: 10px;
      gap: 20px;
      margin: 0 auto;
    }

    .posts {
      flex: 5;

      padding: 10px;

    }

    .sidebar {
      margin-top:100px;
      border: 1px solid black;
      margin-left: 10px;
      padding: 10px;
      height:400px;
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
      margin-top: 10px;
      font-size: 14px;
      width: 100%;
    }

    .footer {
      margin-top: 20px;
      text-align: center;
      border-top: 2px solid black;
      padding: 15px;
      width: 100%;
    }

    .content-card {
      background: white;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      padding: 30px;
      width: 100%;
      box-sizing: border-box;
      font-size: 15px;
      border: 2px solid black;
    }

    .content-card h2 {
      font-size: 22px;
      font-weight: bold;
      margin-bottom: 20px;
      text-align: center;
    }

    .content-card ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .content-card li {
      display: flex;
      justify-content: space-between;
      align-items: start;
      border-bottom: 1px solid #eee;
      padding: 10px 0;
    }

    .content-card li span {
      font-weight: 600;
      width: 100px;
      color: #555;
    }

    .content-card li strong {
      flex: 1;
      color: #222;
      word-break: break-word;
    }

    .post-content {
      flex: 1;
      color: #333;
      line-height: 1.6;
      white-space: pre-line;
      padding: 10px;
      height:600px;
      margin-left: 5px;
    }

    .button-group {
      display: flex;
      justify-content: center;
      gap: 10px;
      margin-top: 20px;
    }

    .button-group button {
      padding: 10px 20px;
      background-color: #f9967a;
      color: black;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      cursor: pointer;
    }
    
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
        <img src="../resources/logo.png" alt="로고 이미지" class="logo" onclick="window.location='../main/mainPage.jsp'">
      <div class="search-box">
        <img src="https://upload.wikimedia.org/wikipedia/commons/5/55/Magnifying_glass_icon.svg" alt="Search Icon">
        <input type="text" placeholder="통합검색..">
      </div>
  
<%
   ContentDAO c_dao = ContentDAO.getInstance();
   ArrayList<ContentDTO> btcList = c_dao.boardTopCount();
   int num = Integer.parseInt(request.getParameter("num"));
   String sid = (String)session.getAttribute("sid");
   String role = (String)session.getAttribute("role");
   java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
   UsersDAO dao = UsersDAO.getInstance();
   NoticeDAO dao1 = NoticeDAO.getInstance();
   
   NoticeDTO dto1 = dao1.noticeInfo(num);
   


   String pageNum = request.getParameter("pageNum");
   
	dto = dao.myPage(sid);
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
       <div class="post-area">
        <div class="posts">
          <div class="content-card">

            <h2>공지사항</h2>
            <ul>
              <li><span>글번호</span><strong><%=dto1.getNum()%></strong>
              <span style="padding-left:60px;">조회수</span><strong><%=dto1.getReadCount() %></strong>
              </li>
              <li ><span>작성자</span><strong><%=dto1.getWriter()%></strong>
              <span style="padding-left:60px;">작성일</span><strong><%=sdf.format(dto1.getReg())%></strong></li>
              <li><span>제목</span><strong><%=dto1.getTitle()%></strong></li>
              <li><span>내용</span><div class="post-content"><%=dto1.getContent()%></div></li>
            </ul>

            <input type="hidden" name="num" value="<%=dto1.getNum()%>">
            <div class="button-group">
              <button type="button" onclick="window.location='../main/mainPage.jsp'">글목록</button>
            </div>
    </div>


</div>
      <div class="sidebar">
        <div class="activity-title">게시왕</div>
        <ul class="activity-list">
        <%for(ContentDTO btcDTO : btcList){ %>
          <li><%=btcDTO.getNick() %> (<%=btcDTO.getBoardCount() %>개)</li>
          <%} %>
        </ul>
        <div class="congrats-btn">게시왕! 축하합니다!</div>
        
        <% 
           CommentsDAO cmtDao = CommentsDAO.getInstance();
           ArrayList<CommentsDTO> cmtList = cmtDao.commentTopCount(); 
        %>
                <div class="activity-title" style="padding-top:15px;">댓글왕</div>
        <ul class="activity-list">
        <%for(CommentsDTO cmtDTO : cmtList){ %>
          <li><%=cmtDTO.getNick() %> (<%=cmtDTO.getCommentCount() %>개)</li>
          <%} %>
        </ul>
        <div class="congrats-btn">댓글왕! 축하합니다!</div>
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
</body>
</html>