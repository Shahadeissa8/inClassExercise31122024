create database SQLFinal
go
create schema TheSchema
go
create table Theschema.Student --creating the student table Q1
(
StudentID int primary key identity (1,1),
StudentName nvarchar(50),
Age int,
Email nvarchar (70)
)

go

create table Theschema.Courses --creating courses table Q1
(
CourseID int primary key identity (1,1),
CourseName nvarchar (40),
StuID int
)

drop table Theschema.Courses
drop table TheSchema.Student

--note:primary keys set on the objectt explorer (wizard)

insert into Theschema.Student--insering values to the table Q2
values 
('Shahad Eissa', 26,'shahad@gmail.com'),
('Ahmad Bader', 28, 'ahmad@hotmail.com'),
('Khalid Nasser', 30, 'Khalid@gmail.com')

insert into Theschema.Courses--insering values to the table Q3
values
('Science',1),
('physics',1),
('maths',2),
('philosophy',3),
('biology',3)

/*
The relationship between tables should be:
-every course hasa one student
-every student has many courses
*/
select * --showing the view to show all the values Q4
from TheSchema.VStudentCourse

--Updating student email Q5
update Theschema.Student
set Email ='shahad123@gmail.com'
from Theschema.Student
where Email = 'shahad@gmail.com'
select *
from Theschema.Student

select *--test
from theschema.VStudentCourse


delete --deleting course from a student Q6
from TheSchema.Courses 
where stuid = 2
select *--checking
from TheSchema.Courses


select *--test
from theschema.VStudentCourse


alter table Theschema.Student --adding a new column to the student table
add gender nvarchar(4)
select * --checking
from TheSchema.Student

EXEC sp_refreshview 'Theschema.VStudentCourse'; --i refreshed the view,
--because without doing this step the data inside the view is wrong, 
--as in it doesnt show the gender column 

select *--test
from theschema.VStudentCourse

--updating the column to havde different values based on the student gender Q8
update TheSchema.Student
set gender =('F')
where StudentID =1
--updating the column to havde different values based on the student gender Q8
update TheSchema.Student
set gender = ('M')
where StudentID =2
--updating the column to havde different values based on the student gender Q8
update TheSchema.Student
set gender=('M')
where StudentID=3

select * --checking
from TheSchema.Student
select *--checking on view just in case
from theschema.VStudentCourse


select studentid, count (courseid) --retreiving count of courses each studentt enrolled in Q9
from TheSchema.VStudentCourse
group by studentid -- we used this because we wont get a result without grouping, 
--as the aggregtion functions return 1 value, however if we want it to return more
--(like in our case for each student) we have to use group by

--adding this to retreive later as my data doesnt have a student that starts with letter M
insert into Theschema.Student
values
('Manal', 29,'Manal@gmail.com','M')

select * --checking
from TheSchema.student

select * --selecting student with letter m Q10
from TheSchema.student 
where studentname like 'M%'

select upper(studentname) --retreiving alll student with upper case names Q11
from TheSchema.student

select lower(studentname) --retreiving alll student with upper case names Q12
from TheSchema.student

select c.coursename, s.* -- Retrieve courses(all of them as it didnt specify), that with student details Q15
from TheSchema.Courses  as c , theschema.student as s

insert into theschema.student--adding a student, enroll in 2 courses Q16
values
('Shouq', 22,'Shouq@gmail.com','M')
/* --i inserted this by mistake:
insert into TheSchema.Courses  
values
('Geology', 4)
--as i forgot that i created a student manal with id number 4,
--so i decided to delete it:
delete 
from TheSchema.courses
where courseid = 6
*/
insert into TheSchema.Courses --adding a student, enroll in 2 courses Q16
values
('Science',5),
('Geology', 5)

select *--checking
from theSchema.Student 
select *--checking
from theSchema.Courses 
select *--checking
from TheSchema.VStudentCourse

select top 1 studentname as 'youngest student name is:', age as 'students age is:'--find the youngest student Q17
from theSchema.Student 
order by age asc

delete --deleting student and all their assosiated courses Q18
from TheSchema.student
where StudentID = 3
delete
from TheSchema.courses
where stuid = 3

select *--checking
from theSchema.Student 
select *--checking
from theSchema.Courses 

select coursename --retrieving in alphabatical order Q20
from TheSchema.courses
order by coursename 

create proc theschema.sp_findByCourseName as --create procedure for all student with courses name Q21 
(
select s.studentname,  c.coursename
from TheSchema.student as s , TheSchema.courses as c
)
exec theschema.sp_findByCourseName

create proc theschema.sp_findBystuCourStuID2 as --creating a procedure to display all students with their courses by student id Q22
(select s.studentid, c.coursename, c.stuid
from TheSchema.student as s , TheSchema.courses as c
where studentid = stuid
)
exec theschema.sp_findBystuCourStuID2

--students enrolled in more than 1 course (Bonus):
select s.*,c.*
from TheSchema.student as s join TheSchema.courses as c
on s.studentid = c.stuid
order by studentname 

--(Bonus):
create table Theschema.enrollement 
(
CoursesId int,
studentsId int
)
insert into Theschema.enrollement
values
(1,1),
(2,1),
(6,4),
(7,4),
(2,5),
(1,5),
(7,4)

select *
from Theschema.enrollement

drop table Theschema.enrollement

select *
from theschema.VEnrollStuCourses