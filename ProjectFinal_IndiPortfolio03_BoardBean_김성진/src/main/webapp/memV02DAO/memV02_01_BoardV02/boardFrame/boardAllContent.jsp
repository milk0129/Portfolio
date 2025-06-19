<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, boardV02.*" %>

<%
	PagingUtil paging = (PagingUtil) request.getAttribute("paging");
    List<BoardV02DTO> postList = (List<BoardV02DTO>) request.getAttribute("postList");
    int nowPage = (Integer) request.getAttribute("nowPage");
    int beginPage = (Integer) request.getAttribute("beginPage");
    int endPage = (Integer) request.getAttribute("endPage");
    int nowBlock = (Integer) request.getAttribute("nowBlock");
    int totalBlock = (Integer) request.getAttribute("totalBlock");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전체 게시글 내용 보기</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/boardAllContent.css">
</head>
<body>

<h2><a href="BoardController?action=allList" style="cursor: pointer;">** 게시글 모아 보기 **</a></h2>
<%@ include file="bodTop.jspf" %>

<% if (postList != null && !postList.isEmpty()) {
     for (BoardV02DTO dto : postList) { %>
    <div class="post">
        <div class="post-header">
            <div class="post-title"><%= dto.getBod_subject() %></div>
            <div class="post-meta">
                글번호: <%= dto.getBod_no() %> |
                작성자: <%= dto.getBod_writer() %> |
                작성일: <%= dto.getBod_logtime() %>
            </div>
        </div>
        <div class="post-content">
            <%= dto.getBod_content().replace("\n", "<br>") %>
        </div>
    </div>
<%   } 
   } else { %>
<p>등록된 게시글이 없습니다.</p>
<% } %>

<div class="pagination">
<% if (nowBlock > 0) { %>
    <a href="BoardController?action=allList&nowPage=<%= beginPage - 1 %>">&laquo;</a>
<% } %>

<% for (int i = beginPage; i <= endPage; i++) {
       int displayPage = i + 1;  
       if (i == nowPage) { %>
           <span class="now"><%= displayPage %></span>
<%     } else { %>
           <a href="BoardController?action=allList&nowPage=<%= i %>"><%= displayPage %></a>
<%     }
   } %>

<% if (nowBlock < totalBlock - 1) { %>
    <a href="BoardController?action=allList&nowPage=<%= endPage + 1 %>">&raquo;</a>
<% } %>
</div>

<%@ include file="bodBottom.jspf" %>
</body>
</html>
