<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.UsersDAO" %>
<%@ page import="matPick.bean.QnaDAO" %>
<%@ page import="matPick.bean.QnaDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:useBean class="matPick.bean.UsersDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />

<%
  String sid = (String) session.getAttribute("sid");
  String pageSizeParam = request.getParameter("pageSize");
  java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
  if (sid == null) {
%>
<script>
  alert("로그인 후 이용가능합니다");
  window.location = "loginForm.jsp";
</script>
<%
}
    UsersDAO dao = UsersDAO.getInstance();
    dto = dao.myPage(sid);
   int pageSize = 10;
   if (pageSizeParam != null && !pageSizeParam.equals("") && !pageSizeParam.equals("null")) {
      pageSize = Integer.parseInt(pageSizeParam);
   }

   String pageNum = request.getParameter("pageNum");
   if (pageNum == null || pageNum.equals("") || pageNum.equals("null")) {
      pageNum = "1";
   }



   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage - 1) * pageSize + 1;
   int endRow = currentPage * pageSize;
     QnaDAO dao1 = QnaDAO.getInstance();
     int count = dao1.myQnaCount(sid);
     ArrayList<QnaDTO> list = dao1.myQna(startRow,endRow,sid);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
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
    }
    .logo {
      width: 180px;
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

    .btn-group {
      text-align: right;
      width: 100%;
      margin: 20px 0;
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

    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      border: 1px solid black;
      padding: 10px;
      text-align: center;
    }
    th {
      background-color: #f9967a;
    }
    .ask-wait { color: orange; font-weight: bold; }
    .ask-done { color: green; font-weight: bold; }
    
    .footer {
      margin-top: 20px;
      text-align: center;
      border-top: 2px solid black;
      padding: 15px;
      width: 100%;
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
   
       table {
      width: 100%;
      border-collapse: collapse;
    }
    a {
	    color: black;
	    text-decoration: none;
	}
    th, td {
      padding: 10px;
      text-align: center;
      border: 1px solid black;
      border-left: none;
	  border-right: none;
	  border-bottom: 1px solid #bbb;
    }
    th {
      background-color: #f9967a;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <img src="../resources/logo.png" class="logo" onclick="location.href='../main/mainPage.jsp'">
      <div class="nav">
        <h1 onclick="location.href='myPage.jsp'">내 프로필</h1>
        <h1 onclick="location.href='myBoardList.jsp'">글목록 조회</h1>
        <h1 onclick="location.href='userQnaList.jsp'">건의/문의</h1>
      </div>
      <div class="login-box">
        <strong><%=sid%>님, 환영합니다.</strong><br>
        <button class="login-main" onclick="location.href='../main/mainPage.jsp'">메인페이지</button>
        <button class="login-main" onclick="location.href='logout.jsp'">로그아웃</button>
      </div>
    </div>

    <div class="btn-group">
    	<button onclick="location.href='../user/userQnaList.jsp'">건의/문의 목록</button>
      	<button onclick="location.href='qnaWriteForm.jsp'">건의/문의하기</button>
    </div>

    <div class="posts">
     <table>
        <thead>
          <tr>
            <th width="50">번호</th>
            <th width="250">건의 제목</th>
            <th width="100">작성자</th>
            <th width="100">등록일</th>
            <th width="50">상태</th>
          </tr>
        </thead>
        <tbody>
          <%
          if (list != null) {
             for (QnaDTO dto1 : list) {
          %>
          <tr>
            <td><%=dto1.getNum()%></td>
            <td style="text-align:center; padding-left:10px;">
              <a  href="qnaContent.jsp?num=<%=dto1.getNum()%>"><%=dto1.getTitle()%></a>
              
            </td>
            <td><%=dto1.getNick()%></td>
            <td><%=sdf.format(dto1.getReg())%></td>
            <td class="<%=dto1.getAsk() == 1 ? "ask-wait" : "ask-done" %>">
              <%=dto1.getAsk() == 1 ? "답변 대기중" : "답변 완료" %>
            </td>
          </tr>
          <% }} %>
        </tbody>
      </table>
    </div>
          <div align="center" style="padding-top:10px;">
<%
         if( count > 0) {   // 글 있음
            int pageCount = count/pageSize + ( count%pageSize == 0 ? 0 : 1 );
            int startPage = (int)(((currentPage-1)/10)*10+1);
            int pageBlock = 10;
            int endPage = startPage + pageBlock-1;
            
            if( endPage > pageCount ) {
               endPage = pageCount;
            }
            
            
            if( startPage > 10) {
%>               <a href="../user/myAskForm.jsp?pageNum=<%=startPage-10 %>&pageSize=<%=pageSize%>">[이전]</a>
<%             }    
            for( int i = startPage; i<=endPage; i++ ) {
%>               <a href="../user/myAskForm.jsp?pageNum=<%=i %>&pageSize=<%=pageSize%>">[<%=i %>]</a>
<%             }   
            if( endPage < pageCount ) {   %>
               <a href="../user/myAskForm.jsp?pageNum=<%=startPage+10%>&pageSize=<%=pageSize%>">[다음]</a>
<%            }
         }
%>
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
