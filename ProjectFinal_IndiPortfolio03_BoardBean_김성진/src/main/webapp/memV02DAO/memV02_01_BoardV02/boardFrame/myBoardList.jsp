<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, boardV02.BoardV02DTO, boardV02.PagingUtil" %>
<%
    String loginUserId = (String) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    List<BoardV02DTO> myPostList = (List<BoardV02DTO>) request.getAttribute("myPostList");
    PagingUtil pu = (PagingUtil) request.getAttribute("pu");
    int nowPage = (Integer) request.getAttribute("nowPage");
    int nowBlock = (Integer) request.getAttribute("nowBlock");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>내 게시글 관리</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/boardTitleList.css"> 
</head>
<body>

<h2>** <%= userName %>님의 게시글 관리 **</h2>
<%@ include file="bodTop.jspf"%>

<table class="myTable">
  <thead>
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성일</th>
      <th>조회수</th>
      <th>IP</th>
      <th>수정</th>
      <th>삭제</th>
    </tr>
  </thead>
  <tbody>
  <%
    for (BoardV02DTO dto : myPostList) {
  %>
    <tr>
      <td><%= dto.getBod_no()%></td>
      <td><%= dto.getBod_subject() %></td>
      <td><%= dto.getBod_logtime() %></td>
      <td><%= dto.getBod_readCnt() %></td>
      <td><%= dto.getBod_connIp() %></td>
      <td>
        <form action="BoardController" method="post" style="display:inline;">
          <input type="hidden" name="action" value="editFormDirect">
          <input type="hidden" name="bod_no" value="<%= dto.getBod_no() %>">
          <input type="hidden" name="bod_pwd" value="<%= dto.getBod_pwd() %>">
          <a href="BoardController?action=editFormDirect&bod_no=<%= dto.getBod_no() %>">수정</a>
        </form>
      </td>
      <td>
        <a href="BoardController?action=deleteDirect&bod_no=<%= dto.getBod_no() %>"
           onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
      </td>
    </tr>
  <%
    }
  %>
  </tbody>
</table>

<div class="pagination">
  <% if (pu.getStartPage() > 0) { %>
    <a href="BoardController?action=myList&nowPage=<%= pu.getStartPage() - 1 %>&nowBlock=<%= nowBlock - 1 %>">≪</a>
  <% } %>

  <% for (int i = pu.getStartPage(); i <= pu.getEndPage(); i++) { %>
    <a href="BoardController?action=myList&nowPage=<%= i %>&nowBlock=<%= nowBlock %>"
       class="<%= (i == nowPage) ? "active" : "" %>"><%= i + 1 %></a>
  <% } %>

  <% if (pu.getEndPage() < pu.getTotalPage() - 1) { %>
    <a href="BoardController?action=myList&nowPage=<%= pu.getEndPage() + 1 %>&nowBlock=<%= nowBlock + 1 %>">≫</a>
  <% } %>
</div>

<%@ include file="bodBottom.jspf"%>
</body>
</html>
