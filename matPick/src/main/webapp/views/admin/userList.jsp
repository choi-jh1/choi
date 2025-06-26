<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="matPick.bean.UsersDTO" %>
<%@ page import="matPick.bean.UsersDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>MAT.PICK</title>
  <link rel="stylesheet" type="text/css" href="../resources/login.css"> 

	<style>
	
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

     .list {
      width: 100%;
      border-collapse: collapse;
    }
    .list th, .list td {
      padding: 10px;
      text-align: center;
      border: 1px solid black;
      border-left: none;
	  border-right: none;
	  border-bottom: 1px solid #bbb;
    }
    .list th {
      background-color: #f9967a;
    }
    .btn-group button {
      background-color: #f9967a;
      color: black;
      border: none;
      padding: 5px 5px;
      border-radius: 6px;
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
</head>
<body>
<%
	// 파라미터
	String search = request.getParameter("search");
	String select = request.getParameter("select");
	String sid = (String)session.getAttribute("sid");
	String role = (String)session.getAttribute("role");
	// 사용자 접근 제한
	if(role==null || !role.equals("admin")){ %>
		<script>
			alert("접근할수 없습니다.");
			window.location="../main/mainPage.jsp";
		</script>
<%	}
	
	
	// 객체 생성
	UsersDAO dao = UsersDAO.getInstance();
	ArrayList<UsersDTO> list = new ArrayList<UsersDTO>();
	int count = 0;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	// 페이징
	int pageSize = 20;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage * pageSize;
	
	// 검색 기능
	if(search != null && select != null){
		if(select.equals("id")){
			// 아이디로 검색
			list = dao.idList(search,startRow,endRow);
			count = dao.idCount(search);
		}else if(select.equals("name")){
			// 이름으로 검색
			list = dao.nameList(search,startRow,endRow);
			count = dao.nameCount(search);
		}else if(select.equals("nick")){
			// 닉네임으로 검색
			list = dao.nickList(search,startRow,endRow);
			count = dao.nickCount(search);
		}
	}else{
		// 전체 목록
		list = dao.userList(startRow,endRow);
		count = dao.userCount();
	}
	
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
			회원수 : <%=count %>
		</td>
		<td align=right valign=bottom>
			<form action=userList.jsp method="get">
				<div class="btn-group">
				<select name="select">
					<option value="id">아이디</option>
					<option value="nick">닉네임</option>
					<option value="name">이름</option>
				</select>
				<input type="text" name="search" placeholder="검색어를 입렵해주세요" value="<%=search != null ? search : "" %>" />
					<button type="submit">검색</button>
				</div>
			</form>
		</td>
	</tr>
</table>

<table  align="center" width="1000" class="list">
	<tr bgcolor="f9967a">
		<th>아이디</th>
		<th>닉네임</th>
		<th>이름</th>
		<th>가입일자</th>
		<th>상태</th>
		<th>관리</th>
	</tr>
<% 	for(UsersDTO dto : list){%>
	<tr  >
		<td><%=dto.getId() %></td>
		<td><%=dto.getNick() %></td>
		<td><%=dto.getName()%></td>
		<td><%=sdf.format(dto.getReg())%></td>
		<td><%if((dto.getStatus()).equals("active")){%>
				정상
<% 			}else if((dto.getStatus()).equals("suspended")){%>
				정지
<%			}else{%>
				탈퇴
<%			}%>
		</td>
		<td align=center>
		<div class="btn-group">
			<button onclick="window.open('userInfo.jsp?id=<%=dto.getId()%>','management','width=400,height=400')">관리</button>
		</div>
		</td>
		
	</tr>
<%} %>
</table>

<div align=center>
<%
	// 페이징
	if(count>1){
		int pageCount = count/pageSize + (count%pageSize==0 ? 0: 1);
		int startPage = ((currentPage-1)/10)*10+1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock -1;
		
		if(endPage>pageCount){
			endPage = pageCount;
		}
		
		if(startPage>10){ %>
			<a href="userList.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<%		}
		for(int i=startPage; i<=endPage;i++){ %>
			<a href="userList.jsp?pageNum=<%=i %>">[<%=i %>]</a>
<%		}
		if(endPage<pageCount){ %>
			<a href="userList.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%		}
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
  </div>
</body>