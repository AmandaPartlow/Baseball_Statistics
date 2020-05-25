/*Q3. Find all players in the database who played at Vanderbilt University. 
Create a list showing each player’s first and last names as well as the total 
salary they earned in the major leagues. Sort this list in descending order 
by the total salary earned. Which Vanderbilt player earned the most money in the majors?*/

--Tried this first. Yielded only 15 results when it should have yielded 24. Also, the salaries
--were different than in my second attempt. Don't know why on either front.
/*SELECT namefirst, namelast, SUM(salary)
FROM people
LEFT JOIN collegeplaying
ON people.playerid = collegeplaying.playerid
LEFT JOIN schools
ON schools.schoolid = collegeplaying.schoolid
LEFT JOIN salaries
ON people.playerid = salaries.playerid
WHERE schoolname ILIKE '%vanderbilt%'
AND salary IS NOT NULL
GROUP BY (concat(namefirst,namelast)), namefirst, namelast
ORDER BY SUM(salary) DESC;*/

--This method yields the correct number of players. Salary is different than in the first method.
--I think this one is probably the winner, but I want to understand what went wrong in the first
--one before I feel good about it.
/*SELECT DISTINCT CONCAT(namefirst, ' ', namelast) AS name, SUM(salary::text::money) AS salary
FROM collegeplaying
LEFT JOIN people
ON collegeplaying.playerid = people.playerid
LEFT JOIN salaries
ON collegeplaying.playerid = people.playerid
WHERE schoolid = 'vandy'
GROUP BY name
ORDER BY salary DESC;*/

--This is how I determined how many players came from Vanderbilt.
/*SELECT COUNT(DISTINCT collegeplaying.playerid)
FROM collegeplaying
WHERE collegeplaying.schoolid = 'vandy';*/
