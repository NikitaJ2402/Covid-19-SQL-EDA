Create database CV;
use CV;
select * from coronavirus;

#code to check NULL values
SELECT *
FROM coronavirus
WHERE Province IS NULL OR Latitude IS NULL OR Longitude IS NULL OR 
Date IS NULL OR Confirmed IS NULL OR Deaths IS NULL OR Recovered IS NULL;
# NO null values Identified

#Checking total number of rows
SELECT COUNT(*)
FROM coronavirus;

# If NULL values are present, update them with zeros for all columns. 
UPDATE coronavirus
SET 
    confirmed = IFNULL(confirmed, 0),
    deaths = IFNULL(deaths, 0),
    recovered = IFNULL(recovered, 0);

#Checking what is start_date and end_date
ALTER TABLE coronavirus
ADD COLUMN Dates DATETIME;
SET SQl_SAFE_UPDATES=0;
UPDATE coronavirus
SET Dates = STR_TO_DATE(Date, '%d-%m-%Y');
select * from coronavirus;


SELECT Min(Dates) AS start_date, Max(Dates) AS end_date
FROM coronavirus;


# Number of month present in dataset
SELECT COUNT(DISTINCT DATE_FORMAT(Dates, '%Y-%m')) AS num_months
FROM coronavirus;



# monthly average for confirmed, deaths, recovered
SELECT 
    YEAR(Dates) AS year,
    MONTH(Dates) AS month,
    AVG(confirmed) AS avg_confirmed,
    AVG(deaths) AS avg_deaths,
    AVG(recovered) AS avg_recovered
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates), MONTH(Dates)
ORDER BY 
    year, month;



#most frequent value for confirmed, deaths, recovered each month 
SELECT 
    YEAR(Dates) AS year,
    MONTH(Dates) AS month,
    MAX(confirmed) AS max_confirmed,
    MAX(deaths) AS max_deaths,
    MAX(recovered) AS max_recovered
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates), MONTH(Dates)
ORDER BY 
    year, month;
    
    
    
#Minimum value for Confirmed,deaths and recovered per year

SELECT 
    YEAR(Dates) AS year,
    MIN(confirmed) AS min_confirmed,
    MIN(deaths) AS min_deaths,
    MIN(recovered) AS min_recovered
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates)
ORDER BY 
    year;



# maximum values of confirmed, deaths, recovered per year

SELECT 
    YEAR(Dates) AS year,
    MAX(confirmed) AS max_confirmed,
    MAX(deaths) AS max_deaths,
    MAX(recovered) AS max_recovered
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates)
ORDER BY 
    year;



#The total number of case of confirmed, deaths, recovered each month

SELECT 
    YEAR(Dates) AS year,
    MONTH(Dates) AS month,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates), MONTH(Dates)
ORDER BY 
    year, month;

# Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total confirmed cases
SELECT 
    COUNT(*) AS total_cases
FROM 
    coronavirus;

-- Calculate average confirmed cases
SELECT 
    AVG(confirmed) AS average_confirmed_cases
FROM 
    coronavirus;

-- Calculate variance of confirmed cases
SELECT 
    VARIANCE(confirmed) AS variance_confirmed_cases
FROM 
    coronavirus;

-- Calculate standard deviation of confirmed cases
SELECT 
    STDDEV(confirmed) AS std_dev_confirmed_cases
FROM 
    coronavirus;



# heck how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total death cases per month
SELECT 
    YEAR(Dates) AS year,
    MONTH(Dates) AS month,
    SUM(deaths) AS total_death_cases
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates), MONTH(Dates)
ORDER BY 
    year, month;

-- Calculate average death cases per month
SELECT 
    YEAR(Dates) AS year,
    MONTH(Dates) AS month,
    AVG(deaths) AS average_death_cases
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates), MONTH(Dates)
ORDER BY 
    year, month;

-- Calculate variance of death cases per month
SELECT 
    YEAR(Dates) AS year,
    MONTH(Dates) AS month,
    VARIANCE(deaths) AS variance_death_cases
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates), MONTH(Dates)
ORDER BY 
    year, month;

-- Calculate standard deviation of death cases per month
SELECT 
    YEAR(Dates) AS year,
    MONTH(Dates) AS month,
    STDDEV(deaths) AS std_dev_death_cases
FROM 
    coronavirus
GROUP BY 
    YEAR(Dates), MONTH(dates)
ORDER BY 
    year, month;



# Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total recovered cases
SELECT 
    COUNT(*) AS total_recovered_cases
FROM 
    coronavirus
WHERE 
    recovered > 0;

-- Calculate average recovered cases
SELECT 
    AVG(recovered) AS average_recovered_cases
FROM 
    coronavirus
WHERE 
    recovered > 0;

-- Calculate variance of recovered cases
SELECT 
    VARIANCE(recovered) AS variance_recovered_cases
FROM 
    coronavirus
WHERE 
    recovered > 0;

-- Calculate standard deviation of recovered cases
SELECT 
    STDDEV(recovered) AS std_dev_recovered_cases
FROM 
    coronavirus
WHERE 
    recovered > 0;



# Find Country having highest number of the Confirmed case
SELECT 
    country AS country,
    SUM(confirmed) AS total_confirmed_cases
FROM 
    coronavirus
GROUP BY 
    country
ORDER BY 
    total_confirmed_cases DESC
LIMIT 5;


# Find Country having lowest number of the death case

SELECT 
    country AS country,
    SUM(deaths) AS total_death_cases
FROM 
    coronavirus
GROUP BY 
    country
ORDER BY 
    total_death_cases
LIMIT 5;

select sum(confirmed) as total_rec_cases from coronavirus;
# Find top 5 countries having highest recovered case
SELECT 
    country AS country,
    SUM(recovered) AS total_recovered_cases
FROM 
    coronavirus
GROUP BY 
    country
ORDER BY 
    total_recovered_cases DESC
LIMIT 5;
