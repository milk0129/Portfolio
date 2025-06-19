<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boardV02.BoardV02DTO" %>
<%
    BoardV02DTO dto = (BoardV02DTO) request.getAttribute("dto");
    boolean fromMyPage = request.getAttribute("fromMyPage") != null;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게시글 수정</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/boardInsUpdFrame.css">
</head>
<body>

<h2>** 게시글 수정 **</h2>

<form action="BoardController" method="post">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="bod_no" value="<%= dto.getBod_no() %>">
  <input type="hidden" name="bod_pwd" value="<%= dto.getBod_pwd() %>">

  <%@ include file="bodTop.jspf" %>

  <table>
    <tr>
      <td class="label">작성자</td>
      <td><input type="text" name="bod_writer" class="input" readonly value="<%= dto.getBod_writer() %>"></td>
      <td class="label">비밀번호</td>
      <td><input type="password" name="bod_pwd" class="input" readonly value="<%= dto.getBod_pwd() %>"></td>
    </tr>
    <tr>
      <td class="label">제목</td>
      <td colspan="3"><input type="text" name="bod_subject" class="input" required value="<%= dto.getBod_subject() %>"></td>
    </tr>
    <tr>
      <td class="label">이메일</td>
      <td colspan="3"><input type="email" name="bod_email" class="input" required value="<%= dto.getBod_email() %>"></td>
    </tr>
    <tr>
      <td rowspan="2" class="label image-cell">
        <img src="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/img/side.jpg" alt="Side Image">
      </td>
      <td colspan="3">
        <textarea name="bod_content" class="input full" required><%= dto.getBod_content() %></textarea>
      </td>
    </tr>
  </table>

  <div class="buttons">
    <button type="submit">수정</button>
    <button type="reset">다시쓰기</button>
  </div>

  <%@ include file="bodBottom.jspf" %>
</form>

</body>
</html>
