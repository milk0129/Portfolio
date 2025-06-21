package boardV02;

import org.apache.ibatis.session.SqlSession;

public class UserDAO {

    // 로그인 유효성 확인
    public boolean loginCheck(String userId, String userPw) {
        try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession()) {
            UserDTO dto = new UserDTO();
            dto.setUserId(userId);
            dto.setUserPw(userPw);
            int result = session.selectOne("user.UserMapper.loginCheck", dto);
            return result == 1;
        }
    }

    // 이름 가져오기 (UserDTO로 조회 후 getUserName 사용)
    public String getUserName(String userId) {
        UserDTO dto = getUser(userId);
        return dto != null ? dto.getUserName() : null;
    }

    // 회원가입
    public int insertUser(UserDTO dto) {
        try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession(true)) {
            return session.insert("user.UserMapper.insertUser", dto);
        }
    }

    // 아이디 찾기
    public String findUserId(String userName, String userEmail) {
        UserDTO param = new UserDTO();
        param.setUserName(userName);
        param.setUserEmail(userEmail);

        try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession()) {
            return session.selectOne("user.UserMapper.findUserId", param);
        }
    }

    // 아이디 중복 확인
    public boolean isUserIdDuplicate(String userId) {
        try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession()) {
            int count = session.selectOne("user.UserMapper.isUserIdDuplicate", userId);
            return count > 0;
        }
    }

    // 유저 정보 조회
    public UserDTO getUser(String userId) {
        try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession()) {
            return session.selectOne("user.UserMapper.getUser", userId);
        }
    }

    // 회원정보 수정
    public int updateUserProfile(UserDTO dto) {
        try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession(true)) {
            if (dto.getUserPw() != null && !dto.getUserPw().trim().isEmpty()) {
                return session.update("user.UserMapper.updateUserWithPw", dto);
            } else {
                return session.update("user.UserMapper.updateUserNoPw", dto);
            }
        }
    }

    // 회원 탈퇴
    public int deleteUser(String userId) {
        try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession(true)) {
            return session.delete("user.UserMapper.deleteUser", userId);
        }
    }
}
