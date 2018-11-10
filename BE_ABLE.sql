--valueable resources

--****https://www.techonthenet.com/oracle/****


--SELECT CLAUSE 
select * from d ept;

select * from emp;

select empno,job,ename from emp;   
 
select dname,loc from dept;

select distinct job from emp;

--WHERE CLAUSE in Query

select * from emp where job='MANAGER';

-- return the employees whose commison is greater than their salary 

select * from emp where comm > sal;

--SYNONYM Create
create public synonym emp_table
for employees;

select * from emp_table;

--Rownum

select rownum,employees.* from employees;



-- return non manager, salary > 2500 , depnno=20

select * from emp where job != 'MANAGER' and sal > 2500 and deptno = 20;

--return the names of those employees that are not managers nor salesman and sal >=2000
select ename,sal,job from emp where (job != 'MANAGER' AND job !='SALESMAN') and sal  >=2000;
select ename,sal,job from emp where job not in('MANAGER','SALESMAN') and sal >=2000;

-- return names and hire dates of those employees that work in either dallas or chicago
select emp.ename,emp.hiredate,dept.loc from emp,dept where emp.deptno=dept.deptno and (loc = 'CHICAGO' OR loc ='DALLAS');
select emp.ename,emp.hiredate,dept.loc from emp,dept where emp.deptno=dept.deptno and loc in ('CHICAGO','DALLAS');

-- return those employees who has salaries between 950 and 1600 -- the range is inclusive
select * from emp
where sal between 950 and 1600;

-- return those employees who has salaries NOT between 950 and 1600 -- the range is inclusive
select * from emp
where sal not between 950 and 1600; 

-- Write a query that returns those employees that dont make any commision and jave a salary greater than 1100 but less than 5000. 
-- Exclude those employees that have a salary equal to 3000
select * from emp 
where (comm is null or comm = 0)
and (sal > 1100 and sal < 5000 and sal != 1500);
-- sal <> 3000; This will also work

--Return those employees that are salsman and that either makes 300 or greater than 1000 dollars in commision
select * from emp
where job = 'SALESMAN'
and (comm = 300 or comm  > 1000);

--Pipe Concatenation
select ename || ' makes ' || sal || '$ per month' AS "concatenated string"
from emp;

--Order by

select deptno,sal,ename from emp
order by deptno,sal,ename;

--below SQL will return all the rows
select * from emp
where 1=1;

--SINGLE ROW FUNCTIONS AND DUAL TABLE
select concat('my name is ',ename) AS name  from emp;
select upper('hello') from emp;
select lower(dname) from dept;
select upper(concat('hello ', ename)) from emp;

--DUAL table only contains a single record
--To test Single row functions
select upper('hello') from dual;
select lower('AJAY') from dual;
select * from dual;

select 'pizza' AS Food, 'fanta' AS drink,concat('Hello ','AJAY') as "This is a function"
from dual;


select concat(concat(lower(ename),upper(' is the name')),concat(' and their job is : ', job)) AS "single row function calls" from emp;

--Character Based SRF
select lower(job) from emp;

select upper(job) from emp;

select * from emp where upper(job) ='MANAGER';

select initcap('hello my name is ajay') as sentence from dual;

select length('hello my name is ajay') as sentence from dual;

select ename,length(ename) as length from emp;

select ename,length(ename) as length from emp where length(ename) = 6;

select substr('hello',2,3) from dual;

select lpad('hello',10,'&') from dual; --10 is the width of the data after padding is added

select rpad('hello',10,'&') from dual; --10 is the width of the data after padding is added

select ltrim ('hello','h') from dual;

select rtrim ('hellohhhhhhhhhhh','h') from dual;

-- NUMERIC and DATE based Signle row functions
select round(1000.437,2) from dual; -- used for rounding

select trunc(107.2) from dual;

select trunc(1000.4379876,2) from dual; --used for truncating

select sysdate from dual;

select systimestamp from dual;

select add_months(sysdate,5) from dual;
select add_months('28-10-18',5) from dual;

select months_between('29-10-2018','29-10-2019') from dual;
select months_between('29-10-2019','25-10-2018') from dual;
select days_between('29-10-2019','25-10-2018') from dual;

select trunc(systimestamp) from dual;
select trunc(systimestamp,'DAY') from dual;
select trunc(systimestamp,'MONTH') from dual;
select trunc(systimestamp,'YEAR') from dual;


