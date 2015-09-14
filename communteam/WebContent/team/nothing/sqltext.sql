-- >>>>회원가입
create table memberTbl(
num number not null,
username varchar2(10) not null,
userid varchar2(12) constraint mem_pk_userid primary key,
userpwd varchar2(12) not null,
tel varchar2(15) not null,
email varchar2(30) not null,
zipcode varchar2(5) not null,--우편번호
addr1 varchar2(80) not null,--시구동
addr2 varchar2(80) not null,--상세
mylocal varchar2(33),
userout varchar2(1)
email varchar2(30));

-- >>>>쪽지
create table pageTbl(
newnum number not null,
userid1 varchar2(12) not null,
idnum1 number(1) not null,
userid2 varchar2(12) constraint page_pk_userid2 primary key,
idnum2 number(1) not null,
text varchar2(100) not null,
writedate date,
constraint page_pk_userid1 foreign key (userid1) references memberTbl(userid)
);

-- >>>>게시판
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

-- >>>>댓글
create table ReplyTbl(
num number primary key,
memnum number not null,
content varchar2(160) not null,
userid varchar2(12) not null,
writedate date,
constraint re_pk_userid foreign key (userid) references memberTbl(userid)
);

-- >>>>주소 테이블
create table zipTbl(
num number primary key,
zipcode varchar(5) not null,
sido varchar2(20) not null,
si_gun_gu varchar2(20),
myem varchar2(20),
doro varchar2(20),
bNum number(4),
bName varchar2(40),
dong varchar2(20),
zibun1 number(5),
zibun2 number(3),

);


-- >>>>오라클 id- commun, pwd- teamcommun


--관리자 db
create table master(
id varchar2(12),
pwd varchar2(20)
);