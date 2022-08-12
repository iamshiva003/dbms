-- 5. Consider the following database of student enrolment in courses and books adopted each
-- course.
-- STUDENT (regno: string, name: string, major: string, bdate: date)
-- COURSE (course: int, cname: string, dept: string)
-- ENROLL (#regno: string, course#: int, sem: int marks: int)
-- TEXT (book-ISBN: int, book-title: string, publisher: string, author: string)
-- BOOK_ADOPTION (course#: int, sem: int, book-ISBN#: int)
    -- i. Create the above tables by properly specifying the primary keys and the foreign keys.
    -- ii. Enter at least five tuples for each relation.
    -- iii. Demonstrate how you add a textbook to the database and make this book be adapted by some department.
    -- iv. Produce list of textbooks (include Course#, Book-ISBN, Book-title) in the alphabetical order for courses offered by the CS department that use more than two books.
    -- v. List any department that has its adopted books published by a specific publisher.

-- crating database
create database student_enrollment;

-- using database
use student_enrollment;

-- i. Create the above tables by properly specifying the primary keys and the foreign keys.
create table student(regno char(10) PRIMARY KEY, sname char(10), major char(10), bdate date);
create table course(course int PRIMARY KEY, cname char(10), dept char(10));
create table enroll(regno char(10) references student(regno), course int references course(course), sem int PRIMARY KEY, marks int);
create table text(book_isbn int PRIMARY KEY, book_title char(10), publisher char(10), author char(10));
create table book_adoption(course int references course(course), sem int, book_isbn int references text(book_isbn));

-- ii. Enter at least five tuples for each relation.
mysql> insert into student values
    ('cs001', 'vijay', 'computers', '1986-01-15'),
    ('cs002', 'neeta', 'computers', '1986-02-15'),
    ('cs003', 'vinod', 'networking', '1986-03-15'),
    ('cs004', 'harish', 'networking', '1986-04-15'),
    ('cs005', 'ankit', 'electronic', '1986-05-15');
insert into course values 
    (1, 'BCA', 'CS'),
    (2, 'bcom', 'commerce'),
    (3, 'be', 'CS'),
    (4, 'be', 'is'),
    (5, 'bsc', 'cs');
insert into enroll values
    ('cs001', 1, 2, 95),
    ('cs002', 2, 4, 95),
    ('cs003', 3, 5, 86),
    ('cs004', 4, 7, 92),
    ('cs005', 5, 6, 98);
insert into text values
    (111, 'c++', 'pearson', 'petrick'),
    (222, 'java', 'tata', 'robert'),
    (333, 'unix', 'tata', 'selena'),
    (444, 'c', 'pearson', 'john'),
    (555, 'jzee', 'tata', 'jame');
insert into book_adoption values
    (1, 2, 111),
    (2, 4, 222),
    (3, 5, 333),
    (4, 7, 444),
    (5, 6, 555);

-- displaying the values from the table 
select * from student;
select * from course;
select * from enroll;
select * from text;
select * from book_adoption;

-- iii. Demonstrate how you add a textbook to the database and make this book be adapted by some department.
insert into text values(666, 'ada', 'tata', 'tom');
insert into book_adoption values(5, 2, 666);
select * from text;
select * from book_adoption;

-- iv. Produce list of textbooks (include Course#, Book-ISBN, Book-title) in the alphabetical order for courses offered by the CS department that use more than two books.
select b.course, t.book_isbn, t.book_title from book_adoption b, text t, course c where c.course = b.course and c.dept = 'cs' and b.book_isbn = t.book_isbn and c.course in (select course from book_adoption group by course having count(*) >= 2) order by t.book_title;

-- v. List any department that has its adopted books published by a specific publisher.
select c.dept from course c, text t, book_adoption b where t.publisher = 'pearson' and c.course = b.course and b.book_isbn = t.book_isbn;



