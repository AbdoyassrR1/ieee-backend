
-- what is constraints?
-- Constraints in SQL are rules applied to columns in a database table to enforce data integrity and ensure that 
-- the data entered into the table meets certain criteria. 
-- can be stored in a column, ensuring uniqueness, and defining relationships between tables.
-- Common types of constraints include:
1. NOT NULL:
    -- Ensures that a column cannot have a NULL value.
2. UNIQUE:
    -- Ensures that all values in a column are unique.
3. PRIMARY KEY:
    -- Uniquely identifies each record in a table and
    -- does not allow NULL values.
4. FOREIGN KEY: 
    -- Establishes a relationship between two tables by
    -- referencing the primary key of another table.
5. CHECK: 
    -- Ensures that all values in a column satisfy a specific condition.
6. DEFAULT: 
    -- Provides a default value for a column when no 
    -- value is specified during insertion.


-- Tables Creation syntax 
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
);






-- Different sizes of integers

CREATE TABLE integer_examples (
    -- TINYINT: Very small numbers (-128 to 127, or 0 to 255 unsigned)
    age TINYINT,                    -- Perfect for age (0-255)
    status_code TINYINT,            -- HTTP status codes, flags
    
    -- SMALLINT: Small numbers (-32,768 to 32,767)
    year SMALLINT,                  -- Year (2024, 2025, etc.)
    quantity SMALLINT,              -- Item quantities
    
    -- MEDIUMINT: Medium numbers (-8,388,608 to 8,388,607)
    views_count MEDIUMINT,          -- Article views, likes
    
    -- INT/INTEGER: Standard numbers (-2 billion to 2 billion)
    user_id INT,                    -- Most common for IDs
    population INT,                 -- City population
    
    -- BIGINT: Very large numbers (-9 quintillion to 9 quintillion)
    account_balance BIGINT,         -- Large financial amounts
    phone_number BIGINT             -- Phone numbers as integers
);

-- Real-world example: E-commerce Products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    stock_quantity SMALLINT DEFAULT 0,      -- Usually < 32,767 items
    total_sold MEDIUMINT DEFAULT 0,         -- Lifetime sales count
    views BIGINT DEFAULT 0,                 -- Can get very large
    rating TINYINT CHECK (rating >= 1 AND rating <= 5)  -- 1-5 stars
);

-- Sample data
INSERT INTO products (stock_quantity, total_sold, views, rating)
VALUES (150, 5420, 1500000, 5);









CREATE TABLE decimal_examples (
    -- DECIMAL(precision, scale) / NUMERIC - Exact values
    -- precision = total digits, scale = digits after decimal
    price DECIMAL(10, 2),           -- 99999999.99 (exact money)
    tax_rate DECIMAL(5, 4),         -- 0.0825 (8.25% tax)
    
    -- FLOAT - Approximate (7 decimal digits precision)
    temperature FLOAT,              -- 98.6, -15.3
    
    -- DOUBLE - Approximate (15 decimal digits precision)
    scientific_value DOUBLE,        -- Very precise measurements
    latitude DOUBLE,                -- GPS coordinates
    longitude DOUBLE
);

-- Real-world example: Financial Transactions
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(15, 2) NOT NULL,          -- $9,999,999,999,999.99 max
    tax_amount DECIMAL(10, 2),               -- Calculated tax
    commission_rate DECIMAL(5, 4),           -- 0.0350 = 3.5%
    exchange_rate DECIMAL(10, 6),            -- 1.234567 USD to EUR
);


-- Real-world example: Scientific Measurements
CREATE TABLE weather_data (
    reading_id INT PRIMARY KEY AUTO_INCREMENT,
    temperature FLOAT,                       -- 72.5°F
    humidity FLOAT,                          -- 65.3%
    pressure DOUBLE,                         -- 1013.25 hPa
    wind_speed DECIMAL(5, 2),               -- 15.75 mph

-- Sample data
INSERT INTO transactions (amount, tax_amount, commission_rate, exchange_rate)
VALUES (1599.99, 127.99, 0.0250, 0.850000);
);






