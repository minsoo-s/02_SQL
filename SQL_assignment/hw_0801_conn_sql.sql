-- Active: 1658994301812@@127.0.0.1@3306@shoppingmall
create DATABASE shoppingmall;
use shoppingmall;

# user_table 생성
CREATE table user_table(
    userID CHAR(8) not null,	       -- 사용자 ID
    userName VARCHAR(10)  not	null,  -- 이름
    birthYear INT  not	null,	   -- 출생년도
    addr CHAR(2)  not	null,		   -- 지역(경기,서울, 경남, 2 글자)
    mobile1 CHAR(3),       -- 휴대폰 국번
    mobile2 CHAR(8),       -- 휴대폰 나머지 전화번호 (하이픈 제외)
    height SMALLINT,	   -- 키
    mDate DATE,
    constraint pk_user_table primary key (userID)	           -- 회원 가입일
);

# buy_table 생성
CREATE table buy_table(
    num INT auto_increment not null,	--	순번
    userID CHAR(8) not null,	    --	아이디 (FK)
    prodName CHAR(6) not null,	--	물품명
    groupName CHAR(4) ,	--	분류
    price INT not null,	            --	단가
    amount SMALLINT not null,
    constraint pk_buy_table primary key (num),
    constraint fk_buy_table foreign key (userID)
    references user_table(userID)	   	--수량
);


select * from user_table;
select * from buy_table;

select *
from user_table as u join buy_table	as b
on b.userID = u.userID;
desc buy_table;
drop table buy_table;
drop table user_table;

-- 2. 두 테이블을 내부 조인(buy_table.useID와 user_table.userID)한 다음, 아래의 결과와 같이 출력이 되도록 SQL 쿼리를 작성하시오.

-- 1) 내부 조인한 결과에 ‘연락처’ 컬럼 추가
select userNAME,prodNAME,addr, concat(u.mobile1,u.mobile2) as 연락처
from user_table as u join buy_table	as b
on b.userID = u.userID;

-- 2) userID가 KYM인 사람이 구매한 물건과 회원 정보 출력
select u.userID, u.userNAME, b.prodName, u.addr, concat(u.mobile1,u.mobile2)
from user_table as u join buy_table	as b
on b.userID = u.userID
where u.userID = 'KYM';

-- 3) 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
select u.userID, u.userNAME, b.prodName, u.addr, concat(u.mobile1,u.mobile2) as 연락
from user_table as u join buy_table	as b
on b.userID = u.userID
ORDER BY u.userID;

-- 4) 쇼핑몰에서 한 번이라도 구매한 기록이 있는 회원 정보를 회원 아이디 순으로 출력
-- (distinct 사용) 
select distinct(u.userID), u.userNAME, u.addr
from user_table as u join buy_table	as b
on b.userID = u.userID
ORDER BY u.userID;

-- 5) 쇼핑몰 회원 중에서 주소가 경북과 경남인 회원 정보를 회원 아이디 순으로 출력
select u.userID, u.userNAME, u.addr, concat(u.mobile1,u.mobile2) as 연락
from user_table as u join buy_table	as b
on b.userID = u.userID
where addr in ('경북','경남')
ORDER BY u.userID;