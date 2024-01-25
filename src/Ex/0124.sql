-- ----------------------
#        left outer join         #
-- ----------------------

select count(*) 
from employees e 
left outer join departments  d 
	on e.department_id = d.department_id
;

select * 
from employees e
left outer join departments d
	on e.department_id = d.department_id
;

-- ----------------------
#        right outer join        #
-- ----------------------
select count(*)
from employees e
right outer join departments d
	on e.department_id = d.department_id
;

select e.employee_id
	   ,e.department_id
       ,d.department_name
from employees e
right outer join departments d
	on e.department_id = d.department_id
;

select first_name
		   ,d.department_id
           ,d.department_name
from employees e
left outer join departments d
	on e.department_id = d.department_id
;

-- ------------------------
#   full outer join - union  #
-- ------------------------
(select d.department_id
		   ,e.first_name
           ,d.department_name
from employees e
left join departments d
	on e.department_id = d.department_id)
Union
(select d.department_id
			,e.first_name
            ,d.department_name
from employees e
right join departments d
	on e.department_id = d.department_id)
;

-- ------------------------
#              self join             #
-- ------------------------
select emp.employee_id
		,emp.first_name
        ,emp.manager_id
        ,man.first_name as manager
from employees emp, employees man
where emp.manager_id = man.employee_id
;

-- ------------------------
#              subQuery             #
-- ------------------------
-- Den의 월급
select first_name
			,salary
from employees
where first_name = 'Den'; 

-- Den보다 월급이 높은 사람들
select employee_id
		   ,first_name
           ,salary
from employees
where salary > ( select salary
                            from employees
							where first_name='Den');

select first_name
			,salary
from employees
where salary < (select avg(salary)
							from employees);