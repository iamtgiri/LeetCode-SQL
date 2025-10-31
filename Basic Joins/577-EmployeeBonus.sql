-- File: 577-EmployeeBonus.sql
--
-- Question: Employee Bonus
--
-- Table: Employee
-- +-------------+---------+----------------------------------------------+
-- | Column Name | Type    | Description                                  |
-- +-------------+---------+----------------------------------------------+
-- | empId       | int     | Unique identifier for each employee          |
-- | name        | varchar | Employee name                                |
-- | supervisor  | int     | empId of the employee's supervisor (nullable) |
-- | salary      | int     | Employee's salary                            |
-- +-------------+---------+----------------------------------------------+
-- Primary Key: empId
--
-- Table: Bonus
-- +-------------+------+----------------------------------------------+
-- | Column Name | Type | Description                                  |
-- +-------------+------+----------------------------------------------+
-- | empId       | int  | Foreign key referencing Employee(empId)      |
-- | bonus       | int  | Bonus amount for the employee                |
-- +-------------+------+----------------------------------------------+
-- Primary Key: empId
--
-- Task:
-- Report the name and bonus amount of each employee whose bonus is less than 1000.
-- Include employees who do not have a bonus record (their bonus should appear as NULL).
--
-- Example:
-- Input:
-- Employee table:
-- +-------+--------+------------+--------+
-- | empId | name   | supervisor | salary |
-- +-------+--------+------------+--------+
-- | 3     | Brad   | null       | 4000   |
-- | 1     | John   | 3          | 1000   |
-- | 2     | Dan    | 3          | 2000   |
-- | 4     | Thomas | 3          | 4000   |
-- +-------+--------+------------+--------+
-- Bonus table:
-- +-------+-------+
-- | empId | bonus |
-- +-------+-------+
-- | 2     | 500   |
-- | 4     | 2000  |
-- +-------+-------+
--
-- Output:
-- +------+-------+
-- | name | bonus |
-- +------+-------+
-- | Brad | null  |
-- | John | null  |
-- | Dan  | 500   |
-- +------+-------+
--
-- Explanation:
-- - Brad and John have no bonus records, so their bonus appears as NULL.
-- - Dan’s bonus is 500 (< 1000), so he is included.
-- - Thomas has a bonus of 2000 (≥ 1000), so he is excluded.
--
-- Approach (Detailed):
-- 1. Start with a LEFT JOIN between Employee and Bonus tables on empId.
--    This ensures every employee appears in the result, even if they have no bonus.
-- 2. Filter to include:
--      - Rows where bonus < 1000 (valid bonuses), or
--      - Rows where bonus IS NULL (employees without any bonus record).
-- 3. Select only the employee name and bonus for the final output.
-- 4. Since ordering isn’t required, the result can be returned in any order.
--
-- This approach keeps employees without bonuses while excluding high-bonus records.
--
-- Solution:
SELECT
    e.name,
    b.bonus
FROM
    Employee e
    LEFT JOIN Bonus b ON e.empId = b.empId
WHERE
    b.bonus < 1000
    OR b.bonus IS NULL;