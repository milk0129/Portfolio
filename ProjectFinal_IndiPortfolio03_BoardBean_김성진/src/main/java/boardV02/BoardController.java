package boardV02;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import boardV02.PagingUtil;
import java.util.List;
import java.util.Optional;


@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        switch (action) {
            case "list": showList(request, response); break;
            case "view": viewPost(request, response); break;
            case "write": writePost(request, response); break;
            case "update": updatePost(request, response); break;
            case "delete": deletePost(request, response); break;
            case "deleteDirect": deleteDirect(request, response); break;
            case "myList": showMyPostList(request, response); break;
            
            case "allList": showAllContent(request, response); break;
            case "writeForm": showWriteForm(request, response); break;
            case "editForm": showEditForm(request, response); break;
            case "editFormDirect": showEditFormDirect(request, response); break;// 바로수정
            case "checkPwd": showPwdCheck(request, response); break;

            default: response.sendRedirect("/memV02DAO/memV02_01_BoardV02/boardFrame/boardTitleList.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 검색 필드와 키워드 파라미터 (null 방지 + trim 처리)
        String searchField = Optional.ofNullable(request.getParameter("searchField")).orElse("all").trim();
        String searchKeyword = Optional.ofNullable(request.getParameter("search")).orElse("").trim();

        // nowPage, nowBlock 안전 파싱
        String nowPageParam = Optional.ofNullable(request.getParameter("nowPage")).orElse("0").trim();
        String nowBlockParam = Optional.ofNullable(request.getParameter("nowBlock")).orElse("0").trim();

        int nowPage = parseInt(nowPageParam, 0);
        int nowBlock = parseInt(nowBlockParam, 0);

        int recPerPage = 10;
        int pagePerBlock = 10;

        BoardV02DAO dao = new BoardV02DAO();

        // 총 레코드 수 계산
        int totalRecord = dao.getTotalRecord(searchField, searchKeyword);

        // 페이징 계산
        PagingUtil paging = new PagingUtil(nowPage, nowBlock, totalRecord, recPerPage, pagePerBlock);

        // 게시글 리스트 가져오기
        List<BoardV02DTO> list = dao.getPagingList(searchField, searchKeyword,
                                                   paging.getRecOfBeginPage(), paging.getRecOfEndPage());

        // 로그인 세션 정보 가져오기
        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;
        String userName = null;
        if (userId != null) {
            userName = dao.getUserName(userId);
        }

        // JSP에 전달할 데이터 설정
        request.setAttribute("list", list);
        request.setAttribute("paging", paging);
        request.setAttribute("searchField", searchField);
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("userId", userId);
        request.setAttribute("userName", userName);

        // 디버깅 로그 
        System.out.println("총 게시글 수: " + totalRecord);
        System.out.println("리스트 개수: " + list.size());
        System.out.println("nowPage: " + nowPage + ", nowBlock: " + nowBlock);
        System.out.println("searchField: " + searchField + ", searchKeyword: " + searchKeyword);
        System.out.println("begin: " + paging.getRecOfBeginPage() + ", end: " + paging.getRecOfEndPage());

        // 화면 이동
        RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/boardTitleList.jsp");
        rd.forward(request, response);
    }
    
    private void showAllContent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        BoardV02DAO dao = new BoardV02DAO();

        
        int recPerPage = 10;
        int pagePerBlock = 10;
        int totalRecord = dao.getTotalRecord("");
        String nowPageParam = request.getParameter("nowPage");
        int nowPage = (nowPageParam == null || nowPageParam.equals("")) ? 0 : Integer.parseInt(nowPageParam);
        int nowBlock = nowPage / pagePerBlock;

        PagingUtil paging = new PagingUtil(nowPage, nowBlock, totalRecord, recPerPage, pagePerBlock);

        int begin = paging.getRecOfBeginPage();
        int end = paging.getRecOfEndPage();

        List<BoardV02DTO> postList = dao.getPagingList("", begin, end);
        
        for (BoardV02DTO dto : postList) {
            String content = dto.getBod_content();
            if (content != null) {
                dto.setBod_content(content.replace("\n", "<br>"));
            }
        }
        
        request.setAttribute("postList", postList);
        request.setAttribute("nowPage", paging.getNowPage());
        request.setAttribute("beginPage", paging.getStartPage());
        request.setAttribute("endPage", paging.getEndPage());
        request.setAttribute("nowBlock", paging.getNowBlock());
        request.setAttribute("totalBlock", paging.getTotalBlock());

        RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/boardAllContent.jsp");
        rd.forward(request, response);
    }

    private void viewPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bod_no = Integer.parseInt(request.getParameter("bod_no"));

        BoardV02DAO dao = new BoardV02DAO();
        BoardV02DTO dto = dao.selectDetail(bod_no, true);

        request.setAttribute("dto", dto);
        RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/boardContentFrame.jsp");
        rd.forward(request, response);
    }

    private void writePost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String writer = request.getParameter("bod_writer");
        String email = request.getParameter("bod_email");
        String subject = request.getParameter("bod_subject");
        String pwd = request.getParameter("bod_pwd");
        String content = request.getParameter("bod_content");
        String connIp = request.getRemoteAddr();

        if (writer == null || email == null || subject == null || pwd == null || content == null) {
            request.setAttribute("msg", "❗ 모든 항목을 입력해주세요.");
            request.setAttribute("location", request.getContextPath() + "/memV02DAO/memV02_01_BoardV02/boardFrame/boardWriteFrame.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/msgChk.jsp");
            rd.forward(request, response);
            return;
        }

        BoardV02DTO dto = new BoardV02DTO();
        dto.setBod_writer(writer);
        dto.setBod_email(email);
        dto.setBod_subject(subject);
        dto.setBod_pwd(pwd);
        dto.setBod_content(content);
        dto.setBod_connIp(connIp);

        BoardV02DAO dao = new BoardV02DAO();
        int result = dao.insertPost(dto);

        if (result > 0) {
            response.sendRedirect("BoardController?action=list");
        } else {
            request.setAttribute("msg", "❗ 게시글 등록에 실패했습니다.");
            request.setAttribute("location", request.getContextPath() + "/memV02DAO/memV02_01_BoardV02/boardFrame/boardWriteFrame.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/msgChk.jsp");
            rd.forward(request, response);
        }
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bodNo = Integer.parseInt(request.getParameter("bod_no"));
        String subject = request.getParameter("bod_subject");
        String content = request.getParameter("bod_content");
        String email = request.getParameter("bod_email");
        String pwd = request.getParameter("bod_pwd");

        BoardV02DTO dto = new BoardV02DTO();
        dto.setBod_no(bodNo);
        dto.setBod_subject(subject);
        dto.setBod_content(content);
        dto.setBod_email(email);
        dto.setBod_pwd(pwd);

        BoardV02DAO dao = new BoardV02DAO();
        int result = dao.updatePost(dto); // 이 메서드 반드시 있어야 함

        if (result > 0) {
            response.sendRedirect("BoardController?action=view&bod_no=" + bodNo);
        } else {
            request.setAttribute("msg", "게시글 수정 실패");
            request.setAttribute("location", "BoardController?action=view&bod_no=" + bodNo);
            request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/msgChk.jsp").forward(request, response);
        }
    }

    
    private void showEditFormDirect(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bodNo = Integer.parseInt(request.getParameter("bod_no"));
        BoardV02DAO dao = new BoardV02DAO();
        BoardV02DTO dto = dao.selectDetail(bodNo, false); // 조회수 증가 X
        request.setAttribute("dto", dto);
        request.setAttribute("fromMyPage", true);  // editFormDirect 에서만

        RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/boardUpdFrame.jsp");
        rd.forward(request, response);
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int bod_no = Integer.parseInt(request.getParameter("bod_no"));
        String bod_pwd = request.getParameter("bod_pwd");

        BoardV02DAO dao = new BoardV02DAO();
        int result = dao.deletePost(bod_no, bod_pwd);

        response.sendRedirect("BoardController?action=list");
    }
    
    private void deleteDirect(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        int bod_no = Integer.parseInt(request.getParameter("bod_no"));
        BoardV02DAO dao = new BoardV02DAO();
        
        int result = dao.deleteDirect(bod_no); // 삭제 처리
        
        if (result > 0) {
            response.sendRedirect("BoardController?action=myList");
        } else {
            request.setAttribute("msg", "삭제 실패");
            request.setAttribute("location", "BoardController?action=myList");
            RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/msgChk.jsp");
            rd.forward(request, response);
        }
    }
    
    private void showWriteForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            // 로그인 페이지로 이동
            response.sendRedirect(request.getContextPath() + "/memV02DAO/memV02_01_BoardV02/boardFrame/login.jsp");
            return;
        }

        // 로그인 상태면 userId 전달하고 글쓰기 화면으로 이동
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        request.setAttribute("userId", loginUser.getUserId());
        request.setAttribute("userEmail", loginUser.getUserEmail());
        RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/boardWriteFrame.jsp");
        rd.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bod_no = Integer.parseInt(request.getParameter("bod_no"));
        String bod_pwd = request.getParameter("bod_pwd"); 

        BoardV02DAO dao = new BoardV02DAO();
        BoardV02DTO dto = dao.selectDetail(bod_no, false); // 조회수 증가 X

        request.setAttribute("dto", dto);
        request.setAttribute("bod_pwd", bod_pwd); 

        RequestDispatcher rd = request.getRequestDispatcher(
            "/memV02DAO/memV02_01_BoardV02/boardFrame/boardUpdFrame.jsp");
        rd.forward(request, response);
    }
    
    private void showPwdCheck(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bod_no = Integer.parseInt(request.getParameter("bod_no"));
        String category = request.getParameter("category");

        BoardV02DAO dao = new BoardV02DAO();
        BoardV02DTO dto = dao.selectDetail(bod_no, false);

        request.setAttribute("dto", dto);
        request.setAttribute("category", category);
        RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/boardDelUpdChk.jsp");
        rd.forward(request, response);
    }

    private int parseInt(String param, int defaultValue) {
        try {
            return Integer.parseInt(param);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
    
    private void showMyPostList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("UserController?action=loginForm");
            return;
        }

        int nowPage = 0;
        int nowBlock = 0;

        try {
            nowPage = Integer.parseInt(Optional.ofNullable(request.getParameter("nowPage")).orElse("0"));
            nowBlock = Integer.parseInt(Optional.ofNullable(request.getParameter("nowBlock")).orElse("0"));
        } catch (NumberFormatException e) {
            nowPage = 0;
            nowBlock = 0;
        }

        int recPerPage = 10;
        int pagePerBlock = 10;

        BoardV02DAO dao = new BoardV02DAO();

        // 총 레코드 수 계산 (작성자 기준)
        int totalRecord = dao.getMyPostCount(userId);  // ← 실제 존재하는 메서드 확인됨:contentReference[oaicite:0]{index=0}

        // 페이징 객체 생성
        PagingUtil paging = new PagingUtil(nowPage, nowBlock, totalRecord, recPerPage, pagePerBlock);  // ← getRecOfBeginPage() 사용 가능:contentReference[oaicite:1]{index=1}

        // 페이징 범위에 맞는 게시글 목록 조회
        List<BoardV02DTO> list = dao.getMyPostPagingList(userId, paging.getRecOfBeginPage(), paging.getRecOfEndPage());

        request.setAttribute("myPostList", list);
        request.setAttribute("pu", paging);
        request.setAttribute("nowPage", nowPage);
        request.setAttribute("nowBlock", nowBlock);

        RequestDispatcher rd = request.getRequestDispatcher("/memV02DAO/memV02_01_BoardV02/boardFrame/myBoardList.jsp");
        rd.forward(request, response);
    }
    



} //BoardController
