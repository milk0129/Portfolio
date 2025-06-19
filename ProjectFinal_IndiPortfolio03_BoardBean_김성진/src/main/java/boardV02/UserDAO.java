package boardV02;

import java.sql.*;

public class UserDAO {

    // 로그인 유효성 확인
    public boolean loginCheck(String userId, String userPw) {
        String sql = "SELECT * FROM BOARD_USERS WHERE USER_ID = ? AND USER_PW = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            pstmt.setString(2, userPw);

            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // 이름 가져오기
    public String getUserName(String userId) {
        String sql = "SELECT USER_NAME FROM BOARD_USERS WHERE USER_ID = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("USER_NAME");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    // 회원가입
    public int insertUser(UserDTO dto) {
        String sql = "INSERT INTO BOARD_USERS (USER_ID, USER_PW, USER_NAME, USER_BIRTH, USER_EMAIL) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getUserId());
            pstmt.setString(2, dto.getUserPw());
            pstmt.setString(3, dto.getUserName());
            pstmt.setString(4, dto.getUserBirth());
            pstmt.setString(5, dto.getUserEmail());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    // 아이디 찾기
    public String findUserId(String userName, String userEmail) {
        String sql = "SELECT USER_ID FROM BOARD_USERS WHERE USER_NAME = ? AND USER_EMAIL = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userName);
            pstmt.setString(2, userEmail);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getString("USER_ID");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //유저 중복확인
    public boolean isUserIdDuplicate(String userId) {
        String sql = "SELECT COUNT(*) FROM BOARD_USERS WHERE USER_ID = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true; // 에러 발생 시 중복된 것으로 간주
    }
    
    public UserDTO getUser(String userId) {
        String sql = "SELECT USER_ID, USER_NAME, USER_EMAIL, PROFILE_IMG FROM BOARD_USERS WHERE USER_ID = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    UserDTO dto = new UserDTO();
                    dto.setUserId(rs.getString("USER_ID"));
                    dto.setUserName(rs.getString("USER_NAME"));
                    dto.setUserEmail(rs.getString("USER_EMAIL"));
                    dto.setProfileImg(rs.getString("PROFILE_IMG")); // 추가
                    return dto;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 회원정보 수정: 비밀번호, 이메일, 프로필 이미지
    public int updateUserProfile(UserDTO dto) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DbSet.getConnection();

            if (dto.getUserPw() != null && !dto.getUserPw().trim().isEmpty()) {
                String sql = "UPDATE BOARD_USERS SET USER_PW = ?, USER_EMAIL = ?, PROFILE_IMG = ? WHERE USER_ID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, dto.getUserPw());
                pstmt.setString(2, dto.getUserEmail());
                pstmt.setString(3, dto.getProfileImg());
                pstmt.setString(4, dto.getUserId());
            } else {
                String sql = "UPDATE BOARD_USERS SET USER_EMAIL = ?, PROFILE_IMG = ? WHERE USER_ID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, dto.getUserEmail());
                pstmt.setString(2, dto.getProfileImg());
                pstmt.setString(3, dto.getUserId());
            }

            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return result;
    }
    
    public int deleteUser(String userId) {
        String sql = "DELETE FROM BOARD_USERS WHERE USER_ID = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}//UserDAO
