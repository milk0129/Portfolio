<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/loginstyle.css">
</head>
<body>
<%@ include file="bodTop.jspf"%>
  <main>
    <header>
      <h2>회원가입</h2>
    </header>

    <section>
	  <form action="<%= request.getContextPath() %>/UserController" method="post">
      <input type="hidden" name="action" value="signup">
        <label for="userName">이름</label>
        <input type="text" id="userName" name="userName" placeholder="이름" required>

        <label for="userBirth">생년월일</label>
        <input type="date" id="userBirth" name="userBirth" required>

        <label for="userId">아이디</label>
        <input type="text" id="userId" name="userId" placeholder="아이디" required>
        <p class="info-text">5자 이상의 숫자와 영문자 조합으로 입력하세요</p>
        
        <label for="userEmail">이메일</label>
        <input type="text" id="userEmail" name="userEmail" placeholder="이메일" required>

        <label for="userPw">비밀번호</label>
        <input type="password" id="userPw" name="userPw" placeholder="비밀번호" required>

        <label for="userPwChk">비밀번호 확인</label>
        <input type="password" id="userPwChk" name="userPwChk" placeholder="비밀번호 확인" required>

        <button type="submit">회원가입</button>
      </form>

      <p id="resultMsg"></p>
    </section>

    <footer>
      <p>이미 회원이신가요? <a href="<%= request.getContextPath() %>/UserController?action=loginForm">로그인</a></p>
    </footer>
  </main>
    <p class="pFooter">ⓒCopyright 김성진</p>
</body>
</html>