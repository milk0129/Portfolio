<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게시글 작성</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/boardInsUpdFrame.css">
</head>
<body>

  <h2>** 게시글 작성 **</h2>
  
  <form action="BoardController" method="post">
  <input type="hidden" name="action" value="write">
    <%@ include file="bodTop.jspf" %>

    <table>
      <tr>
        <td class="label">작성자</td>
        <td>
          <input type="text" name="bod_writer" value="${userId}" readonly>
        </td>
        <td class="label">비밀번호</td>
        <td>
          <input type="password" name="bod_pwd" class="input" required>
        </td>
      </tr>
      <tr>
        <td class="label">제목</td>
        <td colspan="3">
          <input type="text" name="bod_subject" class="input" required>
        </td>
      </tr>
      <tr>
        <td class="label">이메일</td>
        <td colspan="3">
          <input type="text" name="bod_email" value="${userEmail}" required>
        </td>
      </tr>
      <tr>
        <td rowspan="2" class="label image-cell">
        	<img src="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/img/side.jpg" alt="Side Image">
        </td>
        <td colspan="3">
          <textarea name="bod_content" class="input full" required></textarea>
        </td>
      </tr>
    </table>

    <div class="buttons">
      <button type="submit">등록</button>
      <button type="reset">다시쓰기</button>
    </div>

    <%@ include file="bodBottom.jspf" %>
  </form>
</body>
</html>
