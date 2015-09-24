/*
问题：
 1.START WITH 关键字
*/




/*
 DECODE函数的使用
 This example decodes the value warehouse_id. If warehouse_id is 1, then the function returns 'Southlake'; if warehouse_id is 2, then it returns 'San Francisco'; and so forth. If warehouse_id is not 1, 2, 3, or 4, then the function returns 'Non domestic'.
*/

SELECT product_id,
       DECODE (warehouse_id, 1, 'Southlake', 
                             2, 'San Francisco', 
                             3, 'New Jersey', 
                             4, 'Seattle',
                                'Non domestic') 
       "Location of inventory" FROM inventories
       WHERE product_id < 1775;
	   
/*
   NVL函数的使用：
   nul函数将一个null值转换为一个实际的值。数据类型可以是日期，数字，字符。
   数据类型必须匹配：
   nvl(commision,0)
   nvl(hiredate,'01-JAN-87')
   nvl(job_id,'no manager') nvl(to_char(job_id),'no manager')

   http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions105.htm
*/
  
  SELECT last_name, NVL(TO_CHAR(commission_pct), 'Not Applicable')
   "COMMISSION" FROM employees
   WHERE last_name LIKE 'B%'
   ORDER BY last_name;




	   
--查询NAME相同的记录
select ID,NAME
from TEACHER 
where NAME 
in(
    select NAME from TEACHER 
	group by NAME 
	having count(NAME)>1
);


--带表达式的SQL语句，将SAL列查询结果值增加1.1倍
SELECT ID,NAME,SAL*(1+0.1)
FROM USER_INFO

--DISTINCT 去除重复查询，
SELECT DISTINCT ID
FROM USER_INFO

/*=================================
   筛选查询：
=================================*/

-- 查询工资（sal）大于1500的记录
SELECT empno,ename,sal
FROM EMP
WHERE SAL>1500;


-- ALL 关键字的使用：
SELECT empno, sal
FROM   emp
WHERE  sal > ALL (2000, 3000, 4000);
--相当于
SELECT empno, sal
FROM   emp
WHERE  sal > 2000 AND sal > 3000 AND sal > 4000;



--ANY 关键字的使用：
SELECT empno, sal
FROM   emp
WHERE  sal > ANY (2000, 3000, 4000);
--相当于
SELECT empno, sal
FROM   emp
WHERE  sal > 2000 OR sal > 3000 OR sal > 4000;



--like 关键字的使用：其中"%" 匹配任意数量的字符，"_"匹配任意一个字符

SELECT salary 
FROM employees
WHERE last_name LIKE 'R%'
ORDER BY salary;

-- not like 关键字：
SELECT salary 
FROM employees
WHERE last_name NOT LIKE '%TOM%'
ORDER BY salary;


--IN :Equivalent to =ANY.
SELECT * FROM employees
WHERE salary IN
(SELECT salary 
	FROM employees
	WHERE department_id =30)
ORDER BY employee_id;



--NOT IN  :Equivalent to !=ALL.
SELECT * FROM employees
  WHERE salary NOT IN
  (SELECT salary 
   FROM employees
  WHERE department_id = 30)
  ORDER BY employee_id;
  
  
  --BETWEEN ...AND 关键字 
  /*
    1. expr1 BETWEEN expr2 AND expr3
          is the value of the boolean expression:
    expr1>=expr2 AND expr1 <= expr3
	2.BETWEEN ...AND 包括两端的值
*/
 SELECT ID,NAME,SAL
 FROM USER_INFO
 WHERE SAL BETWEEN 2000 AND 3000; --第一个值必须小于第二个值
 
 
 --NOT BETWEEN x AND y 返回x值与y值范围以外的值，不包括x值和y值
 
 
 
 --IS [NOT] NULL  关键字的使用：
 SELECT last_name
 FROM employees
 WHERE commission_pct
 IS NULL
 ORDER BY last_name;
 
 
 
 --逻辑筛选 在where字句中使用AND、OR、NOT 进行数据筛选。
 
 
 /*=================================
   分组查询：
=================================*/