CREATE TABLE string_examples (
    -- CHAR(n) - Fixed length, padded with spaces
    country_code CHAR(2),           -- 'US', 'UK', 'EG' (always 2 chars)
    state_code CHAR(2),             -- 'CA', 'NY'
    gender CHAR(1),                 -- 'M', 'F', 'O'
    
    -- VARCHAR(n) - Variable length (up to n characters)
    username VARCHAR(50),           -- Most common for names
    email VARCHAR(255),             -- Email addresses
    phone VARCHAR(20),              -- Phone with formatting
    
    -- TEXT types - For longer content
    bio TEXT,                       -- User biography
    article_content MEDIUMTEXT,     -- Blog posts
    book_text LONGTEXT             -- Entire books
);

-- Real-world example: User Profiles
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL UNIQUE,        -- Short usernames
    email VARCHAR(255) NOT NULL UNIQUE,          -- Standard email length
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country_code CHAR(2),                        -- ISO country codes
    zip_code VARCHAR(10),                        -- Can have letters (UK: SW1A 1AA)
    bio TEXT,                                    -- About me section
    profile_url VARCHAR(100),
);

-- Sample data
INSERT INTO users (username, email, first_name, last_name, country_code, zip_code, bio)
VALUES (
    'john_dev',
    'john@example.com',
    'John',
    'Doe',
    'US',
    '12345',
    'Software developer passionate about backend development and databases.'
);




-- CHAR is faster but wastes space
CREATE TABLE example1 (
    code CHAR(10)        -- Always uses 10 bytes
);
INSERT INTO example1 VALUES ('AB');  -- Stored as 'AB        ' (with spaces)

-- VARCHAR saves space
CREATE TABLE example2 (
    code VARCHAR(10)     -- Uses only what's needed + 1-2 bytes overhead
);









CREATE TABLE datetime_examples (
    -- DATE - Only date (YYYY-MM-DD)
    birth_date DATE,                -- 1990-05-15
    hire_date DATE,
    
    -- TIME - Only time (HH:MM:SS)
    store_opening TIME,             -- 09:00:00
    meeting_time TIME,              -- 14:30:00
    
    -- DATETIME - Date and time (YYYY-MM-DD HH:MM:SS)
    created_at DATETIME,            -- 2026-02-27 14:30:00
    updated_at DATETIME,
    
    -- TIMESTAMP - Date and time (auto-updates, timezone aware)
    last_login TIMESTAMP,           -- Automatically managed
    
    -- YEAR - Just year (YYYY)
    graduation_year YEAR            -- 2024
);

-- Real-world example: Employee Management
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    
    birth_date DATE NOT NULL,                    -- When they were born
    hire_date DATE NOT NULL,                     -- When they started
    
    shift_start TIME,                            -- 08:00:00
    shift_end TIME,                              -- 17:00:00
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    last_clock_in TIMESTAMP,
    
    graduation_year YEAR
);

-- Sample data
INSERT INTO employees (full_name, birth_date, hire_date, shift_start, shift_end, graduation_year)
VALUES (
    'Alice Johnson',
    '1995-08-20',
    '2024-01-15',
    '09:00:00',
    '18:00:00',
    2017
);

-- Real-world example: Event Management
CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(200) NOT NULL,
    
    event_date DATE NOT NULL,                    -- 2026-12-31
    start_time TIME NOT NULL,                    -- 19:00:00
    end_time TIME,                               -- 23:00:00
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    registration_deadline DATETIME,              -- 2026-12-20 23:59:59
    
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Working with dates
INSERT INTO events (event_name, event_date, start_time, end_time, registration_deadline)
VALUES (
    'New Year Party 2027',
    '2026-12-31',
    '19:00:00',
    '23:59:59',
    '2026-12-20 23:59:59'
);

-- Querying dates
SELECT * FROM events WHERE event_date > CURDATE();  -- Future events
SELECT * FROM events WHERE event_date = '2026-12-31';
SELECT * FROM employees WHERE YEAR(birth_date) = 1995;




-- DATETIME: Stores as-is, no timezone conversion
CREATE TABLE posts (
    created_at DATETIME  -- Stores: 2026-02-27 14:30:00 (exactly as entered)
);

-- TIMESTAMP: Converts to UTC, adjusts for timezone
CREATE TABLE sessions (
    last_activity TIMESTAMP  -- Stores in UTC, displays in your timezone
);

