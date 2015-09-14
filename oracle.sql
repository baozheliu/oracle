/*
���⣺
 1.START WITH �ؼ���
*/


/*
 DECODE������ʹ��
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
	   
	   
--��ѯNAME��ͬ�ļ�¼
select ID,NAME
from TEACHER 
where NAME 
in(
    select NAME from TEACHER 
	group by NAME 
	having count(NAME)>1
);


--�����ʽ��SQL��䣬��SAL�в�ѯ���ֵ����1.1��
SELECT ID,NAME,SAL*(1+0.1)
FROM USER_INFO

--DISTINCT ȥ���ظ���ѯ��
SELECT DISTINCT ID
FROM USER_INFO

/*=================================
   ɸѡ��ѯ��
=================================*/

-- ��ѯ���ʣ�sal������1500�ļ�¼
SELECT empno,ename,sal
FROM EMP
WHERE SAL>1500;


-- ALL �ؼ��ֵ�ʹ�ã�
SELECT empno, sal
FROM   emp
WHERE  sal > ALL (2000, 3000, 4000);
--�൱��
SELECT empno, sal
FROM   emp
WHERE  sal > 2000 AND sal > 3000 AND sal > 4000;



--ANY �ؼ��ֵ�ʹ�ã�
SELECT empno, sal
FROM   emp
WHERE  sal > ANY (2000, 3000, 4000);
--�൱��
SELECT empno, sal
FROM   emp
WHERE  sal > 2000 OR sal > 3000 OR sal > 4000;



--like �ؼ��ֵ�ʹ�ã�����"%" ƥ�������������ַ���"_"ƥ������һ���ַ�

SELECT salary 
FROM employees
WHERE last_name LIKE 'R%'
ORDER BY salary;

-- not like �ؼ��֣�
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
  
  
  --BETWEEN ...AND �ؼ��� 
  /*
    1. expr1 BETWEEN expr2 AND expr3
          is the value of the boolean expression:
    expr1>=expr2 AND expr1 <= expr3
	2.BETWEEN ...AND �������˵�ֵ
*/
 SELECT ID,NAME,SAL
 FROM USER_INFO
 WHERE SAL BETWEEN 2000 AND 3000; --��һ��ֵ����С�ڵڶ���ֵ
 
 
 --NOT BETWEEN x AND y ����xֵ��yֵ��Χ�����ֵ��������xֵ��yֵ
 
 
 
 --IS [NOT] NULL  �ؼ��ֵ�ʹ�ã�
 SELECT last_name
 FROM employees
 WHERE commission_pct
 IS NULL
 ORDER BY last_name;
 
 
 
 --�߼�ɸѡ ��where�־���ʹ��AND��OR��NOT ��������ɸѡ��
 
 
 /*=================================
   �����ѯ��
=================================*/