--group by
--分组查询每个部门的最高工资和最低工资
SELECT department_id, MIN(salary), MAX (salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;


SELECT department_id, MIN(salary), MAX (salary)
FROM employees
WHERE job_id = 'PU_CLERK'
GROUP BY department_id
ORDER BY department_id;


--HAVING 子句对GROUP BY 字句查询得劲结果集进行筛选
--HAVING 子句中可以包含聚合函数（where字句中不能包含）
SELECT department_id, MIN(salary), MAX (salary)
   FROM employees
   GROUP BY department_id
   HAVING MIN(salary) < 5000
   ORDER BY department_id;
   
 
-- order by
SELECT DEPTNO,EMPNO,ENAME
FROM EMP
ORDER BY DEPTNO,EMPNO

 /*=================================
   多表关联查询：
   参考：https://zh.wikipedia.org/zh-cn/%E8%BF%9E%E6%8E%A5_(SQL)
=================================*/

--1.   内连接 ：可以进一步被分为: 相等连接，自然连接，交叉连接

-- 1.1  相等连接
SELECT *
FROM   employee 
INNER JOIN department 
ON employee.DepartmentID = department.DepartmentID
--等价于
SELECT *  
FROM   employee，department 
WHERE  employee.DepartmentID = department.DepartmentID

--使用USING关键字
SELECT *
FROM   employee 
INNER JOIN department 
USING (DepartmentID)  --USING 部分列出的列(column)将以只出现一次，且名称无表名修饰.列名为DepartmentID，而不是 employee.DepartmentID 或 department.DepartmentID.


--1.2自然连接：自然连接比相等连接的进一步特例化。两表做自然连接时，两表中的所有名称相同的列都将被比较，这是隐式的。自然连接得到的结果表中，两表中名称相同的列只出现一次.


SELECT *  --两表中相同的列名只出现一次
FROM   employee NATURAL JOIN department;



-- 注意：在 Oracle 里用 JOIN USING 或 NATURAL JOIN 时，如果两表共有的列的名称前加上某表名作为前缀，则会报编译错误: "ORA-25154: column part of USING clause cannot have qualifier" 或 "ORA-25155: column used in NATURAL join cannot have qualifier".


--1.3 交叉连接：交叉连接(cross join)，又称笛卡尔连接(cartesian join)或叉乘(Product)，它是所有类型的内连接的基础。把表视为行记录的集合，交叉连接即返回这两个集合的笛卡尔积。这其实等价于内连接的链接条件为"永真"，或连接条件不存在.
--如果 A 和 B 是两个集合，它们的交叉连接就记为: A × B.

SELECT *
FROM   employee CROSS JOIN department
-- 或
SELECT *
FROM   employee ,department;  --可以用where语句进一步过滤结果集


--2.外连接：左外连接, 右外连接,全连接

 --2.1左外连接(left outer join), 亦简称为左连接(left join), 若 A 和 B 两表进行左外连接, 那么结果表中将包含"左表"(即表 A)的所有记录, 即使那些记录在"右表" B 没有符合连接条件的匹配. 这意味着即使 ON 语句在 B 中的匹配项是0条, 连接操作还是会返回一条记录, 只不过这条记录中来自于 B 的每一列的值都为 NULL. 这意味着左外连接会返回左表的所有记录和右表中匹配记录的组合(如果右表中无匹配记录, 来自于右表的所有列的值设为 NULL). 如果左表的一行在右表中存在多个匹配行, 那么左表的行会复制和右表匹配行一样的数量, 并进行组合生成连接结果.
SELECT *  
FROM   employee  LEFT OUTER JOIN department  
ON employee.DepartmentID = department.DepartmentID

--2.2右外连接：
SELECT * 
FROM   employee RIGHT OUTER JOIN department 
ON employee.DepartmentID = department.DepartmentID

--2.3全连接是左右外连接的并集. 连接表包含被连接的表的所有记录, 如果缺少匹配的记录, 即以 NULL 填充.
SELECT *  
FROM   employee 
FULL OUTER JOIN department 
ON employee.DepartmentID = department.DepartmentID


--3. 自连接： 

--查询国家相同的员工，并按员工ID排序
SELECT F.EmployeeID, F.LastName, S.EmployeeID, S.LastName, F.Country
FROM Employee F, Employee S
WHERE F.Country = S.Country  --条件 F.Country = S.Country 排除了在不同国家的雇员的组合. 这个例子仅仅期望得到在相同国家的雇员的组合.
AND F.EmployeeID < S.EmployeeID  --条件 F.EmployeeID < S.EmployeeID 排除了雇员号(EmployeeID)相同的组合.
ORDER BY F.EmployeeID, S.EmployeeID;


/*============================
  系统函数
==============================*/


-- 1.字符类函数

--ASCII(c):返回一个字符ASCII码
SELECT ASCII('Z') Z,ASCII('H') H
FROM DUAL
 
 --CHR(i):返回ASCII码所对应的字符
SELECT CHR(90),CHR(72)
FROM DUAL

--LENGTH(S) :返回S的长度
SELECT E.EMPNO,E.ENAME,D.DNAME
FROM EMP E INNER JOIN DEPT D
NO E.DEPTNO=D.DEPTNO
WHERE LENGTH(E.NAME)>5;

--LOWER(S) :返回字符串的小写形式
--UPPER(S):返回字符串的大写形式

SELECT EMPLOYEE_ID,LOWER(FIRST_NAME), UPPER(LAST_NAME)
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) LIKE '%a%';


