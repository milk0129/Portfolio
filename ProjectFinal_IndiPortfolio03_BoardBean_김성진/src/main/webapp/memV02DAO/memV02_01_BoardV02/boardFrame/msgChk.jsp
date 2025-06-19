<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>MsgChk</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/memV02DAO/memV02_01_BoardV02/css/loginstyle.css">
  <style>
    /* 기존 스타일 유지 */
    body {
        width: 800px;
        height: 700px;
        margin: auto;
    }
    ul {
        list-style-type: none;
        overflow: hidden;
        text-align: center;
        padding: 0; 
        margin: 10px 0; 
        display: flex;
        justify-content: center;
        gap: 12px;
    }
    li {
        list-style: none;
    }
    li a {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100px;
        height: 40px;
        font-size: 16px;
        font-weight: bold;
        text-decoration: none;
        color: white;
        background-color: #2e7d32;
        border-radius: 5px;
        border: 2px solid #1b5e20;
        cursor: pointer;
    }
    li a:hover {
        background-color: #1b5e20;
        border-color: #144d17;
    }
    .footer-table {
        margin-top: 25px;
        display: flex;
        justify-content: center;
        gap: 156px;
        width: 100%;
        text-align: center;
        padding: 15px 0px;
    }
    .footer-cell {
        padding: 5px 10px;
        font-size: 14px;
        font-weight: bold;
        color: white;
        background-color: #2e7d32;
        border: 2px solid #1b5e20;
        border-radius: 5px;
    }
    .footer-cell.copyright {
        padding: 5px 70px;
    }
    .Message-container {
        margin: auto;
        margin-top: 20px;
        margin-bottom:20px;
        width: 600px;
        height: 400px;
        border: 3px solid #2e7d32;
        border-spacing: 0px;
    }
    .Message-cell {
        font-family: sans-serif;
        font-weight: bold;
        font-size: 20px;
        text-align: center;
        width: 100%;
        height: 50px;
        background-color: #2e7d32;
        color: #fff;
    }
    .text-cell {
        padding: 0; 
        margin: 0; 
        padding-top: 12px;
        padding-left: 12px;
        text-align: left; 
        vertical-align: top; 
    }
    a {
        text-decoration: none;
        color: #2e7d32;
    }
    .menu {
        margin: auto;
        margin-left: 244px;
        color: #038b00;
        font-weight: bold;
    }
  </style>
</head>
<body>

<%@ include file="bodTop.jspf" %>

<div>
  <table class="Message-container">
    <thead>
      <tr><td class="Message-cell">Message</td></tr>
    </thead>
    <tbody>
      <tr>
        <td class="text-cell">
          <c:choose>
            <c:when test="${not empty msg}">
              ${msg}
            </c:when>
            <c:otherwise>
              Message Chk
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
    </tbody>
  </table>
</div>

<%@ include file="bodBottom.jspf" %>

</body>
</html>
