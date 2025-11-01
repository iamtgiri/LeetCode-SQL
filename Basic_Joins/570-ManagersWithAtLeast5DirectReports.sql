-- File: 570-ManagersWithAtLeast5DirectReports.sql
--
-- Question: Managers with at Least 5 Direct Reports
--
-- Table: Employee
-- +-------------+---------+---------------------------------------------+
-- | Column Name | Type    | Description                                 |
-- +-------------+---------+---------------------------------------------+
-- | id          | int     | Unique identifier for each employee         |
-- | name        | varchar | Employee's name                             |
-- | department  | varchar | Department where the employee works         |
-- | managerId   | int     | ID of the employee’s direct manager         |
-- +-------------+---------+---------------------------------------------+
-- Primary Key: id
-- Notes:
--  - If managerId is NULL, the employee does not have a manager.
--  - No employee manages themselves.
--
-- Task:
-- Find all managers who have at least 5 direct reports (employees directly managed by them).
-- Return their names in any order.
--
-- Example:
-- Input:
-- +-----+-------+------------+-----------+
-- | id  | name  | department | managerId |
-- +-----+-------+------------+-----------+
-- | 101 | John  | A          | null      |
-- | 102 | Dan   | A          | 101       |
-- | 103 | James | A          | 101       |
-- | 104 | Amy   | A          | 101       |
-- | 105 | Anne  | A          | 101       |
-- | 106 | Ron   | B          | 101       |
-- +-----+-------+------------+-----------+
--
-- Output:
-- +------+
-- | name |
-- +------+
-- | John |
-- +------+
--
-- Explanation:
-- John (id=101) manages Dan, James, Amy, Anne, and Ron — 5 direct reports in total.
-- No other employee manages that many people.
--
-- Approach (Detailed):
-- 1. The Employee table contains both employees and their managers within the same structure.
-- 2. To find managers, we focus on the managerId column (which links employees to their managers).
-- 3. Group all employees by their managerId to count how many direct reports each manager has.
-- 4. Filter to keep only those managers with COUNT(managerId) >= 5.
-- 5. Join this filtered result with the Employee table again to get the corresponding manager names.
-- 6. Select only the manager's name for the final output.
--
-- This method efficiently leverages grouping and self-joins within a single table.
--
-- Solution:
SELECT
    e.name
FROM
    Employee e
    JOIN (
        SELECT
            managerId
        FROM
            Employee
        WHERE
            managerId IS NOT NULL
        GROUP BY
            managerId
        HAVING
            COUNT(managerId) >= 5
    ) m ON e.id = m.managerId;

-- Another approach using a self-join:
-- e1 represents employees.
-- e2 represents their managers.
-- You join on e1.managerId = e2.id to connect employees to their manager.
-- Group by manager (e1.managerId, e2.name) and count how many employees each has.
-- The HAVING COUNT(e1.id) >= 5 filter keeps only those with five or more direct reports.

SELECT e2.name
FROM Employee e1
     JOIN Employee e2
     ON e1.managerId = e2.id
GROUP BY
    e1.managerId, e2.name
HAVING
    COUNT(e1.id) >= 5;
-- Both SQL queries above will yield the names of managers with at least 5 direct reports.