-- return those employees whi have been hired in 1982 year
select ename,hiredate from emp
where trunc(hiredate,'YEAR')='01-01-1982';

select trunc(to_date('2018-11-03', 'yyyy-mm-dd') - sysdate) as days from dual;

--Conversions SRF and date formatting
select sysdate from dual;

select to_char(sysdate,'dd-mm-yyyy') from dual;

select to_char(sysdate,'mm/dd/yyyy') from dual;

select to_char(sysdate,'ddth "of" month,yyyy') from dual;

select to_char(sysdate,'ddth "of" month, year ') from dual;

select ename,sal,to_char(sal,'$99,999.99') AS salaries from emp;

select sysdate from dual;

select add_months(to_date('03/11/2018','dd/mm/yyyy'),2) AS string_to_date from dual;

select to_date('3 of november,2018','ddth "of" month,yyyy') AS string_to_date from dual;


select last_day(sysdate) from dual;
select last_day('03-11-2018') from dual;
select next_day(sysdate,'mon') AS NextMonday from dual;
select next_day('03-11-2018','mon') AS NextMonday from dual;


-- Concluding SRFs and NUll/NullIf Functions (NVL) functions

select ename,job,sal,NVL(comm,0) AS commision from emp;
select ename,job,sal,NVL(comm,'no data found') AS commision from emp;-- gives error- expected
select ename,job,sal,NVL(to_char(comm),'no data found') AS commision from emp;


--GROUPING FUNCTIONS MIN,MAX,AVG,COUNT etc
select * from emp;

select max(sal) AS "Max Salary" from emp;

select min(sal) AS "Min Salary" from emp;

select sum(sal) AS "Total of Salaries" from emp;

select max(sal) AS "Max Manager's salary" from emp where JOB='MANAGER';
  
select avg(sal) AS "Average Salary" from emp;

select count(ename) AS "Total Employees" from emp;
select count(comm) AS "Total Employees" from emp;
select count(hiredate) AS "Total Employees" from emp;
select count(*) AS "Total Employees" from emp;


select sum(sal) / count(*) AS computed_avg,avg(sal) AS native_avg from emp;

select sum(sal) AS sum,avg(sal) AS average, min(sal) AS min,max(sal) AS max,count(*) AS total_employees from emp;

--Find the average salaries per job title from emp table
--below is the crude way of doing it which is not recommended


select avg(sal) from emp where job='PRESIDENT';
select avg(sal) from emp where job='MANAGER';
select avg(sal) from emp where job='ANALYST';
select avg(sal) from emp where job='CLERK';
select avg(sal) from emp where job='SALESMAN';

-- Below is the correct way to action the above problem

select job from emp group by job;

select job,avg(sal) from emp group by job;

select job,count(job) from emp group by job;

select job,min(sal) from emp group by job;

select job,max(sal) from emp group by job;

select job,sum(sal) from emp group by job;

--No Group functions are allowed in the where clause, Only single row functions are allowed in the where clause

-- problem statement, find the job titles from emp table under which there are only 2 employees
-- below solution is invalid

select job,count(*)
from emp 
where count(*)=2
group by job;

--Below is the correct way of doing it
select job
from emp 
group by job
having count(*)=2;

--Below is the correct order of SQL syntaxes
/*
1) select job
2) from emp 
3) where ...
4) group by job
5) having count(*)=2;
6) order by ..
*/

--write a query to return those department numbers that have more than 3 employees working form them
select deptno
from emp
group by deptno
having count(deptno) >3;

-- 
select  job ,count(*)
from emp
group by job;

select  job,deptno ,count(*)
from emp
group by job,deptno;

--Multi table queries and joins

--Subqueries(Nested Queries)
select * from (select * from dept);

select * from emp where deptno = (select deptno from dept where loc = 'CHICAGO');

select * from emp where deptno in (select deptno from dept where loc in  ('CHICAGO','DALLAS'));

select job,ename,(select job from emp where ename='KING') from emp;

select job,ename,(select 'Hello There' from dual) from emp;

select job,ename,(select 'Hello There' from emp) from emp; --Gives error

select job,ename,(select * from dual) from emp;

--Joins
select ename as first_name,sal as salary,job as title 
from emp e,dept d
where e.deptno=d.deptno
and loc='DALLAS';


