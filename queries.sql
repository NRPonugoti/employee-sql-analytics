-- 1. Max Salary per Department
SELECT e.*, 
       MAX(salary) OVER(PARTITION BY department_name) AS max_salary
FROM employee e;

--------------------------------------------------

-- 2. Top 3 Salaries per Department
SELECT *
FROM (
    SELECT e.*, 
           RANK() OVER(PARTITION BY department_name ORDER BY salary DESC) AS rnk
    FROM employee e
) x
WHERE rnk <= 3;

--------------------------------------------------

-- 3. First 2 Employees per Department
SELECT *
FROM (
    SELECT e.*, 
           ROW_NUMBER() OVER(PARTITION BY department_name ORDER BY employee_id) AS rn
    FROM employee e
) x
WHERE rn <= 2;

--------------------------------------------------

-- 4. Previous Salary (LAG)
SELECT e.*, 
       LAG(salary) OVER(PARTITION BY department_name ORDER BY employee_id) AS prev_salary
FROM employee e;

--------------------------------------------------

-- 5. Next Salary (LEAD)
SELECT e.*, 
       LEAD(salary) OVER(PARTITION BY department_name ORDER BY employee_id) AS next_salary
FROM employee e;

--------------------------------------------------

-- 6. Salary Comparison
SELECT e.*, 
       CASE 
           WHEN salary > LAG(salary) OVER(PARTITION BY department_name ORDER BY employee_id)
                THEN 'Higher'
           WHEN salary < LAG(salary) OVER(PARTITION BY department_name ORDER BY employee_id)
                THEN 'Lower'
           ELSE 'Same'
       END AS salary_comparison
FROM employee e;
