#查询有奖金的每个领导下员工最高工资 (分组前筛选条件)
SELECT MAX(salary), manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

#查询哪个部门员工个数>=2 (分组后筛选条件)
SELECT COUNT(*), department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) >2;

#查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT MAX(salary), job_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary) > 12000;