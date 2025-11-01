-- File: 620-NotBoringMovies.sql
--
-- Question: Not Boring Movies
--
-- Table: Cinema
-- +----------------+----------+-------------------------------------------+
-- | Column Name    | Type     | Description                               |
-- +----------------+----------+-------------------------------------------+
-- | id             | int      | Unique identifier for each movie          |
-- | movie          | varchar  | Name/title of the movie                   |
-- | description    | varchar  | Short summary or genre description        |
-- | rating         | float    | Rating score (2 decimal places, [0,10])   |
-- +----------------+----------+-------------------------------------------+
-- Primary Key: id
--
-- Task:
-- Report all movies that:
--   1. Have an odd-numbered ID.
--   2. Have a description that is not exactly 'boring'.
-- The result should be ordered by rating in descending order.
--
-- Example:
-- Input:
-- +----+------------+-------------+--------+
-- | id | movie      | description | rating |
-- +----+------------+-------------+--------+
-- | 1  | War        | great 3D    | 8.9    |
-- | 2  | Science    | fiction     | 8.5    |
-- | 3  | irish      | boring      | 6.2    |
-- | 4  | Ice song   | Fantacy     | 8.6    |
-- | 5  | House card | Interesting | 9.1    |
-- +----+------------+-------------+--------+
--
-- Output:
-- +----+------------+-------------+--------+
-- | id | movie      | description | rating |
-- +----+------------+-------------+--------+
-- | 5  | House card | Interesting | 9.1    |
-- | 1  | War        | great 3D    | 8.9    |
-- +----+------------+-------------+--------+
--
-- Explanation:
-- Odd-numbered IDs: 1, 3, 5.
-- Exclude movie 3 since its description is 'boring'.
-- Sort remaining by rating (descending).
--
-- Approach (Detailed):
-- 1. Filter movies whose `id` is odd: this can be checked using `id % 2 = 1`.
-- 2. Exclude movies whose `description` equals 'boring' using `description <> 'boring'`.
-- 3. Order the resulting rows by `rating` in descending order to show top-rated first.
-- 4. Select all columns as required by the output format.
-- 
-- This query is direct and efficient — it uses only simple filtering and sorting.
--
-- Solution:
SELECT 
    *
FROM 
    Cinema
WHERE 
    id % 2 = 1
    AND description <> 'boring'
ORDER BY 
    rating DESC;
