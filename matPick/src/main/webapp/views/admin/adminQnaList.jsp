<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.QnaDAO" %>
<%@ page import = "matPick.bean.QnaDTO" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
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
       .posts {
      width: 100%;
    }
        
    .list {
      width: 100%;
      border-collapse: collapse;
    }
    .list th, .list td {
      border: 1px solid black;
      border-left: none;
	  border-right: none;
	  border-bottom: 1px solid #bbb;
      padding: 10px;
      text-align: center;
    }
    .list th {
      background-color: #f9967a;
      
 	}
 	
 	  .ask-wait { color: orange; font-weight: bold; }
    .ask-done { color: green; font-weight: bold; }
 	
 	adQna td {
 		color: black; 
   	  	text-decoration: none;
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
	
		String pageSizeParam = request.getParameter("pageSize");
		String pageNum = request.getParameter("pageNum");
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		QnaDAO dao = QnaDAO.getInstance();
		int count = dao.waitCount();

	   int pageSize = 10;
	   if (pageSizeParam != null && !pageSizeParam.equals("") && !pageSizeParam.equals("null")) {
	      pageSize = Integer.parseInt(pageSizeParam);
	   }
	   if (pageNum == null || pageNum.equals("") || pageNum.equals("null")) {
	      pageNum = "1";
	   }
	   int currentPage = Integer.parseInt(pageNum);
	   int startRow = (currentPage - 1) * pageSize + 1;
	   int endRow = currentPage * pageSize;
	     QnaDAO dao1 = QnaDAO.getInstance();

	     ArrayList<QnaDTO> list = dao1.imgList(startRow,endRow);

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
	      		답변 대기중 : <%=count%>
	      </td>

	   </tr>
	</table>
	
   <div class="posts">
      <table class="list">
        <thead>
          <tr>
            <th>번호</th>
            <th>건의 제목</th>
            <th>작성자</th>
            <th>등록일</th>
            <th>상태</th>
          </tr>
        </thead >
        <tbody>
          <%
          if (list != null) {
                         for (QnaDTO dto1 : list) {
          %>
          <tr class="adQna">
            <td><%=dto1.getNum()%></td>
            <td style="text-align:center; padding-left:10px; text-decoration: none; color: #333;">
              <a href="../user/qnaContent.jsp?num=<%=dto1.getNum()%>"><%=dto1.getTitle()%></a>
            </td>
            <td><%=dto1.getWriter()%></td>
            <td><%=sdf.format(dto1.getReg()) %></td>
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
%>               <a href="../user/userQnaList.jsp?pageNum=<%=startPage-10 %>&pageSize=<%=pageSize%>">[이전]</a>
<%             }    
            for( int i = startPage; i<=endPage; i++ ) {
%>               <a href="../user/userQnaList.jsp?pageNum=<%=i %>&pageSize=<%=pageSize%>">[<%=i %>]</a>
<%             }   
            if( endPage < pageCount ) {   %>
               <a href="../user/userQnaList.jsp?pageNum=<%=startPage+10%>&pageSize=<%=pageSize%>">[다음]</a>
<%            }
         }
%>
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