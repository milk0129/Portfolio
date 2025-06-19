<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>자유 게시판</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/css/boardTitleList.css">
</head>
<body>

<h2><a href="BoardController?action=list">** 자유 게시판 **</a></h2>
<%@ include file="bodTop.jspf" %>

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
            <c:choose>
              <c:when test="${not empty list}">
                <c:forEach var="dto" items="${list}">
                  <tr onclick="location.href='BoardController?action=view&bod_no=${dto.bod_no}'">
                    <td>${dto.bod_no}</td>
                    <td>${dto.bod_subject}</td>
                    <td>${dto.bod_writer}</td>
                    <td>${dto.bod_logtime}</td>
                    <td>${dto.bod_readCnt}</td>
                    <td>${dto.bod_connIp}</td>
                  </tr>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <tr><td colspan="6">등록된 게시글이 없습니다.</td></tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- 로그인 박스 -->
  <div class="login-box-wrapper">
    <div class="login-box">
      <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
          <c:set var="userId" value="${sessionScope.loginUser.userId}" />
          <c:set var="userName" value="${sessionScope.loginUser.userName}" />
          <c:set var="profileImg" value="${sessionScope.loginUser.profileImg}" />
          <c:set var="imgPath" value="${empty profileImg ? (pageContext.request.contextPath += '/profiles/default.png') : (pageContext.request.contextPath += '/profiles/' += profileImg)}" />

          <div class="profile-container">
            <div class="profile-img">
              <a href="${pageContext.request.contextPath}/UserController?action=userEditForm">
                <img src="${imgPath}" alt="프로필 이미지" width="80" height="80" style="cursor: pointer;">
              </a>
            </div>
            <div class="profile-info">
              <div class="profile-name">${userName}님!</div>
              <div class="profile-id">${userId}</div>
            </div>
          </div>
          <div class="profile-links">
            <a href="${pageContext.request.contextPath}/UserController?action=userEditForm">회원정보 수정</a> |
            <a href="${pageContext.request.contextPath}/BoardController?action=myList">내 글 관리</a> |
            <a href="UserController?action=deleteUserCheckForm">회원 탈퇴</a>
          </div>
          <form action="UserController" method="post">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="logout-button">로그아웃</button>
          </form>
        </c:when>
        <c:otherwise>
          <h4 class="login-title">안전하게 게시판 이용하기</h4>
          <form action="UserController" method="get">
            <input type="hidden" name="action" value="loginForm">
            <input type="submit" value="로그인" class="login-button">
          </form>
          <div class="login-links">
            <a href="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/boardFrame/findId.jsp">아이디 찾기</a> |
            <a href="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/boardFrame/signUp.jsp">회원가입</a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<!-- 페이징 영역 -->
<c:set var="searchField" value="${searchField}" />
<c:set var="searchKeyword" value="${searchKeyword}" />
<c:set var="nowBlock" value="${paging.nowBlock}" />
<c:set var="pagePerBlock" value="${paging.pagePerBlock}" />

<div class="pagination">
  <c:if test="${nowBlock > 0}">
    <a href="BoardController?action=list&nowBlock=${nowBlock - 1}&nowPage=${(nowBlock - 1) * pagePerBlock}&searchField=${searchField}&search=${searchKeyword}">&laquo;</a>
  </c:if>

  <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
    <c:set var="isActive" value="${paging.nowPage == i}" />
    <a href="BoardController?action=list&nowBlock=${nowBlock}&nowPage=${i}&searchField=${searchField}&search=${searchKeyword}"
       class="${isActive ? 'active' : ''}">
       ${i + 1}
    </a>
  </c:forEach>

  <c:if test="${nowBlock + 1 < paging.totalBlock}">
    <a href="BoardController?action=list&nowBlock=${nowBlock + 1}&nowPage=${(nowBlock + 1) * pagePerBlock}&searchField=${searchField}&search=${searchKeyword}">&raquo;</a>
  </c:if>
</div>

<!-- 검색창 UI -->
<form action="BoardController" method="get" class="search-form">
  <input type="hidden" name="action" value="list">

  <select name="searchField">
    <option value="all" ${searchField eq 'all' ? 'selected' : ''}>제목+내용</option>
    <option value="subject" ${searchField eq 'subject' ? 'selected' : ''}>제목</option>
    <option value="content" ${searchField eq 'content' ? 'selected' : ''}>내용</option>
    <option value="writer" ${searchField eq 'writer' ? 'selected' : ''}>작성자</option>
  </select>

  <input type="text" name="search" placeholder="검색어 입력"
         value="${param.search != null ? param.search : ''}">

  <button type="submit">검색</button>
</form>

<%@ include file="bodBottom.jspf" %>
</body>
</html>
