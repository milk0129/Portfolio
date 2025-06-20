<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boardV02.BoardV02DTO" %>

<%
    BoardV02DTO dto = (BoardV02DTO) request.getAttribute("dto");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Board Contents</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/boardContentFrame.css">
</head>
<body>
<div class="container">
    <h2>** 게시글 **</h2>

    <!-- 수정/삭제용 히든 전달 폼 -->
    <form id="bodFrm" method="post" action="BoardController">
    	 <input type="hidden" name="action" value="checkPwd">
        <input type="hidden" name="bod_no" value="">
        <input type="hidden" name="bod_pwd" value="">
        <input type="hidden" name="category" value="">
    </form>

    <form>
        <%@ include file="bodTop.jspf" %>
        <table>
            <tr>
                <td class="label">번호</td>
                <td><%= dto.getBod_no() %></td>
                <td class="label">조회수</td>
                <td><%= dto.getBod_readCnt() %></td>
            </tr>
            <tr>
                <td class="label">작성자</td>
                <td><%= dto.getBod_writer() %></td>
                <td class="label">비밀번호</td>
                <td>••••</td>
            </tr>
            <tr>
                <td class="label">제목</td>
                <td colspan="3"><%= dto.getBod_subject() %></td>
            </tr>
            <tr>
                <td class="label">이메일</td>
                <td colspan="3"><%= dto.getBod_email() %></td>
            </tr>
            <tr>
                <td rowspan="2" class="label image-cell">
                    <img src="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/img/side.jpg" alt="Side Image">
                    
                </td>
                <td colspan="3">
                    <textarea name="bod_content" class="input full" readonly><%= dto.getBod_content() %></textarea>
                </td>
            </tr>
        </table>
    </form>

    <div class="buttons">
        <button onclick="valSend('<%= dto.getBod_no() %>', '<%= dto.getBod_pwd() %>', 'upd')">수정</button>
        <button onclick="valSend('<%= dto.getBod_no() %>', '<%= dto.getBod_pwd() %>', 'del')">삭제</button>
    </div>

    <script>
        function valSend(no, pwd, category) {
            const form = document.getElementById("bodFrm");
            form.bod_no.value = no;
            form.bod_pwd.value = pwd;
            form.category.value = category;
            form.submit();
        }
    </script>

    <%@ include file="bodBottom.jspf" %>
</div>    
</body>
</html>
