-- >>>>ȸ������
create table memberTbl(
num number,
username varchar2(10) not null,
userid varchar2(12) not null,
userpwd varchar2(12) not null,
tel varchar2(15) not null,
zipcode varchar2(5) not null,--�����ȣ
addr1 varchar2(80) not null,--�ñ���
addr2 varchar2(80) not null,--��
mylocal varchar2(33));


-- >>>>����
create table pageTbl(
newnum number,
userid1 varchar2(12) not null,
idnum1 number(1) not null,
userid2 varchar2(12) not null,
idnum2 number(1) not null,
text varchar2(100) not null,
writedate date);

-- >>>>�Խ���
create table ListTbl(
num number,
hdname varchar2(14) not null,
subject varchar2(50) not null,
content varchar2(1000) not null,
userid varchar2(12) not null,
imgfile varchar2(100),
writedate date);

-- >>>>���
create table ReplyTbl(
num number primary key,
memnum number not null,
content varchar2(160) not null,
userid varchar2(12) not null,
writedate date
);

-- >>>>�ּ� ���̺�
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
zibun2 number(3));


-- >>>>����Ŭ id- commun, pwd- teamcommun


--������ db
create table master(
id varchar2(12),
pwd varchar2(20)
);

create sequence zipSq
start with 1
increment by 1;
--LISTTBL
--MASTER
--MEMBERTBL
--PAGETBL
--REPLYTBL
--ZIPTBL