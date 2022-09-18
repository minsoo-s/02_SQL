-- Active: 1658994301812@@127.0.0.1@3306@sakila
-- 다중테이블(JOIN), 집합연산_2022.08.01(월)
# ------------------------------[ 1. JOIN ]--------------------------------


# 내부조인(inner join)-----------------------------------------------------
-- SELECT <열 목록>	
-- FROM <기준 테이블>	[INNER] JOIN	<참조할 테이블>	
-- ON <조인 조건>	
-- [WHERE 검색 조건]
SELECT c.first_name, c.last_name, a.address
from customer as c inner join address as a
on c.address_id = a.address_id;


# 외부조인(outer join)-----------------------------------------------------
-- SELECT <열 목록> 
-- FROM <첫 번째 테이블(LEFT)> 
-- <LEFT | RIGHT | FULL> [OUTER] JOIN <두 번째 테이블(RIGHT)> 
-- ON <조인 조건> 
-- [WHERE 검색조건];


# SQL92문법 표기----------------------------------------------------------
-- join 조건 : on절
-- 필터 조건 : whrer절
select c.first_name, c.last_name, a.address, a.postal_code
from customer as c join address	as a
on c.address_id = a.address_id
where a.postal_code = 52137;


# 세 개의 테이블 조인(조인 순서는 상관없음.)--------------------------------
select c.first_name, c.last_name, ct.city, a.address
from customer as c
    inner join address as a
    on c.address_id = a.address_id
    inner join city as ct
    on a.city_id = ct.city_id;


# 서브 쿼리 사용---------------------------------------------------------------
select c.first_name, c.last_name, addr.address,	addr.city, addr.district
from customer as c
    inner join
    (select a.address_id, a.address, ct.city, a.district from address   as a
        inner join city	ct
        on a.city_id =	ct.city_id
    where a.district =	'California'
    ) as addr
on c.address_id =	addr.address_id;


# 테이블 재사용----------------------------------------------------------------
-- 여러 테이블을 join할 경우, 같은 테이블을 두 번 이상 join 할 수 있음
-- 두 명의 특정 배우가 출연한 영화 제목 검색
-------------------------------------------------------------------------------
select f.title
from film as f
    inner join film_actor as fa
    on f.film_id =	fa.film_id
    inner join actor a
    on fa.actor_id = a.actor_id
where ((a.first_name = 'CATE' and a.last_name = 'MCQUEEN')
    or (a.first_name = 'CUBA' and a.last_name = 'BIRCH'));

-- 두 배우가 같이 출연한 영화만 검색
-- film 테이블에서 film_actor 테이블에 두 행(두 배우)가 있는 모든 행을 검색
-- • 같은 테이블을 여러 번 사용하기 때문에 테이블 별칭 사용.
select f.title
from film	as f
    inner join film_actor as fa1
    on f.film_id = fa1.film_id
    inner join actor as a1	#	film,	film_actor,	actor 내부 조인 #1
    on fa1.actor_id	= a1.actor_id
    inner join film_actor as fa2
    on f.film_id = fa2.film_id
    inner join actor as	a2	#	film,	film_actor,	actor	내부 조인 #2
    on fa2.actor_id	=	a2.actor_id
where (a1.first_name	=	'CATE' and a1.last_name	=	'MCQUEEN')	
    and (a2.first_name	=	'CUBA' and a2.last_name	=	'BIRCH');


use sqlclass_db;
# 셀프 조인 -----------------------------------------------------------------------
create table customer
    (customer_id smallint unsigned,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birth_date DATE,
    spouse_id SMALLINT UNSIGNED,
    constraint PRIMARY KEY (customer_id)); -- 기존의 customer_id가 있으면 지우고 재생성.

desc customer;

insert into customer(customer_id, first_name, last_name, birth_date, spouse_id)
VALUES
(1,	'John',	'Mayer',	'1983-05-12',	2),
(2,	'Mary',	'Mayer',	'1990-07-30',	1),
(3,	'Lisa',	'Ross',	'1989-04-15',	5),
(4,	'Anna',	'Timothy',	'1988-12-26',	6),
(5,	'Tim',	'Ross',	'1957-08-15',	3),
(6,	'Steve',	'Donell',	'1967-07-09',	4);
insert INTO customer (customer_id, first_name, last_name, birth_date)
values (7, 'Donna', 'Trapp', '1978-06-23');

