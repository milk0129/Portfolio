<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/css/loginstyle.css">
</head>
<body>

<%@ include file="bodTop.jspf"%>

<main>
  <header>
    <h2>아이디 찾기</h2>
  </header>

  <section>
    <form method="post" action="${pageContext.request.contextPath}/UserController">
      <input type="hidden" name="action" value="findId">

      <label for="userName">이름</label>
      <input type="text" name="userName" id="userName" required>

      <label for="userEmail">이메일</label>
      <input type="email" name="userEmail" id="userEmail" required>

      <button type="submit">아이디 찾기</button>
    </form>

    <c:if test="${not empty userName and not empty userEmail}">
      <div class="info-text">
        <c:choose>
          <c:when test="${not empty foundId}">
            회원님의 아이디는 <strong>${foundId}</strong> 입니다.
          </c:when>
          <c:otherwise>
            <span style="color: red;">일치하는 회원 정보가 없습니다.</span>
          </c:otherwise>
        </c:choose>
      </div>
    </c:if>

    <nav>
      <a href="${pageContext.request.contextPath}/UserController?action=loginForm">로그인</a> |
      <a href="${pageContext.request.contextPath}/UserController?action=signUpForm">회원가입</a>
    </nav>
  </section>
</main>

<footer>
  ⓒCopyright 김성진
</footer>
</body>
</html>
