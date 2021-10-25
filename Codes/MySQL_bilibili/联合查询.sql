/*
    union联合 合并: 将多条查询语句结果合并成一个结果
*/

#查询部门编号>90或邮箱包含员工a的员工信息
SELECT * FROM employees
WHERE email LIKE '%a%' OR department_id>90;

SELECT * FROM employees WHERE email LIKE '%a%' 
UNION
SELECT * FROM employees WHERE department_id>90;

#查询中国用户中男性的信息以及外国用户中男性的信息
SELECT id, cname, csex FROM t_ca WHERE csex = '男'
UNION
SELECT t_id, tName,tGender FROM t_ua WHERE tGender = 'male';