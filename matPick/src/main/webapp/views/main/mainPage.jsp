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
      background-color: #f9967a;
      cursor: pointer;
      border-radius: 50px; 
       transition: transform 1.0s ease;
    }
    .category-buttons button:hover {
       background-color: #f0f0f0;
      transform: scale(1.50);            
    }

    .post-area {
	display:flex;
      width: 100%;

    }

    .posts {
      flex: 5;
      padding: 10px;

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
    .post-main{
       flex: 5;
    }
	.mainTable {
	  width: 100%;
	  border-collapse: collapse;
	  font-size: 15px;
	  border: none;
	}
	
	.mainTable thead th {
	  background-color: #f9967a;
	  padding: 12px 8px;
	  text-align: center;
	  font-weight: bold;
	  border-bottom: 2px solid #ddd;
	  border-left: none;
	  border-right: none;
	}
	
	.mainTable tbody td {
	  padding: 10px 8px;
	  text-align: center;
	  border-bottom: 1px solid #bbb;
	  border-left: none;
	  border-right: none;
	}
	
	.mainTable tbody tr:hover {
	  background-color: #fff3f0;
	}
	
	.mainTable td:first-child,
	.mainTable th:first-child {
	  border-left: none;
	}
	
	.mainTable td:last-child,
	.mainTable th:last-child {
	  border-right: none;
	}
	
	.mainTable a {
	  text-decoration: none;
	  color: #333;
	}
	
	.mainTable a:hover {
	  text-decoration: underline;
	  color: #ff6600;
	}
    .btn-group button {
      background-color: #f9967a;
      color: balck;
      border: none;
      padding: 8px 14px;
      border-radius: 6px;
      margin-left: 10px;
      cursor: pointer;
    }
    
  </style>
</head>
<body>
  <%   /* 게시판 글 관련 시작 */
   String category = request.getParameter("category");
   //String catParam = request.getParameter("cat");

   /* 게시판 글 관련 시작 */
   String pageSizeParam = request.getParameter("pageSize");
   int pageSize=10;
   
   if(pageSizeParam != null && !pageSizeParam.equals("") && !pageSizeParam.equals("null")){
      pageSize = Integer.parseInt(pageSizeParam);
   }
   String pageNum = request.getParameter("pageNum");
   
   if (pageNum == null || pageNum.equals("") || pageNum.equals("null")) {
       pageNum = "1";
   }
   if (category == null || category.equals("") || pageNum.equals("null")) {
      category = "전체글";
   }
   /* 시간 형식 바꾸기 위함 */
   java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");

   
   int currentPage = Integer.parseInt(pageNum);
   int startRow = ( currentPage - 1 ) * pageSize + 1;
   int endRow = currentPage * pageSize;
   
   ContentDAO c_dao = ContentDAO.getInstance();

   int count = c_dao.contentCount(category);

   String sort = request.getParameter("sort");
   String searchParam = "";
   
   ArrayList<ContentDTO> list = null;
   CommentsDAO cmtDao = CommentsDAO.getInstance();
   
   count = c_dao.contentCount(category);
   String searchFilter = request.getParameter("searchFilter");

   if (searchFilter != null) searchFilter = searchFilter.trim();
   String searchKeyword = request.getParameter("searchKeyword");
   
   String allKeyword = request.getParameter("allKeyword");
   
   %>
  
  <div class="container">
    <div class="header">
        <img src="../resources/logo.png" alt="로고 이미지" class="logo" onclick="window.location='../main/mainPage.jsp'">      
      <div class="search-box">
        <img src="https://upload.wikimedia.org/wikipedia/commons/5/55/Magnifying_glass_icon.svg" alt="Search Icon">
        <form action="mainPage.jsp" method="get">
        	<input type="hidden" name="category" value="<%=category%>">
      		<input type="hidden" name="pageNum" value="<%=pageNum%>">
      		<input type="hidden" name="pageSize" value="<%=pageSize%>">
        	<input type="text" name="allKeyword" placeholder="통합검색.." style="width: 450px">
        	<button type="submit" style="display:none;"></button>
        </form>
      </div>


      
   <%
   if(allKeyword != null){
   		// 통합검색
	   	list= c_dao.allSearch(allKeyword,startRow,endRow);
	   	count = c_dao.allCount(allKeyword);
   }else if (searchKeyword != null && !searchKeyword.trim().equals("")) {
	   // 하단 검색창
       list = c_dao.searchContentList(searchFilter, searchKeyword, startRow, endRow, category);
       count = c_dao.searchContentCount(searchFilter, searchKeyword, category);
   }else {
       if (sort != null && sort.equals("popular")) { // sort가 null 이 아니거나 sort가 "popular" 같다면 조건 실행 
           if (category.equals("전체글")) { // 카테고리가 "전체글" 같다면 조건 실행
               list = c_dao.hotContentList(startRow, endRow);  // dao의 hotContentList를 출력
           } else { // 그 외 전체글이 아닐시 cao의 hotContentListByCategory를 실행
               list = c_dao.hotContentListByCategory(category, startRow, endRow); // dao의 hotContentListByCategory 출력
           }
       } else { // sort가 null 이거나 sort가 "popular"와 다를시
           if (category.equals("전체글")) { // 카테고리가 "전체글"과 같을시  
               list = c_dao.contentList(startRow, endRow); // dao의 contentList출력 
           } else { // 그외
               list = c_dao.categoryContentList(startRow, endRow, category); // dao에서categoryContentList 를 출력  
           }
       }
   }
   

/* 게시판 글 관련 끝 */   %>   
<%
   String sid = (String)session.getAttribute("sid");
   String role = (String)session.getAttribute("role");
   
   UsersDAO dao = UsersDAO.getInstance();
   NoticeDAO noDao = NoticeDAO.getInstance();
   
   ArrayList<NoticeDTO> noList = noDao.noticeList();
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

<%       // 쿠키 검사 후 자동로그인 여부 판단
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
      <p>관리자 입니다.</p>
         <strong>환영합니다.</strong>
      <button class="login-main" onclick="window.location='../admin/userList.jsp'">관리자페이지</button>
      <button class="login-main" onclick="window.location='../user/logout.jsp'">로그아웃</button>
   </div>
<%   //유저가 로그인 했을 때
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
   <!-- 카테고리 버튼 시작 -->
   <div class="category-buttons">
       <%-- <button onclick="window.location='main.jsp?pagenum=<%=currentPage %>&category=전체글'">전체글</button> --%>
       <button onclick="window.location='mainPage.jsp?pagenum=<%=currentPage %>&category=한식'">🍚 한식 </button>
       <button onclick="window.location='mainPage.jsp?pagenum=<%=currentPage %>&category=중식'">🥡 중식 </button>
       <button onclick="window.location='mainPage.jsp?pagenum=<%=currentPage %>&category=일식'">🍣 일식 </button>
       <button onclick="window.location='mainPage.jsp?pagenum=<%=currentPage %>&category=분식'">🌶️ 분식 </button>
       <button onclick="window.location='mainPage.jsp?pagenum=<%=currentPage %>&category=양식'">🍝 양식 </button>
       <button onclick="window.location='mainPage.jsp?pagenum=<%=currentPage %>&category=혼밥'">🧍 혼밥 </button>
    </div>
   <!-- 카테고리 버튼 끝 -->
   
   <%-- main 글 출력 관련 내용 --%>          
    <div class="post-area">
    <div class="post-main">
      <div class="posts">
        <div class="posts-header">
         <div class="btn-group">  
            <button onclick="window.location='mainPage.jsp'">전체글</button>
            <button onclick="window.location='mainPage.jsp?pageNum=<%=currentPage%>&category=<%=category%>&sort=popular'">인기글</button>
          </div>          
          <div class="write-controls">
          <form method="get" action="mainPage.jsp">
            <select name="pageSize" onchange="this.form.submit()">
              <option value="10" <%="10".equals(request.getParameter("pageSize")) ? "selected" : ""%>>➊ 10개씩</option>
              <option value="20" <%="20".equals(request.getParameter("pageSize")) ? "selected" : ""%>>➋ 20개씩</option>
              <option value="30" <%="30".equals(request.getParameter("pageSize")) ? "selected" : ""%>>➌ 30개씩</option>
            </select>
            <input type="hidden" name="category" value="<%=category %>">
          </form>
         <div class= btn-group>
         	<button onclick="window.location='boardWriteForm.jsp'">글쓰기</button>
         </div>
          </div>
        </div>
 	  
      <table class="mainTable">
        <thead>
          <tr bgcolor="#f9967a">
            <th width="50">번호</th>
            <th width="250">제목</th>
            <th width="100">작성자</th>
            <th width="100">작성일</th>
            <th width="50">조회</th>
          </tr>
        </thead>
        <tbody id="postList">
          <%-- 공지사항 출력 --%>
          <% for(NoticeDTO noDto : noList){ %>
            <tr bgcolor="#e9ecef">
              <td><%=noDto.getType()%></td>
              <td>
                <a href="mainNoticeContent.jsp?num=<%=noDto.getNum()%>">[<%=noDto.getType()%>] <%=noDto.getTitle() %></a>
              </td>
              <td><%=noDto.getWriter()%></td>
              <td><%=sdf.format(noDto.getReg()) %></td>
              <td><%=noDto.getReadCount() %></td>
            </tr>
          <% } %>
      
          <%-- 게시글 출력 --%>
          <% if (count == 0) { %>
            <tr>
              <td colspan="5" align="center"><h3>게시글이 없습니다.</h3></td>
            </tr>
          <% } else {   %>
             <%for (ContentDTO cc_dto : list) { %>
            <tr>
              <td><%= cc_dto.getNum() %></td>
              <td align="left">
                <a href="boardContent.jsp?num=<%=cc_dto.getNum()%>&pageNum=<%=currentPage%>">
                <%int cmtCount = cmtDao.commentCount(cc_dto.getNum()); %>
                  [<%= cc_dto.getCategory() %>] <%= cc_dto.getTitle() %> <% if(cmtCount != 0){ %>
                  &nbsp;	<font color="#F9967A">[<%=cmtDao.commentCount(cc_dto.getNum()) %>]</font>
                  <% }%>
                  
                </a>
              </td>
              <td><%= cc_dto.getNick() %></td>
              <td><%= sdf.format(cc_dto.getReg()) %></td>
              <td><%= cc_dto.getReadCount() %></td>
            </tr>
          <% } } %>
        </tbody>
      </table>

           </div>
          <%-- 글 리스트 출력 끝 --%>
          
         <%-- 페이징 처리 시작 --%>
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
       String sortParam = (sort != null && sort.equals("popular")) ? "&sort=popular" : "";
       if (searchKeyword != null && !searchKeyword.trim().equals("")) {
           searchParam = "&searchFilter=" + URLEncoder.encode(searchFilter, "UTF-8") +
                         "&searchKeyword=" + URLEncoder.encode(searchKeyword, "UTF-8");
       }
       /* 인기글 조회 */
       
       if( startPage > 10) {
   %>               <a href="mainPage.jsp?pageNum=<%=startPage-10 %>&category=<%=category%>&pageSize=<%=pageSize%><%=sortParam%><%=searchParam%>">[이전]</a>
   <%             }    
       for( int i = startPage; i<=endPage; i++ ) {
   %>               <a href="mainPage.jsp?pageNum=<%=i %>&category=<%=category%>&pageSize=<%=pageSize%><%=sortParam%><%=searchParam%>">[<%=i %>]</a>
   <%             }   
       if( endPage < pageCount ) {   %>
          <a href="mainPage.jsp?pageNum=<%=startPage + 10%>&category=<%=category%>&pageSize=<%=pageSize%><%=sortParam%><%=searchParam%>">[다음]</a>
   <%            }
    }
