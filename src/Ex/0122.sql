use hrdb;

-- like
select first_name,
	   last_name,
       salary
from employees
where first_name like 'L%';

# 이름에 am 을 포함한 사원의 이름과 월급을 출력하세요
select first_name,
	   last_name,
       salary
from employees
where first_name like '%am%';	
# 이름의 두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select first_name,
	   last_name,
       salary
from employees
where first_name like '_a%';

# 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name,
	   last_name,
       salary
from employees
where first_name like '__a%';

# 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name,
	   last_name,
       salary
from employees
where first_name like '__a_';



-- null
select first_name,
	   salary,
       commission_pct,
       salary*commission_pct
from employees
where salary between 13000 and 15000;

select first_name,
	   salary,
       commission_pct
from employees
where commission_pct is null;
#주의: where commission_pct = null; 아님 

select * 
from employees
where commission_pct is not null;


# 커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요
select first_name,
	   commission_pct
from employees
where commission_pct is not null;

# 담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select first_name,
	   manager_id,
       commission_pct
from employees
where commission_pct is null
and manager_id is null;

# 부서가 없는 직원의 이름과 월급을 출력하세요
select first_name,
	   salary
from employees
where department_id is null;


-- ORDER BY절 
select first_name,
	   salary
from employees
where salary >= 10000
order by salary desc;

select first_name,
	   salary
from employees
order by first_name asc;

select first_name,
	   hire_date,
       salary
from employees
order by hire_date asc;

-- 1. 최근 입사한 순, 2. 입사일이 같으면 월급이 많은 사람부터 
select first_name, hire_date, salary
from employees
order by hire_date asc, salary desc; 

#부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select  department_id, 
		salary, 
        first_name
from employees
order by department_id asc;

#월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select  first_name, 
		salary
from employees
where salary >= 10000
order by salary desc;

#부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 부서번호 월급 이름을 출력하세요
select  department_id, 
		salary, 
        first_name
from employees
order by department_id asc, salary desc;

#직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select  first_name, 
		salary, 
        hire_date
from employees 
order by first_name asc;

#직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select  first_name, 
		salary,
        hire_date
from employees
order by hire_date asc;

/**************************************
* 02일차 수업
***************************************/
-- 단일행 함수 
-- 단일행 함수 > 숫자 함수
select  round(123.123, 2)
		,round(123.126, 2)
        ,round(234.567, 0)
        ,round(123.456, 0)
        ,round(123.456)
        ,round(123.126, -1)
        ,round(125.126, -1)
        ,round(123.126, -2)
;

-- 올림
select ceil(123.456)
	   , ceil(123.789)
       , ceil(123.7892313)
       , ceil(987.1234)
;

select first_name, ceil(salary*commission_pct)
from employees
where commission_pct is not null;

-- 내림 
select floor(132.456)
	   , floor(123.789)
       , floor(132.7892313)
       , floor(987.1234)
;

-- 버림
select truncate(1234.34567, 2)
	   , truncate(1234.34567, 3)
       , truncate(1234.34567, 0)
       , truncate(1234.34567, -2)
;

-- 숫자의 n승 
select power(12, 2), pow(12, 2);

-- sign(): 음수면 -1, 0이면 0, 양수면 1
select sign(123), 
	   sign(0),
       sign(-123)
;

-- abs(): 절대값
select abs(132),
	   abs(0),
       abs(-123)
;

-- Greatest(): 가장 큰 값 --> 한 줄 내에 제일 큰 하나
select greatest(2, 0, -2),
	   greatest(4, 3.2, 5.25),
       greatest('B', 'A', 'C', 'c')
;

select  employee_id,
		manager_id,
        department_id,
		greatest(employee_id, manager_id, department_id)
from employees;

-- max() --> 파라미터 내에 제일 큰 하나
select max(salary)
from employees;


-- least(): 가장 작은 값
select least(2, 0, -2),
	   least(4, 3.2, 5.25),
       least('B', 'A', 'C', 'c')
;


-- 단일행 함수 > 문자 함수
-- concat()
select concat("안녕",' ', "하세요")
from dual;

-- concat(s, str1, str2, ..., strn): str1, str2, ..., strn을 열결할 때 사이에 s로 연결
select concat_ws("^^^", "안", "녕", "하", "세", "요")
from dual;

select concat_ws("-", first_name, last_name, salary)
from employees;

-- LCASE(str) LOWER(str): str의 모든 대문자 --> 소문자
select first_name,
	   lcase(first_name),
       lower(first_name),
       lower('ABCabc!#$'),
       lower('가나다')
from employees;

-- UCASE(str) UPPER(str): str의 모든 소문자 --> 대문자
select first_name,
	   ucase(first_name),
       upper(first_name),
       upper('ABCabc!#$'),
       upper('가나다')
from employees;

