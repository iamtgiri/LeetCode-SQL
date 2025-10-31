-- Question: Rising Temperature
--
-- Table: Weather
-- +---------------+---------+--------------------------------------------+
-- | Column Name   | Type    | Description                                |
-- +---------------+---------+--------------------------------------------+
-- | id            | int     | Unique identifier for each record          |
-- | recordDate    | date    | The date of the temperature record         |
-- | temperature   | int     | Recorded temperature on that date          |
-- +---------------+---------+--------------------------------------------+
-- Primary Key: id
-- Note: Each recordDate is unique (no duplicates).
--
-- Task: Find all record IDs where the temperature was higher than the previous day's temperature.
--
-- Example:
-- Input:
-- +----+------------+-------------+
-- | id | recordDate | temperature |
-- +----+------------+-------------+
-- | 1  | 2015-01-01 | 10          |
-- | 2  | 2015-01-02 | 25          |
-- | 3  | 2015-01-03 | 20          |
-- | 4  | 2015-01-04 | 30          |
-- +----+------------+-------------+
--
-- Output:
-- +----+
-- | id |
-- +----+
-- | 2  |
-- | 4  |
-- +----+
--
-- Explanation:
-- On 2015-01-02, temperature (25) > previous day (10).
-- On 2015-01-04, temperature (30) > previous day (20).
--
-- Approach:
-- 1. Perform a self-join on the Weather table, comparing each day to the previous day.
-- 2. Match rows where the difference between recordDate values is exactly 1 day.
-- 3. Select IDs where the temperature is greater than the previous day's temperature.
--
-- Solution:
SELECT w1.id
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;
