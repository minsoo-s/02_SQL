-- Active: 1658994301812@@127.0.0.1@3306@sakila

-- group by ----------------------------------------------------------------------------
-- 많은 데이터를 일일이 조회하기 어려운 경우가 많음
-- group by 절을 사용하여 특정 컬럼의 데이터를 그룹화
-- 집계 함수(aggregate function)를 사용하여 각 그룹의 행 수를 계산
----------------------------------------------------------------------------------------
select customer_id,	count(*)
from rental
group by customer_id ; -- 1열 오름차순 정렬

SELECT customer_id, count(*)
from rental
GROUP BY customer_id
order by 2 desc; -- 2열 내림차순 정렬


-- having절 사용 ----------------------------------------------------------------------
-- 정렬 후 조건을 설정할 때 group by 다음에 having 절 사용
-- whrere절은 group by절 앞에 와야하므로 이 경우는 having으로 조건 설정
----------------------------------------------------------------------------------------
select customer_id,	count(*)
from rental
group by customer_id
having count(*)	>=	40;


-- 암시적 그룹 결과: group by절을 사용하지 않음: 집계 함수에 의해 생성된 값 ----------
select max(amount)	as max_amt,
min(amount)	as min_amt,
avg(amount)	as avg_amt,
sum(amount)	as tot_amt,
count(*)	as num_payments
from payment;

-- 명시적 그룹 결과: 집계 함수를 적용하기 위해 group by 절에 그룹화할 열의 이름 지정
select customer_id,
       max(amount)	as max_amt,
       min(amount)	as min_amt,
       avg(amount)	as avg_amt,
       sum(amount)	as tot_amt,
       count(*)	as num_payments
from payment
group by customer_id;

# 고유한 값 계산
select 
count(customer_id)	as num_rows, --행의 수
count(distinct customer_id)	as num_customers --반복을 제거한 행의 수
from payment;


# Null 값 처리: 함수들이 null 값을 만나면 무시 -> 행의 수만 늘어남.


# [ with rollup 옵션 ]
# • group by 결과로 출력된 항목들의 합계를 나타내는 행을 추가하는 방법
select fa.actor_id,	f.rating, count(*)
from film_actor as fa
    inner join film	as f
    on fa.film_id =	f.film_id
group by fa.actor_id, f.rating with rollup
order by 1,	2;

# 학습 점검
select customer_id,	count(*), sum(amount)
from payment
group by customer_id;