-- LENGTH(str): str의 길이를 바이트로 반환 
-- CHAR_LENGTH(str) 또는 CHARACTER_LENGTH(): str의 문자열 길이를 반환
select first_name,
	   length(first_name),
       char_length(first_name),
       character_length(first_name)
from employees;

select length('a'), 
	   char_length('a'), 
       character_length('a')
from dual;

select length('가'), 
	   char_length('가'), 
       character_length('가')
from dual;

-- SUBSTRING(str, pos, len) 또는 SUBSTR(str, pos, len): 
-- str의 pos 위치에서 시작하여 len 길이의 문자열 반환
select first_name,
	   substring(first_name, 1, 3),
       substr(first_name, 2, 3),
       substr(first_name, -3, 2)
from employees
where department_id = 100;

select substr('981112-1234567', 8, 1)
from dual;

-- LPAD(str, len, padstr) 좌 <--> 우 RPAD(str, len, padstr)
-- padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
select first_name,
	   lpad(first_name, 10, "*"),
       rpad(first_name, 10, "*")
from employees;

-- TRIM(str): str의 양쪽에 있는 공백 문자를 제거
-- LTRIM(str): str의 왼쪽에 있는 공백 문자를 제거
-- RTRIM(str): str의 오른쪽에 있는 공백 문자를 제거
select  concat('|', '      안녕하세요  ', '|' ),
		concat('|', trim('          안녕하세요 '), '|' ),
		concat('|', ltrim('       안녕하세요         '), '|' ),
		concat('|', rtrim('        안녕하세요     '), '|' )
;

-- REPLACE(str, from_str, to_str): str에서 from_str을 to_str로 변경
select first_name,
	   replace(first_name, 'a', '*')
from employees
where department_id = 100; 

select first_name,
	   replace(first_name, 'a', '*'),
       replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id = 100;


-- 단일행 함수 > 날짜/시간함수 
-- 현재 날짜
select current_date(), curdate();

-- 현재 시간
select current_time(), curtime();

-- 현재 날짜&시간
select current_timestamp(), now();

-- ADDDATE() 또는 DATE_ADD(): 날짜 시간 더하기
-- SUBDATE() 또는 DATE_SUB(): 날짜 시간 빼기
select  adddate('2021-06-20 00:00:00', INTERVAL 1 YEAR),
		adddate('2021-06-20 00:00:00', INTERVAL 1 MONTH),
		adddate('2021-06-20 00:00:00', INTERVAL 1 WEEK),
		adddate('2021-06-20 00:00:00', INTERVAL 1 DAY),
		adddate('2021-06-20 00:00:00', INTERVAL 1 HOUR),
		adddate('2021-06-20 00:00:00', INTERVAL 1 MINUTE),
		adddate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
;

select  subdate('2021-06-20 00:00:00', INTERVAL 1 YEAR),
		subdate('2021-06-20 00:00:00', INTERVAL 1 MONTH),
		subdate('2021-06-20 00:00:00', INTERVAL 1 WEEK),
		subdate('2021-06-20 00:00:00', INTERVAL 1 DAY),
		subdate('2021-06-20 00:00:00', INTERVAL 1 HOUR),
		subdate('2021-06-20 00:00:00', INTERVAL 1 MINUTE),
		subdate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
;

-- DATEDIFF(): 두 날짜간 일수차
-- TIMEDIFF(): 두 날짜시간 간 시간차
select  datediff('2021-06-21 01:05:05', '2021-06-21 01:00:00'),
		timediff('2021-06-21 01:05:05', '2021-06-20 01:00:00')
;

select  first_name,
		hire_date,
        datediff(now(), hire_date) workday
from employees
order by workday desc;


-- 변환함수
-- DATE_FORMAT(date, format): date를 format형식으로 변환
select  now(),
		date_format(now(), '%y-%m-%d %H:%i:%s'),
        date_format(now(), '%Y-%m-%d(%a) %H:%i:%s %p')
from dual;

-- STR_TO_DATE(str, format): str를 format형식으로 변환
select  str_to_date('2021-Jun-04 07:48:52', '%Y-%b-%d'),
		str_to_date('2021-06-01 12:30:05', '%Y-%m-%d')
;

select datediff('2021-06-04', '2021/06/01'); #변환 안 해도 가능 (해보기 전까진 알 수 없음)

select datediff(str_to_date('2021-Jun-04 07:48:52', '%Y-%b-%d'),
		str_to_date('2021-06-01 12:30:05', '%Y-%m-%d')) as datediff
;

-- FORMAT(숫자, p): 숫자에 콤마(,) 를 추가, 소수점 p자리까지 출력

select  format(1234567.89, 2),
		format(1234567.89, 0),
		format(1234567.89, -5)
;

-- IFNULL(컬럼명, null일때값): 컬럼의 값이 null일때 정해진값을 출력
select  first_name,
		commission_pct, 
        ifnull(commission_pct, 0)
from employees;

select  first_name,
		commission_pct, 
        ifnull(commission_pct, "없음")
from employees;