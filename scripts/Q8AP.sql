/* Q8 Using the attendance figures from the homegames table, find the teams and parks 
which had the top 5 average attendance per game in 2016 (where average attendance is defined 
as total attendance divided by number of games). Only consider parks where there were at 
least 10 games played. Report the park name, team name, and average attendance. Repeat for the 
lowest 5 average attendance.*/

--First attempt. Failed. Couldn't get the averages to be specific to the park, and couldn't prevent
--parks from being replicated
/*SELECT DISTINCT teams.name AS team, teams.park AS park,
	(homegames.attendance/homegames.games) AS avg_attendance
FROM homegames
LEFT JOIN teams
ON homegames.team = teams.teamid
WHERE homegames.games > 10
AND homegames.year = '2016'
AND teams.park IS NOT NULL
ORDER BY avg_attendance DESC;*/

--Working on trying use a CTE to fix issues
WITH avg_attendance AS (SELECT (attendance/games) AS avg_attend, 
						team, park
						FROM homegames
						WHERE year = '2016'
						AND homegames.games > 10
						GROUP BY team, park, avg_attend
					   ORDER BY team, avg_attend)
/*attempting to rebuild SELECT (original is below) piece by piece to see where the error is.
looks like the problem is its not able to figure out what the team and park names are by linking
the teams table to the homegames table. These columns are showing NULL, so when IS NOT NULL is
added, there are no results.*/
/*SELECT DISTINCT teams.name AS team, teams.park AS park, avg_attend
FROM avg_attendance
LEFT JOIN teams
ON avg_attendance.team = teams.name
WHERE teams.park IS NOT NULL;*/

SELECT DISTINCT teams.name AS team, parks.park_name AS park, avg_attend
FROM avg_attendance
LEFT JOIN teams
ON avg_attendance.team = teams.teamid
LEFT JOIN parks
ON avg_attendance.park = parks.park
WHERE teams.park IS NOT NULL
AND teams.yearid = 2016
ORDER BY avg_attend DESC;
						
/*SELECT DISTINCT teams.name AS team, teams.park AS park, avg_attend
FROM avg_attendance
LEFT JOIN teams
ON avg_attendance.team = teams.name
LEFT JOIN homegames
ON teams.teamid = homegames.team
WHERE teams.park IS NOT NULL
ORDER BY avg_attend DESC;*/

