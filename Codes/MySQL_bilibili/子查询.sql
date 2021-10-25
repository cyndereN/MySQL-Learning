#子查询
#出现在其他语句中的select语句，成为子查询或内查询
#内部嵌套其他select语句的查询，称为外查询或主查询

/*
一、Where和Having后面: 
    标量子查询(单行) 一般搭配单行操作符使用> < >= <= = < >
    列子查询(多行) IN, ANY/SOME. ALL
    行子查询(多列多行)
*/

#1.标量子查询
#谁的工资比Abel高?

SELECT * 
FROM employees
WHERE salary>(
    SELECT salary
    FROM employees
    WHERE last_name = 'Abel'
);

#查询job_id与141号员工相同，salary比143号员工多的员工姓名,id和工资
SELECT last_name, job_id, salary
FROM employees
WHERE job_id =(
    SELECT job_id FROM employees
    WHERE employee_id = 141
) AND salary>(
    SELECT salary
    FROM employees
    WHERE employee_id = 143
);

#返回公司工资最少的员工的last_name， job_id和salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary =(
    SELECT MiN(salary)
)

#查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT MiN(salary), department_id
FROM employees
GROUP BY department_id
HAVING MiN(salary)>(
    SELECT MiN(salary)
    FROM employees
    WHERE department_id = 50
)

#2.列子查询(多行子查询)
#案例1:返回location_id是1400或1700的部门中的所有员工姓名
SELECT last_name 
FROM employees
WHERE department_id IN (
    SELECT DISTINCT department_id
    FROM departments
    WHERE location_id IN (1400, 1700)
);
#案例2:返回其他部门中比job_id为`IT_PROG`部门任一工资低的员工的员工号、姓名、job_id和salary
SELECT last_name, employee_id, job_id, salary
FROM employees
WHERE salary<ANY(
    SELECT DISTINCT salary
    FROM employees
    WHERE job_id = 'IT_FROG';
) AND job_id <> 'IT_FROG';

#3.行子查询(结果集一行多列或多行多列)
#案例: 查询员工编号最小并且工资最高的员工信息
SELECT * FROM employees
WHERE (employee_id, salary) = (
    SELECT MIN(employee_id), MAX(salary)
    FROM employees
)

SELECT * FROM employees
WHERE employee_id = (
    SELECT MIN(employee_id)
    FROM employees
)AND salary=(
    SELECT MAX(salary)
    FROM employees
)

/*
    二、Select后面
*/
#查询员工号=102的部门名
SELECT(
    SELECT department_name
    FROM departments d
    INNER JOIN employees e
    ON d.department_id = e.department_id
    WHERE e.employee_id = 102
) 部门名;

/*
    三、from后面

*/

#案例: 查询每个部门的平均工资的工资等级
SELECT ag_dep.*, g.grade_level
FROM (
    SELECT AVG(salary) ag, department_id
    FROM employees
    GROUP BY department_id
)ag_dep
INNER JOIN job_grades g
ON ag_dep.ag BETWEEN lowest_sal AND highest_sal;

/*
    四、exists后面(相关子查询)
*/
#有员工的部门
SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT *
    FROM employees e
    WHERE d.department_id = e.department_id    
)

SELECT department_name
FROM departments d
WHERE d.department_id IN (
    SELECT department_id
    FROM employees
)

#查询和Zlotkey相同部门的员工姓名和工资
SELECT employee_id, employee_name, salary 
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    WHERE last_name = 'Zlotkey'
)

#查询各部门中工资比部门平均工资高的员工号，姓名和工资
SELECT employee_id, employee_name, salary
FROM employees e
INNER JOIN(
    SELECT AVG(salary), department_id
    FROM employees
    GROUP BY department_id
) ag_dep
ON e.department_id = ag_dep.department_id
WHERE salary > ag_dep.ag;

#查询平均工资最低的部门信息
SELECT d.* 
FROM departments d
WHERE d.department_id = (
    SELECT AVG(salary), department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) = (
        SELECT MIN(ag)
        FROM (
            SELECT AVG(salary) ag, department_id
            FROM employees
            GROUP BY department_id
        ) ag_dep
    )
);
#or
SELECT * FROM departments
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary)
    LIMIT 1
);

#查询平均工资最低的部门信息和平均薪资
SELECT d.*, ag
FROM departments d
JOIN(
    SELECT AVG(salary) ag, department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary)
    LIMIT 1
) ag_dep
ON d.department_id = ag_dep.department_id

#查询平均工资高于公司平均工资的部门有哪些
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary)>(
    SELECT AVG(salary)
    FROM employees
)

#查询manager详细信息
SELECT * 
FROM employees
WHERE employee_id = ANY(
    SELECT DISTINCT manager_id
    FROM employees
);

#各个部门中最高工资中最低的那个部门的最低工资
#1.最高工资中最低的部门编号
SELECT department_id
FROM employees
GROUP BY department_id
ORDER BY MAX(salary)
LIMIT 1;

#2.查询1.结果的那个部门的最低工资
SELECT MIN(salary), department_id
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY MAX(salary)
    LIMIT 1
);