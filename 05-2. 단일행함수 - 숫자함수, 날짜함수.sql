-- [SQL 문법] 5-2. 단일행함수 - 숫자함수, 날짜함수
use hr;

-- (1) 숫자함수
-- round(숫자, 반올림할 자리) : 반올림을 해주는 함수
-- truncate(숫자, 버림할 자리) : 버림을 해주는 함수
-- 숫자 ... 1  2  3 . 4 5 6 ...
-- 자리 ...-2 -1  0   1 2 3 ...
select round(45.923, 2), round(45.923, 0), round(45.923, -1);
select truncate(45.923, 2), truncate(45.923, 0), truncate(45.923, -1);
select employee_id, last_name, salary, commission_pct,
       truncate(12*salary*commission_pct, 0) as "1년 수당"
from employees
where commission_pct is not null;

-- ceil(숫자) : 일의 자리로 올림하는 함수
-- floor(숫자) : 일의 자리까지 남기고 버림하는 함수 (=) truncate(숫자, 0)
select ceil(45.923), ceil(52.1), ceil(63.09);
select floor(45.923), floor(52.1);

-- mod(숫자1, 숫자2) : 숫자1을 숫자2로 나눈 나머지를 반환함.
select 157/10, mod(157, 10), 157 mod 10, 157 % 10;

select last_name, salary, mod(salary, 5000)
from employees
where job_id = 'SA_REP';

-- 값이 짝수인지 홀수인지를 확인하는 용도로도 활용됨. 
select employee_id, mod(employee_id, 2)
from employees;

-- abs(숫자) : 숫자의 절대값을 반환함.
select abs(-5), abs(5), abs(-4.5);

-- power(숫자, 제곱값) = pow(숫자, 제곱값) : 숫자의 제곱값을 반환함.
select power(2, 3), power(4, 4), power(8, 2);

-- sign(숫자) : 숫자가 양수면 1, 음수면 -1, 0이면 0을 반환함.
select sign(3), sign(-3), sign(-4.3), sign(0);

-- (2) 날짜함수
-- now() = sysdate() = current_timestamp() : 현재 날짜/시간을 반환함.
select now(), sysdate(), current_timestamp();

-- current_date() = curdate() : 현재 날짜를 반환함(년/월/일)
-- cureent_time() = curtime() : 현재 시간을 반환함(시/분/초)
select now(), current_date(), current_time();

-- year(날짜/시간) : 날짜/시간에서 년도를 반환함.
-- month(날짜/시간) : 날짜/시간에서 월을 반환함.
-- day(날짜/시간) : 날짜/시간에서 일을 반환함.
-- hour(날짜/시간) : 날짜/시간에서 시간을 반환함.
-- minute(날짜/시간) : 날짜/시간에서 분을 반환함.
-- second(날짜/시간) : 날짜/시간에서 초를 반환함.
select now(), year(now()), month(now()), day(now()), 
       hour(now()), minute(now()), second(now());

select last_name, hire_date, year(hire_date), month(hire_date), day(hire_date)
from employees
where department_id = 90;

-- 1987년에 입사한 직원 출력하시오.
select employee_id, last_name, hire_date, salary
from employees
where year(hire_date) = 1987;

-- 5월에 입사한 직원 출력하시오.
select employee_id, last_name, hire_date, salary
from employees
where month(hire_date) = 5;
-- (==)
select employee_id, last_name, hire_date, salary
from employees
where substr(hire_date, 6, 2) = '05';
-- (==)
select employee_id, last_name, hire_date, salary
from employees
where hire_date like '%-05-%';

-- date(날짜/시간) : 날짜/시간에서 날짜를 반환함.
-- time(날짜/시간) : 날짜/시간에서 시간을 반환함.
select date(now()), time(now()), now();

-- adddate(날짜, 기간) = date_add(날짜, 기간) : 날짜에 기간을 더한 날짜를 반환함.
-- subdate(날짜, 기간) = date_sub(날짜, 기간) : 날짜에 기간을 뺀 날짜를 반환함.
select adddate('2024-01-01', interval 35 day),
	   adddate('2024-01-01', interval 2 month),
       date_add('2024-01-01', interval 1 year);
       
select subdate('2024-01-01', interval 35 day),
	   subdate('2024-01-01', interval 2 month),
       date_sub('2024-01-01', interval 1 year);   

select last_name, hire_date, 
       adddate(hire_date, interval 6 month) as "입사 6개월 후", 
       subdate(hire_date, interval 7 day) as "입사 7일전"
from employees
where department_id = 60;

-- addtime(날짜/시간, 시간) : 날짜/시간에서 시간을 더한 결과값 반환함.
-- subtime(날짜/시간, 시간) : 날짜/시간에서 시간을 뺀 결과값 반환함.
select addtime('2025-01-01 23:59:59', '1:1:1'),
       addtime('15:00:10', '2:10:30');

select subtime('2025-01-01 23:59:59', '1:1:1'),
       subtime('15:00:10', '2:10:30');

-- datediff(날짜1, 날짜2) : 날짜1 - 날짜2의 결과가 반환함.
-- timediff(시간1, 시간2) : 시간1 - 시간2의 결과가 반환함.
select datediff('2026-05-07', now()),
	   abs(datediff(now(), '2026-05-07'));
select timediff('23:30:50', '12:11:10');

select last_name, hire_date, datediff(now( ), hire_date) as "근무한 일수" 
from employees;      

-- (예제) employess 테이블로부터 오늘 날짜를 기준으로 근무한 주수가 1500주 미만인 
-- 사원들의 last_name, hire_date, 근무한 일수, 근무한 주수를 출력하는 구문을 작성하시오.
select last_name, hire_date, datediff(now(), hire_date) as "근무한 일수",
	   truncate(datediff(now(), hire_date)/7, 0) as "근무한 주수"
from employees
where datediff(now(), hire_date)/7 < 1500;





