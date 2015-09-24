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
	   
/*
   NVL������ʹ�ã�
   nul������һ��nullֵת��Ϊһ��ʵ�ʵ�ֵ���������Ϳ��������ڣ����֣��ַ���
   �������ͱ���ƥ�䣺
   nvl(commision,0)
   nvl(hiredate,'01-JAN-87')
   nvl(job_id,'no manager') nvl(to_char(job_id),'no manager')

   http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions105.htm
*/
  
  SELECT last_name, NVL(TO_CHAR(commission_pct), 'Not Applicable')
   "COMMISSION" FROM employees
   WHERE last_name LIKE 'B%'
   ORDER BY last_name;




	   
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
	


/*====================
   �Ӳ�ѯ
=====================*/
--1. �����Ӳ�ѯ ���Ӳ�ѯ�ķ��ؽ��Ϊһ������
SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE SAL>(SELECT MIN(SAL) FROM EMP)
AND 
SAL <(SELECT MAX(SAL) FROM EMP);

--2. �����Ӳ�ѯ
--��ѯ�����۲��ŵ�Ա����Ϣ
SELECT EMPNO,ENAME,JOB
FROM EMP
WHERE DEPTNO IN
(SELECT DEPTNO
FROM DEPT
WHERE DNAME<>'SALES');

  
--�����Ӳ�ѯ: �ڲ�ѯ��ִ����Ҫ���������ѯ�������ѯ��ִ�����벻���ڲ�ѯ���ڲ�ѯ�����ѯ���໥������
 


-- ע���Ӳ�ѯ�в��ܰ���ORDER BY �־䡣ʹ�ù����Ӳ�ѯʱ����������ݱ���ÿ����¼������Ч�ʽϵ͡�

--��ѯְͬλ�й��ʸ���ƽ�����ʵ�Ա��
select empno,ename,sal
from emp f
where sal > (select avg(sal) from emp where job = f.job)
order by job;



/*====================
   ��������
=====================*/

--�����������ݣ�INSERT INTO ��������������SELECT�־�ָ���������Բ�ͬ�����������ͱ�����ݡ�
insert into jobs_temp
select * from jobs
where jobs.max_salary > 10000;

/*====================
   ��������
=====================*/

--����������2000��Ա��������ƽ������ˮƽ
UPDATE EMP
SET SAL=(SELECT AVG(SAL)
FROM EMP 
WHERE JOB='MANAGER')
WHERE SAL<2000;


/*====================
   ɾ������
=====================*/

--ʹ��DELETE ���ɾ������ʱ��Oracleϵͳ������ع���¼�����Կ���ͨ��ROLLBACK ��䳷��ɾ������
DELETE FROM  JOBS
WHERE JOB_ID='PRO'

--TRUNCATE����DELETE���Ч�ʸߣ����������ع���¼
TRUNCATE TABLE JOBS_TEMP



/*====================
   ������
=====================*/
--��������ԣ�ԭ���ԡ�һ���ԡ������ԡ��־���

truncate table jobs_temp;
insert into jobs_temp values('OFFICE','�칫��Ա',3000,5000);
savepoint sp; --���������
insert into jobs_temp values('FINANCE','������Ա',4000,8000);
select * from jobs_temp;
rollback to savepoint sp;
commit;
select * from jobs_temp;

/*====================
   PL/SQL
=====================*/


--1. PL/SQL �����Կ�Ϊ������λ��PL/SQL��Ϊ�����֣�
   --1���������֣���ѡ�����������������α�
   --2��ִ�в��֣�BEGIN�ؼ��ֿ�ʼ��END�ؼ��ֽ��� 
   --3���쳣�����֣���ѡ��:EXCEPTION�ؼ��ֿ�ʼ
 --ע�⣺ÿ���������ԷֺŽ�����
 
set serveroutput on  --�������ʾִ�н��
declare
  a int:=100;
  b int:=200;
  c number; --����һ����ֵ����
begin
  c:=(a+b)/(a-b);
  dbms_output.put_line(c);
exception
  when zero_divide then
  dbms_output.put_line('��������Ϊ��!');
end;


 --2. PL/SQL ������������
 
  --1) %TYPE :����һ����ָ��������ͬ����������

set serveroutput on
declare
  var_ename emp.ename%type; 						--������ename��������ͬ�ı���
  var_job emp.job%type; 							--������job��������ͬ�ı���
begin
  select ename,job
  /*
    into�Ӿ����ڱ�ʾ�������ݿ��м��������ݴ洢���Ǹ�������;
	into�־��еı���ֻ�ܴ洢һ��������ֵ������Ҫ��select�Ӿ�ͨ��where�Ӿ�����޶�
  */
  into var_ename,var_job   
  from emp
  where empno=7369;							--�������ݣ��������ڱ�����
  dbms_output.put_line(var_ename||'��ְ����'||var_job);	--���������ֵ
end;

  --2) RECORD���ͣ���¼���ͣ�
  
set serveroutput on
declare
  type emp_type is record --����record����emp_type
  (
    var_ename varchar2(20),--�����ֶ�
    var_job varchar2(20),
    var_sal number
  );
  empinfo  emp_type; --�������
begin
  select ename,job,sal
  into empinfo
  from emp
  where empno=7369;--��������
  --�����Ա��Ϣ
  dbms_output.put_line('��Ա'||empinfo.var_ename||'��ְ����'||empinfo.var_job||'��������'||empinfo.var_sal);
end;

 

 --3) ROWTYPE���ͣ���¼���ͣ�
 
 
 set serveroutput on
