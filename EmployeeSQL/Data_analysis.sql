--List the employee number, last name, first name, sex, and salary of each employee.

select e.emp_no as employee_number,
e.last_name,
e.first_name, e.sex, s.salary 
from employees e left outer join 
salaries s 
on e.emp_no = s.emp_no

--List the first name, last name, and hire date for the employees who were hired in 1986.

select e.first_name,
e.last_name, 
e.hire_date
from employees e 
where date_part('year', e.hire_date) = '1986'


--List the manager of each department along with their department number, department name, 
--employee number, last name, and first name.

select d.dept_no as department_number,
d.dept_name as department_name,
e.emp_no as employee_number,
e.last_name,
e.first_name 
from employees e ,
(select dep.dept_no,
 dep.dept_name,
 dm.emp_no 
 from departments dep left outer join 
 dept_manager dm 
 on dep.dept_no = dm.dept_no ) d
 where e.emp_no = d.emp_no

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

select dep.dept_no as department_number, 
dep.dept_name as department_name, 
b.emp_no as employee_number, 
b.last_name, b.first_name 
from departments dep, 
(select  e.emp_no, 
e.last_name,
 e.first_name, d.dept_no 
 from employees e LEFT OUTER JOIN
 dept_emp d
on e.emp_no = d.emp_no) b
where dep.dept_no = b.dept_no


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B

select e.last_name,
e.first_name, 
sex 
from employees e
where upper(trim(e.first_name)) = 'HERCULES'
and trim(upper(e.last_name)) like 'B%'


--List each employee in the Sales department, including their employee number, last name, and first name.

select e.emp_no as employee_number,
e.last_name,
e.first_name
from employees e where e.emp_no in (select de.emp_no 
									from dept_emp de, 
									departments d where 
									de.dept_no = d.dept_no 
									and trim(upper(d.dept_name)) = 'SALES')


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

select e.emp_no as employee_number,
e.last_name,
e.first_name,
dept.dept_name as department_name
from employees e,
     (select de.emp_no,
	  		 d.dept_name
		from dept_emp de, 
		departments d where 
		de.dept_no = d.dept_no 
		and trim(upper(d.dept_name)) in ('SALES','DEVELOPMENT') ) dept
where e.emp_no = dept.emp_no	

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

select e.last_name, count(*) as frequency_count
from employees e 
group by e.last_name order by count(*) desc