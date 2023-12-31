-- Code was done in Snowflake, NOT MySQL -- 

-- Hypothesis #1:

CREATE TABLE population_table AS
SELECT
    STATEABR,
    SUM(TOTALPOP) AS TOTAL_POPULATION
FROM
    CENSUS_DATA
GROUP BY STATEABR;

SELECT * 
FROM population_table;

CREATE TABLE business_summary AS
SELECT
    AVG(STARS) AS average_stars,
    STATE
FROM
    YELP.PUBLIC.BUSINESS
GROUP BY
    STATE;
    
select * from
business_summary 
join population_table on population_table.stateabr = business_summary.state;


-- Hypothesis #2:

CREATE TABLE avg_income_state AS
SELECT
    STATEABR,
    SUM(TOTALPOP*INCOME)/SUM(TOTALPOP) AS AVG_INCOME
FROM
    CENSUS_DATA
GROUP BY
    STATEABR;

select * from 
business_summary 
join avg_income_state on avg_income_state.stateabr = business_summary.state;

-- Hypothesis #3:

create table problem3 as
SELECT
    state,
    MAX(stars) - MIN(stars) AS range_satrs
FROM
    yelp.public.business
group by state;

CREATE TABLE range_pop AS
SELECT
    STATEABR,
    SUM (TOTALPOP) AS population
FROM
    CENSUS_DATA
GROUP BY
    STATEABR;

create table final_pro as
select * from problem3
join range_pop on problem3.state = range_pop.stateabr;

select * from final_pro