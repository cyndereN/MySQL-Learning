/*
‘+’的作用
    仅有运算符的功能，若一方为字符型，试图将字符型数值转换为数值型;
    成功继续做加法，失败将字符型转换为0（e.g. 'john' + 90，结果90）
    其中一方为null，结果为null
*/ 
SELECT last_name + first_name AS "name" 
FROM employees;  #结果为0

#拼串
SELECT CONCAT(last_name, ' ', first_name) AS "name"
FROM employees;

#若为空
/*
    判断第一个参数是否NULL，若是返回第二个参数值
*/
SELECT 
    IFNULL(commission_pct, 0) AS 奖金率, commission_pct
FROM
    employees;

#WHERE
SELECT *
FROM employees
WHERE NOT(department_id>=90 AND department_id<=110) OR salary>15000;

#转义
SELECT last_name
FROM employees
WHERE last_name LIKE '_\_%' #第二个字符是下划线 
#或者 
      last_name LIKE '_$_%' ESCAPE '$';
    
#查询结构
desc departments;

#排序
#高到低 
SELECT * FROM employees ORDER BY salary DESC;
#低到高，不写也行，因为默认就是升序
SELECT * FROM employees ORDER BY salary ASC;

#显示年薪，降序排序
SELECT *, salary*12*IFNULL(commission_pct, 0)) 年薪
FROM employees
ORDER BY 年薪 DESC;

#显示姓名长度，先按长度降序排序，再按工资降序【多个字段排序】
SELECT LENGTH(last_name) 字节长度, last_name, salary  #一个汉字占3个字节（utf-8）
FROM employees
ORDER BY LENGTH(last_name) DESC, salary DESC;