--2. 日期函数： 
   -- SYSDATE() ：返回当前系统日期
   
--转换类函数
  --TO_CHAR(x[,format]) :实现将表达式转换为字符串，format表示字符串格式
  --TO_DATE(s[,format[lan]]) :将字符串类型转换成date类型
  --TO_NUMBER(s[,format[lan]]) :将返回字符串代表的数字
  
--3. 聚合类函数：AVG、COUNT、MAX、MIN、SUM
	


/*====================
   子查询
=====================*/
--1. 单行子查询 ：子查询的返回结果为一行数据
SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE SAL>(SELECT MIN(SAL) FROM EMP)
AND 
SAL <(SELECT MAX(SAL) FROM EMP);

--2. 多行子查询
--查询非销售部门的员工信息
SELECT EMPNO,ENAME,JOB
FROM EMP
WHERE DEPTNO IN
(SELECT DEPTNO
FROM DEPT
WHERE DNAME<>'SALES');

  
--关联子查询: 内查询的执行需要借助于外查询，而外查询的执行又离不开内查询，内查询和外查询是相互关联的
 


-- 注：子查询中不能包括ORDER BY 字句。使用关联子查询时，会遍历数据表中每条记录，所以效率较低。

--查询同职位中工资高于平均工资的员工
select empno,ename,sal
from emp f
where sal > (select avg(sal) from emp where job = f.job)
order by job;



/*====================
   插入数据
=====================*/

--批量插入数据，INSERT INTO 语句的列名必须与SELECT字句指定列名可以不同，但数据类型必须兼容。
insert into jobs_temp
select * from jobs
where jobs.max_salary > 10000;

/*====================
   更新数据
=====================*/

--将工资少于2000的员工，调至平均工资水平
UPDATE EMP
SET SAL=(SELECT AVG(SAL)
FROM EMP 
WHERE JOB='MANAGER')
WHERE SAL<2000;


/*====================
   删除数据
=====================*/

--使用DELETE 语句删除数据时，Oracle系统会产生回滚记录，所以可以通过ROLLBACK 语句撤销删除操作
DELETE FROM  JOBS
WHERE JOB_ID='PRO'

