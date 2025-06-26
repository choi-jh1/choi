<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
  body {
    font-family: 'Arial', sans-serif;
    background: url('../resources/bgImg.png') no-repeat center center fixed;
    background-size: cover;
    margin: 0;
    padding: 0;
  }

  .login-container {
    display: flex;
    flex-direction: column; /* 세로 정렬 */
    justify-content: center;
    align-items: center;
    height: 50h;
    gap: 30px;
  }

  .logo {
    width: 220px;
    cursor: pointer;
  }

  .login-box {
    width: 650px;
    border: /* 2px solid black; */;
    padding: 40px;
    font-size: 16px;
    border-radius: 8px;
    box-shadow: 3px 3px 8px rgba(0,0,0,0.1);
    background-color: white;
    margin-bottom:80px;
  }

  .login-box h2 {
    text-align: center;
    margin-bottom: 30px;
  }

  .login-box input[type="text"],
  .login-box input[type="email"] {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 6px;
  }

  .tab-buttons {
    display: flex;
    margin-bottom: 20px;
    border-bottom: 2px solid #ccc;
  }

  .tab-button {
    flex: 1;
    padding: 10px;
    background: #f2f2f2;
    border: none;
    cursor: pointer;
    font-weight: bold;
    border-radius: 6px 6px 0 0;
  }

  .tab-button.active {
    background: white;
    border-bottom: 2px solid white;
  }

  .tab-content {
    display: none;
  }

  .tab-content.active {
    display: block;
  }

  .login-main {
    width: 100%;
    padding: 12px;
    background-color: #f9967a;
    color: black	;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 15px;
  }

  .join-box {
    display: flex;
    gap: 15px;
    margin-top: 15px;
  }

  .footer {
    text-align: center;
    font-size: 12px;
    color: #666;
    padding: 20px 0;
  }
</style>

<!-- 가운데 정렬된 로고 -->
<div class="login-container">
  <img src="../resources/logo.png" alt="로고" class="logo" onclick="window.location='../main/mainPage.jsp'">

  <div class="login-box">
    <h2>맛은 픽하는 시대 <strong>MAT.PICK</strong></h2>

    <div class="tab-buttons">
      <button class="tab-button active" onclick="showTab(event, 'tab-id')">아이디 찾기</button>
      <button class="tab-button" onclick="showTab(event, 'tab-pw')">비밀번호 찾기</button>
    </div>

    <form action="findIdPro.jsp" method="post">
      <div id="tab-id" class="tab-content active">
        <label for="email">가입한 이메일</label>
        <input type="email" id="email" name="email" placeholder="example@email.com" required>
        <button type="submit" class="login-main">아이디 찾기</button>
      </div>
    </form>

    <form action="findPwPro.jsp" method="post">
      <div id="tab-pw" class="tab-content">
        <label for="user-id">가입한 아이디</label>
        <input type="text" id="user-id" name="id" placeholder="아이디" required>
        <label for="user-email">가입한 이메일</label>
        <input type="email" id="user-email" name="email" placeholder="example@email.com" required>
        <button type="submit" class="login-main">임시 비밀번호 발급</button>
      </div>
    </form>
  </div>
</div>

<div class="footer">
  <p>© 2025 MAT.PICK Team. Designed & Developed by 수한, 석범, 정환, 재희</p>
  <p>
    <a href="#" style="color: #999; margin-right: 10px;">이용약관</a> |
    <a href="#" style="color: #999;">개인정보처리방침</a>
  </p>
  <p style="font-size: 11px; color: #aaa;">프로젝트 기간: 2025.06.02 ~ 2025.06.23 | Ver. 1.0</p>
</div>

<script>
  function showTab(evt, tabId) {
    const buttons = document.querySelectorAll('.tab-button');
    const tabs = document.querySelectorAll('.tab-content');

    buttons.forEach(btn => btn.classList.remove('active'));
    tabs.forEach(tab => tab.classList.remove('active'));

    evt.target.classList.add('active');
    document.getElementById(tabId).classList.add('active');
  }
</script>

