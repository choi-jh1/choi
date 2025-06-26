<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "matPick.bean.UsersDAO" %>
<%@ page import ="matPick.bean.UsersDAO" %>
<%@ page import="matPick.bean.ContentDAO" %>
<%@ page import="matPick.bean.ContentDTO" %>
<%@ page import="matPick.bean.CommentsDAO" %>
<%@ page import="matPick.bean.CommentsDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class = "matPick.bean.UsersDTO" id = "dto" />
<jsp:setProperty name = "dto" property = "*"/>
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
      border: 2px solid black;
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
      height:500px;
      margin-left: 5px;
      overflow-y: auto;

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
   java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
   int num = Integer.parseInt(request.getParameter("num"));
   String sid = (String)session.getAttribute("sid");
   String role = (String)session.getAttribute("role");
   
   UsersDAO dao = UsersDAO.getInstance();
   CommentsDAO coDao = CommentsDAO.getInstance();
   ContentDAO dao1 = ContentDAO.getInstance();
   ContentDTO dto1 = dao1.contentContent(num);
   
   
   ArrayList<ContentDTO> list = null;
   String pageNum = request.getParameter("pageNum");
   String pageNum2 = request.getParameter("pageNum2");
   int contentId = 0;
   
   /* 댓글 페이징 처리 */
   int commentPageSize = 10;
   if (pageNum2 == null || pageNum.equals("") || pageNum.equals("null")) {
       pageNum2 = "1";
   }
   int currentPage = Integer.parseInt(pageNum2);
   int startRow = ( currentPage - 1 ) * commentPageSize + 1;
   int endRow = currentPage * commentPageSize;
   
   int count = coDao.commentCount(num);
   
   
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
    <form action="c_updateContentPro.jsp?pageNum=<%=pageNum%>" method="post">
            <h2>게시글 정보</h2>
            <ul>
              <li><span>글번호</span><strong><%=dto1.getNum()%></strong>
              <span style="padding-left:60px;">조회수</span><strong><%=dto1.getReadCount()%></strong>
              </li>
              <li ><span>작성자</span><strong><%=dto1.getNick()%></strong>
              <span style="padding-left:60px;">작성일</span><strong><%=sdf.format(dto1.getReg())%></strong></li>
              <li><span>제목</span><strong>[<%=dto1.getCategory()%>]<%=dto1.getTitle()%></strong></li>
              <li><span>내용</span><div class="post-content"><%=dto1.getContent().replaceAll("\n", "<br>")%></div></li>
            </ul>

            <input type="hidden" name="num" value="<%=dto1.getNum()%>">

            <div class="button-group">
              <button type="button" onclick="window.location='../main/mainPage.jsp'">글목록</button>
              <% if (sid != null && sid.equals(dto1.getWriter())) { %>
              <button type="button"
                onclick="window.location='boardUpdateForm.jsp?num=<%=dto1.getNum()%>&pageNum=<%=pageNum%>'">글수정</button>
              <button type="button"
                onclick="deletePost(<%=dto1.getNum()%>, '<%=pageNum%>')">글삭제</button>
              <% } %>
            </div>
        
    </form>
   <!-- 댓글 -->
   <div style="display:flex; width:900px; margin:0 auto;">댓글쓰기</div>
   <div style="display:flex; width:900px; margin:0 auto;">
   <form action="commentPro.jsp?num=<%=dto1.getNum() %>" method="post" name="userInput" onsubmit="return commentCheck()" style="display: flex; width: 100%;">
   		<input type="hidden" name="writer" value="<%=sid %>" />
   		<input type="hidden" name="num" value="<%=dto1.getNum() %>" />
   		<textarea  style="flex: 1; height: 120px; resize: none;" name=content></textarea>
   		<div style=" display: flex;justify-content: center;gap: 10px;" >
   			<button type="submit" style="padding: 10px 20px;background-color: #f9967a;color: black;border: none;border-radius: 6px;font-size: 14px;cursor: pointer;width: 100px; height: 120px;">등록</button>
   		</div>
   </form>
   </div>
   <% 
   	ArrayList<CommentsDTO> coList = coDao.commentList(startRow,endRow,dto1.getNum());
   	for(CommentsDTO coDto : coList){	%>
		<div style="display: flex; flex-direction: column; width: 900px; margin: 0 auto; border-top: 1px solid black; border-bottom: 1px solid black; padding: 10px; position: relative;">
		  	<!-- 작성자, 작성시간-->  	
			<div style="padding-bottom:10px;">
				<%	    			
					int wid=0;
					if(coDto.getRe_level() > 0){ 
						wid = 30*(coDto.getRe_level());%>
						
						<img src="../resources/replay.png" width="20" height="20" style="padding-left:<%=wid %>px" >
					<%} %>
				<strong><%=coDto.getNick() %></strong>&nbsp;&nbsp;&nbsp;<%=sdf.format(coDto.getReg()) %>
			</div>
			
		  	<!-- 내용 + 버튼 한 줄 -->
	  		<div style="display: flex; justify-content: space-between; align-items: center;">
	    		<div style="display:flex: 1; margin-right: 10px; padding-left:<%=5+wid%>px; ">
					<%if(coDto.getDeleted().equals("n")){ %>
	    			<%=coDto.getContent() %>
	    			<%}else{ %>
	    			삭제된 댓글입니다.
	    			<%} %>
	    		</div>
	<form action="commentDelete.jsp?commentNum=<%=coDto.getCommentNum() %>&num=<%=dto1.getNum() %>" method="post">
	    <input type="hidden" name="writer" value="<%=sid %>" />
	    <% if (sid != null && sid.equals(coDto.getWriter())) { %>
	        <!-- 내가 쓴 댓글일 경우 -->
	        <% if(!((coDto.getDeleted()).equals("y"))){%>
	        <button type="submit" style="padding: 5px 10px;background-color: #f9967a;color: black;border: none;border-radius: 6px;">삭제</button>
	        <%} %>
	        <button type="button"
	            style="padding: 5px 10px;background-color: #f9967a;color: black;border: none;border-radius: 6px;"
	            onclick="window.open('replayForm.jsp?num=<%=dto1.getNum() %>&ref=<%=coDto.getRef() %>&re_level=<%=coDto.getRe_level() %>&re_step=<%=coDto.getRe_step() %>&commentNum=<%=coDto.getCommentNum() %>', 'replay', 'width=200,height=200,top=' + ((screen.height-400)/2) + ',left=' + ((screen.width-500)/2) + ',resizable=no')">답글</button>
	    <% } else { %>
	        <!-- 내가 쓴 댓글이 아닐 경우 -->

	        <button type="button"
	            style="padding: 5px 10px;background-color: #f9967a;color: black;border: none;border-radius: 6px;"
	            onclick="window.open('replayForm.jsp?num=<%=dto1.getNum() %>&ref=<%=coDto.getRef() %>&re_level=<%=coDto.getRe_level() %>&re_step=<%=coDto.getRe_step() %>&commentNum=<%=coDto.getCommentNum() %>', 'replay', 'width=200,height=200,top=' + ((screen.height-400)/2) + ',left=' + ((screen.width-500)/2) + ',resizable=no')">답글</button>
	    <% } %>
	</form>

	  		</div>
		</div>
<%   	}
   %>
         <div align="center">
