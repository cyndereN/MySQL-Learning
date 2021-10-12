#一、字符函数
#1.length 字节长度
SHOW VARIABLES LIKE '%char%' #显示字符集

#2.concat

#3.upper, lower 大小写
SELECT UPPER('john');

#4.substr, substring
#!!!!!索引从1开始
SELECT SUBSTR('李莫愁爱上了陆展元', 6) out_put; #"了陆展元"
SELECT SUBSTR('李莫愁爱上了陆展元', 1,3) out_put; #"李莫愁"
#姓名首字符大写，其他小写yong_拼装
SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)), '_', LOWER(SUBSTR(last_name, 2))) out_put
FROM employees;

#5.instr 返回子串第一次出现的索引，若找不到返回0
SELECT INSTR('李莫愁爱上了陆展元', '陆展元') AS out_put   #7

#6.trim
SELECT TRIM('  李莫愁  ') AS out_put  
SELECT TRIM('a' FROM 'aaa李aa莫愁aaaa')  #李aa莫愁

#7.lpad, rpad 用特定字符实现左、右填充指定长度
SELECT RPAD('李莫愁',12,'ab') AS out_put  #李莫愁ababababa

#8.replace 
SELECT replace('李莫愁爱上了陆展元', "陆展元", "路人甲")


#二、数学函数
#1.round 四舍五入
SELECT ROUND('1.567', 2); #小数点后保留两位

#2.ceil 向上取整（返回>=该参数的最小整数）, floor 向下取整 ， truncate 截断 ， mod 取余
SELECT TRUNCATE(1.69999, 1);  #1.6

#三、日期函数
#now 返回当前日期+时间
SELECT NOW()

#curdate 返回当前日期，不包含时间

#curtime 返回当前时间，不包含日期

#获取制定的部分，年月日小时分钟秒
SELECT YEAR(NOW()) 年;
SELECT MONTHNAME(NOW());

#str_to_date
SELECT * FROM employees 
WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y');

#date_format
SELECT DATE_FORMAT(NOW(), '%y年%m月%d日') AS out_put;

#四、其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();

#五、流程控制函数

#1.if if else的效果
SELECT last_name, commission_pct, IF(commission_pct ISNULL, '没奖金', '有奖金') 备注
FROM employees;

#2.case 
/*
    case 要判断的字段或表达式
    when 常量1 then 要显示的值1或语句1;
    when 常量2 then 要显示的值2或语句2;
    ...
    else 要显示的值n或语句n
    end
*/
/*
    案例：查询员工工资，
    部门号=30.1.1倍
    40,1.2倍
    50,1.3倍
    其他为默认原工资
*/
SELECT salary 原始工资, department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2 
WHEN 40 THEN salary*1.3 
ELSE salary
END AS 新工资
FROM employees;

#或者类似于多重IF
/*
    case 
    when 条件1 then 要显示的值1或语句1
    when 条件2 then 要显示的值2或语句2
    ...
    else 要显示的值n或语句n
    end
*/
/*
    案例：工资，大于20000，显示A级别
    大于15000，显示B级别
    大于10000，显示C级别，否则显示D级别
*/
SELECT salary, 
CASE
WHEN salary > 20000 THEN 'A'
WHEN salary > 15000 THEN 'B'
WHEN salary > 10000 THEN 'C'
ELSE 'D'
END AS 工资级别
FROM employees;

#六、分组函数
#sum, avg, min, max, count, distinct去重
COUNT(*) #统计总行数，COUNT(1)也行

#!!!!!与分组函数一同查询的字段要求是group by后的字段
#查询员工表中的最大入职时间和最小入职时间的相差天数
SELECT DATEDIFF(MAX(hiredate), MIN(hiredate)) DIFFERENCE
FROM employees;

#查询部门编号为90的员工个数
SELECT COUNT(*)
FROM employees
WHERE department_id=90;
