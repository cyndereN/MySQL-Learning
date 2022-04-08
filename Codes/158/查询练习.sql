-- 1.查询student表中所有的记录

SELECT * FROM student;
+------+--------+-------+---------------------+---------+
| s_no | s_name | s_sex | s_birthday          | s_class |
+------+--------+-------+---------------------+---------+
| 1    | admin  | 男    | 1999-09-09 00:00:00 | 95033   |
| 101  | 曾华   | 男    | 1977-09-01 00:00:00 | 95033   |
| 102  | 匡明   | 男    | 1975-10-02 00:00:00 | 95031   |
| 103  | 王丽   | 女    | 1976-01-23 00:00:00 | 95033   |
| 104  | 李军   | 男    | 1976-02-20 00:00:00 | 95033   |
| 105  | 王芳   | 女    | 1975-02-10 00:00:00 | 95031   |
| 106  | 陆军   | 男    | 1974-06-03 00:00:00 | 95031   |
| 107  | 王尼玛 | 男    | 1976-02-20 00:00:00 | 95033   |
| 108  | 张全蛋 | 男    | 1975-02-10 00:00:00 | 95031   |
| 109  | 赵铁柱 | 男    | 1974-06-03 00:00:00 | 95031   |
+------+--------+-------+---------------------+---------+

-- 2.查询student表中所有记录的s_name,s_sex和s_class列

SELECT s_no,s_name,s_class FROM  student;
+------+--------+---------+
| s_no | s_name | s_class |
+------+--------+---------+
| 1    | admin  | 95033   |
| 101  | 曾华   | 95033   |
| 102  | 匡明   | 95031   |
| 103  | 王丽   | 95033   |
| 104  | 李军   | 95033   |
| 105  | 王芳   | 95031   |
| 106  | 陆军   | 95031   |
| 107  | 王尼玛 | 95033   |
| 108  | 张全蛋 | 95031   |
| 109  | 赵铁柱 | 95031   |
+------+--------+---------+

-- 3.查询教师所有的单位但是不重复的t_depart列

SELECT distinct (t_depart) FROM teacher; 
+------------+
| t_depart   |
+------------+
| 计算机系   |
| 计算机机系 |
| 电子工程系 |
+------------+


-- 4.查询score表中成绩在60-80之间所有的记录(sc_degree)
-- 注意:BETWEEN... ADN...    是包含边界的
SELECT * FROM score WHERE sc_degree BETWEEN 61 AND 79;
SELECT * FROM score WHERE sc_degree < 80 AND sc_degree > 60 ; 
+------+-------+-----------+
| s_no | c_no  | sc_degree |
+------+-------+-----------+
| 105  | 3-245 |        75 |
| 105  | 6-166 |        79 |
| 109  | 3-105 |        76 |
| 109  | 3-245 |        68 |
+------+-------+-----------+

-- 5.查询score表中成绩为85, 86, 或者88的记录(sc_degree)

SELECT * FROM score WHERE sc_degree IN(85, 86, 88);
+------+-------+-----------+
| s_no | c_no  | sc_degree |
+------+-------+-----------+
| 103  | 3-245 |        86 |
| 103  | 6-166 |        85 |
| 105  | 3-105 |        88 |
+------+-------+-----------+

-- 6.查询student表中'95031'班或者性别为'女'的同学记录

SELECT * FROM student WHERE s_class = '95031' OR s_sex = '女';
+------+--------+-------+---------------------+---------+
| s_no | s_name | s_sex | s_birthday          | s_class |
+------+--------+-------+---------------------+---------+
| 102  | 匡明   | 男    | 1975-10-02 00:00:00 | 95031   |
| 103  | 王丽   | 女    | 1976-01-23 00:00:00 | 95033   |
| 105  | 王芳   | 女    | 1975-02-10 00:00:00 | 95031   |
| 106  | 陆军   | 男    | 1974-06-03 00:00:00 | 95031   |
| 108  | 张全蛋 | 男    | 1975-02-10 00:00:00 | 95031   |
| 109  | 赵铁柱 | 男    | 1974-06-03 00:00:00 | 95031   |
+------+--------+-------+---------------------+---------+

-- 7.以class降序查询student表中所有的记录

