CREATE DATABASE library;
USE library;
CREATE TABLE Branch(Branch_no INT  PRIMARY KEY, Manager_ID INT, Branch_address VARCHAR(100),Contact_no INT);
INSERT INTO Branch VALUES (1,2023101,'Trivandrum',2601213) ;
INSERT INTO Branch VALUES (2,2023102,'Karamana',2601215) ;
INSERT INTO Branch VALUES (3,2023103,'Attingl',2621218) ;
INSERT INTO Branch VALUES (4,2023104,'Mamom',2621220) ;
INSERT INTO Branch VALUES (5,2023105,'Peroorkkada',2601256) ;
INSERT INTO Branch VALUES (6,2023106,'Poojappura',2601563) ;
INSERT INTO Branch VALUES (7,2023107,'Vizhinjam',2601452) ;
SELECT * FROM Branch;

CREATE TABLE EMPLOYEE(EMP_ID INT PRIMARY KEY,EMP_NAME VARCHAR(50),POSITION VARCHAR (50),SALARY DECIMAL);
INSERT INTO EMPLOYEE VALUES (2023106,'Akshai','Manager',25000.00);
INSERT INTO EMPLOYEE VALUES (2023107,'Renjini','PRO',24000.00);
INSERT INTO EMPLOYEE VALUES (2023108,'Shilpa','PRO',24000.00);
INSERT INTO EMPLOYEE VALUES (2023109,'Karuna','clerk',24000.00);
INSERT INTO EMPLOYEE VALUES (2023110,'Keerthi','clerk',15000.00);
INSERT INTO EMPLOYEE VALUES (2023111,'Asha','peon',10000.00);
INSERT INTO EMPLOYEE VALUES (2023112,'Arpana','Manager',620000.00);
SELECT * FROM EMPLOYEE;
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE,
    INDEX idx_Customer_Id (Customer_Id) );
INSERT INTO Customer VALUES(1,'Reshma','Sarovram','2020-3-25');
INSERT INTO Customer VALUES(2,'Rajam',' Mayooram','2021-8-23');
INSERT INTO Customer VALUES(3,'Remya','Nilav','2020-7-23');
INSERT INTO Customer VALUES(4,'Pooja','Kottarathil','2017-9-23');
INSERT INTO Customer VALUES(5,'Praveen','Thundthil','2021-3-27');
INSERT INTO Customer VALUES(6,'Rahul','Valiyaveedu','2022-10-10');
INSERT INTO Customer VALUES(7,'Renjith','Ushas','2019-12-12');

SELECT * FROM CUSTOMER;
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100));
    INSERT INTO Books(ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
    ('ISBN6', 'Indian History', 'Modern History', 12, 'yes', 'Entri', 'D C Books'),
('ISBN1', 'Aadujeevitham', 'Novel', 15, 'yes', 'Benyabil', 'Green Books '),
('ISBN2', 'Oru Sangeerthanam pole', 'Fiction Novel', 10, 'No', 'Perumpadavam Sreedharan', 'Sankeerthanam Publications'),
('ISBN3', 'Harry Porter', 'Fantasy', 20, 'yes', 'R. K Rowlling', 'Blooms berry'),
('ISBN4', 'Theruvinte Kadha', 'Novel', 10, 'No', 'S.K Pottakkad', 'D C Books'),
('ISBN5', 'Ramayana', 'Fantasy', 12, 'yes', 'Ezhuthachan', 'D C Books');

select * from Books;
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, 'Aadujeevitham', '2023-07-01', 'ISBN1'),
(2, 2, 'Sangeerthanam pole', '2023-06-01', 'ISBN2'),
(3, 3, 'Harry porter', '2023-05-01', 'ISBN3'),
(4, 4, 'Theruvinte kadha', '2023-04-01', 'ISBN4'),
(5, 5, 'Ramayana', '2023-05-01', 'ISBN5');

select * from IssueStatus;


-- Create the ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus(Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1, 'Aadujeeviitham', '2023-07-29', 'ISBN1'),
(2, 2, 'Oru Sangeerthanam pole', '2023-06-20', 'ISBN2'),
(3, 3, 'Harry Porter', '2023-07-20', 'ISBN3'),
(4, 4, 'Theruvinte Kadha', '2023-08-11', 'ISBN4'),
(5, 5, 'Ramayana', '2023-08-02', 'ISBN5');

-- 1 Retrieve the book title, category, and rental price of all available books.

SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'yes';

-- 2 List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

-- 3 Retrieve the book titles and the corresponding customers who have issued those books.

SELECT b.Book_title, c.Customer_name
FROM Books b
JOIN IssueStatus i ON b.ISBN = i.Isbn_book
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- 4. Display the total count of books in each category.

SELECT Category, COUNT(*) AS Total_count_of_books FROM Books GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT c.Customer_name
FROM Customer c
LEFT JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE c.Reg_date < '2022-01-01' AND i.Issue_Id IS NULL;

-- 7. Display the branch numbers and the total count of employees in each branch.

SELECT b.Branch_no, COUNT(*) AS Total_Employees
FROM Branch b
LEFT JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.

SELECT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE YEAR(i.Issue_date) = 2023 AND MONTH(i.Issue_date) = 6;

-- 9. Retrieve book_title from book table containing history.

SELECT Book_title
FROM Books
WHERE Category LIKE '%history%';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees

SELECT b.Branch_no, COUNT(e.Emp_Id) AS Employee_Count
FROM Branch b
LEFT JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no
HAVING Employee_Count > 5;