<%
      if( count > 0) {   // 글 있음
         int pageCount = count/commentPageSize + ( count%commentPageSize == 0 ? 0 : 1 );
         int startPage = (int)((currentPage -1)*10+1);
         int pageBlock = 10;
         int endPage = startPage + pageBlock-1;
            
         if( endPage > pageCount ) {
            endPage = pageCount;
         }
         
         if( startPage > 10) {   %>
            <a href="boardContent.jsp?num=<%=num%>&pageNum2=<%=pageNum2%>&replyPageNum=<%=startPage - 10%>">[이전]</a>
<%          }
            
         for( int i = startPage; i<=endPage; i++ ) {
%>            <a href="boardContent.jsp?num=<%=num%>&pageNum2=<%=pageNum2%>&replyPageNum=<%=i %>">[<%=i%>]</a>

<%       }            
         if( endPage < pageCount ) {   %>
            <a href="boardContent.jsp?num=<%=num%>&pageNum2=<%=pageNum2%>&replyPageNum=<%=startPage + 10%>">[다음]</a>
<%         }
            
      }
%>

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
    function deletePost(num, pageNum) {
      if (confirm("글을 삭제하시겠습니까?")) {
        location.href = "boardDeletePro.jsp?num=" + num + "&pageNum=" + pageNum;
      } else {
        alert("글 삭제를 취소합니다.");
      }
    }
    
    function commentCheck(){
    	let check = document.userInput;
    	let isLogin = <%= (sid != null) ? "true" : "false" %>
    	if(!isLogin){
    		alert("로그인을 해주세요");
    		window.location="../user/loginForm.jsp";
    		return false;
    	}
    	if(!check.content.value){
    		alert("내용을 입력해 주세요.");
    		return false;
    	}
    }
  </script>
</body>
