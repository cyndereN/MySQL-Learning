#1.内连接
#等值 (join的表要有连接条件)
SELECT last_name, department_name
FROM employees e
INNER JOIN department d
ON e.department_id = d.department_id


#查询每个部门的员工个数>3的部门名和员工个数，并按个数排序
SELECT COUNT(*) 个数, department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY department_name
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

#非等值连接
#查询工资级别>20的个数, 并按工资降序排列
SELECT salary, grade_level
FROM employees e
JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`higest_sal`
GROUP BY grade_level
HAVING COUNT(*)>20
ORDER BY grade_level DESC;