-- TIMESTAMP range: 1970-2038 (smaller range)
-- DATETIME range: 1000-9999 (larger range)

-- Use DATETIME for: Birth dates, historical dates, appointments
-- Use TIMESTAMP for: Created/updated times, server logs, session tracking




CREATE TABLE boolean_examples (
    -- BOOLEAN / BOOL (actually stored as TINYINT(1))
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOL DEFAULT FALSE,
    has_newsletter BOOLEAN,
    
    -- Alternative: TINYINT(1) explicitly
    is_admin TINYINT(1) DEFAULT 0,     -- 0 = false, 1 = true
    is_premium TINYINT(1)
);





-- ENUM - Choose ONE value from a list
-- SET - Choose MULTIPLE values from a list

CREATE TABLE enum_set_examples (
    -- ENUM: Only one value allowed
    size ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL'),
    priority ENUM('low', 'medium', 'high', 'urgent'),
    status ENUM('pending', 'processing', 'completed', 'cancelled'),
    
    -- SET: Multiple values allowed (stored as bitmask)
    permissions SET('read', 'write', 'delete', 'admin'),
    days_available SET('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')

);

-- Real-world example: Support Tickets
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    
    subject VARCHAR(200) NOT NULL,
    description TEXT,
    
    status ENUM('new', 'open', 'in_progress', 'resolved', 'closed') DEFAULT 'new',
    priority ENUM('low', 'normal', 'high', 'critical') DEFAULT 'normal',
    
    category ENUM('technical', 'billing', 'general', 'feature_request'),
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);




-- Quick reference table

/*
FOR THIS DATA              USE THIS TYPE              EXAMPLE
---------------------------------------------------------------------------
Whole numbers (small)      TINYINT                   Age, status codes
Whole numbers (medium)     INT                       IDs, counts
Whole numbers (large)      BIGINT                    View counts, phone numbers
Money/prices              DECIMAL(10,2)              $1,234.56
Percentages               DECIMAL(5,4)               0.0825 (8.25%)
Scientific values         DOUBLE                     3.14159265359
Short text                VARCHAR(50-255)            Names, emails
Long text                 TEXT                       Descriptions, comments
Very long text            MEDIUMTEXT/LONGTEXT        Articles, books
Fixed codes               CHAR(2-10)                 Country codes, zip
Just date                 DATE                       Birth date, due date
Just time                 TIME                       Store hours, meeting time
Date + time               DATETIME                   Created at, appointments
Auto-tracking             TIMESTAMP                  Last login, updated at
Yes/No                    BOOLEAN                    Is active, is verified
One choice                ENUM                       Status, priority
Multiple choices          SET                        Permissions, days
Flexible data             JSON                       Settings, metadata
Files (small)             BLOB                       Icons, thumbnails
*/





-- Create a students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT,
    grade DECIMAL(3, 2),
    enrollment_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- 1. CREATE (INSERT) - Adding Data

-- Basic INSERT Syntax

-- Insert a single row
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);

-- Example 1: Insert one student (all columns)
INSERT INTO students (first_name, last_name, email, age, grade, enrollment_date, is_active)
VALUES ('John', 'Doe', 'john.doe@email.com', 20, 3.75, '2024-09-01', TRUE);


-- Example 2: Insert without specifying all columns (using defaults)
INSERT INTO students (first_name, last_name, email, age)
VALUES ('Jane', 'Smith', 'jane.smith@email.com', 19);
-- student_id will auto-increment
-- grade will be NULL
-- enrollment_date will be NULL
-- is_active will default to TRUE


-- Example 3: Insert multiple rows at once (more efficient)
INSERT INTO students (first_name, last_name, email, age, grade, enrollment_date)
VALUES 
    ('Alice', 'Johnson', 'alice.j@email.com', 21, 3.90, '2024-09-01'),
    ('Bob', 'Williams', 'bob.w@email.com', 20, 3.50, '2024-09-01'),
    ('Charlie', 'Brown', 'charlie.b@email.com', 22, 3.25, '2024-09-01'),
    ('Diana', 'Davis', 'diana.d@email.com', 19, 3.80, '2024-09-01');


