/*********************************************
*              05일차 수업 SubQuery
********************************************/

/*
'Den' 보다 월급을 많은 사람의 이름과 월급은?

1. 'Den'의 월급을 구한다.  --> 11000
2. 직원테이블에서 월급이 11000보다 많은 사람을 구한다.
*/

-- 1. 'Den'의 월급을 구한다. 
select *
from employees
where first_name = 'Den';  -- > 11000

-- 2. 직원테이블에서 월급이 11000보다 많은 사람을 구한다.
select * 
from employees
where salary >= 11000;

-- 3. 합치기
select * 
from employees
where salary >= (select salary
							 from employees
                             where first_name = 'Den');

-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
select first_name
		   ,salary
           ,employee_id
from employees
where salary = (select min(salary)
							  from employees);

-- 평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요
select first_name
	       ,salary
from employees
where salary < (select avg(salary)
							from employees);

-- ----------------------
#        SubQuery -IN        #
-- ----------------------                            
/*
부서번호가 110인 직원의 급여와 같은 월급을 받는
모든 직원의 사번, 이름, 급여를 출력하세요
*/
select salary
from employees
where department_id = 110 ; 
-- 12008, 8300으로 결과의 row 1개 이상 

select employee_id
			,first_name
            ,salary
from employees
where salary in (select salary
							from employees
                            where department_id = 110);

/* 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요 
1. 각 부서별 최고월급을 구한다. --> 1이상 100번 부서는 10000, 200번 부서는 20000
2. 직원테이블에서 월급이 10000 또는 20000 구한다
3. 합친다
*/
#2. 각 부서별 최고 월급 
select department_id, max(salary) 최고월급
from employees
group by department_id;

select first_name
		    ,salary
from employees
where salary in (select  max(salary)
							from employees
							group by department_id);
-- 부서 번호를 제외하고 부서의 최고월급값만 가져와서 비교

select first_name
		    ,salary
from employees
where (department_id, salary) in ((10, 4400), (20, 13000), (30,11000));

select first_name
		    ,salary
from employees
where (department_id, salary) in (select department_id, max(salary)
														from employees
														group by department_id);
-- 양쪽 형태가 맞아야 한다

/* 가장 적게 월급을 받는 사원을 출력하세요 */
select *
from employees
where salary = (select min(salary)
							from employees);


/* 각 부서별로 최고급여를 받는 사원을 출력하세요 */
select department_id
		    ,employee_id
            ,first_name
            ,salary
from employees
where (department_id, salary) in (select department_id, max(salary)
													from employees
													group by department_id);

-- ----------------------
#       SubQuery -ANY        #
-- ----------------------
/*
부서번호가 110인 직원의 급여 보다 큰 모든 직원의
이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
*/
-- 월급이 15000보다 큰 직원의 이름, 급여를 출력하세요
select first_name, 
	        salary
from employees
where salary > 15000;

-- 부서번호가 110인 직원의 월급
select salary
from employees
where department_id = 110;

select *
from employees
where salary >any (select salary
                                 from employees
								 where department_id = 110);

-- ----------------------
#       SubQuery -ALL        #
-- ----------------------
/* 부서번호가 110인 직원의 급여 보다 큰 모든 직원의
이름, 급여를 출력하세요.(and연산--> 12008보다 큰) */
select salary
from employees
where department_id = 110;

select *
from employees
where salary >all (select salary 
					            from employees
                                where department_id = 110);

-- -------------------------------
#       SubQuery -테이블에서 조인       #
-- -------------------------------
/* 각 부서별로 최고급여를 받는 사원을 출력하세요 */
# 조건 절에서 비교!
select department_id
		    ,employee_id
            ,first_name
            ,salary
from employees
where (department_id, salary) in (select department_id, max(salary)
													    from employees
                                                        group by department_id);

# 테이블에서 조인!
select e.department_id
		    ,e.employee_id
            ,e.first_name
            ,e.salary
from employees e, (select department_id, max(salary) salary
								from employees
                                group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary;


-- -------------------------------
#                        limit                      #
-- -------------------------------
select employee_id
            ,first_name
            ,salary
from employees
order by employee_id asc
limit 5 offset 0
; -- 1부터 5개

/*07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? */
select first_name
	        ,salary
            ,hire_date
from employees
where hire_date between 070101 and 071231
order by salary desc
limit 2,5
; -- 3번부터 5개 3,4,5,6,7
