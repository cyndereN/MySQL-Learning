-- 主键约束，联合主键，自增

create table user(
    id int primary key auto_increment,
    name varchar(255);
);

insert into user values (1, '张三');
-- 不能再有同id或者null id

delete from pet where name = 'Fluffy'

update user set name = '李四' where id = 1;

create table user2 (
    id int,
    name varchar(255), 
    password varchar(255)
    primary key (id, name);
)

-- 如果建表时忘记添加
alter table user drop primary key;

alter table user add primary key(id);

alter table user modify id int priamry key;

desc user;

-- 唯一约束
-- 约束修饰的字段的值不可以重复

create table user(
    id int,
    name varchar(255), -- name varchar(20) unique
    unique(id, name) -- 两个键在一起不重复
);
alter table user add unique(name);
-- 主键约束默认唯一且非空

alter table user drop index name;
alter table user modify name varchar(20) unique;

-- 非空约束
create table user(
    id int,
    name varchar(255) not null
);

insert into user(name) values('lisi');
-- 此时lisi的id是null

-- 默认约束
create table user(
    id int,
    name varchar(255)，
    age int default 10
);

-- 外键约束

create table classes(
    id int primary key,
    name varchar(20)
);

create table students(
    id int primary key,
    name varchar(20),
    class_id int,
    foreign key(class_id) references classes(id)
);
-- 主表的记录被引用时是不可以被删除的