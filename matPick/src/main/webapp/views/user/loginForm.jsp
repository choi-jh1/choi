<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
  body {
    font-family: 'Arial', sans-serif;
    background: url('../resources/bgImg.png') no-repeat center center fixed;
    background-size: cover;
    margin: 0;
    padding: 0;
  }

  .page-wrapper {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    align-items: center;
    justify-content: center;
  }

  .logo {
    width: 220px;
    margin-top: 30px;

    cursor: pointer;
  }

  .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-grow: 1;
  }

  .login-box {
    width: 650px;
    border: 2px solid black;
    padding: 40px;
    font-size: 16px;
    border-radius: 8px;
    box-shadow: 3px 3px 8px rgba(0,0,0,0.1);
    background-color: white;
  }

  .login-box h2 {
    text-align: center;
    margin-bottom: 30px;
  }

  .login-box input[type="text"],
  .login-box input[type="password"] {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 6px;
  }

  .auto-login {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 20px;
    font-size: 14px;
  }

  .login-main {
    width: 100%;
    padding: 12px;
    background-color: #f9967a;
    color: black;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
    margin-bottom: 15px;
  }

  .join-box {
    display: flex;
    gap: 15px;
  }

  .login-sub {
    flex: 1;
    padding: 10px;
    background-color: #f9967a;
    color: black;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
  }

  .footer {
    text-align: center;
    font-size: 12px;
    color: #666;
    padding: 20px 0;
  }
</style>

<div class="page-wrapper">
  <!-- 로고 -->
  <img src="../resources/logo.png" alt="로고" class="logo" onclick="window.location='../main/mainPage.jsp'">

  <!-- 로그인 폼 -->
  <div class="login-container">
    <form action="loginPro.jsp" method="post" class="login-box">
      <h2>맛은 픽하는 시대 <strong>MAT.PICK</strong></h2>
      
      <label for="id">아이디</label>
      <input type="text" name="id" id="id" required>
      
      <label for="pw">비밀번호</label>
      <input type="password" name="pw" id="pw" required>

      <div class="auto-login">
        <input type="checkbox" id="auto" name="auto" value="1" />
        <label for="auto">자동로그인</label>
      </div>

      <button class="login-main">로그인</button>

      <div class="join-box">
        <button class="login-sub" type="button" onclick="window.location='../user/userInsertForm.jsp'">회원가입</button>
        <button class="login-sub" type="button" onclick="window.location='../user/find.jsp'">아이디/비밀번호 찾기</button>
      </div>
    </form>
  </div>

  <!-- 푸터 -->
  <div class="footer">
    <p>© 2025 MAT.PICK Team. Designed & Developed by 수한, 석범, 정환, 재희</p>
    <p>
      <a href="#" style="color: #999; margin-right: 10px;">이용약관</a> |
      <a href="#" style="color: #999;">개인정보처리방침</a>
    </p>
    <p style="font-size: 11px; color: #aaa;">프로젝트 기간: 2025.06.02 ~ 2025.06.23 | Ver. 1.0</p>
  </div>
</div>