%>

         </div>
 </div>   
    
      <%-- 페이징 처리 끝 --%>   
      <%-- main 글 출력 관련 내용 끝 --%>
	         <% ArrayList<ContentDTO> btcList = c_dao.boardTopCount(); %>
      <div class="sidebar">
        <div class="activity-title">게시왕</div>
        <ul class="activity-list">
        <%for(ContentDTO btcDTO : btcList){ %>
          <li><%=btcDTO.getNick() %> (<%=btcDTO.getBoardCount() %>개)</li>
          <%} %>
        </ul>
        <div class="congrats-btn">게시왕! 축하합니다!</div>
        
        <% 
        	
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

		      <form method="get" action="mainPage.jsp" class="search-bottom">
       <input type="hidden" name="category" value="<%=category%>">
      <input type="hidden" name="pageNum" value="<%=pageNum%>">
      <input type="hidden" name="pageSize" value="<%=pageSize%>">
      <img src="https://upload.wikimedia.org/wikipedia/commons/5/55/Magnifying_glass_icon.svg" width="20">
      <select name="searchFilter" id="searchFilter">
        <option value="제목">제목</option>
        <option value="작성자">작성자</option>
      </select>
      <input type="text" name="searchKeyword" id="searchKeyword" placeholder="검색어 입력...">
      <button type="submit" style="display:none;"></button> <%-- 엔터 키용 --%>
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
    
</body>
</html> 