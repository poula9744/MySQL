-- 문제1. 
select count(manager_id) haveMngCnt
from employees;

-- 문제2. 
select max(salary) 최고임금
	   ,min(salary) 최저임금
       ,max(salary)-min(salary) '최고임금-최저임금'
from employees;

-- 문제3. 
select date_format(max(hire_date), '%Y년 %m월 %d일') '마지막으로 신입사원이 들어온 날'
from employees;


-- 문제4.
select department_id 부서아이디
	   ,avg(salary) 평균임금
	   , max(salary) 최고임금
       , min(salary) 최저임금
from employees
group by department_id
order by department_id desc;

-- 문제5.
select job_id '업무 아이디'
	  ,round(avg(salary)) 평균임금
      ,max(salary) 최고임금
      ,min(salary) 최저임금
from employees
group by job_id
order by min(salary) desc, avg(salary) asc;

-- 문제6.
select date_format(min(hire_date), '%Y-%m-%d %W') '가장 오래 근속한 직원의 입사일'
from employees;

-- 문제7.
select ifnull(department_id, "없음") 부서
	   ,avg(ifnull(salary, 0)) 평균임금
       ,min(ifnull(salary, 0)) 최저임금
       ,avg(ifnull(salary, 0))-min(ifnull(salary, 0)) '(평균임금-최저임금)'
from employees
group by department_id
having (평균임금-최저임금)<2000
order by (평균임금-최저임금) desc;

-- 문제8. 
select job_title 업무
	   ,max_salary-min_salary '최고임금과 최저임금 차이'
from jobs
group by job_title, max_salary-min_salary
order by max_salary-min_salary desc;

-- 문제9.
select manager_id
	   ,round(avg(salary)) avg
       ,max(salary) max
       ,min(salary) min
from employees
group by manager_id
having avg>=5000
order by avg desc;

-- 문제10. 
select hire_date,
	   CASE when hire_date <021231 then '창립멤버'
			when 030101 <= hire_date and hire_date <= 031231  then '03년 입사'
            when 040101 <= hire_date and hire_date <= 041231 then '04년 입사'
		    else '상장이후입사'
	   END optDate
from employees;

-- 문제11. 
 select  
			 CASE when date_format(min(hire_date), '%a') = 'Mon' then date_format(min(hire_date), '%Y년 %m월 %d일(월요일)')
					   when date_format(min(hire_date), '%a') = 'Tue' then date_format(min(hire_date), '%Y년 %m월 %d일(화요일)')
                       when date_format(min(hire_date), '%a') = 'Wen' then date_format(min(hire_date), '%Y년 %m월 %d일 (수요일)')
                       when date_format(min(hire_date), '%a') = 'Thu' then date_format(min(hire_date), '%Y년 %m월 %d일 (목요일)')
                       when date_format(min(hire_date), '%a') = 'Fri' then date_format(min(hire_date), '%Y년 %m월 %d일 (금요일)')
                       when date_format(min(hire_date), '%a') = 'Sat' then date_format(min(hire_date), '%Y년 %m월 %d일 (토요일)')
					   else date_format(min(hire_date), '%Y년 %m월 %d일 (일요일)')
             END '가장 오래 근속한 직원의 입사일'
from employees;

# case ~ end 로 영어 --> 한글로 바꿈
# date_format으로 hire_date를 format형식으로 바꿔줌