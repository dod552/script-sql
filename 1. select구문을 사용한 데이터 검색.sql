-- [SQL문법] 1. select구문을 사용한 데이터 검색
use hr;
show tables;

-- 테이블 구조 조회하기
-- [문법] desc[ribe] 테이블명;
desc employees;
desc departments;
desc locations;

-- 테이블로부터 데이터 검색하기
-- [문법] select * | 컬럼1, 컬럼2, 컬럼3, ...
--       from 테이블명;

-- 모든 컬럼 출력하기
select *
from employees;

select *
from departments;

select *
from locations;

-- 특정 컬럼 출력하기
select department_id, department_name
from departments;

-- 산술연산자 : *, /, +, -
-- 산술연산자 우선순위 규칙 : 1) *, /가 +, -보다 우선순위가 높다.
-- 						2) 괄호() 안이 우선순위가 높다.
-- 산술식(표현식) : 산술연산자를 활용한 계산식
-- select 구문에 산술식 포함된 예제
select last_name, salary, 12*salary+100
from employees;

select last_name, salary, 12*(salary+100)
from employees;

-- null값이란?
-- 알 수 없는 값, 모르는 값, 아직 정의되지 않은 값, 할당받지 못한 값 등
-- 공백(문자)도 아니고, 0(숫자)도 아닌 하나의 특수한 값
-- 모든 데이터타입에 사용 가능한 값

-- 커미션을 받지 않는 사원들은 null값이 저장되어 있음.
select last_name, job_id, salary, commission_pct
from employees;

-- 부서가 없는 신입사원(178번 직원)은 부서 컬럼에 null값이 저장되어 있음.
select employee_id, last_name, department_id
from employees;

-- 매니저가 없는 사장(100번 직원)은 매니저 컬럼에 null값이 저장되어 있음.
select employee_id, last_name, manager_id
from employees;

-- 100 + null = null
-- 100 - null = null
-- 100 * null = null
-- 100 / null = null
-- 24000 * 12 + 300 / null + 100 = null
-- => 산술식에 null값이 포함된 경우 그 결과도 null이다! 

-- (예제1) employees 테이블에서 사원들의 employee_id, last_name, salary,
-- commission_pct, 1년 동안의 수당을 출력하시오.
select employee_id, last_name, salary, commission_pct,
       12*salary*commission_pct
from employees;

-- (예제2) employees 테이블에서 사원들의 employee_id, last_name, salary,
-- commission_pct, 연봉을 출력하시오.
-- [연봉 공식] (12*salary)+(12*salary*commission_pct)
select employee_id, last_name, salary, commission_pct,
       (12*salary)+(12*salary*commission_pct)
from employees;

-- column alias : 테이블의 제목줄을 재명명하는 문법
-- [문법1] 컬럼명 as alias
-- [문법2] 컬럼명 alias
-- [문법3] 컬럼명 [as] "별칭" --> 특수문자(_, #, $ 제외), 공백 포함
 select employee_id as "사번", last_name L_name, salary "emp sal", 
        12*salary as "연간 급여"
 from employees;

-- distinct 키워드 : 중복값을 제외하고 출력해 주는 키워드
-- employees 테이블의 107명의 사원들이 소속된 부서 종류(리스트)를 출력하시오.
select distinct department_id
from employees;

select distinct department_id, job_id
from employees
order by department_id;

-- <연습문제>
-- 1. 
select employee_id as "Emp #", last_name as "Employee", 
       job_id as "Job", hire_date as "Hire Date"
from employees;

-- 2.
desc employees;

select distinct job_id
from employees;