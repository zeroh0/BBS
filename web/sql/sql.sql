select * from BBS;

truncate table BBS;

select * from (select * from BBS where bbsId < 3 and bbsAvailable = 1 order by bbsId desc) where ROWNUM <= 10;

select bbsID from BBS order by bbsID;

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