select ename as first_name,sal as salary,job as title 
from (select * from emp) e,(select * from dept) d
where e.deptno=d.deptno
and loc='DALLAS';

select ename as first_name,sal as salary,job as title 
from (select * from emp where job in('MANAGER','CLERK')) e,(select * from dept where loc = 'DALLAS') d
where e.deptno=d.deptno;


--Inner join
select * from emp
inner join dept 
on emp.deptno=dept.deptno;

select * from emp
left join dept 
on emp.deptno=dept.deptno; --returns all records from left table whether you find any record from right table or not

select * from emp
right join dept 
on emp.deptno=dept.deptno; --returns all records from right table whether you find any record from left table or not

--left join == left outer join
--right join == right outer join

select * from emp
full join dept 
on emp.deptno=dept.deptno;--returns all the records from both the table irrespective of whether you find the corresponding record in the other table or not

select * from (select * from emp where job='SALESMAN') e
full join (select * from dept) d
on e.deptno=d.deptno;

--use left outer join to produce the same result as above with order of columns intact
select empno, ename, job, mgr, hiredate, sal, comm, e.deptno, d.deptno,dname,loc 
from (select * from dept) d
left join (select * from emp where job='SALESMAN') e
on e.deptno=d.deptno;

select e.*,d.*
from (select * from dept) d
left join (select * from emp where job='SALESMAN') e
on e.deptno=d.deptno;



--Exists / Not Exists

select * from emp where exists (select * from dual);

select * from emp where exists (select * from dept);
-- above is the most inefficient query as for every row from outer select clause, it executes inner subquery

select * from emp
where exists (select * from emp where job='PROGRAMMER');

select * from emp
where exists (select * from emp where job='PROGRAMMER');

select * from emp
where not exists (select * from emp where job='PROGRAMMER');

--Correlated Subquery

--print out all departments from dept table that have atleast single employee working in them

select d.* from dept d where exists (select * from emp e where e.deptno=d.deptno);

--print out all departments from dept table that have no employee working in them

select d.* from dept d where not exists (select * from emp e where e.deptno=d.deptno);

--Creating your own tables and design considerations
--Primary key columns cannot have duplicate values and they cannot contains null
--
--  create table stores
--  (
--    store_id number not null,
--    city varchar(50)
--  );

--  note that above table ddl contains store_id with non null constraints but it is not a primary key
--  commit;

select * from stores;
-- Single row inserts

--insert into stores(store_id, city) values (1, 'San Francisco');
--insert into stores(store_id, city) values (2, 'New York');
--insert into stores(store_id, city) values (3, 'Chicago');
--commit;

-- Multiple row insert

select * from stores;

insert all 
into stores(store_id, city) values (4, 'Philadelphia')
into stores(store_id, city) values (5, 'Boston')
into stores(store_id, city) values (6, 'Seattle')
select * from dual;

commit;

--  select * from stores order by store_id;

-- stores table can contain duplicate store ids as store_id column is not contained as primary key

select store_id,count(*) from stores
group by store_id
order by 1;

--create table products with prouct_id as primary key
/*
create table products(
  product_id number,
  name varchar(50),
  product_cost number(5,2),
  product_retail number(5,2),
  product_type varchar(10),
  store_id number not null,
  
  constraint product_pk primary key (product_id)
)
*/

select * from products;

insert into products (product_id,name,product_cost,product_retail,product_type,store_id)
values(1001,'Colgate Toothpaste',2.25,5.47,'hygiene',2);
insert into products (product_id,name,product_cost,product_retail,product_type,store_id)
values(1002,'Colgate Toothpaste',2.25,5.47,'hygiene',2);
insert into products (product_id,name,product_cost,product_retail,product_type,store_id)
values(1003,'Colgate Toothpaste',1.75,4.81,'hygiene',3);
--commit;

insert all
  into products(product_id,name,product_cost,product_retail,product_type,store_id)
  values(1004,'T-Shirt',1.75,7.77,'Clothing',2)
  into products(product_id,name,product_cost,product_retail,product_type,store_id)
  values(1005,'T-Shirt',1.65,7.85,'Clothing',2)
  into products(product_id,name,product_cost,product_retail,product_type,store_id)
  values(1006,'T-Shirt',1.73,7.80,'Clothing',3)
  into products(product_id,name,product_cost,product_retail,product_type,store_id)
  values(1007,'Shorts',0.73,5.60,'Clothing',3)
  into products(product_id,name,product_cost,product_retail,product_type,store_id)
  values(1008,'Dress Shoes',17.85,87.67,'Clothing',2)
  into products(product_id,name,product_cost,product_retail,product_type,store_id)
  values(1009,'Garden Chair',12.01,27.87,'Home Garde',2)
  into products(product_id,name,product_cost,product_retail,product_type,store_id)
  values(1010,'Grass Fertilizer',3.20,8.70,'Home Garde',2)
