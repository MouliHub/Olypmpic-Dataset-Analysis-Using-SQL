
# OLYMPIC HISTORY DATA EXPLORATION USING SQL

I have downloaded the Olympics history dataset from Kaggle and utilized Microsoft SQL Server Management Studio (SSMS) to explore the data by writing SQL queries, for the problem statements

* Which nation has participated in all of the olympic games
* Identify the sport which was played in all summer olympics
* Top 5 athletes who have won the most gold medals
* List down total gold, silver and broze medals won by each country.
* Which countries have never won gold medal but have won silver/bronze medals?
* In which Sport/event, India has won highest medals.
* Break down all olympic games where india won medal for Hockey and how many medals in each olympic games


The file olympics_history.csv contains 271116 rows and 15 columns. Each row corresponds to an individual athlete competing in an
individual Olympic event (olympics_history). The columns are:

1.	ID - Unique number for each athlete
2.	Name - Athlete's name
3.	Sex - M or F
4.	Age - Integer
5.	Height - In centimetre’s
6.	Weight - In kilograms
7.	Team - Team name
8.	NOC - National Olympic Committee 3-letter code
9.	Games - Year and season
10.	Year - Integer
11.	Season - Summer or Winter
12.	City - Host city
13.	Sport - Sport
14.	Event - Event
15.	Medal - Gold, Silver, Bronze, or NA


The file olympics_history_noc_regions contains 230 rows and 3 columns. The columns are:

1.	NOC (National Olympic Committee 3 letter code)
2.	Country name (matches with regions in map data("world"))
3.	Notes


