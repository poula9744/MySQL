use hrdb;

-- 문제1. 
select  concat(first_name, ' ', last_name) 이름,
		salary 월급,
        phone_number 전화번호,
        hire_date 입사일
from employees
order by hire_date asc, first_name asc;

-- 문제2. 
select  job_title,
		max_salary
from jobs
order by max_salary desc;

-- 문제3.
select  concat(first_name, ' ', last_name) 이름,
		manager_id '매니저 아이디',
        ifnull(commission_pct, 0) '커미션 비율',
        salary 월급
from employees
where manager_id is not null
and commission_pct is null
and salary >= 3000
order by salary desc;

-- 문제4. 
select  job_title 이름,
		max_salary 최고월급
from jobs
where max_salary >= 1000
order by max_salary desc;

-- 문제5. 
select  first_name 이름,
		salary 월급,
        ifnull(commission_pct, 0) 커미션퍼센트
from employees
where salary<14000
and salary>=10000
order by salary desc;
        
-- 문제6. 
select concat(first_name, ' ', last_name) 이름, 
		salary 월급,
        date_format(hire_date, '%Y-%m') 입사일,
        department_id 부서번호
from employees
where department_id in (10, 90, 100);

-- 문제7.
select  first_name 이름,
		salary 월급
from employees
where first_name like '%s%';

-- 문제8. 
select department_name
from departments
order by char_length(department_name) desc;

-- 문제9. 
select  country_id,
		ucase(country_name) 나라이름
from countries
order by country_name asc;

-- 문제10. 
select concat(first_name, ' ', last_name) 이름,
	   salary 월급,
       replace(phone_number, '.', '-') 전화번호,
       hire_date 입사일
from employees
where hire_date > 031231;		