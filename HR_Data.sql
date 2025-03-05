create database projects;

use projects; -- Ensures that we are working on the projects database only

-- Table visualising
select * from hr;

-- Data Cleaning

-- 1) changing id column name
alter table hr
change column id emp_id varchar(20) null;   -- null is provided as a constraint

select * from hr;

-- 2) check data types for all features
describe hr;

-- 3) Next we will work on birthdate column (There is a combination of - and / in birthdates)
select birthdate from hr;

-- **Very important** We need to remove sql_safe_updates mode to update a table, and then after updation, 
-- it is also important to apply the same mode.

set sql_safe_updates = 0;

update hr
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

-- THIS UPDATE PART ENSURED THAT THE DATE IS FORMATTED TO LOOK LIKE PROPER DATE


-- the data type of birthdate column is still text, so converting it to date data type
alter table hr
modify column birthdate date;

-- THIS PART ACTUALLY CONVERTS THE DATA TYPE TO DATE

select birthdate from hr;

describe hr;  -- birthdate column has a Date datatype

-- SAME WORK IS BEING DONE FOR HIRE DATE

update hr
set hire_date = case
	when hire_date like '%/%' then str_to_date(hire_date, '%m/%d/%Y')  -- str_to_date automatically returns date 
    when hire_date like '%-%' then str_to_date(hire_date, '%m-%d-%Y')  -- in the yyyy-mm-dd format
    else null
end;

select hire_date from hr;

alter table hr
modify column hire_date date;

-- Termdate contains the timestamps too, and since we don't have any use for them, we will remove them directly using
-- date() method

update hr
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
	where termdate is not null and termdate != '';
    
select termdate from hr;

alter table hr
modify column termdate date;

alter table hr
add column age int;

-- creating an age column so we can use the age of any person in any query with ease

update hr
set age = timestampdiff(year, birthdate, curdate()); -- some values are negative

-- since some values are negative, we want to check that
select 
	min(age) as Youngest,  -- -44 (Below 18 not acceptable)
    max(age) as Oldest     --  59
from hr;

select count(age)
from hr
where age < 18;

select * from hr;







-- QUESTIONS THAT WE HAVE TO ANSWER



-- 1. What is the gender breakdown of employees in the company?
select distinct(gender) from hr;

select gender, count(*) as count
from hr
where age >= 18 and termdate = ''     -- Empty space termdate represents people who are still working in the company
group by gender;




-- 2. What is the race/ethnicity breakdown of employees in the company?
select distinct(race) from hr;

select race, count(*) as count
from hr
where age >= 18 and termdate = ''
group by race
order by count(*) desc;




-- 3. What is the age distribution of employees in the company?

select
	min(age),
    max(age)
from hr
where age >= 18 and termdate = '';

select
	case
		when age >= 21 and age <= 25 then '21-25'
        when age >= 26 and age <= 30 then '26-30'
        when age >= 31 and age <= 35 then '31-35'
        when age >= 36 and age <= 40 then '36-40'
        when age >= 41 and age <= 45 then '41-45'
        when age >= 46 and age <= 50 then '46-50'
        when age >= 51 and age <= 55 then '51-55'
        when age >= 56 and age <= 60 then '56-60'
        else '60+'
        end as age_distribution,
        count(*) as count
from hr
where age >= 18 and termdate = ''
group by age_distribution
order by age_distribution;


-- gender along with age

select
	case
		when age >= 21 and age <= 25 then '21-25'
        when age >= 26 and age <= 30 then '26-30'
        when age >= 31 and age <= 35 then '31-35'
        when age >= 36 and age <= 40 then '36-40'
        when age >= 41 and age <= 45 then '41-45'
        when age >= 46 and age <= 50 then '46-50'
        when age >= 51 and age <= 55 then '51-55'
        when age >= 56 and age <= 60 then '56-60'
        else '60+'
        end as age_distribution, gender, count(*) as count
from hr
where age >= 18 and termdate = ''
group by age_distribution, gender
order by age_distribution, gender;




-- 4. How many employees work at headquarters versus remote locations?


select location, count(*) as count
from hr
where age >= 18 and termdate = ''
group by location;



-- 5. What is the average length of employment for employees who have been terminated?


select * from hr;
select round(avg(datediff(termdate, hire_date)/365), 0) as average
from hr
where age >= 18 and termdate != '' and termdate <= curdate();




-- 6. How does the gender distribution vary across departments and job titles?


select department, jobtitle, gender, count(*) as count
from hr
where age >= 18 and termdate = ''
group by department, jobtitle, gender
order by department;


-- 7. What is the distribution of job titles across the company?


select jobtitle, count(*) as count
from hr
where age >= 18 and termdate = ''
group by jobtitle
order by jobtitle;



-- 8. Which department has the highest turnover rate?

-- turnover rate - how long before employees leave the job

select department, terminated_count, total_count, terminated_count/total_count as turnover_rate
from (
	select department, count(*) as total_count, 
		sum(case 
			when termdate <> '' and termdate <= curdate() then 1 else 0 end) as terminated_count
	from hr
    where age >= 18
    group by department) as mid_values
order by turnover_rate desc;




-- 9. What is the distribution of employees across locations by state?

select location_state, count(*) as count
from hr
where age >= 18 and termdate = ''
group by location_state
order by count desc;


-- 10. How has the company's employee count changed over time based on hire and term dates?

select
	year,
    hires,
    terminations,
    hires - terminations as net_change,
    round((hires - terminations)/hires * 100, 2) as net_change_percent
from (
	select 
		year(hire_date) as year,
        count(*) as hires,
        sum(case when termdate <> '' and termdate <= curdate() then 1 else 0 end) as terminations
	from hr
    where age >= 18
    group by year(hire_date)) as mid_values
order by year asc;



-- 11. What is the tenure distribution for each department?

select department, round(avg(datediff(termdate, hire_date)/365), 0) as avg_tenure
from hr
where termdate <> '' and termdate <= curdate() and age >= 18
group by department;




