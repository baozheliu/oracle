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
	

  