--TRUNCATE语句比DELETE语句效率高，但不产生回滚记录
TRUNCATE TABLE JOBS_TEMP



/*====================
   事务处理
=====================*/
--事务的属性：原子性、一致性、隔离性、持久性

truncate table jobs_temp;
insert into jobs_temp values('OFFICE','办公文员',3000,5000);
savepoint sp; --创建保存点
insert into jobs_temp values('FINANCE','财务人员',4000,8000);
select * from jobs_temp;
rollback to savepoint sp;
commit;
select * from jobs_temp;

/*====================
   PL/SQL
=====================*/


--1. PL/SQL 程序以块为基本单位，PL/SQL分为三部分：
   --1）声明部分（可选）：变量、常量、游标
   --2）执行部分：BEGIN关键字开始，END关键字结束 
   --3）异常处理部分（可选）:EXCEPTION关键字开始
 --注意：每条语句必须以分号结束。
 
set serveroutput on  --服务端显示执行结果
declare
  a int:=100;
  b int:=200;
  c number; --声明一个数值变量
begin
  c:=(a+b)/(a-b);
  dbms_output.put_line(c);
exception
  when zero_divide then
  dbms_output.put_line('除数不许为零!');
end;


 --2. PL/SQL 特殊数据类型
 
  --1) %TYPE :声明一个与指定列名相同的数据类型

set serveroutput on
declare
  var_ename emp.ename%type; 						--声明与ename列类型相同的变量
  var_job emp.job%type; 							--声明与job列类型相同的变量
begin
  select ename,job
  /*
    into子句用于表示将从数据库中检索的数据存储到那个变量中;
	into字句中的变量只能存储一个单独的值，所以要求select子句通过where子句进行限定
  */
  into var_ename,var_job   
  from emp
  where empno=7369;							--检索数据，并保存在变量中
  dbms_output.put_line(var_ename||'的职务是'||var_job);	--输出变量的值
end;

  --2) RECORD类型（记录类型）
  
set serveroutput on
declare
  type emp_type is record --声明record类型emp_type
  (
    var_ename varchar2(20),--定义字段
    var_job varchar2(20),
    var_sal number
  );
  empinfo  emp_type; --定义变量
begin
  select ename,job,sal
  into empinfo
  from emp
  where empno=7369;--检索数据
  --输出雇员信息
  dbms_output.put_line('雇员'||empinfo.var_ename||'的职务是'||empinfo.var_job||'、工资是'||empinfo.var_sal);
end;

 

 --3) ROWTYPE类型（记录类型）
 
 
 set serveroutput on
declare
  rowVar_emp emp%rowtype; --定义能够存储emp表中一行数据的变量rowVar_emp
begin
  select * 
  into rowVar_emp
  from emp
  where empno=7369;--检索数据
  /*输出雇员信息*/
  dbms_output.put_line('雇员'||rowVar_emp.ename||'的编号是'||rowVar_emp.empno||',职务是'||rowVar_emp.job);
end;


 --if ...then 语句
 set serveroutput on
declare
  var_name1 varchar2(50);
  var_name2 varchar2(50);
begin
  var_name1:='East';
  var_name2:='xiaoke';
  if length(var_name1) < length(var_name2) then
    dbms_output.put_line('字符串“'||var_name1||'”的长度比字符串“'||var_name2||'”的长度小');
  end if;
end;


  -- if ...then ...else
  set serveroutput on
declare
  age int:=55;--定义整形变量并赋值
begin
  if age >= 56 then--比较年龄是否大于56岁
    dbms_output.put_line('您可以申请退休了！');--输出退休信息
  else
    dbms_output.put_line('您小于56岁，不可以申请退休了！');--输出不可退休信息
  end if;
end;


--if...then ...else if
set serveroutput on
declare
  month int:=10;--定义整形变量并赋值
