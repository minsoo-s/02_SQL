# 2022.07.28(목)
# 데이터베이스 만들기
create DATABASE testdb;
use testdb;

# 테이블 만들기--------------------------------------------------------------
create table person
	(person_id SMALLINT UNSIGNED,
	fname VARCHAR(20),
	lname VARCHAR(20),
	eye_color ENUM('BR','BL','GR'),
	birth_date DATE,
	street	VARCHAR(30),
	city	VARCHAR(20),
	state	VARCHAR(20),
	country	VARCHAR(20),
	postal_code VARCHAR(20),
	CONSTRAINT pk_person PRIMARY KEY (person_id)
);
CREATE TABLE favorite_food
	(person_id SMALLINT UNSIGNED,
	food VARCHAR(20),
	CONSTRAINT pk_favorite_food PRIMARY KEY (person_id,food),
	CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
	REFERENCES person(person_id)
);

desc person;
DESC favorite_food;

# 테이블 제약있을 때 방법-------------------------------------------------------
SET foreign_key_checks=0;
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
SET foreign_key_checks = 1;

DESC person;

# 데이터 화인하는 코드
SELECT * FROM person;
SELECT * FROM favorite_food;

# 데이터 추가----------------------------------------------------------------
INSERT INTO person 
(person_id,
	fname,
	lname,
	eye_color,
	birth_date)
VALUES (NULL,
'William',
'Turner',
'BR',
'1972-05-27');

SELECT * FROM person;

# 데이터 확인: SELECT문--------------------------------------------------------

SELECT person_id, fname, lname, birth_date FROM person;
SELECT person_id, fname, lname, birth_date FROM person WHERE lname ='Turner';

# 데이터 추가: (insert)-------------------------------------------------------

# 방법1
INSERT INTO favorite_food(person_id, food)
value(1, 'pizza');
INSERT INTO favorite_food(person_id, food)
value(1, 'cookies');
INSERT INTO favorite_food(person_id, food)
value(1, 'nachos');

# 방법2
insert into favorite_food (person_id,	food)
values (1,	'pizza'),	(1,	'cookie'),	(1,	'nachos');

# 조건부 정렬-----------------------------------------------------------------

SELECT food FROM favorite_food
WHERE person_id = 1 ORDER BY food desc;

insert into person
(person_id, fname, lname, eye_color, birth_date,
street, city, state, country, postal_code)
values 
(null, 'Susan', 'Smith', 'BL', '1975-11-02',
'23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

select person_id, fname, lname, birth_date from person

# 업데이트---------------------------------------------------------------------

update person
set street = '1225 Tremon St.',
	city = 'Boston',
	state = 'MA',
	country = 'USA',
	postal_code = '02138'
where person_id=1;

SELECT * FROM person;

# 삭제-----------------------------------------------------------------------

delete from person	where person_id=3;

