
--1) Which nation has participated in all of the olympic games

      WITH tot_games AS (
    SELECT COUNT(DISTINCT games) AS total_games
    FROM olympics_history
),
countries AS (
    SELECT games, nr.region AS country
    FROM olympics_history oh
    JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
    GROUP BY games, nr.region
),
countries_participated AS (
    SELECT country, COUNT(1) AS total_participated_games
    FROM countries
    GROUP BY country
)
SELECT cp.*
FROM countries_participated cp
JOIN tot_games tg ON tg.total_games = cp.total_participated_games
ORDER BY 1;



--2)Identify the sport which was played in all summer olympics.
     
	 WITH t1 AS (
    SELECT COUNT(DISTINCT games) AS total_games
    FROM olympics_history
    WHERE season = 'Summer'
),
t2 AS (
    SELECT DISTINCT games, sport
    FROM olympics_history
    WHERE season = 'Summer'
),
t3 AS (
    SELECT sport, COUNT(1) AS no_of_games
    FROM t2
    GROUP BY sport
)
SELECT *
FROM t3
JOIN t1 ON t1.total_games = t3.no_of_games;


--3)Top 5 athletes who have won the most gold medals.
   
 WITH t1 AS (
    SELECT name, team, COUNT(1) AS total_gold_medals
    FROM olympics_history
    WHERE medal = 'Gold'
    GROUP BY name, team
),
t2 AS (
    SELECT *, DENSE_RANK() OVER (ORDER BY total_gold_medals DESC) AS rnk
    FROM t1
)
SELECT name, team, total_gold_medals
FROM t2
WHERE rnk <= 5;


--4) List down total gold, silver and broze medals won by each country.

SELECT country
	, ISNULL([Gold], 0) AS gold
	, ISNULL([Silver], 0) AS silver
	, ISNULL([Bronze], 0) AS bronze
FROM (
	SELECT nr.region AS country
		, medal
		, COUNT(1) AS total_medals
	FROM olympics_history oh
	JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
	WHERE medal <> 'NA'
	GROUP BY nr.region, medal
) AS src
PIVOT (
	SUM(total_medals)
	FOR medal IN ([Bronze], [Gold], [Silver])
) AS piv
ORDER BY gold DESC, silver DESC, bronze DESC;

--5)Which countries have never won gold medal but have won silver/bronze medals?
WITH t1 AS
(
    SELECT
        DISTINCT Region,
        SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Gold,
        SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver,
        SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze
    FROM
        OLYMPICS_HISTORY O1
        INNER JOIN OLYMPICS_HISTORY_NOC_REGIONS O2 ON O1.NOC = O2.NOC
    GROUP BY
        Region
),
T2 AS
(
    SELECT *
    FROM t1
    WHERE Gold = 0 AND (Silver > 0 OR Bronze > 0)
)
SELECT
    Region,
    Gold,
    Silver,
    Bronze
FROM
    T2
ORDER BY
    Region;


--alternate solution 

SELECT *
FROM
(
    SELECT region, medal
    FROM OLYMPICS_HISTORY o
    JOIN OLYMPICS_HISTORY_NOC_REGIONS oh ON o.NOC = oh.NOC
    WHERE medal <> 'NA'
) t
PIVOT
(
    COUNT(medal) FOR Medal IN ([Gold], [Silver], [Bronze])
) AS Pivot_Table
WHERE [Gold] = 0 AND ([Silver] > 0 OR [Bronze] > 0)
ORDER BY region;




--6)In which Sport/event, India has won highest medals.

  WITH t1 AS (
    SELECT
        sport,
        COUNT(*) AS total_medals
    FROM
        olympics_history
    WHERE
        medal <> 'NA'
        AND team = 'India'
    GROUP BY
        sport
),
t2 AS (
    SELECT
        *,
        RANK() OVER (ORDER BY total_medals DESC) AS rnk
    FROM
        t1
)
SELECT
    sport,
    total_medals
FROM
    t2
WHERE
    rnk = 1;


--7)Break down all olympic games where india won medal for Hockey and how many medals in each olympic games

  SELECT team, sport, games, COUNT(1) AS total_medals
FROM olympics_history
WHERE medal <> 'NA'
      AND team = 'India'
      AND sport = 'Hockey'
GROUP BY team, sport, games
ORDER BY total_medals DESC;
