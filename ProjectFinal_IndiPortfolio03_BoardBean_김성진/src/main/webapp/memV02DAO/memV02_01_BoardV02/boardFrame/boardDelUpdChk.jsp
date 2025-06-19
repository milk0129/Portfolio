<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="boardV02.BoardV02DTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 확인</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/css/boardChkFrame.css">
  <script src="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/jas/jquery-3.7.1.js"></script>
</head>
<body onload="mInit()">

<c:set var="category" value="${requestScope.category}" />
<c:set var="isUserDelete" value="${category eq 'userDelete'}" />

<div id="wrapper">
  <h2>** 정보 확인 **</h2>
  <%@ include file="bodTop.jspf" %>

  <c:if test="${not isUserDelete}">
    <form name="frm01" id="frm01" method="post" action="BoardController">
      <input type="hidden" name="action" value="${category eq 'del' ? 'delete' : 'editForm'}">
      <input type="hidden" name="bod_no" value="${dto.bod_no}">
      <input type="hidden" id="realPwd" value="${dto.bod_pwd}">

      <table id="chkTable">
        <tr>
          <td class="chkTd">** 글 작성 시 입력한 비밀번호를 입력해 주세요 **</td>
        </tr>
        <tr>
          <td><input type="password" id="passwd" name="bod_pwd" placeholder="비밀번호를 입력하세요."></td>
        </tr>
        <tr>
          <td>
            <input type="button" value="확인" class="button" onclick="mPwdChkSend()">
            <input type="button" value="홈으로" class="button" onclick="location.href='BoardController?action=list'">
          </td>
        </tr>
        <tr>
          <td id="bodMsg">
            <div id="resultInput" class="resultChk" style="cursor:pointer; padding: 6px;">클릭 결과</div>
          </td>
        </tr>
      </table>
    </form>
  </c:if>

  <c:if test="${isUserDelete}">
    <form method="post" action="UserController" id="userDeleteForm">
      <input type="hidden" name="action" value="deleteUser">
      <input type="hidden" name="userId" value="${userId}">
      <table id="chkTable">
        <tr>
          <td class="chkTd">** 회원 비밀번호를 입력해 주세요 **</td>
        </tr>
        <tr>
          <td><input type="password" name="userPw" placeholder="비밀번호를 입력하세요."></td>
        </tr>
        <tr>
          <td>
            <input type="submit" value="탈퇴하기" class="button">
            <input type="button" value="홈으로" class="button" onclick="location.href='BoardController?action=list'">
          </td>
        </tr>
      </table>
    </form>
  </c:if>

  <%@ include file="bodBottom.jspf" %>
</div>

<c:if test="${not isUserDelete}">
<script>
let pwdMatch = false;

function mInit() {
  document.getElementById("passwd").focus();
  pwdMatch = false;
}

function mPwdChkSend() {
  const inputPwd = document.getElementById("passwd").value;
  const realPwd = document.getElementById("realPwd").value;
  const resultBox = document.getElementById("resultInput");

  if (inputPwd !== realPwd) {
    resultBox.textContent = "▶ 비밀번호가 일치하지 않습니다 !! ◀";
    pwdMatch = false;
  } else {
    resultBox.textContent = "▶ 비밀번호가 일치 : 클릭 시 이동 ◀";
    pwdMatch = true;
  }
}

$("#resultInput").on("click", function () {
  if (pwdMatch) {
    document.forms.frm01.submit();
  } else {
    alert("비밀번호가 일치하지 않습니다.");
  }
});
</script>
</c:if>

</body>
</html>
