-- Active: 1658994301812@@127.0.0.1@3306@sqlclass_db

-- [SQL 과제 #2 ]_2022.07.29(금)_신민수
---------------------------------------------------------------------------
-- 1. sqlclass_db 데이터베이스에 제공된 nobel.csv파일을 import하여 각각 nobel 테이블을 생성
-- 하고 아래 내용에 대해 쿼리를 작성하시오.
-- n 제출물: hw02.sql
-- n 데이터베이스 이름: sqlclass_db
-- n 테이블 이름: nobel (1901년 ~ 1965년까지 노벨상 수상자 현황)
---------------------------------------------------------------------------
use sqlclass_db;
# 1) 1960년에 노벨상 물리학상 또는 노벨 평화상을 수상한 사람의 정보를 출력
#   - 출력 컬럼: year, subject, winn
SELECT year, subject, winner from nobel
where year = 1960 
and (subject ='Physics' or subject ='Peace');

# 2) Albert Einstein이 수상한 연도와 상 이름을 출력
# - 출력 컬럼: year, subject
SELECT year, subject FROM nobel
where winner = 'Albert Einstein';

# 3) 1910년 부터 1950년까지 노벨 평화상 수상자 명단 출력
#   - 출력 컬럼: year, winner
SELECT year, winner FROM nobel
where subject = 'peace' 
and year BETWEEN 1910 and 1950;

# 4) 전체 테이블에서 수상자 이름이 ‘John’으로 시작하는 수상자 모두 출력
#   - 출력 컬럼: subject, winner 
SELECT subject, winner FROM nobel
where winner REGEXP '^John';

# 5) 1964년 수상자 중에서 노벨화학상과 의학상을 제외한 수상자의 모든 정보를 수상자
#   이름을 기준으로 오름차순으로 정렬 후 출력
SELECT * FROM nobel
where (year = 1964)
and not((subject = 'Chemistry') or (subject = 'Medicine'))
order by winner ASC;

# 6) 1910년부터 1960년까지 노벨 문학상 수상자 명단 출력
SELECT winner FROM nobel
where subject = 'Literature' 
and year BETWEEN 1910 and 1960;

# 7) 각 분야별 역대 수상자의 수를 내림차순으로 정렬 후 출력(group by, order by)
SELECT SUBJECT, COUNT(*) subject FROM nobel
GROUP BY subject
ORDER BY COUNT(*) DESC;

# 8) 노벨 의학상이 없었던 연도를 모두 출력 (distinct) 사용
SELECT distinct year FROM nobel
WHERE year not in (select year from nobel where subject = 'Medicine');

# 9) 노벨 의학상이 없었던 연도의 총 회수를 출력
SELECT count(*) FROM 
(SELECT count(*) FROM nobel
WHERE year not in (select year from nobel where subject = 'Medicine')
GROUP BY year) AS S;