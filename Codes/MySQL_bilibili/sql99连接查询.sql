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

#自连接
#查询
SELECT e.last_name, m.last_name
FROM employees e
JOIN employees m
ON e.`manager_id` = m.`employee_id`
WHERE e.`last_name` LIKE '%k%';

#2.外连接
/*
    应用场景 用于查询一个表里有 另一个表里没有的记录
    1.查询结果为主表中的所有记录，如果从表中有匹配的，则显示匹配的值
        如果从表中没有和他匹配的则显示null
    2. 左外连接, left join 左边是主表
        右外连接, right join 右边的是主表
    3. 左外和右外交换两个表的顺序  可以实现同样的效果 
    4. 全外连接 = 内连接的结果+表1有但婊2没有的+表2中有但表1没有的 
*/
#查询男朋友不在表里的女生名
#左外
SELECT b.name, #bo.* 
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NULL;  #没有group不用having

#右外
SELECT b.name, #bo.* 
FROM boys bo
RIGHT OUTER JOIN beauty b
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NULL;  #没有group不用having


#查询哪个部门没有员工
#左外
SELECT d.*, e.employee_id
FROM departments d
LEFT OUTER JOIN employees e
ON d.`department_id` = e`department_id`
WHERE e.`employee_id` IS NULL;

#全外

#交叉连接
SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo;