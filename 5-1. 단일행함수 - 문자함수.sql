-- [SQL문법 ] 5-1. 단일행함수 - 문자함수
use hr;

-- 함수란?
-- 인수를 받아서 정해진 조작을 한 후 반드시 하나의 결과값을 반환함.
-- SQL함수 유형 : 단일행함수, 다중행함수(=그룹함수)

-- 단일행함수란?
-- 행당 조작해서 하나의 결과값을 반환함.
-- 단일행함수 유형 : 문자함수, 숫자함수, 날짜함수, 변환함수
--               제어흐름함수, 시스템정보함수

-- ascii(문자) : 해당 문자의 아스키코드값을 반환함.
-- char(숫자) : 해당 숫자(아스키코드값)의 문자를 반환함.
select ascii('A'), ascii('B'), ascii('a')
from dual;

select char(65), char(97);

-- length(문자열) : 문자열의 byte수를 반환함.
-- bit_length(문자열) : 문자열의 bit수를 반환함.
-- char_length(문자열) : 문자열의 문자의 개수를 반환함.
select length('itwill'), bit_length('itwill'), char_length('itwill');
select length('아이티윌'), bit_length('아이티윌'), char_length('아이티윌');

select employee_id, last_name, email, length(email)
from employees;

-- concat(인수1, 인수2, ..., 인수n) : n개의 인수를 하나의 문자열로 연결함.
-- concat_ws(구분자, 인수1, ..., 인수n) : 구분자와 함께 인수n개를 연결함.
select employee_id, concat(first_name, ' ', last_name) as name, email
from employees;

select employee_id, 
       concat(last_name, ' / ', email, ' / ', salary, ' / ', job_id)
       as emp_info
from employees;
-- (==)
select employee_id, 
       concat_ws(' / ', last_name, email, salary, job_id) as emp_info
from employees;

-- instr(문자열, 특정문자) : 문자열에서 특정 문자의 첫번째 위치값을 반환함.
select employee_id, last_name, instr(last_name, 'a')
from employees;

-- upper(문자열) : 대문자로 변환함.
-- lower(문자열) : 소문자로 변환함.
select employee_id, upper(first_name) as F_name, 
       upper(last_name) as L_name, lower(email) as "E-mail", job_id
from employees;

select concat('The job id for ' , upper(last_name) , ' is ' , lower(job_id))
from employees;

-- left(문자열, 길이) : 문자열의 왼쪽에서 길이만큼 반환함. (=) substr(문자열, 1, 길이)
-- right(문자열, 길이) : 문자열의 오른쪽에서 길이만큼 반환함. (=) substr(문자열, -N, N)
-- substr(문자열, 시작위치, 길이) : 문자열에서 시작위치부터 길이만큼 반환함.
select employee_id, last_name, email, 
	   left(email, 3), right(email, 3), substr(email, 2, 3)
from employees;

select employee_id, last_name, job_id, left(job_id, 2), substr(job_id, 1, 2)
from employees;

select employee_id, last_name, job_id, right(job_id, 2), substr(job_id, -2, 2)
from employees;

select employee_id, concat(left(last_name, 2), '***', right(last_name, 2)) as name,
       concat('010-', substr(phone_number, 5, 3), '-****') as phone
from employees;

-- 1990년 이전 입사자를 출력하시오.
select employee_id, last_name, left(hire_date, 4) as "입사년도"
from employees
where left(hire_date, 4) < 1990;
-- (==)
select employee_id, last_name, left(hire_date, 4) as "입사년도"
from employees
where hire_date < '1990-01-01';

-- 1987년에 입사한 직원 출력하시오.
select employee_id, last_name, hire_date, department_id
from employees
where left(hire_date, 4) = 1987;
-- (==)
select employee_id, last_name, hire_date, department_id
from employees
where hire_date between '1987-01-01' and '1987-12-31';

-- lpad(문자열, 전체길이, 채울문자) : 문자열을 전체 길이만큼 늘려서 출력하되
--                               혹시 남는 공간이 있다면 채울 문자로 채움.
--                               오른쪽 정렬하는 함수
-- rpad(문자열, 전체길이, 채울문자) : 문자열을 전체 길이만큼 늘려서 출력하되
--          					 혹시 남는 공간이 있다면 채울 문자로 채움.
-- 								 왼쪽 정렬하는 함수
select lpad(first_name, 20, '_') as fname,
	   rpad(last_name, 20, '_') as lname
from employees;

-- ltrim(문자열) : 문자열의 왼쪽 공백을 제거함.
-- rtrim(문자열) : 문자열의 오른쪽 공백을 제거함.
-- trim(문자열) : 문자열의 양쪽(앞/뒤) 공백을 제거함.
-- trim(방향 특정문자 from 문자열) : 방향 - leading(앞), trailing(뒤), both(양쪽)
--                              문자열로부터 해당 방향의 특정 문자를 제거함.
select ltrim('     MySQL DBMS   ') as test1,
       rtrim('     MySQL DBMS   ') as test2,
       trim('     MySQL DBMS   ') as test3;

select trim(both '_' from '__SQL_문법_____') as test;

-- replace(문자열, 특정문자, 바꿀문자) : 문자열에서 특정 문자를 바꿀 문자로 교체함.
select employee_id, last_name, 
       replace(phone_number, '.', '-') as phone
from employees;

-- space(길이) : 길이만큼의 공백을 반환함.
select concat('MySQL', '          ', 'DBMS') as test;
-- (==)
select concat('MySQL', space(10), 'DBMS') as test;

-- <연습문제>
-- 1.
SELECT last_name as "Name", LENGTH(last_name) as "Length"
FROM employees
WHERE left(last_name, 1) in ('J', 'M', 'A')
ORDER BY last_name;
-- (==)
SELECT last_name as "Name", LENGTH(last_name) as "Length"
FROM employees
WHERE substr(last_name, 1, 1) in ('J', 'M', 'A')
ORDER BY last_name;
-- (==)
SELECT last_name as "Name", LENGTH(last_name) as "Length"
FROM employees
WHERE last_name LIKE 'J%'
OR 	  last_name LIKE 'M%'
OR    last_name LIKE 'A%'
ORDER BY last_name;

-- 2.
SELECT last_name, LPAD(salary, 15, '$') as SALARY
FROM employees;

-- 3. 
-- [오답] 백의 자리는 반올림해서 처리하는 방식
SELECT salary, CONCAT(last_name, ' ', RPAD('*', salary/1000, '*')) 
       as EMPLOYEES_AND_THEIR_SALARIES
FROM employees
ORDER BY salary DESC;
-- (==)
SELECT salary, CONCAT(last_name, RPAD(' ', salary/1000+1, '*')) 
       as EMPLOYEES_AND_THEIR_SALARIES
FROM employees
ORDER BY salary DESC;

-- [정답] 백의 자리는 버림해서 처리하는 방식
SELECT salary, CONCAT(last_name, ' ', RPAD('*', truncate(salary/1000,0), '*')) 
       as EMPLOYEES_AND_THEIR_SALARIES
FROM employees
ORDER BY salary DESC;
-- (==)
SELECT salary, CONCAT(last_name, RPAD(' ', truncate(salary/1000,0)+1, '*')) 
       as EMPLOYEES_AND_THEIR_SALARIES
FROM employees
ORDER BY salary DESC;



