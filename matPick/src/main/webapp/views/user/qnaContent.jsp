<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.QnaDAO" %>
<%@ page import = "matPick.bean.QnaDTO" %>
<%@ page import = "matPick.bean.QnaAnswerDAO" %>
<%@ page import = "matPick.bean.QnaAnswerDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import = "java.util.ArrayList" %>

<head>
	<link rel="stylesheet" type="text/css" href="../resources/login.css"> 
</head>
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
      border: 2px solid black;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      padding: 30px;
      width: 100%;
      box-sizing: border-box;
      font-size: 15px;
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
      height:400px;
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

   </style>
   
   <%
         String sid = (String)session.getAttribute("sid");
         String role = (String)session.getAttribute("role");
         
         java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
         int num = Integer.parseInt( request.getParameter("num"));
         
         QnaDAO dao1 = QnaDAO.getInstance();
         QnaDTO dto1 = dao1.imgContent(num);
         
         QnaAnswerDAO dao2 = QnaAnswerDAO.getInstance();
         QnaAnswerDTO dto2 = dao2.answerInfo(num);
      %>
   
   <div class="container">
     <div class="header">
       <img src="../resources/logo.png" alt="로고" class="logo" onclick="window.location='../main/mainPage.jsp'">
<%   if(role.equals("user")){ %>
      <div class="nav">
        <h1 onclick="location.href='myPage.jsp'">내 프로필</h1>
        <h1 onclick="location.href='myBoardList.jsp'">글목록 조회</h1>
        <h1 onclick="location.href='userQnaList.jsp'">건의/문의</h1>
      </div>
       <div class="login-box">
         <div><strong><%=sid %>님, 환영합니다.</strong></div>
         <button class="login-main" onclick="window.location='../main/mainPage.jsp'">메인페이지</button>
         <button class="login-main" onclick="window.location='logout.jsp'">로그아웃</button>
      </div>
<%   }else if(role.equals("admin")){%>
       <table align=center width=400 class="cate">
       <tr >
          <td><h2 onclick="window.location='../admin/userList.jsp'">회원 목록</h2></td>
          <td><h2 onclick="window.location='../admin/noticeList.jsp'">공지 사항</h2></td>
          <td><h2 onclick="window.location='../admin/adminQnaList.jsp'">문의 내역</h2></td>
       </tr>

    </table>
    <div class="login-box">
      <div><strong><%=sid %>님, 환영합니다.</strong></div>
      <button class="login-main" onclick="window.location='../main/mainPage.jsp'">메인페이지</button>
      <button class="login-main" onclick="window.location='../user/logout.jsp'">로그아웃</button>
     
   </div>
<% }%>
     </div>


    <div class="post-area">
        <div class="posts">
          <div class="content-card">
            <h2>문의/건의 정보</h2>
            <ul>
              <li ><span>작성자</span><strong><%=dto1.getWriter()%></strong>
              <span style="padding-left:60px;">작성일</span><strong><%=sdf.format(dto1.getReg())%></strong></li>
              <li><span>제목</span><strong><%=dto1.getTitle()%></strong></li>
              <li><span>내용</span><div class="post-content"><%=dto1.getContent().replaceAll("\n", "<br>")%>
              <% 
              	if(dto1.getImg() != null){
               %>             		
            	  <img src="../upload/<%=dto1.getImg()%>" ></div></li>   		
              <% }%>
            </ul>

            <input type="hidden" name="num" value="<%=dto1.getNum()%>">
          <h2>답변</h2>
              <ul>
<%          if(dto2.getContent() == null && role.equals("user")){ %>
            <li><span>내용</span><div class="post-content"><h1>답변대기중...</h1></div></li>
      <%     }else if(role.equals("admin") && dto2.getContent() == null){%>
              <form action="../admin/qnaAnswerPro.jsp?num=<%=dto1.getNum() %>" method="post">
              <input type="hidden" name="writer" value="<%=sid %>" />
              <li>
              <span>내용</span>
              <div class="post-content">
              <textarea name="content" cols=100 rows=25></textarea>
              </div>
            <div class="button-group" ><button type="submit" >등록</button></div>
            </li>
            </form>
      <%   } else if(dto2.getContent() != null){%>
      <li><span>작성자</span><strong><%=dto2.getWriter()%></strong>
              <span style="padding-left:60px;">작성일</span><strong><%=sdf.format(dto2.getReg())%></strong></li>
            <li><span>내용</span><div class="post-content"><%=dto2.getContent().replaceAll("\n", "<br>")%></div></li>
<%         } %>
            </ul>
           <div class="button-group">
              <% if (role != null && role.equals("admin")) { 
                    if(dto2.getContent() != null){   %>
              <button type="button" onclick="window.location='../admin/qnaAnswerDelete.jsp?num=<%=dto1.getNum()%>&qnaNum=<%=dto2.getQnaNum()%>'">답변삭제</button>
              <%   } %>
              <button type="button" onclick="window.location='../admin/adminQnaList.jsp'">글목록</button>
              <button type="button" onclick="qnaDelete(<%=dto1.getNum()%>)">글삭제</button>
              <% }else if(sid != null && sid.equals(dto1.getWriter())){ %>
                 <button type="button" onclick="window.location='../user/userQnaList.jsp'">글목록</button>
              <button type="button" onclick="qnaDelete(<%=dto1.getNum()%>)">글삭제</button>
                <%}else { %>
                <button type="button" onclick="window.location='../user/userQnaList.jsp'">글목록</button>
                <%} %>
            </div>
        </div>
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
    function qnaDelete(num) {
      if (confirm("글을 삭제하시겠습니까?")) {
        location.href = "userQnaDelete.jsp?num=" + num;
      }
    }
    </script>
