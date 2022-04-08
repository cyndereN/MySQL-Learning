create database students;
show databases;
use students;

show tables;

学生表
Student
学号、姓名、性别、出生年月日、所在班级
CREATE TABLE student(
    s_no VARCHAR(20) PRIMARY KEY COMMENT'学生学号',
    s_name VARCHAR(20) NOT NULL COMMENT'学生姓名 不能为空',
    s_sex VARCHAR(10) NOT NULL COMMENT'学生性别',
    s_birthday DATETIME COMMENT'学生生日',
    s_class VARCHAR(20) COMMENT'学生所在的班级'
);

课程表
Course
课程号、课程名、教师编号
CREATE TABLE course(
    c_no VARCHAR(20) PRIMARY KEY COMMENT'课程号',
    c_name VARCHAR(20) NOT NULL COMMENT'课程名称',
    t_no VARCHAR(20) NOT NULL COMMENT'教师编号 外键关联teacher表',
    FOREIGN KEY(t_no) references teacher(t_no)
);

报错:Failed to open the referenced table 'teacher'
我们先创建teacher表



成绩表
Score
学号、课程号、成绩
CREATE TABLE score (
    s_no VARCHAR(20) NOT NULL COMMENT'成绩表的编号 依赖学生学号',
    c_no VARCHAR(20)  NOT NULL COMMENT'课程号 依赖于课程表中的c_id',
    sc_degree decimal,
    foreign key(s_no) references student(s_no),
    foreign key(c_no) references course(c_no),
    PRIMARY KEY(s_no,c_no)
);



教师表
Teacher
教师编号、教师名字、教师性别、出生年月日、职称、所在部门
CREATE TABLE teacher(
    t_no VARCHAR(20) PRIMARY KEY COMMENT'教师编号',
    t_name VARCHAR(20) NOT NULL COMMENT'教师姓名',
    t_sex VARCHAR(20) NOT NULL COMMENT'教师性别',
    t_birthday DATETIME COMMENT'教师生日',
    t_rof VARCHAR(20) NOT NULL COMMENT'教师职称',
    t_depart VARCHAR(20) NOT NULL COMMENT'教师所在的部门'
);

向表中添加数据
LOAD DATA LOCAL INFILE "student.txt" INTO TABLE student;
--学生表数据
INSERT INTO student VALUES('101','曾华','男','1977-09-01','95033');
INSERT INTO student VALUES('102','匡明','男','1975-10-02','95031');
INSERT INTO student VALUES('103','王丽','女','1976-01-23','95033');
INSERT INTO student VALUES('104','李军','男','1976-02-20','95033');
INSERT INTO student VALUES('105','王芳','女','1975-02-10','95031');
INSERT INTO student VALUES('106','陆军','男','1974-06-03','95031');
INSERT INTO student VALUES('107','王尼玛','男','1976-02-20','95033');
INSERT INTO student VALUES('108','张全蛋','男','1975-02-10','95031');
INSERT INTO student VALUES('109','赵铁柱','男','1974-06-03','95031');

--教师表数据
INSERT INTO teacher VALUES('804','李诚','男','1958-12-02','副教授','计算机系');
INSERT INTO teacher VALUES('856','张旭','男','1969-03-12','讲师','电子工程系');
INSERT INTO teacher VALUES('825','王萍','女','1972-05-05','助教','计算机系');
INSERT INTO teacher VALUES('831','刘冰','女','1977-08-14','助教','电子工程系');

--添加课程表
INSERT INTO course VALUES('3-105','计算机导论','825');
INSERT INTO course VALUES('3-245','操作系统','804');
INSERT INTO course VALUES('6-166','数字电路','856');
INSERT INTO course VALUES('9-888','高等数学','831');

--添加成绩表
INSERT INTO score VALUES('103','3-245','86');
INSERT INTO score VALUES('105','3-245','75');
INSERT INTO score VALUES('109','3-245','68');
INSERT INTO score VALUES('103','3-105','92');

INSERT INTO score VALUES('105','3-105','88');
INSERT INTO score VALUES('109','3-105','76');
INSERT INTO score VALUES('103','6-166','85');

INSERT INTO score VALUES('105','6-166','79');
INSERT INTO score VALUES('109','6-166','81');