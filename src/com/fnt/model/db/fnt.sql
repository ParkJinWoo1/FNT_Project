 SELECT * FROM ALL_TABLES WHERE OWNER = 'BIGMASTER05_SEMI';
 
--회원
DELETE FROM MEMBER;
SELECT * FROM MEMBER;
CREATE TABLE MEMBER(
   --아이디
   MEMBER_ID VARCHAR2(10) NOT NULL,
   --비밀번호
   MEMBER_PW VARCHAR2(16) NOT NULL, 
   --비밀번호 체크
   MEMBER_PWCHK VARCHAR2(16) NOT NULL,
   --닉네임
   MEMBER_NICKNAME VARCHAR2(20) NOT NULL,
   --이름
   MEMBER_NAME VARCHAR2(20) NOT NULL,
   --생년월일
   MEMBER_BIRTH DATE NOT NULL,
   --전화번호
   MEMBER_PHONE VARCHAR2(20) NOT NULL,
   --주소
   MEMBER_ADDR VARCHAR2(100) NOT NULL,
   --이메일
   MEMBER_EMAIL VARCHAR2(50) NOT NULL,
   --ADMIN은 관리자, USER은 회원
   MEMBER_ROLE VARCHAR2(10) NOT NULL,
   --Y는 회원, N은 탈퇴된 회원, R은 신고된 회원
   ENABLED CHAR(1) NOT NULL,
   --가입날짜
   REGDATE DATE NOT NULL,
   
   CONSTRAINT ID_MEMBER_PK PRIMARY KEY(MEMBER_ID),
   CONSTRAINT NICKNAME_MEMBER_UNQ UNIQUE(MEMBER_NICKNAME),
   CONSTRAINT PHONE_MEMBER_UNQ UNIQUE(MEMBER_PHONE),
   CONSTRAINT EMAIL_MEMBER_UNQ UNIQUE(MEMBER_EMAIL),
   --ADMIN : 관리자, USER : 일반회원
   CONSTRAINT MEMBER_ROLE_MEMBER_CHK CHECK(MEMBER_ROLE IN('ADMIN','USER')),
   --Y : 회원, N : 탈퇴한 회원, R : 신고된 회원
   CONSTRAINT ENABLED_MEMBER_CHK CHECK(ENABLED IN('Y','N','R'))
);
SELECT * FROM MEMBER;
INSERT INTO MEMBER
VALUES('test', 'test1234', 'test1234', '문의열리네요', '김지후', SYSDATE, '010-1234-1234', '캘리포니아', 'mune@kh.com', 'USER', 'Y', SYSDATE);

--공지사항 테이블
DELETE FROM NOTICE_BOARD;

DROP TABLE NOTICE_BOARD;

DROP SEQUENCE NB_BOARDNO_SEQ;


CREATE SEQUENCE NB_BOARDNO_SEQ;


CREATE TABLE NOTICE_BOARD(
   --공지사항 글번호
   NB_BOARDNO NUMBER NOT NULL,
   --아이디
   NB_ID VARCHAR2(10) NOT NULL,
   --닉네임
   NB_NICKNAME VARCHAR2(20) NOT NULL,
   --제목
   NB_TITLE VARCHAR2(50) NOT NULL,
   --내용
   NB_CONTENT VARCHAR2(3000) NOT NULL,
   --작성 날짜
   NB_REGDATE DATE NOT NULL,
   
   CONSTRAINT NB_BOARDNO_PK PRIMARY KEY(NB_BOARDNO),
   FOREIGN KEY(NB_ID) REFERENCES MEMBER(MEMBER_ID),
   FOREIGN KEY(NB_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME)
);

--거래게시판 테이블
DELETE FROM DEAL_BOARD;

DROP TABLE DEAL_BOARD;

DROP SEQUENCE DB_BOARDNO_SEQ;

CREATE SEQUENCE DB_BOARDNO_SEQ;


