<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.UsersDAO" %>
<%@ page import="matPick.bean.QnaDAO" %>
<%@ page import="matPick.bean.QnaDTO" %>
<%@ page import="matPick.bean.ContentDAO" %>
<%@ page import="matPick.bean.ContentDTO" %>
<%@ page import = "matPick.bean.CommentsDAO" %>
<%@ page import = "matPick.bean.CommentsDTO" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean class="matPick.bean.UsersDTO" id="dto" />
<jsp:setProperty name="dto" property="*" />

<%
  String sid = (String) session.getAttribute("sid");

  if (sid == null) { %>
	<script>
	  alert("로그인 후 이용가능합니다");
	  window.location = "loginForm.jsp";
	</script>
<% } %>
<%
	ContentDAO dao = ContentDAO.getInstance();
	CommentsDAO cmtDao = CommentsDAO.getInstance();
	String pageSizeParam = request.getParameter("pageSize");
	String pageNum = request.getParameter("pageNum");
	int pageSize = 10;
	if (pageSizeParam != null && !pageSizeParam.equals("") && !pageSizeParam.equals("null")) {
		pageSize = Integer.parseInt(pageSizeParam);
	}

	if (pageNum == null || pageNum.equals("") || pageNum.equals("null")) {
		pageNum = "1";
	}

	int myCount = dao.myBoardCount(sid);
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = dao.myBoardCount(sid);
	
	ArrayList<ContentDTO> list = dao.myBoardList(startRow,endRow,sid);
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
%>


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
      background-color: #00c73c;
      color: white;
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
  
    .ask-wait { color: orange; font-weight: bold; }
    .ask-done { color: green; font-weight: bold; }
    
    .footer {
      margin-top: 20px;
      text-align: center;
      border-top: 2px solid black;
      padding: 15px;
      width: 100%;
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
    <div style="width: 100%; text-align: left; margin: 20px 0;"><strong>내 글 : <%=myCount %></strong></div>
    <div class="posts">
      <table>
        <thead>
          <tr>
            <th width="50">번호</th>
            <th width="150">제목</th>
            <th width="50">작성자</th>
            <th width="50">등록일</th>
          </tr>
        </thead>
        <tbody>
          <%
         
        	  
             for (ContentDTO dto1 : list) {
          %>
          <tr>
            <td><%=dto1.getNum()%></td>
            <td style="text-align:center; padding-left:10px;">
              <a style="color: #333;" href="../main/boardContent.jsp?num=<%=dto1.getNum()%>">
              <%int cmtCount = cmtDao.commentCount(dto1.getNum()); %>
              [<%=dto1.getCategory()%>]<%=dto1.getTitle()%><% if(cmtCount != 0){ %>
                  &nbsp;	<font color="#F9967A">[<%=cmtDao.commentCount(dto1.getNum()) %>]</font>
                  <% }%></a>
            </td>
            <td><%=dto1.getNick()%></td>
            <td><%=sdf.format(dto1.getReg())%></td>
          </tr>
          <% } %>
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
%>               <a href="../user/myBoardList.jsp?pageNum=<%=startPage-10 %>&pageSize=<%=pageSize%>">[이전]</a>
<%             }    
            for( int i = startPage; i<=endPage; i++ ) {
%>               <a href="../user/myBoardList.jsp?pageNum=<%=i %>&pageSize=<%=pageSize%>">[<%=i %>]</a>
<%             }   
            if( endPage < pageCount ) {   %>
               <a href="../user/myBoardList.jsp?pageNum=<%=startPage+10%>&pageSize=<%=pageSize%>">[다음]</a>
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

