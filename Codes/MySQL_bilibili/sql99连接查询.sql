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

#查询编号>3的女生男朋友信息，如果有列出，没有用null链接
SELECT b.id, b.name, b.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE b.`id`>3;

#查询哪个城市没有部门
SELECT city, d.*
FROM departments d
RIGHT OUTER JOIN locations l
ON d.`location_id` = l.`location_id`
WHERE d.`department_id` IS NULL;

#查询部门名为SAL或IT的员工信息
SELECT e.*, d.department_name
FROM departments d
LEFT JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE d.`department_name` IN('SAL', 'IT');

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


#------------------------
#查询姓张的学生中最低分大于60的学号姓名
SELECT s.studentno, s.studentname, MIN(score)
FROM student s
JOIN result r
ON s.studentno = r.studentno
WHERE s.studentname LIKE '张%'
GROUP BY s.studentno
HAVING MIN(score)>60;

#查询学生名、专业名、分数
SELECT studentname, score, majorname
FROM student s
JOIN major m ON s.majorid = m.majorid
LEFT JOIN result r ON s.studentno = r.studentno

#查询哪个专业没有学生
#左连
SELECT m.*, s.studentno
FROM major m
LEFT JOIN student s ON m.majorid = s.student = s.majorid
WHERE s.studentno IS NULL;

#查询没有成绩的学生人数
SELECT COUNT(*)
FROM student s
LEFT JOIN result r ON s.studentno = r.studentno
WHERE r.id IS NULL;