SELECT * FROM student ORDER BY s_class desc;
+------+--------+-------+---------------------+---------+
| s_no | s_name | s_sex | s_birthday          | s_class |
+------+--------+-------+---------------------+---------+
| 1    | admin  | 男    | 1999-09-09 00:00:00 | 95033   |
| 101  | 曾华   | 男    | 1977-09-01 00:00:00 | 95033   |
| 103  | 王丽   | 女    | 1976-01-23 00:00:00 | 95033   |
| 104  | 李军   | 男    | 1976-02-20 00:00:00 | 95033   |
| 107  | 王尼玛 | 男    | 1976-02-20 00:00:00 | 95033   |
| 102  | 匡明   | 男    | 1975-10-02 00:00:00 | 95031   |
| 105  | 王芳   | 女    | 1975-02-10 00:00:00 | 95031   |
| 106  | 陆军   | 男    | 1974-06-03 00:00:00 | 95031   |
| 108  | 张全蛋 | 男    | 1975-02-10 00:00:00 | 95031   |
| 109  | 赵铁柱 | 男    | 1974-06-03 00:00:00 | 95031   |
+------+--------+-------+---------------------+---------+

-- 8.以c_no升序.sc_degree降序插叙score表中所有的数据
-- 先以c_no进行升序,若c_no相同,则以sc_degree降序
SELECT * FROM score ORDER BY c_no ASC,sc_degree DESC;
+------+-------+-----------+
| s_no | c_no  | sc_degree |
+------+-------+-----------+
| 103  | 3-105 |        92 |
| 105  | 3-105 |        88 |
| 109  | 3-105 |        76 |
| 103  | 3-245 |        86 |
| 105  | 3-245 |        75 |
| 109  | 3-245 |        68 |
| 103  | 6-166 |        85 |
| 109  | 6-166 |        81 |
| 105  | 6-166 |        79 |
+------+-------+-----------+

-- 9.查询'95031'班的学生人数
SELECT COUNT(s_no) FROM student WHERE s_class = '95031';
+-------------+
| COUNT(s_no) |
+-------------+
|           5 |
+-------------+

-- 10.查询score表中的最高分数的学生号和课程号.(子查询或者排序)
查询步骤
1.先找到最高分
最高分: SELECT MAX(sc_degree) FROM score;
2.通过我们找到的最高分的分数来从score中找到我们需要的学生号和课程号
SELECT c_no, s_no FROM score WHERE sc_degree = (最高分)

SELECT c_no, s_no FROM score WHERE sc_degree = (SELECT MAX(sc_degree) FROM score);
+-------+------+
| c_no  | s_no |
+-------+------+
| 3-105 | 103  |
+-------+------+

排序做法在最高分有多个的情况下可能有数据问题
limit x,y  (x:表示从X条数据开始  y:需要查出多少条) 排序自下往上，类似stack，最下面是0
SELECT c_no, s_no FROM score ORDER BY sc_degree DESC LIMIT 0,1; 这个OK
但是我们再插入一条数据:
INSERT INTO score VALUES('101','9-888','92');
再用排序法去查得到:
+-------+------+
| c_no  | s_no |
+-------+------+
| 9-888 | 101  |
+-------+------+
有两条数据但是只显示一条,有问题

若我们用子查询的方法来查询的话会得到:
+-------+------+
| c_no  | s_no |
+-------+------+
| 9-888 | 101  |
| 3-105 | 103  |
+-------+------+
完全没有问题.
最后为了和视频数据一致删除刚刚插入的数据:
DELETE FROM score WHERE c_no = '9-888' AND s_no = '101';

-- 11.查询每门课的平均成绩
SELECT c_no,AVG(sc_degree) FROM SCORE GROUP BY c_no;
+-------+----------------+
| c_no  | AVG(sc_degree) |
+-------+----------------+
| 3-105 |        87.6667 |
| 3-245 |        76.3333 |
| 6-166 |        81.6667 |
+-------+----------------+

-- 12,查询score表中至少有2名学生选修的,并且以3开头的课程的平均分
-- 有条件的分组和模糊查询
SELECT AVG(sc_degree),c_no  from score GROUP BY c_no 
HAVING COUNT(c_no)  >= 2 AND c_no like '3%'  ;
+----------------+-------+
| AVG(sc_degree) | c_no  |
+----------------+-------+
|        85.3333 | 3-105 |
|        76.3333 | 3-245 |
+----------------+-------+

SELECT s_no,sc_degree  FROM score WHERE sc_degree BETWEEN 71 AND 89;
+------+-----------+
| s_no | sc_degree |
+------+-----------+
| 103  |        86 |
| 103  |        85 |
| 105  |        88 |
| 105  |        75 |
| 105  |        79 |
| 109  |        76 |
| 109  |        81 |
+------+-----------+

