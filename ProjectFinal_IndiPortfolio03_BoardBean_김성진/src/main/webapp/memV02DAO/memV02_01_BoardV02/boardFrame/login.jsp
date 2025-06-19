<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/css/loginstyle.css">
</head>
<body>

<%@ include file="bodTop.jspf" %>

<main>
  <header>
    <h2>로그인</h2>
  </header>

  <section>
    <form action="${pageContext.request.contextPath}/UserController" method="post">
      <input type="hidden" name="action" value="login">

      <label for="userId">아이디</label>
      <input type="text" id="userId" name="userId" placeholder="아이디 입력" required>

      <label for="userPw">비밀번호</label>
      <input type="password" id="userPw" name="userPw" placeholder="비밀번호 입력" required>

      <button type="submit">로그인</button>
    </form>

    <p id="resultMsg">
      <c:if test="${not empty loginFailMsg}">
        <span style="color:red">${loginFailMsg}</span>
      </c:if>
    </p>
  </section>

  <footer>
    <p>아직 회원이 아니신가요? 
       <a href="${pageContext.request.contextPath}/UserController?action=signUpForm">회원가입</a>
    </p>
  </footer>
</main>

<p class="pFooter">ⓒCopyright 김성진</p>

</body>
</html>
