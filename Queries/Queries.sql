

--------------------   Making the data types same for all the columns same in all the databases   --------------------

-- July_2020
ALTER TABLE [Portfolio Project - Google Case Study]..July_2020
ALTER COLUMN end_station_id nvarchar(255);
 
ALTER TABLE [Portfolio Project - Google Case Study]..July_2020
ALTER COLUMN start_station_id nvarchar(255);

-- August_2020
ALTER TABLE [Portfolio Project - Google Case Study]..August_2020
ALTER COLUMN end_station_id nvarchar(255);
 
ALTER TABLE [Portfolio Project - Google Case Study]..August_2020
ALTER COLUMN start_station_id nvarchar(255);

-- September_2020
ALTER TABLE [Portfolio Project - Google Case Study]..September_2020
ALTER COLUMN end_station_id nvarchar(255);
 
ALTER TABLE [Portfolio Project - Google Case Study]..September_2020
ALTER COLUMN start_station_id nvarchar(255);

-- October_2020
ALTER TABLE [Portfolio Project - Google Case Study]..October_2020
ALTER COLUMN end_station_id nvarchar(255);
 
ALTER TABLE [Portfolio Project - Google Case Study]..October_2020
ALTER COLUMN start_station_id nvarchar(255);

-- November_2020
ALTER TABLE [Portfolio Project - Google Case Study]..November_2020
ALTER COLUMN end_station_id nvarchar(255);
 
ALTER TABLE [Portfolio Project - Google Case Study]..November_2020
ALTER COLUMN start_station_id nvarchar(255);

-- December_2020
ALTER TABLE [Portfolio Project - Google Case Study]..December_2020
ALTER COLUMN start_station_id nvarchar(255);

-- January_2021
ALTER TABLE [Portfolio Project - Google Case Study]..January_2021
ALTER COLUMN start_station_id nvarchar(255);

-- February_2021
ALTER TABLE [Portfolio Project - Google Case Study]..February_2021
ALTER COLUMN start_station_id nvarchar(255);

-- March_2021
ALTER TABLE [Portfolio Project - Google Case Study]..March_2021
ALTER COLUMN start_station_id nvarchar(255);

-- April_2021
ALTER TABLE [Portfolio Project - Google Case Study]..April_2021
ALTER COLUMN end_station_id nvarchar(255);





--------------------   Combining all the data using UNION and INSERTING them into a table. UNION adds rows when dataset have same set of columns.   --------------------

DELETE FROM [Portfolio Project - Google Case Study]..All_Months_Combined;


INSERT INTO [Portfolio Project - Google Case Study]..All_Months_Combined

SELECT *
FROM [Portfolio Project - Google Case Study]..July_2020
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..August_2020
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..September_2020
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..October_2020
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..November_2020
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..December_2020
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..January_2021
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..February_2021
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..March_2021
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..April_2021
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..May_2021
UNION
SELECT *
FROM [Portfolio Project - Google Case Study]..June_2021



--------------------  Analyzing the data  --------------------

-- Getting ride_length in duration format
Alter table [Portfolio Project - Google Case Study]..All_Months_Combined Alter column ride_length time(0)


-- Count of rides by each bike type
SELECT DISTINCT rideable_type, COUNT(rideable_type) AS count_of_type
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY rideable_type


-- Count of rides by each bike type
SELECT rideable_type, member_casual, COUNT(rideable_type) AS count_of_type
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY rideable_type, member_casual
ORDER BY rideable_type, member_casual


-- Count of rider types
SELECT member_casual, COUNT(member_casual) AS count_rider_types
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY member_casual


-- Mean ride length
SELECT CAST(DATEADD( ms,AVG(CAST(DATEDIFF( ms, '00:00:00', ISNULL(ride_length, '00:00:00')) as bigint)), '00:00:00' )  as TIME(0)) as 'avg_time'
FROM [Portfolio Project - Google Case Study]..All_Months_Combined


-- Mean ride length by customer type 
SELECT member_casual, CAST(DATEADD( ms,AVG(CAST(DATEDIFF( ms, '00:00:00', ISNULL(ride_length, '00:00:00')) as bigint)), '00:00:00' )  as TIME(0)) as 'avg_time'
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY member_casual


-- Changing the datatype of day_of_week
ALTER TABLE [Portfolio Project - Google Case Study]..All_Months_Combined
ALTER COLUMN day_of_week int;
 

-- Mean ride length per day
SELECT DATENAME(dw, day_of_week) as Day, CAST(DATEADD( ms,AVG(CAST(DATEDIFF( ms, '00:00:00', ISNULL(ride_length, '00:00:00')) as bigint)), '00:00:00' )  as TIME(0)) as 'avg_time'
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY day_of_week
ORDER BY avg_time DESC


-- Mode of day of week
SELECT DISTINCT Datename(dw, day_of_week) as Day, COUNT(*) as mode
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY day_of_week
ORDER BY mode DESC


-- Daily Count of Casual users
SELECT DISTINCT DATENAME(dw, day_of_week) as Day, COUNT(day_of_week) AS daily_casual_rides_count
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
WHERE member_casual = 'casual'
GROUP BY day_of_week
ORDER BY daily_casual_rides_count DESC 


