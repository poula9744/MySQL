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
					   when date_format(min(hire_date), '%a') = 'Tue' then date_format(min(hire_date), '%Y년 %m월 %d일(화요일)')
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
			,e1.first_name
            ,round(avg(e1.salary)) avg_salary
            ,min(e1.salary) min_salary
            ,max(e1.salary) max_salary
from employees e1, (select manager_id, max(salary) max_salary
								  from employees
                                  group by manager_id) s
                                  where  e1.hire_date >20050101
group by e1.manager_id, e1.first_name, e1.hire_date                                
having e1.manager_id = s.manager_id
and max(e1.salary) = s.max_salary

and round(avg(e1.salary)) >=5000


order by avg(e1.salary) desc;