select * from customer;

# self-join 예제
select
    cust.customer_id,
    cust.first_name,
    cust.last_name,
    cust.birth_date,
    cust.spouse_id,
    spouse.first_name as spouse_firstname,
    spouse.last_name as spouse_lastname
from customer	as cust
    join customer as spouse
    on cust.spouse_id =	spouse.customer_id;


use sakila;
# 실습 ----------------------------------------------------------------------------------
# JOHN이라는 이름의 배우가 출연한 모든 영화의 제목을 출력
# ---------------------------------------------------------------------------------------
select f.title
    from film	as f
    inner join film_actor as fa
    on f.film_id =	fa.film_id
    inner join actor as a
    on fa.actor_id = a.actor_id
where a.first_name = 'JOHN';

# 학습점검 -----------------------------------------------------------------------------
-- 같은 도시에 있는 모든 주소를 반환하는 쿼리 작성
-- address 테이블을 self-join, 각 행에는 서로 다른 주소가 포함
----------------------------------------------------------------------------------------
select a1.address as addr1,	a2.address as addr2, a1.city_id, a1.district
from address as a1
    inner join address	as a2
where (a1.city_id =	a2.city_id)
    and (a1.address_id != a2.address_id);


-------------------------------------[ 2.집합 연산 ]-------------------------------------
-- 집합 연산 규칙
-- - 두 데이터셋 모두 같은 수의 열을 가져야 됨.
-- - 두 데이터셋의 각 열의 자료형은 서로 동일해야 됨.
-----------------------------------------------------------------------------------------
select 1 as num, 'abc' as str
union
select 9 as num, 'xyz' as str;

-- [유니온 연산자] ---------------------------------------------------------------------
-- union 연산자 :결합된 집합을 정렬하고 중복을 제거
-- union all 연산자 :중복되는 모든 값을 보여줌
----------------------------------------------------------------------------------------
desc customer;
desc actor;

# union all ----------------------------------------------------------------------------
select 'CUST' as type1,	c.first_name, c.last_name
from customer as c
union all
select 'ACTR' as type1,	a.first_name, a.last_name
from actor as a;

select count(first_name) from customer;
select count(first_name) from actor;

select c.first_name,	c.last_name
from customer	as c
where c.first_name like 'J%' and c.last_name like 'D%'
union all
select a.first_name,	a.last_name
from actor	as a
where a.first_name like 'J%' and a.last_name like 'D%';

# union --------------------------------------------------------------------------------
# 중복 데이터 제거됨.
----------------------------------------------------------------------------------------
select c.first_name,	c.last_name
from customer	as c
where c.first_name like 'J%' and c.last_name like 'D%'
union
select a.first_name,	a.last_name
from actor	as a
where a.first_name like 'J%' and a.last_name like 'D%';

-- 복합 쿼리의 결과 정렬 ----------------------------------------------------------------
-- order by 절을 쿼리 마지막에 추가
-- • 열 이름 정의는 복합 쿼리의 첫 번째 쿼리에 있는 열의 이름을 사용해야 됨
-----------------------------------------------------------------------------------------
select a.first_name as fname, a.last_name as lname
from actor as a
where a.first_name like 'J%' and a.last_name like 'D%'
union all
select c.first_name, c.last_name
from customer as c
where c.first_name like 'J%' and c.last_name like 'D%'
order by lname,	fname; -->  첫번째 쿼리 열 사용

--  집합 연산의 순서 --------------------------------------------------------------------
--  복합 쿼리는 위에서 아래의 순서대로 실행
--  예외: intersect 연산자가 다른 집합 연산자보다 우선 순위가 높음
-----------------------------------------------------------------------------------------
select a.first_name, a.last_name
from actor as a
where a.first_name like 'J%' and a.last_name like 'D%'
union all
select a.first_name,	a.last_name
from actor	as a
where a.first_name like 'M%' and a.last_name like 'T%'
union 
select c.first_name,	c.last_name
from customer	as c
where c.first_name like 'J%' and c.last_name like 'D%';

-- 6.5 학습 점검 -----------------------------------------------------------------------
-- 실습 6-2
-- 성이 L로 시작하는 모든 배우와 고객의 이름과 성을 찾는 복합 쿼리 작성
----------------------------------------------------------------------------------------
select first_name, last_name
from actor
where last_name like 'L%'
union
select first_name, last_name
from customer
where last_name like 'L%';