进阶:显示s_name,c_name
select s_name,sc_degree,c_name FROM score,student,course 
WHERE score.s_no = student.s_no AND score.c_no = course.c_no AND sc_degree BETWEEN 71 AND 89;
+--------+-----------+------------+
| s_name | sc_degree | c_name     |
+--------+-----------+------------+
| 王丽   |        86 | 操作系统   |
| 王丽   |        85 | 数字电路   |
| 王芳   |        88 | 计算机导论 |
| 王芳   |        75 | 操作系统   |
| 王芳   |        79 | 数字电路   |
| 赵铁柱 |        76 | 计算机导论 |
| 赵铁柱 |        81 | 数字电路   |
+--------+-----------+------------+

-- 14.查询所有的学生 s_name , c_no, sc_degree列
SELECT s_name, c_no, sc_degree FROM student,score WHERE student.s_no = score.s_no;
+--------+-------+-----------+
| s_name | c_no  | sc_degree |
+--------+-------+-----------+
| 王丽   | 3-105 |        92 |
| 王丽   | 3-245 |        86 |
| 王丽   | 6-166 |        85 |
| 王芳   | 3-105 |        88 |
| 王芳   | 3-245 |        75 |
| 王芳   | 6-166 |        79 |
| 赵铁柱 | 3-105 |        76 |
| 赵铁柱 | 3-245 |        68 |
| 赵铁柱 | 6-166 |        81 |
+--------+-------+-----------+

--  15.查询所有学生的s_no, c_name, sc_degree列
SELECT student.s_no, c_name, sc_degree FROM student, course,score WHERE student.s_no = score.s_no AND score.c_no = course.c_no ;
+------+------------+-----------+
| s_no | c_name     | sc_degree |
+------+------------+-----------+
| 103  | 计算机导论 |        92 |
| 103  | 操作系统   |        86 |
| 103  | 数字电路   |        85 |
| 105  | 计算机导论 |        88 |
| 105  | 操作系统   |        75 |
| 105  | 数字电路   |        79 |
| 109  | 计算机导论 |        76 |
| 109  | 操作系统   |        68 |
| 109  | 数字电路   |        81 |
+------+------------+-----------+

-- 16.查询所有的学生 s_name , c_name, sc_degree列
-- 将上面的c_no 的值换位c_name
SELECT s_name, c_name, sc_degree FROM student, course, score WHERE student.s_no = score.s_no AND score.c_no = course.c_no;
+--------+------------+-----------+
| s_name | c_name     | sc_degree |
+--------+------------+-----------+
| 王丽   | 计算机导论 |        92 |
| 王丽   | 操作系统   |        86 |
| 王丽   | 数字电路   |        85 |
| 王芳   | 计算机导论 |        88 |
| 王芳   | 操作系统   |        75 |
| 王芳   | 数字电路   |        79 |
| 赵铁柱 | 计算机导论 |        76 |
| 赵铁柱 | 操作系统   |        68 |
| 赵铁柱 | 数字电路   |        81 |
+--------+------------+-----------+

-- 17.查询班级是'95031'班学生每门课的平均分
select c_no,AVG(sc_degree) from score 
WHERE s_no IN (select s_no from student where s_class = '95031') 
GROUP BY c_no;

select c_no,AVG(sc_degree) from score AS sc 
LEFT JOIN student AS s ON sc.s_no = s.s_no WHERE s.s_class = '95031' GROUP BY sc.c_no;

SELECT sc.c_no,AVG(sc.sc_degree) FROM student AS s, score AS SC  
WHERE s.s_class = '95031' AND s.s_no = sc.s_no GROUP BY sc.c_no ;
+-------+-------------------+
| c_no  | AVG(sc.sc_degree) |
+-------+-------------------+
| 3-105 |           82.0000 |
| 3-245 |           71.5000 |
| 6-166 |           80.0000 |
+-------+-------------------+
进阶,加入课程名称:
SELECT sc.c_no, c.c_name, AVG(sc.sc_degree) FROM student AS s, score AS SC, course AS c  
WHERE s.s_class = '95031' AND s.s_no = sc.s_no AND c.c_no = sc.c_no GROUP BY sc.c_no ;
+-------+------------+-------------------+
| c_no  | c_name     | AVG(sc.sc_degree) |
+-------+------------+-------------------+
| 3-105 | 计算机导论 |           82.0000 |
| 3-245 | 操作系统   |           71.5000 |
| 6-166 | 数字电路   |           80.0000 |
+-------+------------+-------------------+

-- 18.查询选修"3-105"课程的成绩高于'109'号同学'3-105'成绩 的所有同学的记录
-- (在大家都在选修3-105的背景下 查询 所有 分数 比 学号为"109"还要高的学生信息)
SELECT * FROM student AS s, score AS sc 
WHERE sc.c_no = '3-105' AND sc.sc_degree > (SELECT sc_degree FROM score WHERE s_no = '109' AND c_no = '3-105') AND s.s_no = sc.s_no;


