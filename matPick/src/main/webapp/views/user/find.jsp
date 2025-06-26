<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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

