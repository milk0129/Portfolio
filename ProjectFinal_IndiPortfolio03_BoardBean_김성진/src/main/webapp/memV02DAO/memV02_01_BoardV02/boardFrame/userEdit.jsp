<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="boardV02.UserDTO" %>
<%
    request.setCharacterEncoding("UTF-8");
    UserDTO user = (UserDTO) session.getAttribute("loginUser");

    if (user == null) {
        response.sendRedirect("UserController?action=loginForm");
        return;
    }

    String imgName = user.getProfileImg();
    String imgPath = (imgName != null && !imgName.trim().isEmpty())
                   ? request.getContextPath() + "/profiles/" + imgName
                   : request.getContextPath() + "/profiles/default.png";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/memV02DAO/memV02_01_BoardV02/css/userEdit.css">
</head>
<body>
    <h2>회원정보 수정</h2>
    
    <div class="form-wrapper">
        <form action="<%= request.getContextPath() %>/UserController?action=updateProfile" method="post" enctype="multipart/form-data">
            <!-- 삭제 여부 전달 -->
            <input type="hidden" name="deleteProfileImg" id="deleteProfileImg" value="false">

            <table>
                <tr>
                    <td>프로필 이미지</td>
                    <td>
                        <img src="<%= imgPath %>" width="120" height="120" alt="프로필" id="profilePreview">
                        <br>
                        <input type="file" name="newProfileImg" accept="image/*">
                        <input type="button" id="delBtn" value="삭제">

                    </td>
                </tr>
                <tr>
                    <td>아이디</td>
                    <td><%= user.getUserId() %></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td><input type="email" name="userEmail" value="<%= user.getUserEmail() %>" required></td>
                </tr>
                <tr>
                    <td>현재 비밀번호</td>
                    <td><input type="password" name="userPw" id="pw" required></td>
                </tr>
                <tr>
                    <td>새 비밀번호</td>
                    <td><input type="password" name="userPw" id="newPw"></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td>
                        <input type="password" id="pwCheck">
                        <span id="msg" style="color:red;"></span>
                    </td>
                </tr>
            </table>
            <br>
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
            <input type="submit" value="정보 수정" onclick="return validatePassword();">
            <input type="button" value="취소" onclick="history.back();">
        </form>
    </div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // 버튼 이벤트 바인딩
    document.getElementById("delBtn").addEventListener("click", function () {
        const img = document.getElementById("profilePreview");
        img.src = "<%= request.getContextPath() %>/profiles/default.png";

        document.getElementById("deleteProfileImg").value = "true";
    });

    // 비밀번호 확인 함수는 여전히 전역으로 유지
    window.validatePassword = function () {
        var newPw = document.getElementById("newPw").value;
        var pwCheck = document.getElementById("pwCheck").value;
        var msg = document.getElementById("msg");

        if (newPw || pwCheck) {
            if (newPw !== pwCheck) {
                msg.innerText = "비밀번호가 일치하지 않습니다.";
                return false;
            }
        }

        msg.innerText = "";
        return true;
    };
});
</script>


    <p class="pFooter">ⓒCopyright 김성진</p>
</body>
</html>