+------+--------+-------+---------------------+---------+------+-------+-----------+
| s_no | s_name | s_sex | s_birthday          | s_class | s_no | c_no  | sc_degree |
+------+--------+-------+---------------------+---------+------+-------+-----------+
| 103  | 王丽   | 女    | 1976-01-23 00:00:00 | 95033   | 103  | 3-105 |        92 |
| 105  | 王芳   | 女    | 1975-02-10 00:00:00 | 95031   | 105  | 3-105 |        88 |
+------+--------+-------+---------------------+---------+------+-------+-----------+


-- 19.查询成绩高于学号为'109',课程号为'3-105'的成绩的所有记录
SELECT * FROM score 
WHERE sc_degree >(SELECT sc_degree FROM score WHERE s_no = '109' AND c_no = '3-105');
+------+-------+-----------+
| s_no | c_no  | sc_degree |
+------+-------+-----------+
| 103  | 3-105 |        92 |
| 103  | 3-245 |        86 |
| 103  | 6-166 |        85 |
| 105  | 3-105 |        88 |
| 105  | 6-166 |        79 |
| 109  | 6-166 |        81 |
+------+-------+-----------+

不过视频中仅仅查出来了score记录,但是并没有学生的信息,按照上面的来修改:
SELECT * FROM student AS s, score AS sc 
WHERE sc.sc_degree > (SELECT sc_degree FROM score WHERE s_no = '109' AND c_no = '3-105') 
AND s.s_no = sc.s_no;

还可以再进一步:
SELECT s.s_no AS'学生学号', s.s_name AS'学生姓名', s_sex AS'性别', 
s_class AS'班级', c.c_no AS'课程编号', c.c_name AS'课程名称' ,sc.sc_degree AS'分数' 
FROM student AS s, score AS sc ,course AS c 
WHERE sc.sc_degree > (SELECT sc_degree FROM score WHERE s_no = '109' AND c_no = '3-105') 
AND s.s_no = sc.s_no 
AND sc.c_no = c.c_no;
+----------+----------+------+-------+----------+------------+------+
| 学生学号 | 学生姓名 | 性别 | 班级  | 课程编号 | 课程名称   | 分数 |
+----------+----------+------+-------+----------+------------+------+
| 103      | 王丽     | 女   | 95033 | 3-105    | 计算机导论 |   92 |
| 103      | 王丽     | 女   | 95033 | 3-245    | 操作系统   |   86 |
| 103      | 王丽     | 女   | 95033 | 6-166    | 数字电路   |   85 |
| 105      | 王芳     | 女   | 95031 | 3-105    | 计算机导论 |   88 |
| 105      | 王芳     | 女   | 95031 | 6-166    | 数字电路   |   79 |
| 109      | 赵铁柱   | 男   | 95031 | 6-166    | 数字电路   |   81 |
+----------+----------+------+-------+----------+------------+------+

--  20.查询和学号为108.101的同学同年出生的所有学生的s_no,s_name和s_birthday
SELECT * FROM student 
WHERE YEAR(s_birthday) IN (SELECT YEAR(s_birthday) FROM student WHERE s_no IN('108','101'));
+------+--------+-------+---------------------+---------+
| s_no | s_name | s_sex | s_birthday          | s_class |
+------+--------+-------+---------------------+---------+
| 101  | 曾华   | 男    | 1977-09-01 00:00:00 | 95033   |
| 102  | 匡明   | 男    | 1975-10-02 00:00:00 | 95031   |
| 105  | 王芳   | 女    | 1975-02-10 00:00:00 | 95031   |
| 108  | 张全蛋 | 男    | 1975-02-10 00:00:00 | 95031   |
+------+--------+-------+---------------------+---------+


-- 21.查询 张旭 教师任课的学生的成绩
select * from student 
where s_no IN (SELECT s_no FROM score 
    WHERE c_no = (SELECT c_no FROM course 
        WHERE t_no = (SELECT t_no FROM teacher WHERE t_name='张旭')));

+------+--------+-------+---------------------+---------+
| s_no | s_name | s_sex | s_birthday          | s_class |
+------+--------+-------+---------------------+---------+
| 103  | 王丽   | 女    | 1976-01-23 00:00:00 | 95033   |
| 105  | 王芳   | 女    | 1975-02-10 00:00:00 | 95031   |
| 109  | 赵铁柱 | 男    | 1974-06-03 00:00:00 | 95031   |