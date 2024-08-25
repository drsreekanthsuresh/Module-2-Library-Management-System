create database library;
use library;
create table Branch(Branch_no INT PRIMARY KEY, Manager_ID INT, Branch_Address Varchar(50) not null, Contact_no int);
CREATE TABLE Employee (Emp_Id INT PRIMARY KEY, Emp_name VARCHAR(50) NOT NULL, Position VARCHAR(30), Salary DECIMAL(10, 2), Branch_no INT,
FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));
CREATE TABLE Books (ISBN VARCHAR(13) PRIMARY KEY, Book_title VARCHAR(100) NOT NULL, Category VARCHAR(50), Rental_Price DECIMAL(10, 2),Status_ ENUM('yes', 'no') NOT NULL,
 Author VARCHAR(100), Publisher VARCHAR(100));
CREATE TABLE Customer(Customer_Id INT PRIMARY KEY, Customer_name VARCHAR(100) NOT NULL, Customer_address VARCHAR(255), Reg_date DATE);
CREATE TABLE IssueStatus(Issue_Id INT PRIMARY KEY,Issued_cust INT,Issue_date DATE,ISBN_book VARCHAR(13),FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (ISBN_book) REFERENCES Books(ISBN));
CREATE TABLE ReturnStatus( Return_Id INT PRIMARY KEY,Return_cust Varchar (100), Return_book_name VARCHAR(100), Return_date DATE,ISBN_book2 VARCHAR(13),
    FOREIGN KEY (ISBN_book2) REFERENCES Books(ISBN));
    
Alter table Branch modify column Contact_no Varchar(50);

  -- Inserting Values--
  
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES (1, 101, '123 Main St, Thrissur', '123-456-7890'),(2, 102, '456 Elm St, Kochi', '123-456-7891');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES (1, 'Arun Nair', 'Manager', 60000, 1), (2, 'Deepa Menon', 'Assistant', 40000, 1),
(3, 'Ravi Kumar', 'Manager', 65000, 2),(4, 'Sita Devi', 'Clerk', 35000, 2);

Alter table books modify ISBN Varchar (25);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status_, Author, Publisher) VALUES
('978-93-5007-123-4', 'Wings of Fire', 'Autobiography', 150,'yes', 'A.P.J Abdul Kalam', 'University Press'),
('978-93-5007-124-1', 'Ikigai', 'Self-help', 200,'no', 'Héctor García', 'Penguin Books'),
('978-93-5007-125-8', 'Chemeen', 'Fiction', 100,'yes', 'K. K. Nair', 'DC Books'),
('978-93-5007-126-5', 'Khasakinte Ithihasam', 'Novel', 120,'no', 'O.V. Vijayan', 'DC Books'),
('978-93-5007-127-2', 'Three Mistakes of My Life', 'Fiction', 180, 'yes','Chetan Bhagat', 'Rupa Publications'),
('978-93-5007-128-9', '1728 Crime Story', 'Thriller', 220,'no', 'John Doe', 'HarperCollins'),
('978-93-5007-129-6', 'Ivory Throne', 'History', 250,'yes', 'Manu S. Pillai', 'Aleph Book Company');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES (1, 'Arun Nair', 'Kochi, Kerala', '2021-05-12'),
(2, 'Meera Pillai', 'Thiruvananthapuram, Kerala', '2020-11-25'), (3, 'Rajesh Kumar', 'Kozhikode, Kerala', '2022-03-30');

Alter table IssueStatus modify Isbn_book varchar (25);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issue_date, Isbn_book) VALUES (1, 1, '2023-06-10', '978-93-5007-123-4'), (2, 2, '2023-06-15', '978-93-5007-125-8'),
(3, 3, '2023-07-01', '978-93-5007-126-5');

Alter table ReturnStatus modify Isbn_book2 varchar (50);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES (1, 1, 'Wings of Fire', '2023-07-10', '978-93-5007-123-4'),
(2, 2, 'Chemeen', '2023-07-20', '978-93-5007-125-8');

Select*from Branch;
Select*from Employee;
Select*from Books;
Select*from Customer;
Select*from Issuestatus;
Select*from ReturnStatus;

-- Retrieve the book title, category, and rental price of all available books --

Select book_title,Category, rental_price from Books where Status_ = 'yes';

-- List the employee names and their respective salaries in descending order of salary --

Select Emp_name, Salary from Employee order by Salary desc;

-- Retrieve the book titles and  the corresponding customers who have issued those books --

SELECT b.Book_title, c.Customer_name FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- Display the total count of books in each category.- -

Select category, count(*) As total_count_of_books from books group by Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000 --

Select Emp_name, Position from Employee where salary > 50000;


-- List the customer names who registered before 2022-01-01 and have not issued any books yet --

SELECT c.Customer_name FROM Customer c LEFT JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE c.Reg_date < '2022-01-01' AND i.Issued_cust IS NULL;

-- Display the branch numbers and the total count of employees in each branch --

Select Branch_no,Count(*) from employee group by Branch_no;


-- Display the names of customers who have issued books in the month of June 2023 --
SELECT DISTINCT c.Customer_name FROM IssueStatus i
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;


-- Retrieve book_title from book table containing history --

Select Book_title from Books where Book_title like 'history';


-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees--

SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;


-- Retrieve the names of employees who manage branches and their respective branch addresses --

SELECT e.Emp_name, b.Branch_address FROM Employee e JOIN Branch b ON e.Branch_no = b.Branch_no WHERE e.Position = 'Manager';


-- Display the names of customers who have issued books with a rental price higher than Rs. 25 --

SELECT DISTINCT c.Customer_name FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE b.Rental_Price > 25;











