drop table listtbl;

purge recyclebin;

create table ListTbl(
num number primary key,
hdname varchar2(14) not null,
subject varchar2(50) not null,
content varchar2(1000) not null,
userid varchar2(12) not null,
listpwd varchar2(12) not null,
imgfile varchar2(100),
writedate date,
constraint list_pk_userid foreign key (userid) references memberTbl(userid));
