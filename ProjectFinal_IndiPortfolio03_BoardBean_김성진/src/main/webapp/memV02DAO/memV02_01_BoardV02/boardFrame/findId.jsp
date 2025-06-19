<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/loginstyle.css">
</head>
<body>
<%@ include file="bodTop.jspf"%>
<main>
  <header>
    <h2>아이디 찾기</h2>
  </header>

  <section>
    <form method="post" action="<%= request.getContextPath() %>/UserController">
      <input type="hidden" name="action" value="findId">

      <label for="userName">이름</label>
      <input type="text" name="userName" id="userName" required>

      <label for="userEmail">이메일</label>
      <input type="email" name="userEmail" id="userEmail" required>

      <button type="submit">아이디 찾기</button>
    </form>

    <%
      String name = (String) request.getAttribute("userName");
      String email = (String) request.getAttribute("userEmail");
      String foundId = (String) request.getAttribute("foundId");
      if (name != null && email != null) {
    %>
      <div class="info-text">
        <% if (foundId != null) { %>
          회원님의 아이디는 <strong><%= foundId %></strong> 입니다.
        <% } else { %>
          <span style="color: red;">일치하는 회원 정보가 없습니다.</span>
        <% } %>
      </div>
    <% } %>

    <nav>
      <a href="<%= request.getContextPath() %>/UserController?action=loginForm">로그인</a> |
      <a href="<%= request.getContextPath() %>/UserController?action=signUpForm">회원가입</a>
    </nav>
  </section>
</main>

<footer>
  ⓒCopyright 김성진
</footer>
</body>
</html>
