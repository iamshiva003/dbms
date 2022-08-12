-- 1. A ) Create the following relation for the student :
-- Student (regno : string , name : string, class :string, bdate: date, marks1:int, marks2:int, marks3:int)
--     i.Enter atleast five tuples of the above relation
--     ii.Demonstrate the usage of following clauses for the above relation
--         a. Where
--         c. Having
--         b. Order By
--         d. Group By
--     iii.Demonstrate the usage of following clauses for the above relation
--         a. Sum
--         c. Count
--         e. Between
--         b. Avg
--         d. Like
--         f. Max & Min
--     iv.Demonstrate the rollback and commit command for the above relation

-- creating DATABASE
create database studentinfo;

-- using DATABASE
use studentinfo;

-- creating table
create table student(regno varchar(10) PRIMARY KEY,name varchar(20),class varchar(20),bdate date,marks1 int,marks2 int, marks3 int);

-- i.Enter atleast five tuples of the above relation
insert into student values('CO1','Tony','BCA','2000-01-01',95,90,99);
insert into student values('CO2','Tom','B.Com','2000-02-02',90,92,92);
insert into student values('CO3','Jerry','B.Sc','2000-03-03',96,94,92);
insert into student values('CO4','Motu','BBA','2000-04-04',92,93,91);
insert into student values('CO5','Patlu','BCA','2000-05-05',92,96,94);

-- displaying the values from the table
select * from student;

-- ii.Demonstrate the usage of following clauses for the above relation
-- a. Where
select * from student where regno >= 'CO2';
-- b. Order By
select * from student ORDER BY name;
-- c. Having
select regno,name from student GROUP BY bdate HAVING regno >= 'CO3';
-- d. Group By
select regno,name from student GROUP BY name;

-- iii.Demonstrate the usage of following clauses for the above relation
-- a. Sum
select SUM(marks1) from student;
-- b. Avg
select AVG(marks2) from student;
-- c. Count
select count(*) from student;
-- d. Like
select *from student where name LIKE "T%";
select *from student where name LIKE "%T%";
-- e. Between
select * from student where regno BETWEEN 'CO1' and 'CO2';
-- f. Max & Min
select MIN(marks1) from student;
select MAX(marks1) from student;

-- iv.Demonstrate the rollback and commit command for the above relation
COMMIT;
SET AUTOCOMMIT = 0;
delete from student where name = 'Tony';
select * from student;
ROLLBACK;
select * from student;
