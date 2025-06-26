<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "matPick.bean.UsersDAO" %>
<jsp:useBean class = "matPick.bean.UsersDTO" id ="dto"/>
<jsp:setProperty name = "dto" property = "*"/>
<%@ page import = "matPick.bean.QnaDAO" %>
<%@ page import = "matPick.bean.QnaDTO" %>
<%@ page import = "java.util.ArrayList" %>

<%
   String sid = (String)session.getAttribute("sid");
   if(sid == null){ %>
   <script>
      alert("로그인 후 이용가능합니다.");
      window.location="loginForm.jsp";
   </script>
<%    }%>
<% 
   UsersDAO dao = UsersDAO.getInstance();
   dto = dao.myPage(sid);
   int count = 0;

%>
<head>
	<link rel="stylesheet" type="text/css" href="../resources/login.css"> 
</head>
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
      border: 3px solid black;
         
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
    .cate {
       cursor: pointer;
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
  margin-bottom: 15px;
  max-width: 300px;
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
  width: 400px;
  margin: 0 auto;
  background: white;
  border: 2px solid #b3e6b3;
  border-radius: 12px;
  padding: 20px;
  box-sizing: border-box;
  font-family: Arial, sans-serif;
}

.profile-header {
  position: relative;
  margin-bottom: 20px;
}

.profile-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: bold;
}

.profile-header p {
  margin: 5px 0;
  color: gray;
  font-size: 14px;
}

.edit-btn {
  background: #eee;
  border: none;
  border-radius: 6px;
  padding: 4px 10px;
  font-size: 12px;
  cursor: pointer;
}

.profile-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
  font-size: 14px;
}
.form-box {
  width: 80%;
  margin: 0 auto;
}
#content {
  resize: none;
  overflow: auto;
  width: 100%;
  height: 300px;
  font-size: 16px;
  padding: 10px;
}
  .form-container {
    width: 600px;
    margin: 40px auto;
    background: white;
    border: 2px solid black;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 4px 4px 10px rgba(0,0,0,0.1);
  }

  .form-container h2 {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
  }

  .form-container input[type="text"],
  .form-container textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    margin-bottom: 15px;
    border-radius: 6px;
    font-size: 14px;
  }

  .form-container input[type="file"] {
    margin-bottom: 15px;
  }

  .form-container textarea {
    height: 250px;
    resize: none;
  }

  .form-container .btn-wrap {
    display: flex;
    justify-content: center;
    gap: 10px;
  }

  .form-container button {
    background-color: #f9967a;
    color: black;
    padding: 10px 30px;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
  }

/*   .form-container button:hover {
    background-color: #009d2a;
  } */
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
  .form-container input[type="file"] {
    display: none; /* 기본 파일 입력 숨김 */
  }

  .custom-file-upload {
    display: inline-block;
    padding: 10px 16px;
    background-color: #f9967a;
    color: #333;
    border: 1px solid #ccc;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    margin-bottom: 15px;
    transition: background 0.2s;
  }

  .custom-file-upload:hover {
    background-color: #ddd;
  }

  .file-name {
    font-size: 13px;
    color: #666;
    margin-left: 10px;
  }

   </style>
    <body>
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
   

	<div class="form-container">
	  <h2>건의/문의하기</h2>
	  <form action="qnaWritePro.jsp" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="writer" value="<%=sid %>"/>
	    <input type="text" name="title" placeholder="제목을 입력하세요" required>
	
	    <label for="file-upload" class="custom-file-upload">파일 선택</label>
	    <span class="file-name" id="file-name">선택된 파일 없음</span>
	    <input id="file-upload" type="file" name="img" onchange="updateFileName(this)">
	
	    <textarea name="content" placeholder="내용을 입력하세요" required></textarea>
	
	    <div class="btn-wrap">
	      <button type="submit">작성 완료</button>
	      <button type="button" onclick="location.href='userQnaList.jsp'">글 목록</button>
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
  
<script>
  function updateFileName(input) {
    const fileName = input.files.length > 0 ? input.files[0].name : '선택된 파일 없음';
    document.getElementById('file-name').textContent = fileName;
  }
</script>
</body>
    