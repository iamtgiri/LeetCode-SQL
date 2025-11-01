-- File: 1661-AverageTimeOfProcessPerMachine.sql
--
-- Question: Average Time of Process per Machine
--
-- Table: Activity
-- +----------------+---------+---------------------------------------------+
-- | Column Name    | Type    | Description                                 |
-- +----------------+---------+---------------------------------------------+
-- | machine_id     | int     | Unique ID of the machine                    |
-- | process_id     | int     | Unique ID of a process on that machine      |
-- | activity_type  | enum    | Either 'start' or 'end'                     |
-- | timestamp      | float   | Time (in seconds) for the activity          |
-- +----------------+---------+---------------------------------------------+
-- Primary Key: (machine_id, process_id, activity_type)
-- Notes:
--  - Each (machine_id, process_id) has exactly one 'start' and one 'end'.
--  - The 'start' timestamp always precedes the 'end' timestamp.
--
-- Task: Find the average processing time for each machine.
-- The processing time for each process = (end timestamp - start timestamp).
-- Round the final average time to 3 decimal places.
--
-- Example:
-- Input:
-- +------------+------------+---------------+-----------+
-- | machine_id | process_id | activity_type | timestamp |
-- +------------+------------+---------------+-----------+
-- | 0          | 0          | start         | 0.712     |
-- | 0          | 0          | end           | 1.520     |
-- | 0          | 1          | start         | 3.140     |
-- | 0          | 1          | end           | 4.120     |
-- | 1          | 0          | start         | 0.550     |
-- | 1          | 0          | end           | 1.550     |
-- | 1          | 1          | start         | 0.430     |
-- | 1          | 1          | end           | 1.420     |
-- | 2          | 0          | start         | 4.100     |
-- | 2          | 0          | end           | 4.512     |
-- | 2          | 1          | start         | 2.500     |
-- | 2          | 1          | end           | 5.000     |
-- +------------+------------+---------------+-----------+
--
-- Output:
-- +------------+-----------------+
-- | machine_id | processing_time |
-- +------------+-----------------+
-- | 0          | 0.894           |
-- | 1          | 0.995           |
-- | 2          | 1.456           |
-- +------------+-----------------+
--
-- Explanation:
-- Each machine has multiple processes. 
-- For each process, compute the time difference between 'end' and 'start'.
-- Then, find the average of these differences for each machine.
--
-- Approach (Detailed):
-- 1. Self-join the Activity table to pair each 'start' record with its corresponding 'end' record 
--    using both `machine_id` and `process_id`.
-- 2. Filter such that one side of the join represents 'start' and the other 'end'.
-- 3. Compute the duration for each process as (end.timestamp - start.timestamp).
-- 4. Group the results by machine_id to calculate the average processing time per machine.
-- 5. Use ROUND(…, 3) to format the result to three decimal places for consistency.
-- 
-- This approach ensures accuracy because:
--  - Each (machine_id, process_id) pair appears once in both 'start' and 'end'.
--  - The join condition guarantees correct matching.
--  - Averaging by machine_id directly yields the desired processing_time.
--
-- Solution:
SELECT
  a.machine_id,
  ROUND(AVG(b.timestamp - a.timestamp), 3) AS processing_time
FROM
  Activity a
  JOIN Activity b ON a.machine_id = b.machine_id
  AND a.process_id = b.process_id
WHERE
  a.activity_type = 'start'
  AND b.activity_type = 'end'
GROUP BY
  a.machine_id;