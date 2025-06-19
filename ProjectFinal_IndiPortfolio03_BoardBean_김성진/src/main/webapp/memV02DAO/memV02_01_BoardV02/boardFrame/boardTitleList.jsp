<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, boardV02.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>자유 게시판</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/boardTitleList.css">
</head>
<body>

<h2><a href="BoardController?action=list">** 자유 게시판 **</a></h2>
<%@ include file="bodTop.jspf"%>

<div class="page-wrapper">

  <div class="board-wrapper">
    <div class="container">
      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th>번호</th>
              <th>제목</th>
              <th>작성자</th>
              <th>작성일</th>
              <th>조회</th>
              <th>IP</th>
            </tr>
          </thead>
          <tbody>
            <%
              List<BoardV02DTO> list = (List<BoardV02DTO>) request.getAttribute("list");
              if (list != null && !list.isEmpty()) {
                for (BoardV02DTO dto : list) {
            %>
            <tr onclick="location.href='BoardController?action=view&bod_no=<%=dto.getBod_no()%>'">
              <td><%= dto.getBod_no() %></td>
              <td><%= dto.getBod_subject() %></td>
              <td><%= dto.getBod_writer() %></td>
              <td><%= dto.getBod_logtime() %></td>
              <td><%= dto.getBod_readCnt() %></td>
              <td><%= dto.getBod_connIp() %></td>
            </tr>
            <% }
              } else {
            %>
            <tr><td colspan="6">등록된 게시글이 없습니다.</td></tr>
            <% } %>
          </tbody>
        </table>

      </div>
    </div>
  </div>

  <!-- 로그인 박스 -->
  <div class="login-box-wrapper">
    <div class="login-box">
      <%
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        if (loginUser != null) {
          String userId = loginUser.getUserId();
          String userName = loginUser.getUserName();
          String profileImg = loginUser.getProfileImg();
          String imgPath = (profileImg != null && !profileImg.trim().isEmpty())
                           ? request.getContextPath() + "/profiles/" + profileImg
                           : request.getContextPath() + "/profiles/default.png";
      %>
      <div class="profile-container">
        <div class="profile-img">
          <a href="<%= request.getContextPath() %>/UserController?action=userEditForm">
          <img src="<%= imgPath %>" alt="프로필 이미지" width="80" height="80" style="cursor: pointer;">
          </a>
        </div>
        <div class="profile-info">
          <div class="profile-name"><%= userName %>님!</div>
          <div class="profile-id"><%= userId %></div>
        </div>
      </div>
      <div class="profile-links">
        <a href="<%= request.getContextPath() %>/UserController?action=userEditForm">회원정보 수정</a> |
        <a href="<%= request.getContextPath() %>/BoardController?action=myList">내 글 관리</a> |
        <a href="UserController?action=deleteUserCheckForm">회원 탈퇴</a>
      </div>
      <form action="UserController" method="post">
        <input type="hidden" name="action" value="logout">
        <button type="submit" class="logout-button">로그아웃</button>
      </form>
      <%
        } else {
      %>
        <h4 class="login-title">안전하게 게시판 이용하기</h4>
        <form action="UserController" method="get">
          <input type="hidden" name="action" value="loginForm">
          <input type="submit" value="로그인" class="login-button">
        </form>
        <div class="login-links">
          <a href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/boardFrame/findId.jsp">아이디 찾기</a> |
          <a href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/boardFrame/signUp.jsp">회원가입</a>
        </div>
      <%
        }
      %>
    </div>
  </div>
</div>

<!-- 페이징 영역 -->
<%
  PagingUtil paging = (PagingUtil) request.getAttribute("paging");
  String searchField = (String) request.getAttribute("searchField");
  String searchKeyword = (String) request.getAttribute("searchKeyword");

  int nowBlock = paging.getNowBlock();
  int pagePerBlock = paging.getPagePerBlock();
  
%>

<div class="pagination">
  <% if (nowBlock > 0) { %>
    <a href="BoardController?action=list&nowBlock=<%= nowBlock - 1 %>&nowPage=<%= (nowBlock - 1) * pagePerBlock %>
             &searchField=<%= searchField %>&search=<%= searchKeyword %>">&laquo;</a>
  <% } %>

  <% for (int i = paging.getStartPage(); i <= paging.getEndPage(); i++) { %>
    <a href="BoardController?action=list&nowBlock=<%= nowBlock %>&nowPage=<%= i %>
             &searchField=<%= searchField %>&search=<%= searchKeyword %>"
       <%= (paging.getNowPage() == i) ? "class='active'" : "" %>>
      <%= i + 1 %>
    </a>
  <% } %>

  <% if (nowBlock + 1 < paging.getTotalBlock()) { %>
    <a href="BoardController?action=list&nowBlock=<%= nowBlock + 1 %>&nowPage=<%= (nowBlock + 1) * pagePerBlock %>
             &searchField=<%= searchField %>&search=<%= searchKeyword %>">&raquo;</a>
  <% } %>
</div>

<!-- 검색창 UI -->
<form action="BoardController" method="get" class="search-form">
  <input type="hidden" name="action" value="list">

		<select name="searchField">
		  <option value="all" <%= "all".equals(searchField) ? "selected" : "" %>>제목+내용</option>
		  <option value="subject" <%= "subject".equals(searchField) ? "selected" : "" %>>제목</option>
		  <option value="content" <%= "content".equals(searchField) ? "selected" : "" %>>내용</option>
		  <option value="writer" <%= "writer".equals(searchField) ? "selected" : "" %>>작성자</option>
		</select>

  <input type="text" name="search" placeholder="검색어 입력"
         value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">

  <button type="submit">검색</button>
</form>

<%@ include file="bodBottom.jspf" %>
</body>
</html>
