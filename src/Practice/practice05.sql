
/* 문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요. (45건) */ 
select first_name 이름
            ,manager_id 매니저아이디
            ,ifnull(commission_pct, '없음') 커미션비율
            ,salary 월급
from employees
where manager_id is not null
and commission_pct is null
and salary>3000;

/*문제2.
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 
월급(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요
-조건절비교 방법으로 작성하세요
-월급의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.             (11건) */
select employee_id 직원번호
            ,first_name 이름
            ,salary 월급
            ,CASE when date_format(min(hire_date), '%a') = 'Mon' then date_format(min(hire_date), '%Y년 %m월 %d일(월요일)')
					   when date_format(min(hire_date), '%a') = 'Tue' then date_format(min(hire_date), '%Y년 %m월 %d일 (화요일)')
                       when date_format(min(hire_date), '%a') = 'Wen' then date_format(min(hire_date), '%Y년 %m월 %d일 (수요일)')
                       when date_format(min(hire_date), '%a') = 'Thu' then date_format(min(hire_date), '%Y년 %m월 %d일 (목요일)')
                       when date_format(min(hire_date), '%a') = 'Fri' then date_format(min(hire_date), '%Y년 %m월 %d일 (금요일)')
                       when date_format(min(hire_date), '%a') = 'Sat' then date_format(min(hire_date), '%Y년 %m월 %d일 (토요일)')
					   else date_format(min(hire_date), '%Y년 %m월 %d일 (일요일)')
              END 입사일
            ,replace(phone_number, '.', '-') 전화번호
            ,department_id 부서번호
from employees
group by  employee_id, first_name, salary, phone_number, department_id
having (department_id, salary) in (select department_id, max(salary) salary
                                                       from employees
                                                       group by department_id)
order by salary desc;
;

/*문제3
매니저별 담당직원들의 평균월급 최소월급 최대월급을 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균월급이 5000이상만 출력합니다.
-매니저별 평균월급의 내림차순으로 출력합니다.
-매니저별 평균월급은 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균월급, 매니저별최소월급, 
매니저별최대월급 입니다.  (9건) */

select e1.manager_id 
			,e2.first_name '매니저 이름'
			,round(avg(e1.salary), 1)
			,min(e1.salary)
			,max(e1.salary)
from employees e1
inner join employees e2 
	on e1.manager_id = e2.employee_id
    
where e1.hire_date >= 20050101  
group by e1.manager_id, e2.first_name
having round(avg(e1.salary),1) >=5000
order by avg(e1.salary) desc
;



/*문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.             (106명)        */
select  e1.employee_id 사번
            ,e1.first_name 이름
            ,d.department_name 부서명
            ,e2.first_name 매니저이름
from employees e1
left join departments d
	on e1.department_id = d.department_id
inner join employees e2
	on e1.manager_id = e2.employee_id
;


/*문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 월급, 입사일을 입사일 순서로 출력하세요 */
select employee_id 
			,first_name
            ,department_name
            ,salary
            ,hire_date
from employees e, departments d
where e.department_id = d.department_id
and hire_date >= 2005/01/01
order by hire_date asc
limit 10, 10;

/*문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 월급(salary)과 근무하는 
부서 이름(department_name)은? */
select concat(first_name, ' ' , last_name) 이름
           ,salary 월급
           ,department_name 부서이름
           ,e.hire_date
from employees e, departments d
where e.department_id = d.department_id
order by hire_date desc
limit 0,2
;

/*문제7.
평균월급(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 월급(salary)을 조회하시오. */

select e.employee_id 사번
            ,last_name 성
            ,first_name  이름
            ,job_title 업무명
            ,e.salary 월급
            ,s.salary 부서평균월급
from employees e
join jobs j 
	on e.job_id = j.job_id
join (select department_id, max(avg_salary) salary 
from (select d.department_id,
			avg(salary) avg_salary
			from departments d, employees ee
            where d.department_id = ee.department_id
			group by department_id) ss
            group by department_id) s
	on e.department_id = s.department_id
    
limit 0,3
;

# 평균월급(salary)이 가장 높은 부서
select max(avg_salary) salary 
from (select d.department_id,
			avg(salary) avg_salary
			from departments d, employees ee
            where d.department_id = ee.department_id
			group by department_id) ss
	;
    

/* 문제8. ?????????????
평균 월급(salary)이 가장 높은 부서명과 월급은? (limt사용하지 말고 그룹함수 사용할 것) */

select department_name
			,max(avg_salary)
from employees e, departments d, (select d.department_id,
																	avg(salary) avg_salary
														from departments d, employees ee
														where d.department_id = ee.department_id
														group by department_id) s
where e.department_id = d.department_id
and e.department_id = s.department_id
group by department_name
limit 0, 1;

select department_name
			,s.salary
from employees e, departments d, (select department_id, max(avg_salary) salary 
                                                          from (select d.department_id,
			                                                                      avg(salary) avg_salary
			                                                         from departments d, employees ee
																	where d.department_id = ee.department_id
																	group by department_id) ss
																	group by department_id) s
where e.department_id = d.department_id
and e.department_id = s.department_id
;