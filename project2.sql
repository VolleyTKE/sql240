--project 2 q #5
select initcap(last_name) "Name", length(last_name) "Length"
from employees
where last_name like '&start_letter.%'
order by last_name;

--project 2 q #6
select last_name, lpad(salary, 15, '$') as salary
from employees
order by salary desc;

--project 2 q #7
select last_name, hire_date, 
  to_char(next_day(add_months((hire_date),6),'Monday'),
  'fmDay, "the "Ddspth "of" Month, YYYY') as "REVIEW"
from employees;

--project 2 q #8
select last_name as "LAST_NAME", 
  NVL(to_char(COMMISSION_PCT*SALARY), 'No Commission') as "COMM"
from EMPLOYEES
ORDER BY last_name;

--project 2 q #9
select job_id as "Job", 
  CASE job_id
    WHEN 'AD_PRES' THEN 'A'
    WHEN 'ST_MAN' then 'B'
    WHEN 'IT_PROG' THEN 'C'
    WHEN 'SA_REP' THEN 'D'
    WHEN 'ST_CLERK' THEN 'E'
    ELSE '0'
  END AS "Grade"
from employees
group by job_id;

--project 2 q #10
select SYSDATE AS "Date"
from Dual;