CREATE TABLE DEAL_BOARD(
   --글 번호
   D_BOARDNO NUMBER NOT NULL,
   --아이디
   D_ID VARCHAR2(10) NOT NULL,
   --닉네임
   D_NICKNAME VARCHAR2(20) NOT NULL,
   --제목
   D_TITLE VARCHAR2(50) NOT NULL,
   --파일명
   D_FILENAME VARCHAR2(50),
   --내용
   D_CONTENT VARCHAR2(3000) NOT NULL,
   --가격
   D_PRICE NUMBER NOT NULL,
   --작성 날짜
   D_REGDATE DATE NOT NULL,
   --카테고리
   D_CATEGORY CHAR(1) NOT NULL,
   --판매,구매
   D_FLAG CHAR(1) NOT NULL,
   --경도
   D_LONGITUDE VARCHAR2(50),
   --위도
   D_LANGITUDE VARCHAR2(50),
   
   CONSTRAINT DB_BOARDNO_PK PRIMARY KEY(D_BOARDNO),
   FOREIGN KEY(D_ID) REFERENCES MEMBER(MEMBER_ID),
   --F : 패션, C : 차량, D : 가전제품, A : 애완, S : 스포츠
   CONSTRAINT D_CATEGORY_DEAL_BOARD_CHK CHECK(D_CATEGORY IN('F','C','D','A','S')),
   --B : 구매, S : 판매
   CONSTRAINT D_FLAG_DEAL_BOARD_CHK CHECK(D_FLAG IN('B','S')),
   FOREIGN KEY(D_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME)
);
-- D_LONGITUDE , D_LATITUDE VARCHAR2(20)
insert into deal_board(D_BOARDNO ,D_ID ,D_NICKNAME,D_TITLE ,D_CONTENT ,D_PRICE ,D_REGDATE ,D_CATEGORY ,D_FLAG )
values (10,'admin','회원','ㅇㅇ','ㅇㄴㅁ',2000,SYSDATE,'F','B');


--문의게시판 테이블
DELETE FROM QNA_BOARD;

DROP TABLE QNA_BOARD;

DROP SEQUENCE QB_BOARDNO_SEQ;

CREATE SEQUENCE QB_BOARDNO_SEQ;

CREATE TABLE QNA_BOARD(
   --글 번호
   QB_BOARDNO NUMBER NOT NULL,
   --아이디
   QB_ID VARCHAR2(10) NOT NULL,
   --닉네임
   QB_NICKNAME VARCHAR2(20) NOT NULL,
   --제목
   QB_TITLE VARCHAR2(50) NOT NULL,
   --내용
   QB_CONTENT VARCHAR2(3000) NOT NULL,
   --비밀글 여부
   QB_SECRET CHAR(1) NOT NULL,
   --답변처리 여부
   QB_FLAG CHAR(1) NOT NULL,
   --작성 날짜
   QB_REGDATE DATE NOT NULL,
   --답변 날짜
   QB_REDATE DATE NOT NULL,
   
   CONSTRAINT QB_BOARDNO_PK2 PRIMARY KEY(QB_BOARDNO),
   FOREIGN KEY(QB_ID) REFERENCES MEMBER(MEMBER_ID),
   FOREIGN KEY(QB_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME),
   CONSTRAINT QB_SECRET_CHK1 CHECK(QB_SECRET IN('Y','N')),
   CONSTRAINT QB_FLAG_CHK CHECK(QB_FLAG IN('Y','N'))
);

--리플
DELETE FROM REPLY;
DROP SEQUENCE REPLY_SEQ;

DROP TABLE REPLY;

CREATE SEQUENCE REPLY_SEQ;
CREATE SEQUENCE REPLY_GROUPNO_SEQ;
CREATE TABLE REPLY(
   --댓글 번호
   REPLY_NO NUMBER NOT NULL,
   --아이디
   REPLY_ID VARCHAR2(10) NOT NULL,
   --닉네임
   REPLY_NICKNAME VARCHAR2(20) NOT NULL,
   --댓글남길 해당 글의 번호
   REPLY_BOARDNO NUMBER NOT NULL,
   --댓글 그룹 번호
   REPLY_GROUPNO NUMBER NOT NULL,
   --댓글 그룹 번호안에서의 순서
   REPLY_GROUPNOSEQ NUMBER NOT NULL,
   --댓글의 댓글을 달때 공백
   REPLY_TITLETAB VARCHAR2(10) NOT NULL,
   --댓글의 제목 및 내용
   REPLY_TITLE VARCHAR2(1000) NOT NULL, --댓글 내용
   --댓글 작성 날짜
   REPLY_REGDATE DATE NOT NULL,
   
   CONSTRAINT REPLY_NO_PK PRIMARY KEY(REPLY_NO),
   FOREIGN KEY(REPLY_ID) REFERENCES MEMBER(MEMBER_ID),
   FOREIGN KEY(REPLY_BOARDNO) REFERENCES DEAL_BOARD(D_BOARDNO),
   FOREIGN KEY(REPLY_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME)
);

--신고게시판
DELETE FROM REPORT;

DROP TABLE REPORT;

DROP SEQUENCE REPORT_SEQ;

CREATE SEQUENCE REPORT_SEQ;

