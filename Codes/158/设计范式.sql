-- 1NF
-- 数据表中的所有字段都是不可分割的原子 （还可以拆分就不满足）

-- 2NF
-- 满足第一范式的前提下
-- 除主键外的每一列必须完全依赖主键
-- 如果出现不完全依赖，只可能发生在联合主键的情况下

create table myorder(
    product_id int,
    customer_id int,
    product_name varchar(20),
    customer_name varchar(20),
    primary key (product_id, customer_id)
);
-- 问题？
-- 除主键外的其他列，只依赖于主键的部分字段
-- 解决？
-- 拆表

create table myorder(
    order_id primary key,
    product_id int,
    customer_id int
);

create table product(
    id int primary key,
    name varchar(20)
);

create table customer(
    id int primary key,
    name varchar(20)
);

-- 3NF
-- 必须先满足第二范式，除开主键列的其他列之间不能有传递依赖
create table myorder(
    order_id primary key,
    product_id int,
    customer_id int,
    customer_phone varchar(20)
);

-- 问题？ phone和order_id和customer_id都有关系
-- 解决？

create table myorder(
    order_id primary key,
    product_id int,
    customer_id int,
);

create table customer(
    id int primary key,
    name varchar(20),
    customer_phone varchar(20)
);