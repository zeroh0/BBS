select * from BBS;

truncate table BBS;

select * from (select * from BBS where bbsId < 3 and bbsAvailable = 1 order by bbsId desc) where ROWNUM <= 10;

select bbsID from BBS order by bbsID desc;

select max(BBSID) from BBS;

select * from ALL_CONSTRAINTS where TABLE_NAME = 'BBS';

create table BBS
(
    BBSID        int primary key,
    BBSTITLE     VARCHAR2(50),
    USERID       VARCHAR2(20),
    BBSDATE      DATE,
    BBSCONTENT   VARCHAR2(2048),
    BBSAVAILABLE int
);

drop table BBS;

insert into BBS values ((select max(BBSID)+1 from BBS), '게시판 테스트', 'gildong', sysdate, '게시판 내용', 1);

commit;


select * from (select * from BBS where bbsId < 13 and bbsAvailable = 1 order by bbsId desc) where ROWNUM <= 10;

select * from (select * from BBS where bbsId < 2 and bbsAvailable = 1 order by bbsId desc) where ROWNUM <= 10;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;

select TO_DATE(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;


select TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') from dual;

SELECT TO_DATE('20201108132408') FROM DUAL;