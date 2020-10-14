/*Conditional Expressions and Operators*/

/*CASE*/

We can use the CASE statement to only execute SQL code when certain conditions are met. 
This is very similar to IF/ELSE statements in other programming languages.

/*general CASE*/
CASE 
  WHEN consition 1 THEN result1
  WHEN condition 2 THEN result2
  ELSE some_other_result
END 

SELECT a,
CASE WHEN a=1 THEN 'ONE'
CASE WHEN a=2 THEN 'two'
ELSE 'other' AS label
END
FROM test;

/*CASE expression*/
CASE expression
  WHEN value1 THEN result1
  WHEN value2 THEN result2
  ELSE some_other_result
END

SELECT a,
  CASE a 
    WHEN 1 THEN 'ONE'
    WHEN 2 THEN 'TWO'
    ELSE 'OTHER'
  END
FROM test

SELECT * FROM customer

SELECT customer_id,
CASE 
  WHEN (customer_id <= 100) THEN 'Premium'
  WHEN (customer_id BETWEEN 100 and 200) THEN 'Plus'
  ELSE 'Normal'
END AS customer_class
FROM customer

SELECT customer_id,
CASE customer_id
  WHEN 2 THEN 'Winner'
  WHEN 5 THEN 'Second Place'
  ELSE 'Normal'
END AS raffle_results
FROM customer

SELECT 
SUM(CASE rental_rate
  WHEN 0.99 THEN 1
  ELSE 0
END) AS number_of_bargins
FROM film
SUM(CASE rental_rate
  WHEN 2.99 THEN 1
  ELSE 0
END) AS regular
FROM film
SUM(CASE rental_rate
  WHEN 4.99 THEN 1
  ELSE 0
END) AS premium
FROM film



/*
We wnat to know and compare the various amounts of films we have per movie rating 
Use CASE and the dvdrental database to re-create this table
*/

SELECT 
SUM(
CASE rating
  WHEN 'PG' THEN 1 ELSE 0
  END
) AS pg,
SUM(
CASE rating
  WHEN 'R' THEN 1 ELSE 0
  END
) AS r,
SUM(
CASE ratin
  WHEN 'PG-13' THEN 1 ELSE 0
  END
) AS pg13

FROM film
/*COALESCE*/
The COALESCE function accepts an unlimited number of arguments. It returns the first argument
that is not null. if all arguments are null, the COALESCE function will return null.
/*example*/
SELECT COALESCE(1,2) ---> RETURN 1
SELCE COALESCE(NULL, 2, 3)---> RETURN 2

COALESCE(arg_1, arg_2, ...., arg_n)

TABLE OF Products 
------------------
Item   Price   Discount
A      100     20
B      300     null
C      200     10
--------------------
SELECT item, (price - COALESCE(discount, 0))
AS final FROM Table






/*NULLIF*/
The NULLIF function takes in 2 inputs and returns NULL if both are equal, otherwise it returns 
the first argument passed.

NULLIF(arg1, arg2)

NULLIF(10,10)--> Returns NULL
NULLIF(10,12)--> Returns 10

------------------------
Name    Department
Lauren  A
Vinton  A 
Claire  B 
------------------------

CREATE TABLE depts(
first_name VARCHAR(50),
department VARCHAR(50)
)

INSERT INTO depts(first_name, department )
VALUES 
('Vinton', 'A'),
('Lauren', 'A'),
('Claire', 'B');

SELECT(
SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END)/

NULLIF(SUM(CASE WHEN department = 'B' THEN 2 ELSE 0 END), 0)
)AS department_ratio
FROM depts

/*CAST*/
The CAST operator let you convert from one data type tp another 
/*Syntax for CAST function*/
SELECT CAST('5' AS INTEGER) AS new_int

/*PostgreSQL CAST operator*/
SELECT '5'::INTEGER


SELECT CAST(date AS TIMESTAMP)
FROM table 

SELECT CHAR_LENGTH( CAST(inventory_id AS VARCHAR) )FROM rental



/*Views*/
Often there are specific combinations of tables and conditions that your find yourself using quite often
for a project. Instead of having to perform the same query over and over again as a starting point,
you can create a VIEW to quickly see this query with a simpel call

CREATE VIEW customer_info AS 
SELECT first_name, last_name, address FROM customer
INNER JOIN address
ON customer.address_id = address.address_id

SELECT * FROM customer_info

CREATE OR REPLACE VIEW customer_info AS 
SELECT first_name, last_name, address, district FROM customer
INNER JOIN address
ON customer.address_id = address.address_id

SELECT * FROM customer_info 

/*drop a view*/

DROP VIEW IF EXISTS customer_info

ALTER VIEW customer_info RENAME to c_info


/*Import and Export Functionality*/

1. create Excel
  -- Download as csv file->simpleTable.csv
  -- get the path of file locatuin
2. create table in progreSQL 

CREATE TABLE Simple(
a INTEGER,
b INTEGER,
c INTEGER,
)

3.right click the table under "schema" -->Import/export
