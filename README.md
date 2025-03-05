# HR-MySQL-PowerBI

![image](https://github.com/Jatin-s16/HR_MySql_PowerBI/blob/main/Screenshot%202025-03-05%20at%205.32.02%20PM.png)
![image](https://github.com/Jatin-s16/HR_MySql_PowerBI/blob/main/Screenshot%202025-03-05%20at%205.33.00%20PM.png)

## Data Used

**Data** - HR Data with over 22000 rows from the year 2000 to 2020.

**Data Cleaning & Analysis** - MySQL Workbench

**Data Visualization** - PowerBI

## Questions

1. What is the gender breakdown of employees in the company?
2. What is the race/ethnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters versus remote locations?
5. What is the average length of employment for employees who have been terminated?
6. How does the gender distribution vary across departments?
7. What is the distribution of job titles across the company?
8. Which department has the highest turnover rate?
9. What is the distribution of employees across locations by state?
10. How has the company's employee count changed over time based on hire and term dates?
11. What is the tenure distribution for each department?

## Summary of Findings
 - There are more male employees
 - White race is the most dominant while Native Hawaiian and American Indian are the least dominant.
 - The youngest employee is 22 years old and the oldest is 59 years old
 - 8 age groups were created (21-25, 26-30, 31-35, 36-40, 41-45, 46-50, 51-55, 56-60). A large number of employees were between 36-40 closely followed by 31-35 while the smallest group 
   was 56-60.
 - A large number of employees work at the headquarters versus remotely.
 - The average length of employment for terminated employees is around 8 years.
 - The gender distribution across departments is fairly balanced but there are generally more male than female employees.
 - The Marketing department has the highest turnover rate followed by Business Development. The least turn over rate are in the Training, Auditing and Legal departments.
 - A large number of employees come from the state of Ohio.
 - The net change in employees has increased over the years except for the first few years.
 - The average tenure for each department is about 8 years with Legal and Auditing having the highest and Services, Sales and Marketing having the lowest.

## Limitations

- Some records had negative ages and these were excluded during querying(967 records). Ages used were 18 years and above.
- Some termdates were far into the future and were not included in the analysis(1258 records). The only term dates used were those less than or equal to the current date.
