-- File: 1280-StudentsAndExaminations.sql
--
-- Question: Students and Examinations
--
-- Table: Students
-- +---------------+---------+---------------------------------------------+
-- | Column Name   | Type    | Description                                 |
-- +---------------+---------+---------------------------------------------+
-- | student_id    | int     | Unique ID for each student                  |
-- | student_name  | varchar | Name of the student                         |
-- +---------------+---------+---------------------------------------------+
-- Primary Key: student_id
--
-- Table: Subjects
-- +--------------+---------+---------------------------------------------+
-- | Column Name  | Type    | Description                                 |
-- +--------------+---------+---------------------------------------------+
-- | subject_name | varchar | Unique subject name                         |
-- +--------------+---------+---------------------------------------------+
-- Primary Key: subject_name
--
-- Table: Examinations
-- +--------------+---------+---------------------------------------------+
-- | Column Name  | Type    | Description                                 |
-- +--------------+---------+---------------------------------------------+
-- | student_id   | int     | ID of the student who attended the exam     |
-- | subject_name | varchar | Name of the subject attended                |
-- +--------------+---------+---------------------------------------------+
-- Note: No primary key. Duplicates allowed (a student can attend the same exam multiple times).
--
-- Task:
-- For each student and each subject, find how many times the student attended that subject’s exam.
-- Return all possible (student, subject) combinations, even if the count is 0.
-- Order the result by student_id and subject_name.
--
-- Example:
-- Input:
-- Students:
-- +------------+--------------+
-- | student_id | student_name |
-- +------------+--------------+
-- | 1          | Alice        |
-- | 2          | Bob          |
-- | 13         | John         |
-- | 6          | Alex         |
-- +------------+--------------+
--
-- Subjects:
-- +--------------+
-- | subject_name |
-- +--------------+
-- | Math         |
-- | Physics      |
-- | Programming  |
-- +--------------+
--
-- Examinations:
-- +------------+--------------+
-- | student_id | subject_name |
-- +------------+--------------+
-- | 1          | Math         |
-- | 1          | Physics      |
-- | 1          | Programming  |
-- | 2          | Programming  |
-- | 1          | Physics      |
-- | 1          | Math         |
-- | 13         | Math         |
-- | 13         | Programming  |
-- | 13         | Physics      |
-- | 2          | Math         |
-- | 1          | Math         |
-- +------------+--------------+
--
-- Output:
-- +------------+--------------+--------------+----------------+
-- | student_id | student_name | subject_name | attended_exams |
-- +------------+--------------+--------------+----------------+
-- | 1          | Alice        | Math         | 3              |
-- | 1          | Alice        | Physics      | 2              |
-- | 1          | Alice        | Programming  | 1              |
-- | 2          | Bob          | Math         | 1              |
-- | 2          | Bob          | Physics      | 0              |
-- | 2          | Bob          | Programming  | 1              |
-- | 6          | Alex         | Math         | 0              |
-- | 6          | Alex         | Physics      | 0              |
-- | 6          | Alex         | Programming  | 0              |
-- | 13         | John         | Math         | 1              |
-- | 13         | John         | Physics      | 1              |
-- | 13         | John         | Programming  | 1              |
-- +------------+--------------+--------------+----------------+
--
-- Explanation:
-- - Every student must be listed against every subject.
-- - Count the occurrences of (student_id, subject_name) pairs in Examinations.
-- - Use 0 where no record exists.
--
-- Approach (Detailed):
-- 1. Generate all possible combinations of students and subjects using a CROSS JOIN.
--    This ensures every student-subject pair exists in the result, even if there’s no record in Examinations.
-- 2. LEFT JOIN the result with Examinations to bring in attendance data.
--    If a student never attended a subject, Examinations will contribute NULL, which we handle with COUNT.
-- 3. Use COUNT(e.subject_name) to compute the number of times a student attended that subject.
--    COUNT automatically skips NULLs, giving 0 where no exam attendance exists.
-- 4. Group by student_id, student_name, and subject_name.
-- 5. Sort the final output by student_id and subject_name to meet the ordering requirement.
--
-- This ensures a complete and accurate view of each student's attendance record per subject.
--
-- Solution:
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM
    Students s
    CROSS JOIN Subjects sub
    LEFT JOIN Examinations e ON s.student_id = e.student_id
    AND sub.subject_name = e.subject_name
GROUP BY
    s.student_id,
    s.student_name,
    sub.subject_name
ORDER BY
    s.student_id,
    sub.subject_name;
    
-- The above SQL query generates all possible combinations of students and subjects using a CROSS JOIN.
-- It then LEFT JOINs with the Examinations table to count how many times each student attended each subject's exam.