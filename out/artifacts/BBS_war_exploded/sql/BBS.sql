-- BBS 유저 생성
create user BBS identified by oracle
default tablespace users
temporary tablespace temp
quota unlimited on users;

-- 생성된 유저 조회
select username from dba_users;

-- 접속 권한 부여
grant create session to BBS;

-- 테이블 생성 권한 부여
grant create table to BBS;

-- MEMBER 테이블 생성
CREATE TABLE MEMBER (
    userID varchar(20),
    userPassword varchar(20),
    userName varchar(20),
    userGender varchar(20),
    userEmail varchar(50),
    PRIMARY KEY (userID)
);

-- MEMBER 테이블 조회
select * from MEMBER;

truncate table MEMBER;

-- 테스트 insert
insert into MEMBER values ('gildong', '123456', '홍길동', '남자', 'gildong@naver.com');

-- insert 조회
select userPassword from MEMBER where userID = 'gildong';

-- BBS 유저에게 MEMBER 테이블 SELECT, INSERT, DELETE, UPDATE 권한 부여
GRANT SELECT, INSERT, DELETE, UPDATE ON MEMBER TO BBS ;

-- truncate table MEMBER;

commit;

---

-- 게시판 테이블 생성
create table BBS (
    bbsID number primary key,
    bbsTitle varchar2(50),
    userID varchar2(20),
    bbsDate date,
    bbsContent varchar2(2048),
    bbsAvailable number -- 현재 글이 삭제되었는지, 1: 삭제가 되지 않은 글, 0: 삭제가 된 글
);

-- 게시판 테이블 조회
select * from BBS;

-- drop table BBS;

-- truncate table BBS;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;

select sysdate from DUAL;

insert into BBS values ((select max(bbsID)+1 from BBS), '게시판 제목', 'gildong', sysdate, '게시판 내용', 1);