CREATE TABLE REPORT(
   --신고 번호
   REPORT_NO NUMBER NOT NULL,
   --신고 보낸 아이디
   SEND_ID VARCHAR2(10) NOT NULL,
   --신고 받은 아이디
   -- SEND ID, RECEIVE ID 모두 MEMBER와 조인해서 NICKNAME 가져오기
   RECEIVE_ID VARCHAR2(10) NOT NULL,
   --신고 보낸 닉네임
   SEND_NICKNAME VARCHAR2(20) NOT NULL,
   --신고 받는 닉네임
   RECEIVE_NICKNAME VARCHAR2(20) NOT NULL,
   --신고 제목
   REPORT_TITLE VARCHAR2(50) NOT NULL,
   --신고 내용
   REPORT_CONTENT VARCHAR2(3000) NOT NULL,
   --신고 작성 날짜
   REPORT_REGDATE DATE NOT NULL,
   
   CONSTRAINT RP_REPORT_NO_PK PRIMARY KEY(REPORT_NO),
   FOREIGN KEY(SEND_ID) REFERENCES MEMBER(MEMBER_ID),
   FOREIGN KEY(RECEIVE_ID) REFERENCES MEMBER(MEMBER_ID),
   FOREIGN KEY(SEND_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME),
   FOREIGN KEY(RECEIVE_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME)
);
INSERT INTO REPORT
VALUES(REPORT_SEQ.NEXTVAL, 'test', 'member', '문의열리네요', '회원', '거래사기', '거래사기쳤어요', SYSDATE);
INSERT INTO REPORT
VALUES(REPORT_SEQ.NEXTVAL, 'test', 'zxcv', '문의열리네요', '미친개발자', '태도불량', '불친절해요ㅜㅜ', SYSDATE);

--찜목록
DELETE FROM WISH_LIST;

DROP TABLE  WISH_LIST;

DROP SEQUENCE WL_NO_SEQ;

CREATE SEQUENCE WL_NO_SEQ;

CREATE TABLE WISH_LIST(
   --찜 목록 번호
   WL_NO NUMBER NOT NULL,
   --자신의 아이디
   WL_ID VARCHAR2(10) NOT NULL,
   --파는사람 닉네임
   WL_SELL_NICKNAME VARCHAR2(20) NOT NULL,
   --찜 목록 해둔 글의 번호
   WL_BOARDNO NUMBER NOT NULL,
   
   CONSTRAINT WL_NO_PK PRIMARY KEY(WL_NO),
   FOREIGN KEY(WL_BOARDNO) REFERENCES DEAL_BOARD(D_BOARDNO),
   FOREIGN KEY(WL_ID) REFERENCES MEMBER(MEMBER_ID),
   FOREIGN KEY(WL_SELL_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME)
);

--주문내역
DELETE FROM ORDER_LIST;

DROP TABLE ORDER_LIST;

DROP SEQUENCE OL_NO_SEQ;

CREATE SEQUENCE OL_NO_SEQ;

CREATE TABLE ORDER_LIST(
   --주문내역 번호
   OL_NO NUMBER NOT NULL,
   --자신의 아이디
   OL_ID VARCHAR2(10) NOT NULL,
   --파는사람 닉네임
   OL_SELL_NICKNAME VARCHAR2(20) NOT NULL,
   --송장번호
   OL_INVOICE NUMBER,
   --파는글의 번호
   OL_BOARDNO NUMBER NOT NULL,
   
   CONSTRAINT OL_NO_PK PRIMARY KEY(OL_NO),
   FOREIGN KEY(OL_BOARDNO) REFERENCES DEAL_BOARD(D_BOARDNO),
   FOREIGN KEY(OL_ID) REFERENCES MEMBER(MEMBER_ID),
   FOREIGN KEY(OL_SELL_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME)
);

--알람
DELETE FROM ALERT;

DROP TABLE ALERT;

DROP SEQUENCE ALERT_NO_SEQ;

CREATE SEQUENCE ALERT_NO_SEQ;

CREATE TABLE ALERT(
   --알람 번호
   ALERT_NO NUMBER NOT NULL,
   --알람 받을 아이디
   ALERT_ID VARCHAR2(10) NOT NULL,
   --알람의 갯수
   ALERT_COUNT NUMBER NOT NULL,
   --알람을 받을 글의 번호
   ALERT_BOARDNO NUMBER NOT NULL,
    
   CONSTRAINT AT_ALERT_NO_PK PRIMARY KEY(ALERT_NO),
   FOREIGN KEY(ALERT_BOARDNO) REFERENCES DEAL_BOARD(D_BOARDNO),
   FOREIGN KEY(ALERT_ID) REFERENCES MEMBER(MEMBER_ID)
);




CREATE TABLE MAP(
   MAP_NO NUMBER NOT NULL,
   MAP_LONGITUDE NUMBER NOT NULL,
   MAP_LATITUDE NUMBER NOT NULL,
   
   CONSTRAINT MP_MAP_NO_PK PRIMARY KEY(MAP_NO),
   FOREIGN KEY(MAP_NO) REFERENCES DEAL_BOARD(D_BOARDNO)
);