--group by
--�����ѯÿ�����ŵ���߹��ʺ���͹���
SELECT department_id, MIN(salary), MAX (salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;


SELECT department_id, MIN(salary), MAX (salary)
FROM employees
WHERE job_id = 'PU_CLERK'
GROUP BY department_id
ORDER BY department_id;


--HAVING �Ӿ��GROUP BY �־��ѯ�þ����������ɸѡ
--HAVING �Ӿ��п��԰����ۺϺ�����where�־��в��ܰ�����
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
   ��������ѯ��
   �ο���https://zh.wikipedia.org/zh-cn/%E8%BF%9E%E6%8E%A5_(SQL)
=================================*/

--1.   ������ �����Խ�һ������Ϊ: ������ӣ���Ȼ���ӣ���������

-- 1.1  �������
SELECT *
FROM   employee 
INNER JOIN department 
ON employee.DepartmentID = department.DepartmentID
--�ȼ���
SELECT *  
FROM   employee��department 
WHERE  employee.DepartmentID = department.DepartmentID

--ʹ��USING�ؼ���
SELECT *
FROM   employee 
INNER JOIN department 
USING (DepartmentID)  --USING �����г�����(column)����ֻ����һ�Σ��������ޱ�������.����ΪDepartmentID�������� employee.DepartmentID �� department.DepartmentID.


--1.2��Ȼ���ӣ���Ȼ���ӱ�������ӵĽ�һ������������������Ȼ����ʱ�������е�����������ͬ���ж������Ƚϣ�������ʽ�ġ���Ȼ���ӵõ��Ľ�����У�������������ͬ����ֻ����һ��.


SELECT *  --��������ͬ������ֻ����һ��
FROM   employee NATURAL JOIN department;



-- ע�⣺�� Oracle ���� JOIN USING �� NATURAL JOIN ʱ����������е��е�����ǰ����ĳ������Ϊǰ׺����ᱨ�������: "ORA-25154: column part of USING clause cannot have qualifier" �� "ORA-25155: column used in NATURAL join cannot have qualifier".


--1.3 �������ӣ���������(cross join)���ֳƵѿ�������(cartesian join)����(Product)�������������͵������ӵĻ������ѱ���Ϊ�м�¼�ļ��ϣ��������Ӽ��������������ϵĵѿ�����������ʵ�ȼ��������ӵ���������Ϊ"����"������������������.
--��� A �� B ���������ϣ����ǵĽ������Ӿͼ�Ϊ: A �� B.

SELECT *
FROM   employee CROSS JOIN department
-- ��
SELECT *
FROM   employee ,department;  --������where����һ�����˽����


--2.�����ӣ���������, ��������,ȫ����

 --2.1��������(left outer join), ����Ϊ������(left join), �� A �� B ���������������, ��ô������н�����"���"(���� A)�����м�¼, ��ʹ��Щ��¼��"�ұ�" B û�з�������������ƥ��. ����ζ�ż�ʹ ON ����� B �е�ƥ������0��, ���Ӳ������ǻ᷵��һ����¼, ֻ����������¼�������� B ��ÿһ�е�ֵ��Ϊ NULL. ����ζ���������ӻ᷵���������м�¼���ұ���ƥ���¼�����(����ұ�����ƥ���¼, �������ұ�������е�ֵ��Ϊ NULL). �������һ�����ұ��д��ڶ��ƥ����, ��ô�����лḴ�ƺ��ұ�ƥ����һ��������, ����������������ӽ��.
SELECT *  
FROM   employee  LEFT OUTER JOIN department  
ON employee.DepartmentID = department.DepartmentID

--2.2�������ӣ�
SELECT * 
FROM   employee RIGHT OUTER JOIN department 
ON employee.DepartmentID = department.DepartmentID

--2.3ȫ���������������ӵĲ���. ���ӱ���������ӵı�����м�¼, ���ȱ��ƥ��ļ�¼, ���� NULL ���.
SELECT *  
FROM   employee 
FULL OUTER JOIN department 
ON employee.DepartmentID = department.DepartmentID


--3. �����ӣ� 

--��ѯ������ͬ��Ա��������Ա��ID����
SELECT F.EmployeeID, F.LastName, S.EmployeeID, S.LastName, F.Country
FROM Employee F, Employee S
WHERE F.Country = S.Country  --���� F.Country = S.Country �ų����ڲ�ͬ���ҵĹ�Ա�����. ������ӽ��������õ�����ͬ���ҵĹ�Ա�����.
AND F.EmployeeID < S.EmployeeID  --���� F.EmployeeID < S.EmployeeID �ų��˹�Ա��(EmployeeID)��ͬ�����.
ORDER BY F.EmployeeID, S.EmployeeID;


/*============================
  ϵͳ����
==============================*/


-- 1.�ַ��ຯ��

--ASCII(c):����һ���ַ�ASCII��
SELECT ASCII('Z') Z,ASCII('H') H
FROM DUAL
 
 --CHR(i):����ASCII������Ӧ���ַ�
SELECT CHR(90),CHR(72)
FROM DUAL

--LENGTH(S) :����S�ĳ���
SELECT E.EMPNO,E.ENAME,D.DNAME
FROM EMP E INNER JOIN DEPT D
NO E.DEPTNO=D.DEPTNO
WHERE LENGTH(E.NAME)>5;

--LOWER(S) :�����ַ�����Сд��ʽ
--UPPER(S):�����ַ����Ĵ�д��ʽ

SELECT EMPLOYEE_ID,LOWER(FIRST_NAME), UPPER(LAST_NAME)
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) LIKE '%a%';


--2. ���ں����� 
   -- SYSDATE() �����ص�ǰϵͳ����
   
--ת���ຯ��
  --TO_CHAR(x[,format]) :ʵ�ֽ����ʽת��Ϊ�ַ�����format��ʾ�ַ�����ʽ
  --TO_DATE(s[,format[lan]]) :���ַ�������ת����date����
  --TO_NUMBER(s[,format[lan]]) :�������ַ������������
  
--3. �ۺ��ຯ����AVG��COUNT��MAX��MIN��SUM
	

  