-- 실습 6-3
-- last_name 열을 기준으로 실습 6-2의 결과를 오름 차순 정렬하시오.
select first_name, last_name
from actor
where last_name like 'L%'
union
select first_name, last_name
from customer
where last_name like 'L%'
order by last_name;

-----------------------------[ 데이터 생성, 조작, 변환 ]---------------------------------
-- 7.1 문자열 데이터 처리 : 문자열 생성 , 문자열 조작  
-- 7.2 숫자 데이터 처리 : 산술 함수 , 숫자 자릿수 관리 , Signed 데이터 처리 
-- 7.3 시간 데이터 처리 : 시간대 처리 , 시간 데이터 생성 , 시간 데이터 조작
-----------------------------------------------------------------------------------------
use testdb;

-- [문자열 데이터 처리] -----------------------------------------------------------------
-- char 고정 길이 문자열 자료형(MySQL 255글자)
-- varchar 가변 길이 문자열 자료형(MySQL 최대 65,536 글자 허용)
-- text 매우 큰 가변 길이 문자열 저장
-----------------------------------------------------------------------------------------
# 테이블 생성
create table string_tbl (
    char_fld char(30),
    vchar_fld varchar(30),
    text_fld text
);

# 문자열 데이터를 테이블에 추가1
insert into string_tbl (char_fld, vchar_fld, text_fld)
values (
    'This	is	char	data',
    'This	is	varchar	data',
    'This	is	text	data');

# 문자열 데이터를 테이블에 추가2
insert into string_tbl (char_fld, vchar_fld, text_fld)
values (
    'This	string	is	28	characters',
    'This	string	is	28	characters',
    'This	string	is	28	characters');

# 문자열의 개수를 반환
select length(char_fld)	as char_length,
        length(vchar_fld) as varchar_length,
        length(text_fld) as text_length
from string_tbl;

-- position() 함수 ----------------------------------------------------------------------
-- 부분 문자열의 위치를 반환 (MySQL의 문자열 인덱스: 1부터 시작)
-- 부분 문자열을 찾을 수 없는 경우, 0을 반환함
-----------------------------------------------------------------------------------------
select position('characters' in vchar_fld)
from string_tbl;


--  locate(‘문자열’, 열이름, 시작위치) 함수 ---------------------------------------------
--  특정 위치의 문자부터 검색, 검색의 시작 위치 정의
-----------------------------------------------------------------------------------------
select locate('is',	vchar_fld,	5)
from string_tbl;


delete from string_tbl;

-- strcmp(‘문자열1’, ‘문자열2’) 함수 ----------------------------------------------------
-- if 문자열1 < 문자열2, -1 반환
-- if 문자열1 == 문자열2, 0 반환
-- if 문자열1 > 문자열2, 1 반환
-----------------------------------------------------------------------------------------
insert into string_tbl(vchar_fld)
values 
('abcd'),
('xyz'),
('QRSTUV'),
('qrstuv'),
('12345');

select vchar_fld
from string_tbl
order by vchar_fld;

