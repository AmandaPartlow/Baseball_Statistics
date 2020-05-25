### Nashville Software School Project - SQL Baseball Statistics Analysis

For this project, we used a database of dozens of relational tables created by [Sean Lahman](http://www.seanlahman.com/baseball-archive/statistics/). It was my task to answer the following two questions:  

* Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
* Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

First question:  

![First Question](/assets/Q3.png)  

For this question, I first selected what was asked for (first name, last name, and the sum of the player's salary over the course of their career.) I started with the "people" table, but had to join the "collegeplaying" table in order to find the school id of the school each player went to and joined the "schools" table in order to link the id to the school names. I used one last join to add on the "salaries" table in order to determine how much each player made. In order to filter out anyone who went somewhere other than Vanderbilt, I used ILIKE to search for schools that included "Vanderbilt" in their title. Originally I got a lot of null values in the salary category, so I filtered out those as well. I grouped by a concatenated "namefirst" + "namelast" to make sure I was getting each player only once. Finally, I sorted by salary in descending order as requested by the question.

Second question:  

![Second Question](/assets/Q8.png)  

This question was a bit trickier. After some troubleshooting, I decided to use a CTE to narrow down my table before working with it. I selected (attendance/games) in order to get the average attendance, teams, and parks from the "homegames" table and filtered by the year 2016 and only entries that had at ten games or more (however, I should have used >= instead of > in order to get entries that also included 10, since the question said "at least 10.") The last bit of the CTE groups by team, park, and avg_attend in that order and then orders them by team and avg_attend.

After creating the CTE, which I called "avg_attendance", I selected unique team names, parks, and average attendance from this CTE. I joined "teams" and "parks" using a left join because I was only interested in information that corresponded with the CTE, and any extra information the other tables provided would not be useful to me. The purpose of adding on the tables "teams" and "parks" was to turn the ID's referenced in the CTE into the corresponding names. I filtered out nulls and made sure the year was 2016 (although this step was probably not necessary because the CTE already filters for the year.) Finally I ordered average attendance by descending to get the top teams and parks. To be more thorough, I could have added a LIMIT 5 to just get the top 5. I did not get the bottom 5, although I could have simply by ordering by avg_attend ASC instead of DESC.