-- Example 4: Insert without specifying columns (must match order)
-- ⚠️ Not recommended - fragile if table structure changes
INSERT INTO students
VALUES (NULL, 'Eve', 'Martinez', 'eve.m@email.com', 20, 3.65, '2024-09-01', TRUE);
-- NULL for student_id because it's AUTO_INCREMENT



-- 2. READ (SELECT) - Querying Data

-- Basic SELECT Syntax

-- Select all columns from all rows
SELECT * FROM table_name;

-- Select specific columns
SELECT column1, column2 FROM table_name;

-- Select with conditions
SELECT * FROM table_name WHERE condition;


-- Example 1: Get ALL students
SELECT * FROM students;

-- Example 2: Get specific columns
SELECT first_name, last_name, email FROM students;

-- Example 3: Get students with a specific condition
SELECT * FROM students WHERE age = 20;

-- Example 4: Get students older than 20
SELECT * FROM students WHERE age > 20;

-- Example 5: Get students with grade above 3.5
SELECT first_name, last_name, grade 
FROM students 
WHERE grade > 3.5;

-- Example 6: Get students enrolled in 2024
SELECT * FROM students 
WHERE enrollment_date >= '2024-01-01' AND enrollment_date < '2025-01-01';


-- Using WHERE with Multiple Conditions
-- AND - Both conditions must be true
SELECT * FROM students 
WHERE age > 19 AND grade > 3.5;

-- OR - At least one condition must be true
SELECT * FROM students 
WHERE age > 21 OR grade > 3.8;

-- Combining AND/OR with parentheses
SELECT * FROM students 
WHERE (age > 20 OR grade > 3.8) AND is_active = TRUE;

-- NOT - Opposite condition
SELECT * FROM students 
WHERE NOT age = 20;  -- Same as: WHERE age != 20



-- Common WHERE Operators

-- Comparison operators
SELECT * FROM students WHERE age = 20;      -- Equal
SELECT * FROM students WHERE age != 20;     -- Not equal
SELECT * FROM students WHERE age <> 20;     -- Not equal (alternative)
SELECT * FROM students WHERE age > 20;      -- Greater than
SELECT * FROM students WHERE age >= 20;     -- Greater than or equal
SELECT * FROM students WHERE age < 20;      -- Less than
SELECT * FROM students WHERE age <= 20;     -- Less than or equal

-- BETWEEN - Range of values
SELECT * FROM students 
WHERE age BETWEEN 19 AND 21;  -- Includes 19 and 21

-- IN - Match any value in a list
SELECT * FROM students 
WHERE age IN (19, 20, 21);

-- NOT IN - Exclude values
SELECT * FROM students 
WHERE first_name NOT IN ('John', 'Jane');

-- LIKE - Pattern matching
SELECT * FROM students 
WHERE first_name LIKE 'J%';  -- Starts with J

SELECT * FROM students 
WHERE email LIKE '%@email.com';  -- Ends with @email.com

SELECT * FROM students 
WHERE first_name LIKE '%oh%';  -- Contains 'oh'

SELECT * FROM students 
WHERE first_name LIKE 'J___';  -- J followed by exactly 3 characters

-- IS NULL / IS NOT NULL
SELECT * FROM students WHERE grade IS NULL;
SELECT * FROM students WHERE grade IS NOT NULL;




-- Sorting Results (ORDER BY)

-- Sort by age (ascending - default)
SELECT * FROM students ORDER BY age;

-- Sort by age (descending)
SELECT * FROM students ORDER BY age DESC;

-- Sort by multiple columns
SELECT * FROM students 
ORDER BY grade DESC, age ASC;
-- First by grade (highest first), then by age (youngest first)

-- Sort by column position (not recommended)
SELECT first_name, last_name, grade FROM students 
ORDER BY 3 DESC;  -- Sort by 3rd column (grade)


-- Limiting Results (LIMIT)

-- Get first 5 students
SELECT * FROM students LIMIT 5;

-- Get top 3 students by grade
SELECT * FROM students 
ORDER BY grade DESC 
LIMIT 3;

-- Skip first 5, then get next 5 (pagination)
SELECT * FROM students 
LIMIT 5 OFFSET 5;