-- strcmp() 예제 ------------------------------------------------------------------------
-- 5개의 서로 다른 문자열 비교
select 
strcmp('12345', '12345') 12345_12345,
strcmp('abcd', 'xyz') abcd_xyz,
strcmp('abcd', 'QRSTUV') abcd_QRSTUV,
strcmp('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
strcmp('12345', 'xyz') 12345_xyz,
strcmp('xyz', 'qrstuv')	xyz_qrstuv;


--[ like 또는 regexp 연산자 사용 ]------------------------------------------------------
-- select 절에 like 연산자나 regexp 연산자를 사용.
-- 0 또는 1의 값을 반환.
-----------------------------------------------------------------------------------------
use sakila;
select name, name like '%y' as ends_in_y
from category;
select name, name REGEXP 'y$' as ends_in_y
from category;


-- [ concat() 함수 ] --------------------------------------------------------------------
-- 문자열 추가 함수
-- concat() 함수를 사용하여 string_tbl의 text_fld열에 저장된 문자열 수정.
-- • 기존 text_fld의 문자열에 ',but	now	it	is	longer’ 문자열 추가.
-----------------------------------------------------------------------------------------
use testdb;
delete from string_tbl;
insert into string_tbl (text_fld)
values ('This	string	was	29	characters');

# 문자열 추가
update string_tbl
set text_fld =	concat(text_fld,	',	but	now	it	is	longer');

# 변경된 text_fld 열 확인
select text_fld
from string_tbl;


-- [ concat() 함수 활용 ] ---------------------------------------------------------------
-- 각 데이터 조각을 합쳐서 하나의 문자열 생성
-- concat() 함수 내부에서 date(create_date)를 문자열로 변환
-----------------------------------------------------------------------------------------
use sakila;
#	concat()	함수 사용 #2
select concat(first_name,'	', last_name,
' has been a customer since	', date(create_date)) as cust_narrative
from customer;


-- [ insert() 함수 ] --------------------------------------------------------------------
-- 4개의 인수로 구성
-- insert(문자열, 시작위치, 길이, 새로운 문자열)
-----------------------------------------------------------------------------------------
select insert('goodbye	world',	9,	0,	'cruel') as string;
select insert('goodbye	world', 1,	7,	'hello') as string;


-- [ replace() 함수 ] -------------------------------------------------------------------
-- replace(문자열, 기존문자열, 새로운 문자열)
-- 기존 문자열을 찾아서 제거하고, 새로운 문자열을 삽입
-----------------------------------------------------------------------------------------
select replace('goodbye	world',	'goodbye',	'hello')as replace_str;


-- [ substr() 함수 ] --------------------------------------------------------------------
-- § substr(문자열, 시작위치, 개수)
-- § 문자열에서 시작 위치에서 개수만큼 추출
-----------------------------------------------------------------------------------------
select substr('goodbye	cruel	world',	9,	5);


-- [ cast() 함수 ] ----------------------------------------------------------------------
-- 지정한 값을 다른 데이터 타입으로 변환
-- cast() 함수를 이용해서 datetime값을 반환하는 쿼리 생성
select cast('2019-09-17	15:30:00' as datetime);

# date 값과 time 값을 생성
select cast('2019-09-17' as date)	date_field,
cast('108:17:57' as time)	time_field;


-- MySQL의 문자열을 이용한 datetime 처리 ------------------------------------------------
-- MySQL은 날짜 구분 기호에 관대
-- 2019년 9월 17일 오후 3시 30분에 대한 유효한 표현 방식
-----------------------------------------------------------------------------------------
-- '2019-09-17	15:30:00'
-- '2019/09/17	15:30:00'
-- '2019,09,17,15,30,00'
-- '20190917153000'
------------------------------>>> '섞어서 써도 모두 적용됨'
select cast('20190917153000' as datetime); -- 오..이게 되네??
select cast('2020-07-07 15' as datetime);
select cast('2022/05-16 14:23:34' as datetime);
select cast('2019-2,28 23:00:00' as datetime);



-- [ 날짜 생성 함수 / str_to_date()] ----------------------------------------------------
-- • 형식 문자열의 내용에 따라 datetime, date 또는 time값을 반환
-- • cast() 함수를 사용하기에 적절한 형식이 아닌 경우 사용
-- • ‘September 17, 2019’ 문자열을 date 형식으로 변환
-----------------------------------------------------------------------------------------
select str_to_date('September 17, 2019', '%M %d, %Y') as return_date;
-- 주의! 콤마가 있으면 변형 형태에서도 똑같이 넣어줘야 함.

# 현재 날짜/시간
select CURRENT_DATE(),	CURRENT_TIME(),	CURRENT_TIMESTAMP();

# date_add() :날짜를 반환하는 시간 함수
-- 지정한 날짜에 일정 기간(일, 월, 년 등)을 더해서 다른 날짜를 생성
select date_add(current_date(),	interval 5 day);

select last_day('2022-08-01'); -- 해당월의 마지막 날짜 반환
select dayname('2022-08-01'); -- 해당 날짜의 영어 요일 이름을 반환
select extract(year from '2019-09-18	22:19:05'); -- date의 구성 요소 중 일부를 추출
select datediff('2019-09-03',	'2019-06-21'); -- 두 날짜 사이의 기간(년, 주, 일)을 계산
select cast('1456328' as signed	integer); -- 데이터를 다른 유형으로 변환할 때 사용
select cast('20220101' as date); --cast() 예제1
select cast(20220101 as char); --cast() 예제2
select cast(now() as signed); --cast() 예제3