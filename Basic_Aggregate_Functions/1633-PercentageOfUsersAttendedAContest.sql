-- File: 1633-PercentageOfUsersAttendedAContest.sql
--
-- Question: Percentage of Users Attended a Contest
--
-- Table: Users
-- +-------------+---------+---------------------------+
-- | Column Name | Type    | Description               |
-- +-------------+---------+---------------------------+
-- | user_id     | int     | Unique user identifier    |
-- | user_name   | varchar | Name of the user          |
-- +-------------+---------+---------------------------+
-- user_id is the primary key.
--
-- Table: Register
-- +-------------+---------+--------------------------------------------+
-- | Column Name | Type    | Description                                |
-- +-------------+---------+--------------------------------------------+
-- | contest_id  | int     | Contest identifier                         |
-- | user_id     | int     | ID of the user who registered for contest  |
-- +-------------+---------+--------------------------------------------+
-- (contest_id, user_id) is the primary key.
--
-- Task:
-- Find the percentage of total users who registered for each contest.
-- Round to two decimal places.
-- Order by percentage (descending), then contest_id (ascending).
--
-- Example:
-- Input:
-- Users:
-- +---------+-----------+
-- | user_id | user_name |
-- +---------+-----------+
-- | 6       | Alice     |
-- | 2       | Bob       |
-- | 7       | Alex      |
-- +---------+-----------+
-- Register:
-- +------------+---------+
-- | contest_id | user_id |
-- +------------+---------+
-- | 215        | 6       |
-- | 209        | 2       |
-- | 208        | 2       |
-- | 210        | 6       |
-- | 208        | 6       |
-- | 209        | 7       |
-- | 209        | 6       |
-- | 215        | 7       |
-- | 208        | 7       |
-- | 210        | 2       |
-- | 207        | 2       |
-- | 210        | 7       |
-- +------------+---------+
--
-- Output:
-- +------------+------------+
-- | contest_id | percentage |
-- +------------+------------+
-- | 208        | 100.00     |
-- | 209        | 100.00     |
-- | 210        | 100.00     |
-- | 215        | 66.67      |
-- | 207        | 33.33      |
-- +------------+------------+
--
-- Explanation:
-- Total users = 3
-- Contest 208: 3 registered → (3/3)*100 = 100.00
-- Contest 209: 3 registered → 100.00
-- Contest 210: 3 registered → 100.00
-- Contest 215: 2 registered → (2/3)*100 = 66.67
-- Contest 207: 1 registered → (1/3)*100 = 33.33
--
-- Approach:
-- 1. Get total number of users from `Users` table.
-- 2. Count unique users registered in each contest from `Register`.
-- 3. Divide that count by total users, multiply by 100 for percentage.
-- 4. Use `ROUND()` to two decimal places.
-- 5. Sort by percentage descending, and `contest_id` ascending to break ties.
--
-- Note:
-- - `COUNT(DISTINCT user_id)` ensures users counted once per contest.
-- - Works even if some contests have no registrations (though not required here).
--
-- Solution:
SELECT
    r.contest_id,
    ROUND(
        COUNT(DISTINCT r.user_id) * 100.0 / (
            SELECT
                COUNT(*)
            FROM
                Users
        ),
        2
    ) AS percentage
FROM
    Register r
GROUP BY
    r.contest_id
ORDER BY
    percentage DESC,
    r.contest_id ASC;