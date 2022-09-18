# [ Query & Filtering]_2022.07.29(금)
-- Active: 1658994301812@@127.0.0.1@3306@sakila
use sakila;
select * from language;

------------------------- [ Query ] -----------------------------------

-- [clause(절)]     [이름 사용 목적 ]
-- 1. select   : 쿼리 결과에 포함할 열을 결정
-- 2. from     : 데이터를 검색할 테이블과 테이블을 조인하는 방법을 식별
-- 3. where    : 불필요한 데이터를 걸러냄 (조건식)
-- 4. group	by : 공통 열 값을 기준으로 행을 그룹화함
-- 5. having   : 불필요한 그룹을 걸러냄
-- 6. order	by : 하나 이상의 열을 기준으로 최종 결과의 행을 정렬
# [ 1. SELECT문 ]  -----------------------------------------------------


# select 호출
SELECT language_id, name, last_update from language;
select name from language;

# 열의 별칭(alias) 
# 열레이블 지정, 출력 이해 쉬움. as키워드로 가독성 향상
SELECT language_id,
'COMMON' as language_usage,
language_id * 3.14 as lang_pi_value,
upper(name) as language_name
from language;

# 중복제거 : DISTINCT
SELECT actor_id from film_actor ORDER BY actor_id;

# 데이터 정렬이 먼저 이루어지므로 시간소요가 많아 지양.
SELECT distinct actor_id from film_actor ORDER BY actor_id;


-- [ 2. FROM절 ] -------------------------------------------------------
-- 쿼리에 사용되는 테이블을 명시 , 테이블을 연결하는 수단

--  테이블 유형 : from 절에 포함
--  ● 영구 테이블(permanent table) : create table 문으로 생성
--  ● 파생 테이블(derived table) : 하위 쿼리(subquery)에서 반환하고 메모리에 보관된 행들
--  ● 임시 테이블(temporary table) : 메모리에 저장된 휘발성 데이터
--  ● 가상 테이블(virtual table) : create view문으로 생성
------------------------------------------------------------------------

# 1. 파생 테이블 subquery
SELECT concat(cust.last_name, ',' , cust.first_name) as full_name
from (
    select first_name, last_name, email
    from customer
    where first_name = 'JESSIE'
) as cust;

# 2. 임시 테이블 : 데이터베이스 세션이 닫힐 때 사라짐.
CREATE TEMPORARY TABLE actors_j
    (actor_id smallint(5),
    first_name varchar(45),
    last_name varchar(45)
);
# 원본 쿼리에서 #1: J로 시작하는 last_name을 검색
SELECT actor_id, first_name, last_name
FROM actor WHERE last_name like 'J%';

# 원본 쿼리에서 'J'로 시작하는 데이터 찾아서 임시 테이블에 저장
insert into actors_j
select actor_id, first_name, last_name
from actor where last_name like 'J%';
select * from actors_j;

# 3. 가상 테이블 (View) 생성
CREATE VIEW cust_vw AS
SELECT customer_id, first_name, last_name, active
FROM customer;

#  가상 테이블 (view) 활용
SELECT first_name, last_name from cust_vw
where active = 0;

# 삭제
DROP VIEW cust_vw;


-- [ 3. WHRER절 ] ------------------------------------------------------
-- 1. 테이블 연결: JOIN(INNER JOIN): 연결있는 두 개 이상의 테이블 합침
-- SELECT <열 목록>	
-- FROM <기준 테이블> [INNER] JOIN <참조할 테이블>	
-- ON <조인 조건>	
-- [WHERE 검색 조건]
------------------------------------------------------------------------
# 예제 : INNER JOIN
select customer.first_name, customer.last_name,
    time(rental.rental_date) as rental_time
from customer inner join rental
    on customer.customer_id = rental.customer_id
where date(rental.rental_date) = '2005-06-14';

# 예제 : DATE() 함수
SELECT DATE('2022-07-29 09:02:03') AS DAY1;
# 예제 : TIME() : HH:MM:SS 정보 리턴
SELECT TIME('2022-07-29 09:02:03') AS TIME1;

# 예제 : TABLE 별칭 정의
select c.first_name, c.last_name,
    time(r.rental_date)	as rental_time
from customer as c inner join rental as r
    on c.customer_id =	r.customer_id
where date(r.rental_date) = '2005-06-14';