-- Alternative syntax (MySQL)
SELECT * FROM students 
LIMIT 5, 5;  -- LIMIT offset, count



-- Aliasing (AS)
-- Column aliases (rename columns in output)
SELECT 
    first_name AS 'First Name',
    last_name AS 'Last Name',
    grade AS GPA
FROM students;

-- Can omit AS keyword
SELECT 
    first_name 'First Name',
    last_name 'Last Name'
FROM students;

-- Table aliases (useful for joins later)
SELECT s.first_name, s.last_name
FROM students AS s;

-- Aggregate Functions

-- COUNT - Number of rows
SELECT COUNT(*) FROM students;  -- Total students
SELECT COUNT(*) AS total_students FROM students;

-- COUNT with condition
SELECT COUNT(*) FROM students WHERE age > 20;

-- COUNT non-null values
SELECT COUNT(grade) FROM students;  -- Only counts non-NULL grades

-- AVG - Average value
SELECT AVG(grade) AS average_grade FROM students;

-- SUM - Total
SELECT SUM(age) FROM students;

-- MAX - Maximum value
SELECT MAX(grade) FROM students;

-- MIN - Minimum value
SELECT MIN(age) FROM students;

-- Combining multiple aggregates
SELECT 
    COUNT(*) AS total_students,
    AVG(grade) AS avg_grade,
    MAX(grade) AS highest_grade,
    MIN(grade) AS lowest_grade
FROM students;




-- Grouping Data (GROUP BY)

-- Count students by age
SELECT age, COUNT(*) AS student_count
FROM students
GROUP BY age;

-- Average grade by age
SELECT age, AVG(grade) AS avg_grade
FROM students
WHERE grade IS NOT NULL
GROUP BY age;

-- Having clause (filter groups - like WHERE but for groups)
SELECT age, AVG(grade) AS avg_grade
FROM students
WHERE grade IS NOT NULL
GROUP BY age
HAVING AVG(grade) > 3.5;
-- HAVING filters AFTER grouping, WHERE filters BEFORE grouping


-- 3. UPDATE - Modifying Data

-- Basic UPDATE Syntax

UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;


-- ⚠️ IMPORTANT: Always use WHERE or you'll update ALL rows!

-- Example 1: Update one student's email
UPDATE students
SET email = 'john.newemail@email.com'
WHERE student_id = 1;

-- Example 2: Update multiple columns
UPDATE students
SET grade = 3.85, is_active = TRUE
WHERE student_id = 2;

-- Example 3: Update based on condition
UPDATE students
SET grade = grade + 0.1
WHERE grade < 3.0;  -- Give bonus to struggling students

-- Example 4: Update multiple rows
UPDATE students
SET enrollment_date = '2024-09-01'
WHERE enrollment_date IS NULL;

-- Example 5: Update with calculation
UPDATE students
SET age = age + 1
WHERE student_id IN (1, 2, 3);

-- Example 6: Update using another column
UPDATE students
SET email = LOWER(email);  -- Convert all emails to lowercase


-- Dangerous Updates (Without WHERE)
-- ⚠️ DANGER: This updates ALL rows!
UPDATE students
SET grade = 4.0;
-- Now every student has 4.0 grade!

-- ⚠️ DANGER: This sets everyone's age to 20
UPDATE students
SET age = 20;



-- 4. DELETE - Removing Data

-- Basic DELETE Syntax

DELETE FROM table_name
WHERE condition;

-- ⚠️ CRITICAL: Always use WHERE or you'll delete ALL rows!

-- Example 1: Delete one specific student
DELETE FROM students
WHERE student_id = 5;

-- Example 2: Delete based on condition
DELETE FROM students
WHERE is_active = FALSE;

-- Example 3: Delete multiple students
DELETE FROM students
WHERE age < 18;

-- Example 4: Delete with multiple conditions
DELETE FROM students
WHERE grade < 2.0 AND enrollment_date < '2024-01-01';

-- Example 5: Delete using IN
DELETE FROM students
WHERE student_id IN (10, 11, 12);

-- Example 6: Delete using subquery (advanced)
DELETE FROM students
WHERE grade < (SELECT AVG(grade) FROM students);
-- Deletes students below average grade