-- [SQL문법] 2. where절과 order by절
use hr;

-- 2-1. where절(조건문)
-- [문법] select * | 컬럼1, 컬럼2, 컬럼3
--       from 테이블명
--       where  좌변      =    우변;
--            (컬럼명)(비교연산자)(값)--> 숫자, '문자', '년-월-일'

-- employees 테이블에서 90번 부서에 소속된 사원들 출력하시오.
select employee_id, last_name, salary, department_id
from employees
where department_id = 90;

-- employees 테이블에서 it_prog 업무 담당자를 출력하시오.
select employee_id, last_name, job_id, email, department_id
from employees
where job_id = 'it_prog';

-- employees 테이블에서 1996년 2월 1일 이전 입사자를 출력하시오.
select employee_id, last_name, hire_date
from employees
where hire_date < '1996-02-01';

-- (1) 비교연산자
-- 단일행비교연산자 : =, >, >=, <, <=, <>, !=
-- 추가 비교연산자 : between A and B, in, like, is null

-- [비교연산자1] between A and B
-- 범위 검색 시 사용되는 연산자로 A(하한값)이상 B(상한값)이하의 값을 비교해 주는 연산자
select employee_id, last_name, salary
from employees
where salary between 2500 and 3500;
-- (==)
select employee_id, last_name, salary
from employees
where salary >= 2500
and   salary <= 3500;

select employee_id, first_name, last_name, hire_date
from employees
where hire_date between '1990-01-01' and '1991-12-31';

select employee_id, first_name, last_name, department_id
from employees
where first_name between 'b' and 'd';

-- [비교연산자] in
-- 다중행 비교연산자로 우변에 값리스트가 올 수 있음.
-- 우변의 값리스트들과 비교해서 하나이상 동일하면 만족되는 비교연산자
-- (=, OR)의 성격을 내포하는 비교연산자
select employee_id, last_name, salary, department_id
from employees
where department_id in (20, 80, 100);
-- (==)
select employee_id, last_name, salary, department_id
from employees
where department_id = 20
or    department_id = 80
or    department_id = 100;

select employee_id, last_name, job_id, department_id
from employees
where job_id in ('it_prog', 'ac_account');

-- [비교연산자3] like
-- 패턴 일치 여부를 비교해 주는 연산자
-- like 비교연산자와 함께 사용되는 기호 1) % : 0개 또는 여러개 문자가 올 수 있음.
--                               2) _ : 무조건 1개 문자가 와야함.
-- a로 시작되는 문자열 : 'a%'
-- a가 포함된 문자열 : '%a%'
-- a로 끝나는 문자열 : '%a'
-- 두번째 문자가 a인 문자열 : '_a%'
-- 끝에서 세번째 문자가 a인 문자열 : '%a__'
select employee_id, last_name
from employees
where last_name like '_o%';

select employee_id, last_name, job_id
from employees
where job_id like '%rep';

-- [비교연산자4] is null
-- 값이 null인지를 비교하는 연산자
-- 커미션을 받지 않는 사원들만 출력하시오.
select employee_id, last_name, salary, commission_pct
from employees
where commission_pct is null;

-- 부서가 없는 신입사원 출력하시오.
select employee_id, first_name, last_name, department_id
from employees
where department_id is null;

-- 매니저가 없는 사원 출력하시오.
select employee_id, first_name, last_name, job_id, manager_id
from employees
where manager_id is null;

-- (2) 논리연산자
-- 논리연산자 종류 : and, or, not
-- 논리연산자 우선순위 : not >> and >> or

-- [논리연산자1] and
select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
and   job_id like '%man%';

-- [논리연산자2] or
select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
or    job_id like '%man%';

-- and, or가 함께 사용된 예제
-- where절에서 and를 먼저하고 or 작업을 함.
select employee_id, last_name, salary, job_id, department_id
from employees
where department_id = 30
or    department_id = 50
and   salary >= 8000;

-- where절에서 or를 먼저하고 and 작업을 함.
select employee_id, last_name, salary, job_id, department_id
from employees
where (department_id = 30
or    department_id = 50)
and   salary >= 8000;

-- [논리연산자3] not
-- <<비교연산자 정리>>
-- =							<-->	<>, !=
-- >, >=						<-->	<, <=
-- between A and B : A이상 B이하	<--> 	not between A and B : A미만 B초과
-- in : (=, OR)					<-->	not in : (<>, and)
-- like							<-->	not like
-- is null						<--> 	is not null

select employee_id, last_name, salary, department_id
from employees
where salary not between 5000 and 15000;

select employee_id, last_name, job_id, hire_date
from employees
where job_id not in ('sa_rep', 'st_man', 'it_prog');

select employee_id, last_name, job_id, hire_date
from employees
where hire_date not like '1996%';

select employee_id, last_name, salary, commission_pct
from employees
where commission_pct is not null;

-- 2-2. order by절(정렬)
-- [문법] select 컬럼명1, 컬럼명2, 컬럼명3, ...
--       from 테이블명
--      [where 조건문]
--      [order by 컬럼명 [asc(default) | desc]];

-- 컬럼명을 기준으로 정렬하기
select employee_id, last_name, job_id, department_id, hire_date
from employees
where department_id is not null
order by department_id;

select employee_id, last_name, job_id, department_id, hire_date
from employees
order by hire_date desc;

select employee_id, last_name, email
from employees
order by last_name;

-- 표현식 또는 alias명으로 정렬하기
select employee_id, last_name, salary*12 annsal
from employees
order by salary*12;
-- (==)
select employee_id, last_name, salary*12 annsal
from employees
order by annsal;

-- 위치 표기법으로 정렬하기
select employee_id, first_name, last_name, department_id, salary
from employees
order by 4 desc;

-- 여러 컬럼을 기준으로 정렬하기
select employee_id, last_name, department_id, salary, email
from employees
order by department_id desc, salary desc;

select employee_id, last_name, department_id, salary, email
from employees
order by department_id, salary desc;

-- <연습문제>
-- 1. 
-- [방법1] 단일행 비교연산자
select last_name, hire_date
from employees
where hire_date >= '2000-01-01' and hire_date <= '2000-12-31';

-- [방법2] like
select last_name, hire_date
from employees
where hire_date like '2000%';

-- [방법3] between A and B
select last_name, hire_date
from employees
where hire_date between '2000-01-01' and '2000-12-31';

-- 2. 
select last_name, salary, commission_pct
from employees
where commission_pct is null
order by salary desc;