# 예제 : AND, OR, NOT 연산자
SELECT title, rating, rental_duration
FROM film
WHERE (rating = 'G' and rental_duration >= 7)
    or(rating = 'PG-13' and rental_duration < 4);


-- [ 4. GROUP BY절과 HAVING절 ] ---------------------------------------
-- SELECT 컬럼 FROM 테이블 GROUP BY	그룹화할 컬럼 HAVING 
------------------------------------------------------------------------
SELECT c.first_name, c.last_name, count(*)
from customer as c
    inner join rental as r
    on c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
HAVING count(*) >= 40; -- count(*) : 그룹화한 전체 행의 수


-- [ 5. ORDER BY ] -----------------------------------------------------
# 오름차순 : ASC
select c.first_name, c.last_name,
    time(r.rental_date)	as rental_time
from customer as c inner join rental as r
    on c.customer_id =	r.customer_id
where date(r.rental_date) = '2005-06-14'
ORDER BY c.last_name, c.first_name asc;

# 내림차순 : DESC
select c.first_name, c.last_name,
    time(r.rental_date)	as rental_time
from customer as c inner join rental as r
    on c.customer_id =	r.customer_id
where date(r.rental_date) = '2005-06-14'
ORDER BY r.rental_date DESC;

--[ 연습 문제 ] --------------------------------------------------------

# 1. 1차 정렬 : last_name , 2차 정렬 : first_name
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name, first_name;

# 2. 성이 ‘WILLIAMS’ 또는 ‘DAVIS’인 모든 배우의 actor_id, first_name, last_name을 검색
SELECT actor_id, first_name, last_name
from actor
WHERE last_name = 'WILLIAMS' or last_name = 'DAVIS';

# 3. rental 테이블에서 2005년 7월 5일 영화를 대여한 고객 ID를 반환하는 쿼리를 작성하고, date()함수로 시간 요소를 무시
SELECT distinct customer_id
from rental
where date(rental_date) = '2005-07-05';

# 4. 컬럼 :store_id, email, return_date 출력
SELECT c.store_id c.email, r.return_date
FROM customer as c
INNER JOIN rental as r
on c.customer_id = r.customer_id
where date(r.rental_date) - '2005-06-14'
order by return_date desc;




----------------------------[ FILTERING ]-------------------------------
--  4.1 조건 평가 
--  4.2 조건 작성 
--  4.3 조건 유형 
--  4.4 Null
------------------------------------------------------------------------

-- [1. 조건평가 ]-------------------------------------------------------
-- and 또는 or 연산자로 하나 이상의 조건을 포함
-- 조건 2개 이상 시, 괄호 사용

-- not 연산자
-- not 연산자로 <> 사용

-- 조건 연산자
-- • 비교 연산자: =, !=, <, >, <>, like, in, between
-- • 산술 연산자: +, -, *, /

-- 동등 조건(equality condition): ‘열 = 표현/값’ <-> 부등조건
-- 범위 조건 : 날짜의 경우, 시간이 포함되어 있어 당일은 포함하지 않음.
                --> date() 함수를 사용해야 정확한 날짜 추출.
------------------------------------------------------------------------

# 동등 조건(equality condition): ‘열 = 표현/값
select c.email
from customer as c
inner join rental as r
on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14';

# 부등 조건(inequality condition): 두 표현이 동일하지 않음
select c.email
from customer as c
inner join rental as r
on c.customer_id = r.customer_id
where date(r.rental_date) <> '2005-06-14';

# 데이터를 수정할 때 사용
delete from rental
where year(rental_date)	=2004;

delete from rental
where year(rental_date)	<>	2005 and year(rental_date)<>2006;

# 2005년 6월 14일부터 6월 16일까지의 데이터를 출력하기 위해
select customer_id, rental_date
from rental
where date(rental_date) <= '2005-06-16'
    and date(rental_date) >= '2005-06-14';


-- [2. between 연산자 ] ----------------------------------------------
-- betwwen 문법
-- 숫자 범위 
-- 문자열 범위
--------------------------------------------------------------------
# between [범위의 하한값] and [범위의 상한값]
select customer_id, rental_date
from rental
where rental_date between '2005-06-14' and '2005-06-16';

# 숫자 범위 사용: 하한값과 상한값이 범위에 포함됨
select customer_id, payment_date, amount
from payment
where amount between 10.0 and 11.99;

