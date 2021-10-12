#又称多表查询
/*
    笛卡尔乘积: 表1 m行，表2 n行，结果=m*n行
    发生原因: SELECT NAME, boyName FROM boys, beauty; 没有添加有效的连接条件
*/
#1.等值连接
SELECT NAME, boyName FROM boys, beauty
WHERE beauty.boyfriend_id = boys.id;

SELECT department_name, city
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
AND city LIKE '_o%'
GROUP BY city;  #查询城市名中第二个字符为o的部门名和城市名

#2.非等值连接
#查询员工的工资和工资级别
SELECT salary, grade_level
FROM employees e, job_grades g
WHERE salary BETWEEN g.`lowest_sal` AND g.`higest_sal`;

#3.自连接