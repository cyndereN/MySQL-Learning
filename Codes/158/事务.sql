在 MySQL 中，事务其实是一个最小的不可分割的工作单元。事务能够保证一个业务的完整性。

比如我们的银行转账：

-- a -> -100
UPDATE user set money = money - 100 WHERE name = 'a';

-- b -> +100
UPDATE user set money = money + 100 WHERE name = 'b';
在实际项目中，假设只有一条 SQL 语句执行成功，而另外一条执行失败了，就会出现数据前后不一致。

因此，在执行多条有关联 SQL 语句时，事务可能会要求这些 SQL 语句要么同时执行成功，要么就都执行失败。


如何控制事务 - COMMIT / ROLLBACK
在 MySQL 中，事务的自动提交状态默认是开启的。

-- 查询事务的自动提交状态
SELECT @@AUTOCOMMIT;
+--------------+
| @@AUTOCOMMIT |
+--------------+
|            1 |
+--------------+
自动提交的作用：当我们执行一条 SQL 语句的时候，其产生的效果就会立即体现出来，且不能回滚。

什么是回滚？举个例子：

CREATE DATABASE bank;

USE bank;

CREATE TABLE user (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    money INT
);

INSERT INTO user VALUES (1, 'a', 1000);

SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
可以看到，在执行插入语句后数据立刻生效，原因是 MySQL 中的事务自动将它提交到了数据库中。那么所谓回滚的意思就是，撤销执行过的所有 SQL 语句，使其回滚到最后一次提交数据时的状态。

在 MySQL 中使用 ROLLBACK 执行回滚：

-- 回滚到最后一次提交
ROLLBACK;

SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
由于所有执行过的 SQL 语句都已经被提交过了，所以数据并没有发生回滚。那如何让数据可以发生回滚？

-- 关闭自动提交
SET AUTOCOMMIT = 0;

-- 查询自动提交状态
SELECT @@AUTOCOMMIT;
+--------------+
| @@AUTOCOMMIT |
+--------------+
|            0 |
+--------------+
将自动提交关闭后，测试数据回滚：

INSERT INTO user VALUES (2, 'b', 1000);

-- 关闭 AUTOCOMMIT 后，数据的变化是在一张虚拟的临时数据表中展示，
-- 发生变化的数据并没有真正插入到数据表中。
SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+

-- 数据表中的真实数据其实还是：
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+

-- 由于数据还没有真正提交，可以使用回滚
ROLLBACK;

-- 再次查询
SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
那如何将虚拟的数据真正提交到数据库中？使用 COMMIT :

INSERT INTO user VALUES (2, 'b', 1000);
-- 手动提交数据（持久性），
-- 将数据真正提交到数据库中，执行后不能再回滚提交过的数据。
COMMIT;

-- 提交后测试回滚
ROLLBACK;

-- 再次查询（回滚无效了）
SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
总结

1 自动提交

查看自动提交状态：SELECT @@AUTOCOMMIT ；

设置自动提交状态：SET AUTOCOMMIT = 0 。

2 手动提交

@@AUTOCOMMIT = 0 时，使用 COMMIT 命令提交事务。

3 事务回滚

@@AUTOCOMMIT = 0 时，使用 ROLLBACK 命令回滚事务。

事务的实际应用，让我们再回到银行转账项目：

-- 转账
UPDATE user set money = money - 100 WHERE name = 'a';

-- 到账
UPDATE user set money = money + 100 WHERE name = 'b';

SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
这时假设在转账时发生了意外，就可以使用 ROLLBACK 回滚到最后一次提交的状态：

-- 假设转账发生了意外，需要回滚。
ROLLBACK;

SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
这时我们又回到了发生意外之前的状态，也就是说，事务给我们提供了一个可以反悔的机会。假设数据没有发生意外，这时可以手动将数据真正提交到数据表中：COMMIT 。


手动开启事务 - BEGIN / START TRANSACTION
事务的默认提交被开启 ( @@AUTOCOMMIT = 1 ) 后，此时就不能使用事务回滚了。但是我们还可以手动开启一个事务处理事件，使其可以发生回滚：

-- 使用 BEGIN 或者 START TRANSACTION 手动开启一个事务
-- START TRANSACTION;
BEGIN;
UPDATE user set money = money - 100 WHERE name = 'a';
UPDATE user set money = money + 100 WHERE name = 'b';

-- 由于手动开启的事务没有开启自动提交，
-- 此时发生变化的数据仍然是被保存在一张临时表中。
SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+

-- 测试回滚
ROLLBACK;

SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
仍然使用 COMMIT 提交数据，提交后无法再发生本次事务的回滚。

BEGIN;
UPDATE user set money = money - 100 WHERE name = 'a';
UPDATE user set money = money + 100 WHERE name = 'b';

SELECT * FROM user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+

-- 提交数据
COMMIT;

-- 测试回滚（无效，因为表的数据已经被提交）
ROLLBACK;
事务的 ACID 特征与使用
事务的四大特征：

A 原子性：事务是最小的单位，不可以再分割；
C 一致性：要求同一事务中的 SQL 语句，必须保证同时成功或者失败；
I 隔离性：事务1 和 事务2 之间是具有隔离性的；
D 持久性：事务一旦结束 ( COMMIT ) ，就不可以再返回了 ( ROLLBACK ) 。
事务的隔离性
事务的隔离性可分为四种 ( 性能从低到高 ) ：

READ UNCOMMITTED ( 读取未提交 )

如果有多个事务，那么任意事务都可以看见其他事务的未提交数据。

READ COMMITTED ( 读取已提交 )

只能读取到其他事务已经提交的数据。

REPEATABLE READ ( 可被重复读 )

如果有多个连接都开启了事务，那么事务之间不能共享数据记录，否则只能共享已提交的记录。

SERIALIZABLE ( 串行化 )

所有的事务都会按照固定顺序执行，执行完一个事务后再继续执行下一个事务的写入操作。

查看当前数据库的默认隔离级别：

-- MySQL 8.x, GLOBAL 表示系统级别，不加表示会话级别。
SELECT @@GLOBAL.TRANSACTION_ISOLATION;
SELECT @@TRANSACTION_ISOLATION;
+--------------------------------+
| @@GLOBAL.TRANSACTION_ISOLATION |
+--------------------------------+
| REPEATABLE-READ                | -- MySQL的默认隔离级别，可以重复读。
+--------------------------------+

-- MySQL 5.x
SELECT @@GLOBAL.TX_ISOLATION;
SELECT @@TX_ISOLATION;
修改隔离级别：

-- 设置系统隔离级别，LEVEL 后面表示要设置的隔离级别 (READ UNCOMMITTED)。
SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- 查询系统隔离级别，发现已经被修改。
SELECT @@GLOBAL.TRANSACTION_ISOLATION;
+--------------------------------+
| @@GLOBAL.TRANSACTION_ISOLATION |
+--------------------------------+
| READ-UNCOMMITTED               |
+--------------------------------+




