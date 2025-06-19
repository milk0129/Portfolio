package boardV02;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardV02DAO {

    // 게시글 등록
    public int insertPost(BoardV02DTO dto) {
        String sql = "INSERT INTO BoardV02 (BOD_NO, BOD_WRITER, BOD_EMAIL, BOD_SUBJECT, BOD_PWD, BOD_CONTENT, BOD_CONNIP) " +
                     "VALUES (SEQ_BOARD_NO.NEXTVAL, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getBod_writer());
            pstmt.setString(2, dto.getBod_email());
            pstmt.setString(3, dto.getBod_subject());
            pstmt.setString(4, dto.getBod_pwd());
            pstmt.setString(5, dto.getBod_content());
            pstmt.setString(6, dto.getBod_connIp());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 게시글 전체 목록
    public ArrayList<BoardV02DTO> selectAll() {
        ArrayList<BoardV02DTO> list = new ArrayList<>();
        String sql = "SELECT * FROM BoardV02 ORDER BY BOD_NO DESC";

        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                BoardV02DTO dto = new BoardV02DTO();
                dto.setBod_no(rs.getInt("BOD_NO"));
                dto.setBod_writer(rs.getString("BOD_WRITER"));
                dto.setBod_subject(rs.getString("BOD_SUBJECT"));
                dto.setBod_logtime(rs.getString("BOD_LOGTIME"));
                dto.setBod_readCnt(rs.getInt("BOD_READCNT"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 게시글 상세 조회
    public BoardV02DTO selectDetail(int bodNo, boolean increaseHit) {
        if (increaseHit) increaseReadCount(bodNo);

        String sql = "SELECT * FROM BoardV02 WHERE BOD_NO = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, bodNo);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    BoardV02DTO dto = new BoardV02DTO();
                    dto.setBod_no(rs.getInt("BOD_NO"));
                    dto.setBod_writer(rs.getString("BOD_WRITER"));
                    dto.setBod_email(rs.getString("BOD_EMAIL"));
                    dto.setBod_subject(rs.getString("BOD_SUBJECT"));
                    dto.setBod_content(rs.getString("BOD_CONTENT"));
                    dto.setBod_logtime(rs.getString("BOD_LOGTIME"));
                    dto.setBod_readCnt(rs.getInt("BOD_READCNT"));
                    dto.setBod_connIp(rs.getString("BOD_CONNIP"));
                    dto.setBod_pwd(rs.getString("BOD_PWD")); 
                    return dto;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 조회수 증가
    private void increaseReadCount(int bodNo) {
        String sql = "UPDATE BoardV02 SET BOD_READCNT = BOD_READCNT + 1 WHERE BOD_NO = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, bodNo);
            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 게시글 수정
    public int updatePost(BoardV02DTO dto) {
        String sql = "UPDATE BoardV02 SET BOD_EMAIL = ?, BOD_SUBJECT = ?, BOD_CONTENT = ? WHERE BOD_NO = ? AND BOD_PWD = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getBod_email());
            pstmt.setString(2, dto.getBod_subject());
            pstmt.setString(3, dto.getBod_content());
            pstmt.setInt(4, dto.getBod_no());
            pstmt.setString(5, dto.getBod_pwd());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 게시글 삭제
    public int deletePost(int bodNo, String bodPwd) {
        String sql = "DELETE FROM BoardV02 WHERE BOD_NO = ? AND BOD_PWD = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, bodNo);
            pstmt.setString(2, bodPwd);

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // 게시글 바로삭제
    public int deleteDirect(int bodNo) {
        String sql = "DELETE FROM BoardV02 WHERE BOD_NO = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, bodNo);

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 총 게시글 수
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM BoardV02";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 키워드 검색 게시글 수
    public int getTotalRecord(String keyword) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM BoardV02 WHERE BOD_SUBJECT LIKE ?";

        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    // 페이징 리스트
    public ArrayList<BoardV02DTO> selectPage(int start, int end) {
        ArrayList<BoardV02DTO> list = new ArrayList<>();
        String sql = "SELECT * FROM (" +
                     "  SELECT ROWNUM rnum, a.* FROM (" +
                     "    SELECT * FROM BoardV02 ORDER BY BOD_NO DESC" +
                     "  ) a WHERE ROWNUM <= ?" +
                     ") WHERE rnum >= ?";

        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, end);
            pstmt.setInt(2, start);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    BoardV02DTO dto = new BoardV02DTO();
                    dto.setBod_no(rs.getInt("BOD_NO"));
                    dto.setBod_writer(rs.getString("BOD_WRITER"));
                    dto.setBod_subject(rs.getString("BOD_SUBJECT"));
                    dto.setBod_logtime(rs.getString("BOD_LOGTIME"));
                    dto.setBod_readCnt(rs.getInt("BOD_READCNT"));
                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 사용자 이름 가져오기
    public String getUserName(String userId) {
        String sql = "SELECT USER_NAME FROM BOARD_USERS WHERE USER_ID = ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getString("USER_NAME");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 페이징 검색 목록
    public List<BoardV02DTO> getPagingList(String field, String keyword, int start, int end) {
        List<BoardV02DTO> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM ( ");
        sql.append(" SELECT ROWNUM rnum, a.* FROM ( ");
        sql.append("   SELECT * FROM BoardV02 WHERE 1=1 ");

        if (field != null && keyword != null && !keyword.trim().isEmpty()) {
            if ("subject".equals(field)) {
                sql.append(" AND BOD_SUBJECT LIKE ? ");
            } else if ("content".equals(field)) {
                sql.append(" AND BOD_CONTENT LIKE ? ");
            } else if ("writer".equals(field)) {
                sql.append(" AND BOD_WRITER LIKE ? ");
            } else if ("all".equals(field)) {
                sql.append(" AND (BOD_SUBJECT LIKE ? OR BOD_CONTENT LIKE ?) ");
            }
        }

        sql.append("   ORDER BY BOD_NO DESC ");
        sql.append(" ) a WHERE ROWNUM <= ? ");
        sql.append(") WHERE rnum >= ?");

        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (field != null && keyword != null && !keyword.trim().isEmpty()) {
                if ("all".equals(field)) {
                    pstmt.setString(paramIndex++, "%" + keyword + "%");
                    pstmt.setString(paramIndex++, "%" + keyword + "%");
                } else {
                    pstmt.setString(paramIndex++, "%" + keyword + "%");
                }
            }

            pstmt.setInt(paramIndex++, end);
            pstmt.setInt(paramIndex, start);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    BoardV02DTO dto = new BoardV02DTO();
                    dto.setBod_no(rs.getInt("BOD_NO"));
                    dto.setBod_subject(rs.getString("BOD_SUBJECT"));
                    dto.setBod_writer(rs.getString("BOD_WRITER"));
                    dto.setBod_logtime(rs.getString("BOD_LOGTIME"));
                    dto.setBod_readCnt(rs.getInt("BOD_READCNT"));
                    dto.setBod_connIp(rs.getString("BOD_CONNIP"));
                    dto.setBod_content(rs.getString("BOD_CONTENT"));
                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    // 게시글 모음 페이지
    public List<BoardV02DTO> getPagingList(String keyword, int start, int end) {
        return getPagingList("subject", keyword, start, end);
    }
    
    public int getTotalRecord(String field, String keyword) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM BoardV02 WHERE 1=1 ");

        if (field != null && keyword != null && !keyword.trim().isEmpty()) {
            if ("subject".equals(field)) {
                sql.append(" AND BOD_SUBJECT LIKE ? ");
            } else if ("content".equals(field)) {
                sql.append(" AND BOD_CONTENT LIKE ? ");
            } else if ("writer".equals(field)) {
                sql.append(" AND BOD_WRITER LIKE ? ");
            } else if ("all".equals(field)) {
                sql.append(" AND (BOD_SUBJECT LIKE ? OR BOD_CONTENT LIKE ?) ");
            }
        }

        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (field != null && keyword != null && !keyword.trim().isEmpty()) {
                if ("all".equals(field)) {
                    pstmt.setString(paramIndex++, "%" + keyword + "%");
                    pstmt.setString(paramIndex++, "%" + keyword + "%");
                } else {
                    pstmt.setString(paramIndex++, "%" + keyword + "%");
                }
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public List<BoardV02DTO> getPostsByWriter(String writer) {
        List<BoardV02DTO> result = new ArrayList<>();
        String sql = "SELECT * FROM BOARDV02 WHERE bod_writer = ? ORDER BY bod_no DESC";

        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, writer);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardV02DTO dto = new BoardV02DTO(
                    rs.getInt("bod_no"),
                    rs.getString("bod_writer"),
                    rs.getString("bod_email"),
                    rs.getString("bod_subject"),
                    rs.getString("bod_pwd"),
                    rs.getString("bod_logtime"),
                    rs.getString("bod_content"),
                    rs.getInt("bod_readCnt"),
                    rs.getString("bod_connIp")
                );
                result.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
 // 총 게시글 수
    public int getMyPostCount(String writer) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM BOARDV02 WHERE bod_writer=?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, writer);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // 페이징된 게시글 목록
    public List<BoardV02DTO> getMyPostPagingList(String writer, int start, int end) {
        List<BoardV02DTO> list = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT ROWNUM rn, A.* FROM (SELECT * FROM BOARDV02 WHERE bod_writer=? ORDER BY bod_no DESC) A) WHERE rn BETWEEN ? AND ?";
        try (Connection conn = DbSet.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, writer);
            pstmt.setInt(2, start);
            pstmt.setInt(3, end);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                BoardV02DTO dto = new BoardV02DTO(
                    rs.getInt("bod_no"),
                    rs.getString("bod_writer"),
                    rs.getString("bod_email"),
                    rs.getString("bod_subject"),
                    rs.getString("bod_pwd"),
                    rs.getString("bod_logtime"),
                    rs.getString("bod_content"),
                    rs.getInt("bod_readCnt"),
                    rs.getString("bod_connIp")
                );
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}//BoardV02DAO
