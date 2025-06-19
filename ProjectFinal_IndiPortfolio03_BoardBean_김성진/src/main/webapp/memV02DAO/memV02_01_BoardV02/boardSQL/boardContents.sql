-- 기존 게시글 삭제
DELETE FROM BoardV02;
COMMIT;

-- 테스트용 게시글 
BEGIN
    FOR i IN 1 .. 254 LOOP
        INSERT INTO BoardV02 (
            BOD_NO, BOD_WRITER, BOD_SUBJECT, BOD_CONTENT, BOD_LOGTIME,
            BOD_READCNT, BOD_PWD, BOD_EMAIL, BOD_CONNIP
        ) VALUES (
            SEQ_BOARD_NO.NEXTVAL,
            'user' || LPAD(MOD(i, 10) + 1, 2, '0'),  -- user01 ~ user10 반복
            '테스트 제목 ' || i,
            '이것은 테스트 게시글 내용입니다. 번호: ' || i,
            SYSDATE - (255 - i), 
            0,
            '1234',
            'user' || LPAD(MOD(i, 10) + 1, 2, '0') || '@test.com',
            '127.0.0.1'
        );
    END LOOP;
END;
/

COMMIT;
