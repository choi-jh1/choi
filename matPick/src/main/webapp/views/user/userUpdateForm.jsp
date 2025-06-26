<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="matPick.bean.UsersDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="matPick.bean.UsersDTO" %>

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

    .users td{
       background-color:white;
    }
   .container {
      max-width: 1000px;
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      align-items: center;
   }
   .form-group {
  margin-bottom: 200px;
  width: 400px;
  margin : 0 auto;

	}
	
	label {
	  display: block;
	  font-weight: bold;
	  margin-bottom: 5px;
	}
	
	input[type="text"],
	input[type="password"],
	input[type="email"],
	input[type="date"],
	select {
	  width: 100%;
	  padding: 10px;
	  box-sizing: border-box;
	  border: 1px solid #ccc;
	  border-radius: 6px;
	  font-size: 14px;
	}
	input[type="button"] { <%--중복확인 버튼 --%>
	  padding: 10px 10px;
	  background-color: #00c73c;
	  color: white;
	  border: none;
	  border-radius: 6px;
	  cursor: pointer;
	  font-size: 14px;
	}
	
	button { <%--제출 버튼 --%>
	  padding: 10px 10px;
	  background-color: #00c73c;
	  color: white;
	  border: none;
	  border-radius: 6px;
	  cursor: pointer;
	}

.profile-box {
  width: 100%;
  max-width: 600px;
  background: white;
  border-radius: 16px;
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
  padding: 40px 30px;
  margin: 40px auto;
  box-sizing: border-box;
  font-family: 'Noto Sans KR', sans-serif;
  border: 2px solid #00c73c33;
  transition: all 0.3s ease-in-out;
}

.profile-box h2 {
  font-size: 24px;
  font-weight: 700;
  color: #333;
  margin-bottom: 25px;
  border-bottom: 1px solid #eee;
  padding-bottom: 10px;
}

.profile-item-group {
  margin-bottom: 20px;
}

.profile-label {
  font-weight: bold;
  color: #555;
  margin-bottom: 4px;
  display: block;
}

.profile-value {
  font-size: 16px;
  color: #222;
  padding: 6px 0 12px;
  border-bottom: 1px solid #f0f0f0;
}

.profile-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 30px;
}

.profile-buttons button {
  background-color: #00c73c;
  color: white;
  border: none;
  padding: 10px 16px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.2s;
}

.profile-buttons button:hover {
  background-color: #00a030;
}
 .container1 {
    width: 600px;
    background: #ffffff;
    margin: 60px auto;
    padding: 40px 30px;
    border-radius: 16px;
	border: 2px solid black;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
  }

  h2 {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 30px;
  }

  .form-group {
    margin-bottom: 20px;
  }

  label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #444;
  }

  input[type="text"],
  input[type="password"],
  input[type="email"],
  input[type="date"],
  select {
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
  }

  .tel-row {
    display: flex;
    gap: 10px;
    margin-top: 5px;
  }

  .tel-row select {
    width: 80px;
  }

  .tel-row input {
    flex: 1;
  }

  button[type="submit"] {
    width: 100%;
    padding: 12px;
    background-color: #f9967a;
    color: black;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 10px;
  }

</style>

<%
	String sid = (String)session.getAttribute("sid");
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO dto = dao.myPage(sid);
	SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
	String birthDate = "";
	if(dto.getBirth_date() != null){
		birthDate = sdf.format(dto.getBirth_date());
	}
%>	
<% if(sid == null){ %>
		<script>
			alert("로그인 후 이용가능합니다.");
			window.location="loginForm.jsp";
		</script>
<% 	
	return;
	}%>
	<div class="container">
	  <div class="header">
	    <img src="../resources/logo.png" alt="로고" class="logo" onclick="window.location='../main/mainPage.jsp'">
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
	  </div>
	  
	  <div class="container1" >
	  <h2>내 정보수정</h2>
  <form action="userUpdatePro.jsp" method="post" name="userInput" onsubmit="return memCheck();">

    <div class="form-group">
      <label>아이디</label>
      <div style="padding: 6px 0 12px";><%=sid %></div>
      <input type="hidden" name="id" value="<%=sid%>" />
    </div>

    <div class="form-group">
      <label for="pw">비밀번호</label>
      <input style="padding: 6px 0 12px" type="password" id="pw" name="pw" maxlength="100" required>
    </div>

    <div class="form-group">
      <label for="pw2">비밀번호 확인</label>
      <input style="padding: 6px 0 12px" type="password" id="pw2" name="pw2" maxlength="100" required />
    </div>

    <div class="form-group">
      <label for="nick">닉네임</label>
      <input style="padding: 6px 0 12px" type="text" id="nick" name="nick" maxlength="20" value="<%=dto.getNick() %>" required>
    </div>

    <div class="form-group">
      <label for="email">이메일</label>
      <input style="padding: 6px 0 12px" type="email" id="email" name="email" value="<%=dto.getEmail() %>">
    </div>

    <div class="form-group">
      <label for="telecom">통신사 및 전화번호</label>
      <div class="tel-row">
        <select name="telecom" id="telecom">
          <option value="SKT">SKT</option>
          <option value="KT">KT</option>
          <option value="LG U+">LG U+</option>
        </select>
        <input style="padding: 6px 0 12px" type="text" id="tel" name="phone" placeholder="010-0000-0000" required value="<%=dto.getPhone() %>">
      </div>
    </div>

    <div class="form-group">
      <label>생년월일</label>
      <div><%=birthDate %></div>
      <input style="padding: 6px 0 12px" type="hidden" name="birth_date" value="<%=birthDate %>"/>
    </div>
	 <div class="form-group">
    	<button type="submit">제출</button>
    </div>
  </form>
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