# 문자열 범위: last_name이 ‘FA’와 ‘FRB’로 시작하는 데이터 리턴
select last_name, first_name
from customer
where last_name between 'FA' and 'FRB';


-- [3. 멤버십 조건 ] ---------------------------------------------------
-- OR 또는 IN() 연산
-- 서브 쿼리 사용
-- not in 사용
------------------------------------------------------------------------

# OR 연산
select title, rating
from film
where rating='G' or rating='PG';

# IN() 연산
select title, rating
from film
where rating in ('G', 'PG');

# not in: 표현식 집합 내에 존재하지 않음
select title, rating
from film
where rating not in ('PG-13', 'R', 'NC-17');

# 서브 쿼리 사용
-- where 절 내용: where rating in ('G', 'PG');
select title, rating from film where title like '%PET%';

select title, rating
from film
where rating in (select rating from film where title like '%PET%');
-- » ‘PET%’: PET로 시작하는 단어
-- » ‘%PET’: PET로 끝나는 단어
-- » ‘%PET%’: PET를 포함하는 단어


-- [4. 일치 조건 ] ---------------------------------------------------
-- 문자열 부분 가져오기
-- 와일드 카드
-- 정규표현식
------------------------------------------------------------------------

# 1-1. left(문자열, n)
select left('abcdefg', 3);
# 1-2. mid(문자열, 시작 위치, n) = substr(문자, 시작 위치, n)
select mid('abcdefg', 2, 3);
# 1-3. right(문자열, n)
select right('abcdefg', 2);

-- 2. 와일드 카드
-- ‘_’: 정확히 한 문자 
-- ‘%’: 개수에 상관없이 모든 문자 포함
-- 와일드 카드 사용시 LIKE 연산자를 사용

# 2-1. 두 번째 위치에 ‘A’, 네 번째 위치에 ‘T’를 포함하며 마지막은 ‘S
select last_name, first_name
from customer
where last_name like '_A_T%S';

# 2-2. last_name이 ‘Q’로 시작하거나 ‘Y’로 시작하는 고객 이름 검색
select last_name, first_name
from customer
where last_name like 'Q%' or last_name like 'Y%';

# 3. 정규표현식
-- ‘^[QY]’: Q 또는 Y로 시작하는 단어 검색
select last_name,	first_name
from customer
where last_name	REGEXP '^[QY]';

-- [ 5. Null ] ---------------------------------------------------------
-- 해당 사항 없음 
-- 아직 알려지지 않은 값 
-- 정의되지 않은 값
------------------------------------------------------------------------

# is null : Null 확인 방법
select rental_id, customer_id, return_date
from rental
where return_date is null;

# is not null : 열에 값이 할당되어 있는 경우 (null이 아닌 경우)
select rental_id, customer_id, return_date
from rental
where return_date is not null;

# Null과 조건 조합
-- 반납이 되지 않은 경우, 반납 날짜의 값이 NULL
-- • 또는 반납 날짜가 2005년 5월~ 2005년 8월 사이가 아닌 경우
select rental_id, customer_id, return_date
from rental
where return_date is null
or return_date not between '2005-05-01' and '2005-09-01';


# [6. 실습 ] -----------------------------------------------------------

# 서브셋 조건 설정
select payment_id, customer_id,	amount,	
    date(payment_date) as payment_date
from payment
where (payment_id between 101 and 120);

# 실습1. 아래의 필터조건에 따라 반환되는 payment_id는 무엇입니까?
# customer_id가 5가 아니고
# amount가 8보다 크거나 payment_date가 2005년 8월 23일인 경우
select payment_id, customer_id,	amount,	
    date(payment_date) as payment_date
from payment
where (payment_id between 101 and 120)
and customer_id <> 5 
and (amount > 8 or date(payment_date) = '2005-08-23' );

# 실습2. 다음 필터조건에 따라 반환되는 payment_id는 무엇입니까?
# customer_id는 5이고
# amount가 6보다 크거나 payment_date가 2005년 6월 19일이 아닌 payment_id
select payment_id, customer_id,	amount,	
    date(payment_date) as payment_date
from payment
where (payment_id between 101 and 120)
and customer_id = 5 
and not (amount > 6 or date(payment_date) = '2005-06-19' );

# 실습3. payments 테이블에서 금액이 1.98, 7.98 또는 9.98인 모든 행을 검색하는 쿼리
SELECT * from payment
WHERE amount in(1.98, 7.98, 9.98);