-- Daily Count of member users
SELECT DISTINCT DATENAME(dw, day_of_week) as Day, COUNT(day_of_week) AS daily_member_rides_count
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
WHERE member_casual = 'member'
GROUP BY day_of_week
ORDER BY daily_member_rides_count DESC 


-- Monthly Count of Casual users
SELECT DISTINCT DATENAME(mm, started_at) as Month, COUNT(started_at) AS monthly_casual_rides_count
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
WHERE member_casual = 'casual'
GROUP BY DATENAME(mm, started_at)
ORDER BY monthly_casual_rides_count DESC 


-- Monthly Count of member users
SELECT DISTINCT DATENAME(mm, started_at) as Month, COUNT(started_at) AS monthly_member_rides_count
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
WHERE member_casual = 'member'
GROUP BY DATENAME(mm, started_at)
ORDER BY monthly_member_rides_count DESC 


-- Total Monthly rides
SELECT DISTINCT DATENAME(mm, started_at) as Month, COUNT(started_at) AS monthly_rides_count
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY DATENAME(mm, started_at)
ORDER BY monthly_rides_count DESC 


-- No of Riders by season
SELECT DATENAME(mm, started_at) AS Month, COUNT(started_at) AS number_of_rides, member_casual, (Case
    WHEN DATENAME(mm, started_at) like 'January' or
	DATENAME(mm, started_at) like 'February' or
	DATENAME(mm, started_at) like 'December' THEN 'Winter'
    WHEN DATENAME(mm, started_at) like 'March' or
	DATENAME(mm, started_at) like 'April' or 
	DATENAME(mm, started_at) like 'May' THEN 'Spring'
	WHEN DATENAME(mm, started_at) like 'June' or
	DATENAME(mm,started_at) like 'July' or 
	DATENAME(mm,started_at) like 'August' THEN 'Summer'
	WHEN DATENAME(mm,started_at) like 'September' or
	DATENAME(mm,started_at) like 'October' or 
	DATENAME(mm,started_at) like 'November' THEN 'Autumn'
END) AS season
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY DATENAME(mm, started_at), member_casual, (Case
    WHEN DATENAME(mm, started_at) like 'January' or
	DATENAME(mm, started_at) like 'February' or
	DATENAME(mm, started_at) like 'December' THEN 'Winter'
    WHEN DATENAME(mm, started_at) like 'March' or
	DATENAME(mm, started_at) like 'April' or 
	DATENAME(mm, started_at) like 'May' THEN 'Spring'
	WHEN DATENAME(mm, started_at) like 'June' or
	DATENAME(mm,started_at) like 'July' or 
	DATENAME(mm,started_at) like 'August' THEN 'Summer'
	WHEN DATENAME(mm,started_at) like 'September' or
	DATENAME(mm,started_at) like 'October' or 
	DATENAME(mm,started_at) like 'November' THEN 'Autumn'
END)
ORDER BY season


-- Riders by weekday and weekend
SELECT DATENAME(dw, day_of_week) as Day, Count(day_of_week) as number_of_rides, (CASE
	WHEN DATENAME(dw, day_of_week) = 'Saturday' or DATENAME(dw, day_of_week) = 'Sunday' THEN 'Weekend'
	ELSE 'Weekday' END) AS Weekday_or_Weekend
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY day_of_week, (CASE
	WHEN DATENAME(dw, day_of_week) = 'Saturday' or DATENAME(dw, day_of_week) = 'Sunday' THEN 'Weekend'
	ELSE 'Weekday' END)
ORDER BY number_of_rides DESC


-- Riders in different times of the day
SELECT DATENAME(dw, day_of_week) as Day, COUNT(day_of_week) as number_of_rides, (CASE
	WHEN CAST(started_at AS TIME(0)) >= '06:00:00' and CAST(started_at AS TIME(0)) < '12:00:00' THEN 'Morning'
	WHEN CAST(started_at AS TIME(0)) >= '12:00:00' and CAST(started_at AS TIME(0)) < '16:00:00' THEN 'Afternoon'
	WHEN CAST(started_at AS TIME(0)) >= '16:00:00' and CAST(started_at AS TIME(0)) < '20:00:00' THEN 'Evening'
	Else 'Night'
	end) as time_of_day
FROM [Portfolio Project - Google Case Study]..All_Months_Combined
GROUP BY (CASE
	WHEN CAST(started_at AS TIME(0)) >= '06:00:00' and CAST(started_at AS TIME(0)) < '12:00:00' THEN 'Morning'
	WHEN CAST(started_at AS TIME(0)) >= '12:00:00' and CAST(started_at AS TIME(0)) < '16:00:00' THEN 'Afternoon'
	WHEN CAST(started_at AS TIME(0)) >= '16:00:00' and CAST(started_at AS TIME(0)) < '20:00:00' THEN 'Evening'
	ELSE 'Night'
	END), day_of_week
ORDER BY time_of_day, number_of_rides DESC
