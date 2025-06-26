<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 정보 수정</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background: url('../resources/bgImg.png') no-repeat center center fixed;
      background-size: cover;
      margin: 0;
      padding: 0;
    }

    .delete-box {
      max-width: 500px;
      margin: 80px auto;
      background: white;
      border: 2px solid black;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      padding: 40px 30px;
      text-align: center;
    }

    .delete-box h2 {
      font-size: 24px;
      margin-bottom: 25px;
      color: #333;
    }

    .form-group {
      margin-bottom: 25px;
      text-align: left;
    }

    .form-group label {
      font-weight: bold;
      display: block;
      margin-bottom: 10px;
    }

    .form-group input[type="password"] {
      width: 100%;
      padding: 10px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }

    .form-group button {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      background-color: #f9967a;
      color: black;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

/*     .form-group button:hover {
      background-color: #00b030;
    } */
  </style>
</head>
<body>
  <div class="delete-box">
    <h2>회원 정보 수정</h2>
    <form action="userCheckPwPro.jsp" method="post">
      <div class="form-group">
        <label for="pw">비밀번호 입력</label>
        <input type="password" id="pw" name="pw" maxlength="20" required>
      </div>
      <div class="form-group">
        <button type="submit">회원 정보 수정</button>
      </div>
    </form>
  </div>
</body>
</html>
