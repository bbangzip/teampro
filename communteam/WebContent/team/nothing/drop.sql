--drop table memberTbl;
--drop table pageTbl;
--drop table ListTbl;
--drop table ReplyTbl;
drop table zipTbl;

PURGE RECYCLEBIN;

create table zipTbl(
num number primary key,
zipcode varchar(5) not null,
sido varchar2(20) not null,
gu varchar2(20) not null,
myem varchar2(20),
doro varchar2(20),
bNum number(4),
bName varchar2(40),
dong varchar2(20) not null,
zibun1 number(5),
zibun2 number(3));