<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.NoticeDAO" %>
<%@ page import="matPick.bean.NoticeDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<head>
	<link rel="stylesheet" type="text/css" href="../resources/login.css"> 
</head>
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
      flex: 1;
      border: 2px solid black;
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
	
<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
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
    <img src="../resources/logo.png" alt="로고" class="logo" onclick="window.location='../main/mainPage.jsp'" >
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
      
      
      <div class="post-area">
        <div class="posts">
          <div class="content-card">

            <h2>공지사항 정보</h2>
            <ul>
              <li><span>글번호</span><strong><%=dto.getNum()%></strong>
              <span style="padding-left:60px;">조회수</span><strong></strong>
              </li>
              <li ><span>작성자</span><strong><%=dto.getWriter()%></strong>
              <span style="padding-left:60px;">작성일</span><strong><%=sdf.format(dto.getReg())%></strong></li>
              <li><span>제목</span><strong><%=dto.getTitle()%></strong></li>
              <li><span>내용</span><div class="post-content"><%=dto.getContent().replaceAll("\n", "<br>")%></div></li>
            </ul>

            <div class="button-group">
              <button type="button" onclick="window.location='../admin/noticeList.jsp'">목록</button>
              <button type="button"
                onclick="window.location='noticeUpdate.jsp?num=<%=dto.getNum()%>'">수정</button>
              <button type="button"
                onclick="deleteNotice(<%=dto.getNum()%>)">삭제</button>
            </div>
    </div>

</div>

</div>
<hr width=1000 color="black" />

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
    function deleteNotice(num) {
      if (confirm("삭제하시겠습니까?")) {
        location.href = "boardDeletePro.jsp?num=" + num;
      }
    }
    </script>  
</body>
</html>
