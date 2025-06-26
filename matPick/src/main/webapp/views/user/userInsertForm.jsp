<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <style>
	body {
	     font-family: 'Arial', sans-serif;
	     background: url('../resources/bgImg.png') no-repeat center center fixed;
	     background-size: cover;
	     margin: 0;
	     padding: 0;
	   }

    .container {
      max-width: 600px;
      background: #ffffff;
      margin: 60px auto;
      padding: 40px 30px;
      border-radius: 16px;
      border: /* 2px solid #00c73c33; */;
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

    input[type="button"] {
      margin-top: 5px;
      padding: 10px;
      background-color: #f9967a;
      color: black;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
      width: 100%;
    }

    .radio-group {
      display: flex;
      gap: 20px;
      margin-top: 5px;
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
</head>
<body>
  <div class="container">
    <h2>회원가입</h2>
    <form action="userInsertPro.jsp" method="post" name="userInput" onsubmit="return memCheck();">

      <div class="form-group">
        <label for="id">아이디</label>
        <input type="text" id="id" name="id" maxlength="20" required>
        <input type="button" value="중복확인" onclick="idCheck();">
        <div id="idResult"></div>
      </div>

      <div class="form-group">
        <label for="pw">비밀번호</label>
        <input type="password" id="pw" name="pw" maxlength="100" required>
      </div>

      <div class="form-group">
        <label for="pw2">비밀번호 확인</label>
        <input type="password" id="pw2" name="pw2" required>
      </div>

      <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" name="name" maxlength="20" required>
      </div>

      <div class="form-group">
        <label for="nick">닉네임</label>
        <input type="text" id="nick" name="nick" maxlength="20" required>
      </div>

      <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="email" name="email" placeholder="example@email.com">
      </div>

      <div class="form-group">
        <label for="telecom">통신사 및 전화번호</label>
        <div class="tel-row">
          <select name="telecom" id="telecom">
            <option value="SKT">SKT</option>
            <option value="KT">KT</option>
            <option value="LG U+">LG U+</option>
          </select>
          <input type="text" id="tel" name="phone" placeholder="010-0000-0000" required>
        </div>
      </div>

      <div class="form-group">
        <label>성별</label>
        <div class="radio-group">
          <label><input type="radio" name="gender" value="남자"> 남자</label>
          <label><input type="radio" name="gender" value="여자"> 여자</label>
        </div>
      </div>

      <div class="form-group">
        <label for="birth_date">생년월일</label>
        <input type="date" id="birth_date" name="birth_date">
      </div>

      <button type="submit">제출</button>
    </form>
  </div>
<script>
function idCheck(){
	let id = document.getElementById("id").value;
	open("confirmId.jsp?id="+id, 'confirm', 'width=400, height=400');
}
function memCheck() {
  let check = document.userInput;
  let pw = check.pw.value;
  let name = document.getElementById("name").value.trim();
  let nameCheck = /^[가-힣]{2,5}$/;
  let phone = document.getElementById("tel").value.trim();
  let phoneCheck = /^010-\d{4}-\d{4}$/;

	if (!pw) {
	    alert("비밀번호를 입력해주세요");
	    return false;
	}
	if (pw !== check.pw2.value) {
	    alert("비밀번호를 동일하게 입력해주세요");
	    return false;
	}
	if (pw.length < 8 || pw.length > 20) {
	    alert("비밀번호는 8~20자리여야 합니다.");
	    return false;
	}
	if (!/[A-Z]/.test(pw)) {
	    alert("비밀번호에는 대문자가 최소 1개가 포함되어야 합니다.");
	    return false;
	}
	if (!/[!@#$%^&*(),.?:{}|<>]/.test(pw)) {
	    alert("비밀번호에는 특수문자가 최소 1개가 포함되어야 합니다.");
	    return false;
	}   
	if (/\s/.test(pw)) {
	    alert("비밀번호에는 공백이 포함되어 있으면 안 됩니다.");
	    return false;
    }
	if (!nameCheck.test(name)) {
		alert("이름은 한글 2~5자 사이여야 합니다.");
	   	return false;
    }
	if (!phoneCheck.test(phone)){
		alert("휴대폰 번호는 반드시 010-0000-0000 형식으로 입력해주세요.");
	   	return false;
    }
    return true;
}
</script>

</body>
</html>