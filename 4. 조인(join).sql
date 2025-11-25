-- [SQL문법] 4. 조인(join)
use hr;

-- 조인(join)이란?
-- 하나 이상의 테이블로부터 데이터를 검색하는 문법
-- [문법] select 컬럼명1, 컬럼명2, 컬럼명3, ...
--       from 테이블1 join 테이블2
--       on 테이블1.컬럼 = 테이블2.컬럼
--      [where 조건문]
--      [order by 컬럼 [asc | desc]];

-- (예제1) employees, departments 테이블을 사용해서
-- 직원 정보(employee_id, last_name, job_id, salary, department_id)와
-- 직원이 소속된 부서 정보(department_name)를 함께 출력하시오.
select employee_id, last_name, job_id, salary,
       employees.department_id, department_name
from employees join departments
on employees.department_id = departments.department_id
order by employee_id;
-- (==)
select employees.employee_id, employees.last_name, employees.job_id, 
       employees.salary, employees.department_id, 
       departments.department_name
from employees join departments
on employees.department_id = departments.department_id
order by employees.employee_id;
-- (==)
select e.employee_id, e.last_name, e.job_id, e.salary, 
       e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id
order by e.employee_id;

-- (예제2) departments, locations 테이블을 사용해서
-- 부서 정보(department_id, department_name, location_id)와
-- 부서의 위치 정보(city, street_address)를 함께 출력하시오.
select d.department_id, d.department_name, d.location_id,
       l.city, l.street_address
from departments d join locations l
on d.location_id = l.location_id;

-- (예제3) employees, jobs 테이블을 사용해서
-- 직원 정보(employee_id, last_name, job_id)와
-- 직원이 담당하고 있는 업무명(job_title)을 함께 출력하시오.
select e.employee_id, e.last_name, e.job_id, j.job_title
from employees e join jobs j
on e.job_id = j.job_id
order by e.employee_id;

-- (예제4) employees, departments 테이블을 사용해서
-- 부서 정보(department_id, department_name, manager_id)와
-- 부서의 매니저 이름(first_name, last_name)을 함께 출력하시오.
select d.department_id, d.department_name, d.manager_id,
       e.first_name, e.last_name
from departments d join employees e
on d.manager_id = e.employee_id
order by d.department_id;

-- (예제5) employees, departments 테이블을 사용해서
-- 사원 정보(employee_id, last_name, salary, hire_date)와
-- 사원이 소속된 부서 정보(department_name)를 함께 출력하되
-- 급여가 8000이상인 사원만 출력하고, 사번을 기준으로 오름차순 정렬하시오.
select e.employee_id, e.last_name, e.salary, e.hire_date, d.department_name
from employees e join departments d
on e.department_id = d.department_id
where e.salary >= 8000
order by e.employee_id;

-- N개 테이블 조인하기
-- 테이블 수 | 조인조건 수
-- ------------------
--    2        1
--    3        2
--    N       N-1

-- (예제6) employees, departments, locations 테이블을 사용해서
-- 직원의 정보(employee_id, last_name, salary)와
-- 직원이 소속된 부서 정보(department_id, department_name)와
-- 부서의 위치 정보(location_id, city, street_address)를 함께 출력하시오.
select e.employee_id, e.last_name, e.salary, 
       d.department_id, d.department_name,
       l.location_id, l.city, l.street_address
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
order by e.employee_id;
-- (==)
select e.employee_id, e.last_name, e.salary, 
       d.department_id, d.department_name,
       l.location_id, l.city, l.street_address
from employees e join departments d join locations l
on e.department_id = d.department_id
and d.location_id = l.location_id
order by e.employee_id;

-- self-join(자체조인)이란?
-- 자기 자신 테이블과 조인하는 유형
-- 하나의 테이블을 마치 다른 테이블인듯 테이블 alias를 다르게 부여해서 조인함.

-- (예제7) employees 테이블로부터
-- 직원의 정보(employee_id, last_name, job_id, email, manager_id)와
-- 직원의 매니저 이름(last_name)을 함께 출력하시오.
select e1.employee_id, e1.last_name as emp_name, e1.job_id, e1.email, 
	   e1.manager_id, e2.last_name as mgr_name
from employees e1 join employees e2
on e1.manager_id = e2.employee_id;

-- <연습문제>
-- 1.
select e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- 2.
select e1.last_name as "Employee", e1.employee_id as "Emp#", 
       e2.last_name as "Manager", e1.manager_id as "Mgr#" 
from employees e1 join employees e2
on e1.manager_id = e2.employee_id;



