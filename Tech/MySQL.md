MySQL
=====


#### 启动mysql

	mysql -u root -p

#### 创建数据库

	create database [dbname];	

#### 删除数据库

	drop database [dbname];

#### 查看所有的数据库

	show databases;

#### 导入SQL脚本

	source [sqlname].sql;

#### 导出数据库

	mysqldump -u root -p [dbname] >[dbname].sql;

#### 使用某个数据库

	use [dbname];

#### 创建表

	create table [tablename] (id int primary key not null AUTO_INCREMENT,
          [field name] [filed type]);

#### 删除表

	drop table [tablename];

#### 查看数据库中所有的表

	show tables;

#### 查看表结构

	describe [tablename];

#### 添加字段（新增某列）

	alter table [tablename]
	add [column name] [type];

#### 删除字段（删除某列）

	alter table [tablename]
	drop column [column name];

#### 插入数据

	insert into Company
          (name,address,legal_representative,establish_date,phone,Email) 
          values('admin','admin','admin','1992-12-31','15986934725','447467113@qq.com');