select * from dual;


--commit;

select * from products;

describe products;

alter table products 
modify name varchar2(50) not null;

commit;

insert into products values(1011,'',3.20,8.70,'Home Garde',2);--gives error SQL Error: ORA-01400: cannot insert NULL into ("BE_ABLE"."PRODUCTS"."NAME")
 
describe products;
--you will find name is not null now

--also change PRODUCT_COST & PRODUCT_RETAIL to be non nullable

alter table products 
modify (product_retail number(5,2) not null,
        product_cost number(5,2) not null);
        
commit;

describe products;

--change name of the product#name to product#product_name

alter table products
  rename column name to product_name;
  
  
commit;

describe products;

--CREATE table with SELECT
describe emp;

create table employees as 
select empno,ename,job,hiredate,sal,comm from emp;

describe employees;

select * from employees;

alter table employees
  add store_id number;
  
commit;

describe employees;

select * from employees;

--Update existing data
update employees set store_id=3 
where lower(ename) in ('king','blake','clark');

select * from employees;

--Working with the database indexes
select * from employees where ename='KING';

--create inded on ename column
create index emp_name_idx
  on employees (ename);
  
describe employees;

select * from employees where ename='KING';

--create index on combination of name,hiredate and job
create index emp_name_job_hiredate
  on employees(ename,job,hiredate);
  
select * from employees where ename='SMITH' and job='CLERK' and hiredate='17-12-80';

--create index on job column
create index emp_job_idx
  on employees (job);
  
--drop index on job
drop index  emp_job_idx; 

-- drop index on name,job,hiredate
drop index emp_name_job_hiredate;

create index emp_name_job_hiredate_idx
  on employees(ename,job,hiredate)
  compute statistics;

alter index emp_name_idx
  rebuild compute statistics;
  
commit;

--Deleting duplicates from stores;
select * from stores order by store_id;

select store_id,city,count(*)
from stores
group by store_id,city 
order by store_id;


select rowid,store_id,city from stores;

select min(rowid) from stores;

--select minimum rowid from the group 
select min(rowid),store_id,city from stores
group by store_id,city
order by store_id;

--now delete all rowids records which does not falls into above query result. This will delete off all duplicate elements
delete from stores
where rowid not in (select min(rowid) from stores
group by store_id,city
);
commit;

select * from stores; --duplicates are deleted

alter table stores
add constraint store_id_pk primary key(store_id);

commit;

describe stores;

--store id not null and unique constraint is added to stores table
--now try inserting the duplicate reord it should give you an error of constraint violation

select * from stores;
insert into stores values(3,'Chicago');

--system tables

select * from all_tables;

select * from all_tables where owner ='BE_ABLE';

select * from all_tab_columns;

select * from all_objects;

select * from all_objects where object_type='TABLE';

select DISTINCT(object_type) from all_objects;

select * from all_objects where object_type='INDEX' and owner ='BE_ABLE';

--Views and the other objects

create view manager_v as
select * from employees where job = 'MANAGER';

commit;

select * from manager_v;

select * from all_objects where object_type='VIEW' and owner='BE_ABLE';

select * from user_objects;
select * from user_objects where object_type='VIEW';

select * from employees;

select * from stores;

--Get the employees who has maximum salary per store
select e1.* 
from employees e1
inner join (
select store_id,max(sal) AS sal
from employees 
group by store_id
) e2
on e1.store_id=e2.store_id
and e1.sal=e2.sal;

-- Create a view of above query

create view super_employees AS
(select e1.* 
from employees e1
inner join (
select store_id,max(sal) AS sal
from employees 
group by store_id
) e2
on e1.store_id=e2.store_id
and e1.sal=e2.sal);

commit;

select * from super_employees;

--UNION

select * from super_employees
union 
select * from employees;

--UNION ALL
select * from super_employees
union all
select * from employees;

--MINUS
select * from super_employees
minus 
select * from employees where job='SALESMAN';

