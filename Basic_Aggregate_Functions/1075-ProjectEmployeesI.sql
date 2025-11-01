-- File: 1075-ProjectEmployeesI.sql
--
-- Question: Project Employees I
--
-- Table: Project
-- +-------------+---------+-----------------------------+
-- | Column Name | Type    | Description                 |
-- +-------------+---------+-----------------------------+
-- | project_id  | int     | Unique project identifier   |
-- | employee_id | int     | ID of employee in project   |
-- +-------------+---------+-----------------------------+
-- (project_id, employee_id) is the primary key.
-- Each row indicates that an employee works on a given project.
--
-- Table: Employee
-- +------------------+---------+---------------------------+
-- | Column Name      | Type    | Description               |
-- +------------------+---------+---------------------------+
-- | employee_id      | int     | Unique employee identifier|
-- | name             | varchar | Name of employee          |
-- | experience_years | int     | Years of experience (non-null) |
-- +------------------+---------+---------------------------+
--
-- Task: Report the average experience (rounded to 2 decimals)
-- of employees working on each project.
--
-- Example:
-- Input:
-- Project table:
-- +-------------+-------------+
-- | project_id  | employee_id |
-- +-------------+-------------+
-- | 1           | 1           |
-- | 1           | 2           |
-- | 1           | 3           |
-- | 2           | 1           |
-- | 2           | 4           |
-- +-------------+-------------+
-- Employee table:
-- +-------------+--------+------------------+
-- | employee_id | name   | experience_years |
-- +-------------+--------+------------------+
-- | 1           | Khaled | 3                |
-- | 2           | Ali    | 2                |
-- | 3           | John   | 1                |
-- | 4           | Doe    | 2                |
-- +-------------+--------+------------------+
--
-- Output:
-- +-------------+---------------+
-- | project_id  | average_years |
-- +-------------+---------------+
-- | 1           | 2.00          |
-- | 2           | 2.50          |
-- +-------------+---------------+
--
-- Explanation:
-- Project 1 includes employees with 3, 2, and 1 years of experience → avg = 2.00
-- Project 2 includes employees with 3 and 2 years of experience → avg = 2.50
--
-- Approach:
-- 1. Join `Project` with `Employee` using `employee_id` to bring in experience data.
-- 2. Group by `project_id` since we need the average for each project.
-- 3. Use `AVG()` on `experience_years` to compute the mean value.
-- 4. Round the result to 2 decimal places for presentation.
-- 5. No filtering needed, as all employees and projects are relevant.
-- This is a straightforward aggregation problem involving a single join.
--
-- Solution:
SELECT
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM
    Project p
    JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY
    p.project_id;