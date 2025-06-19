<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전체 게시글 내용 보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/css/boardAllContent.css">
</head>
<body>

<h2><a href="BoardController?action=allList" style="cursor: pointer;">** 게시글 모아 보기 **</a></h2>
<%@ include file="bodTop.jspf" %>

<c:choose>
  <c:when test="${not empty postList}">
    <c:forEach var="dto" items="${postList}">
      <div class="post">
        <div class="post-header">
          <div class="post-title">${dto.bod_subject}</div>
          <div class="post-meta">
            글번호: ${dto.bod_no} |
            작성자: ${dto.bod_writer} |
            작성일: ${dto.bod_logtime}
          </div>
        </div>
        <div class="post-content">
          <c:out value="${dto.bod_content}" escapeXml="false" />
        </div>
      </div>
    </c:forEach>
  </c:when>
  <c:otherwise>
    <p>등록된 게시글이 없습니다.</p>
  </c:otherwise>
</c:choose>

<div class="pagination">
  <c:if test="${nowBlock > 0}">
    <a href="BoardController?action=allList&nowPage=${beginPage - 1}">&laquo;</a>
  </c:if>

  <c:forEach var="i" begin="${beginPage}" end="${endPage}">
    <c:set var="displayPage" value="${i + 1}" />
    <c:choose>
      <c:when test="${i == nowPage}">
        <span class="now">${displayPage}</span>
      </c:when>
      <c:otherwise>
        <a href="BoardController?action=allList&nowPage=${i}">${displayPage}</a>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <c:if test="${nowBlock < totalBlock - 1}">
    <a href="BoardController?action=allList&nowPage=${endPage + 1}">&raquo;</a>
  </c:if>
</div>

<%@ include file="bodBottom.jspf" %>
</body>
</html>