begin
  if month >= 0 and month <= 3  then--判断春季
    dbms_output.put_line('这是春季');
  elsif  month >= 4 and month <= 6 then--判断夏季
    dbms_output.put_line('这是夏季');
  elsif  month >= 7 and month <= 9  then--判断秋季
    dbms_output.put_line('这是秋季');
  elsif  month >= 10 and month <= 12 then--判断冬季
    dbms_output.put_line('这是冬季');
  else
    dbms_output.put_line('对不起，月份不合法！');
  end if;
end;


--case 语句
set serveroutput on
declare
  season int:=3;--定义整形变量并赋值
  aboutInfo varchar2(50); 
begin
  case season 
    when 1 then
      aboutInfo := season||'季度包括1，2，3月份';
    when 2 then
      aboutInfo := season||'季度包括4，5，6月份';
    when 3 then
      aboutInfo := season||'季度包括7，8，9月份';
    when 4 then
      aboutInfo := season||'季度包括10，11，12月份';
    else
      aboutInfo := season||'季节不合法';
  end case;
  dbms_output.put_line(aboutinfo);
end;


-- loop 
set serveroutput on
declare
  sum_i int:= 0;--定义整数变量，存储整数和
  i int:= 0;--定义整数变量，存储自然数
begin
  loop--循环累加自然数
    i:=i+1;--得出自然数
    sum_i:= sum_i+i;--计算前n个自然数的和
    exit when i = 100;--当循环100次时，程序退出循环体
  end loop;
  dbms_output.put_line('前100个自然数的和是：'||sum_i);--计算前100个自然数的和
end;



-- while语句
set serveroutput on
declare
  sum_i int:= 0;--定义整数变量，存储整数和
  i int:= 0;--定义整数变量，存储自然数
begin
  while i<=99 loop
    i:=i+1;--得出自然数
    sum_i:= sum_i+i;--计算前n个自然数的和
  end loop;
  dbms_output.put_line('前100个自然数的和是：'||sum_i);--计算前100个自然数的和
end;


-- for 语句
set serveroutput on
declare
  sum_i int:= 0;--定义整数变量，存储整数和
begin
  for i in reverse 1..100 loop --遍历前100个自然数
    if mod(i,2)=0 then --判断是否为偶数
      sum_i:=sum_i+i;--计算偶数和
    end if;
  end loop;
  dbms_output.put_line('前100个自然数中偶数之和是：'||sum_i);
end;



/*===================================================*/

/*存储过程 
http://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm
*/



CREATE OR REPLACE PROCEDURE pro_insertDept is
begin 
	insert into dept values(99,'市场拓展部','北京');
	dbms_output.put_line('插入新纪录成功！');
end pro_insertDept

--执行存储过程
exec pro_insertDept;

--在PL/SQL 执行pro_insertDep
begin	
	pro_insertDept
end 





--给存储过程传入参数：

 --创建存储过程
 create or replace procedure insert_dept(
  num_deptno in number,					--定义in模式的变量，参数类型不能指定长度
  var_ename in varchar2,				
  var_loc in varchar2) is
begin
  insert into dept
  values(num_deptno,var_ename,var_loc);		--向dept表中插入记录
  commit;								--提交数据库
end insert_dept;


--传入参数调用存储过程：
begin
	insert_dept(var_ename=>'采购部',var_loc=>'成都',num_deptno=>'15')   --参数定义的顺序和调用时传入的顺序不一定一致
end;
--等同于
begin
	insert_dept(28,'工程部','洛阳')   --参数传值顺序必须与定义存储过程参数顺序一直
end 
--等同于
exec insert_dept(28,var_loc=>'济南',var_name=>'测试部')





--创建存储过程
CREATE PROCEDURE remove_emp (employee_id NUMBER) AS
   tot_emps NUMBER;
   BEGIN
      DELETE FROM employees
      WHERE employees.employee_id = remove_emp.employee_id;
   tot_emps := tot_emps - 1;
 END;


