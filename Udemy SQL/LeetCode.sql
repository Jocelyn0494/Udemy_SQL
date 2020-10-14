## 1. Second Highest Salary

#method1:

SELECT max(Salary) AS SecondHighestSalary
FROM Employee
Where Salary not in (SELECT MAX(Salary) from Employee)

#method2:

SELECT max(Salary) AS SecondHighestSalary
FROM Employee
Where Salary < (SELECT MAX(Salary) from Employee)

#method3:

SELECT DISTINCT
    Salary AS SecondHighestSalary
FROM
    Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1

## 2. Nth Highest Salary

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
 DECLARE M INT;
 SET M = N-1;
 RETURN(
 	SELECT DISTINCT Salary
 	FROM Employee
 	ORDER BY Salary DESC
 	LIMIT 1 OFFSET M
 	# LIMIT M, 1 (offset,COUNT)
 	);
 END

## 3. Rank Scores

#method 1:
SELECT Score,(SELECT COUNT(DISTINCT Score) FROM Scores WHERE Score >= s.Score ) Rank
FROM Scores s
ORDER BY Score desc

#method2:
SELECT Score,(SELECT COUNT(*) FROM Scores WHERE Score >= s.Score ) Rank
FROM Scores s
ORDER BY Score desc


##4. Consecutive Numbers

SELECT DISTINCT x.num as ConsecutiveNums
from 
(
select num,
LEAD(num,1) over (order by id) as nex_num,
LEAD(num,2) over (order by id) as next_next_num
from logs 
) x
where x.num = x.next_num
and x.num = x.next_next_num


Select DISTINCT Num AS ConsecutiveNums
FROM
    Logs l
WHERE
    Num = (SELECT Num FROM logs WHERE Id = l.Id - 1)
    And Num = (SELECT Num FROM logs WHERE Id = l.Id + 1)