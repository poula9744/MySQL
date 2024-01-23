use hrdb;

/*************************************
*              03일차 수업             *
*************************************/

select first_name,
	   salary,
	   round(salary) #단일함수
from employees;

-- 오류
select first_name,
	   salary,
       sum(salary) #그룹함수 --> 하나의 row에 표현될 수 없다
from employees;

-- -----------------------------------
#             count()                #
-- -----------------------------------

select count(*), 
	   count(commission_pct)
from employees;

select count(first_name)
from employees;

select count(commission_pct)
from employees;

-- 월급이 16000 초과되는 직원의 수는?
select count(*)
from employees
where salary > 16000;

-- -----------------------------------
#                sum()               #
-- -----------------------------------
select count(*),
	   sum(salary),
       sum(employee_id)
from employees;

-- -----------------------------------
#                avg()               #
-- -----------------------------------
select count(*),
	   sum(salary),
       avg(salary)
from employees;

select count(*),
	   sum(salary),
       avg(ifnull(salary,0))
from employees;

-- -----------------------------------
#          max() / min()             #
-- -----------------------------------
select count(*),
	   max(salary),
       min(salary)
from employees
;


-- -----------------------------------
#            group by 절              #
-- -----------------------------------
select department_id,
	   avg(salary)
from employees
group by department_id
order by department_id asc
;

select department_id,
	   max(salary),
       avg(salary)
from employees
group by department_id
order by department_id asc
;

select department_id, 
	   job_id, 
       sum(salary)
from employees
group by department_id, job_id
order by department_id asc
;

# 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력하세요
# where절에는 그룹함수를 쓸 수 없다
select department_id '부서 번호',
	   count(department_id) 인원수,
       sum(salary) 월급합계
from employees
where sum(salary) >= 20000 
group by department_id
;
-- -----------------------------------
#             having 절              #
-- -----------------------------------
select department_id '부서 번호',
	   count(department_id) 인원수,
       sum(salary) 월급합계
from employees
group by department_id
having sum(salary) >= 20000 
order by department_id asc
;

select department_id,
	   count(*),
       sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id = 100
;

-- -----------------------------------
#     IF~ELSE 문 / CASE~END 문        #
-- -----------------------------------
select first_name,
	   commission_pct,
	   if(commission_pct is null, 0, 1) state
from employees;


#직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
#실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,
         #'SA_REP' 월급+월급*0.2,
		 #'ST_CLERL' 면 월급+월급*0.3
         #그외에는 월급으로 계산하세요
select employee_id,
	   salary, 
       job_id,
       CASE when job_id = 'AC_ACCOUNT' then salary+salary*0.1
		    when job_id = 'SA_REP'     then salary+salary*0.2
            when job_id = 'ST_CLERK'   then salary+salary*0.3
            ELSE salary
	   END realSalary
from employees;

#직원의 이름, 부서번호, 팀을 출력하세요
#팀은 코드로 결정하며 부서코드가
    #10~50 이면 'A-TEAM'
	#60~100이면 'B-TEAM'
    #110~150이면 'C-TEAM'
    #나머지는 '팀없음' 으로 출력하세요.
select concat(first_name, ' ', last_name) 이름,
	   department_id 부서번호, 
       CASE when department_id between 10 and 50 then 'A-Team'
		    when department_id between 60 and 100 then 'B-Team'
            when department_id between 110 and 150 then 'C-Team'
            ELSE '팀 없음'
	    END team
from employees
order by team asc;


-- -----------------------------------
#              Join                  #
-- -----------------------------------
-- 사람이름, 부서번호
select first_name, department_id
from employees;

-- 부서명
select *
from employees;

-- join
select  e.first_name, 
		d.department_name, 
        e.department_id,
        d.department_id
from employees as e, departments as d
where e.department_id = d.department_id;

select  e.first_name, 
		d.department_name, 
        e.department_id,
        d.department_id
from employees e 
inner join departments d
	on e.department_id = d.department_id;
    
#모든 직원이름, 부서이름, 업무명 을 출력하세요 *3개의 테이블
select e.first_name 직원이름,
	   d.department_name 부서이름,
       j.job_title 업무명
from employees e, departments d, jobs j
where e.employee_id = d.manager_id
and e.job_id = j.job_id;

select e.first_name 직원이름,
	   d.department_name 부서이름,
       j.job_title 업무명
from employees e
inner join departments d
	on e.employee_id = d.manager_id
inner join jobs j
	on e.job_id = j.job_id;

-- 이름, 부서번호, 부서명, 업무아이디, 업무명, 도시아이디, 도시명 
select e.first_name
	   ,d.department_id
	   ,d.department_name
	   ,j.job_id
       ,j.job_title
       ,l.location_id
       ,l.city
from employees e, departments d, jobs j, locations l
where e.employee_id = d.manager_id
and d.location_id = l.location_id
and e.job_id = j.job_id
;

select e.first_name
	   ,d.department_id
	   ,d.department_name
	   ,j.job_id
       ,j.job_title
       ,l.location_id
       ,l.city
from employees e
inner join departments d
	on e.employee_id = d.manager_id
inner join jobs j
	on e.job_id = j.job_id
inner join locations l
	on d.location_id = l.location_id
;