declare
  rowVar_emp emp%rowtype; --�����ܹ��洢emp����һ�����ݵı���rowVar_emp
begin
  select * 
  into rowVar_emp
  from emp
  where empno=7369;--��������
  /*�����Ա��Ϣ*/
  dbms_output.put_line('��Ա'||rowVar_emp.ename||'�ı����'||rowVar_emp.empno||',ְ����'||rowVar_emp.job);
end;


 --if ...then ���
 set serveroutput on
declare
  var_name1 varchar2(50);
  var_name2 varchar2(50);
begin
  var_name1:='East';
  var_name2:='xiaoke';
  if length(var_name1) < length(var_name2) then
    dbms_output.put_line('�ַ�����'||var_name1||'���ĳ��ȱ��ַ�����'||var_name2||'���ĳ���С');
  end if;
end;


  -- if ...then ...else
  set serveroutput on
declare
  age int:=55;--�������α�������ֵ
begin
  if age >= 56 then--�Ƚ������Ƿ����56��
    dbms_output.put_line('���������������ˣ�');--���������Ϣ
  else
    dbms_output.put_line('��С��56�꣬���������������ˣ�');--�������������Ϣ
  end if;
end;


--if...then ...else if
set serveroutput on
declare
  month int:=10;--�������α�������ֵ
begin
  if month >= 0 and month <= 3  then--�жϴ���
    dbms_output.put_line('���Ǵ���');
  elsif  month >= 4 and month <= 6 then--�ж��ļ�
    dbms_output.put_line('�����ļ�');
  elsif  month >= 7 and month <= 9  then--�ж��＾
    dbms_output.put_line('�����＾');
  elsif  month >= 10 and month <= 12 then--�ж϶���
    dbms_output.put_line('���Ƕ���');
  else
    dbms_output.put_line('�Բ����·ݲ��Ϸ���');
  end if;
end;


--case ���
set serveroutput on
declare
  season int:=3;--�������α�������ֵ
  aboutInfo varchar2(50); 
begin
  case season 
    when 1 then
      aboutInfo := season||'���Ȱ���1��2��3�·�';
    when 2 then
      aboutInfo := season||'���Ȱ���4��5��6�·�';
    when 3 then
      aboutInfo := season||'���Ȱ���7��8��9�·�';
    when 4 then
      aboutInfo := season||'���Ȱ���10��11��12�·�';
    else
      aboutInfo := season||'���ڲ��Ϸ�';
  end case;
  dbms_output.put_line(aboutinfo);
end;


-- loop 
set serveroutput on
declare
  sum_i int:= 0;--���������������洢������
  i int:= 0;--���������������洢��Ȼ��
begin
  loop--ѭ���ۼ���Ȼ��
    i:=i+1;--�ó���Ȼ��
    sum_i:= sum_i+i;--����ǰn����Ȼ���ĺ�
    exit when i = 100;--��ѭ��100��ʱ�������˳�ѭ����
  end loop;
  dbms_output.put_line('ǰ100����Ȼ���ĺ��ǣ�'||sum_i);--����ǰ100����Ȼ���ĺ�
end;



-- while���
set serveroutput on
declare
  sum_i int:= 0;--���������������洢������
  i int:= 0;--���������������洢��Ȼ��
begin
  while i<=99 loop
    i:=i+1;--�ó���Ȼ��
    sum_i:= sum_i+i;--����ǰn����Ȼ���ĺ�
  end loop;
  dbms_output.put_line('ǰ100����Ȼ���ĺ��ǣ�'||sum_i);--����ǰ100����Ȼ���ĺ�
end;


-- for ���
set serveroutput on
declare
  sum_i int:= 0;--���������������洢������
begin
  for i in reverse 1..100 loop --����ǰ100����Ȼ��
    if mod(i,2)=0 then --�ж��Ƿ�Ϊż��
      sum_i:=sum_i+i;--����ż����
    end if;
  end loop;
  dbms_output.put_line('ǰ100����Ȼ����ż��֮���ǣ�'||sum_i);
end;



/*===================================================*/

/*�洢���� 
http://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm
*/



CREATE OR REPLACE PROCEDURE pro_insertDept is
begin 
	insert into dept values(99,'�г���չ��','����');
	dbms_output.put_line('�����¼�¼�ɹ���');
end pro_insertDept

--ִ�д洢����
exec pro_insertDept;

--��PL/SQL ִ��pro_insertDep
begin	
	pro_insertDept
end 





--���洢���̴��������

 --�����洢����
 create or replace procedure insert_dept(
  num_deptno in number,					--����inģʽ�ı������������Ͳ���ָ������
  var_ename in varchar2,				
  var_loc in varchar2) is
begin
  insert into dept
  values(num_deptno,var_ename,var_loc);		--��dept���в����¼
  commit;								--�ύ���ݿ�
end insert_dept;


--����������ô洢���̣�
begin
	insert_dept(var_ename=>'�ɹ���',var_loc=>'�ɶ�',num_deptno=>'15')   --���������˳��͵���ʱ�����˳��һ��һ��
end;
--��ͬ��
begin
	insert_dept(28,'���̲�','����')   --������ֵ˳������붨��洢���̲���˳��һֱ
end 
--��ͬ��
exec insert_dept(28,var_loc=>'����',var_name=>'���Բ�')





--�����洢����
CREATE PROCEDURE remove_emp (employee_id NUMBER) AS
   tot_emps NUMBER;
   BEGIN
      DELETE FROM employees
      WHERE employees.employee_id = remove_emp.employee_id;
   tot_emps := tot_emps - 1;
 END;


