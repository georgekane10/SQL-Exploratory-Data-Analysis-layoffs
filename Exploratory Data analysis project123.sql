 # Exploratory Data Analysis
 
 SELECT *
 FROM layoffs_staging5
 WHERE percentage_laid_off IS NOT NULL
 ORDER BY percentage_laid_off ASC
 LIMIT 8
;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging5;

SELECT *
FROM layoffs_staging5
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC
;

SELECT *
FROM layoffs_staging5
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC
;

SELECT company, SUM(total_laid_off), ROUND(AVG(percentage_laid_off), 4)
FROM layoffs_staging5
GROUP BY company
ORDER BY 2 DESC
;


SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging5
;


SELECT industry, SUM(total_laid_off)
FROM layoffs_staging5
GROUP BY industry
ORDER BY 2 DESC
;


SELECT country, SUM(total_laid_off)
FROM layoffs_staging5
GROUP BY country
ORDER BY 2 DESC
;


SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging5
GROUP BY YEAR(`date`)
ORDER BY 1 DESC
;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging5
GROUP BY stage
ORDER BY 2 DESC
;



SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging5
GROUP BY company
ORDER BY 2 DESC
;



SELECT company, 
location, 
industry, 
total_laid_off, 
percentage_laid_off, 
`date`,
stage, 
country, 
funds_raised_millions, AVG(funds_raised_millions)
OVER (PARTITION BY country) AS avg_funds_raised_millions
FROM  layoffs_staging5
ORDER BY avg_funds_raised_millions DESC
;



WITH max_funds AS (
	SELECT 
		company, 
		location, 
		industry, 
		total_laid_off, 
		percentage_laid_off, 
		`date`,
		stage, 
		country, 
		funds_raised_millions, ROW_NUMBER()
		OVER (PARTITION BY country
        ORDER BY funds_raised_millions DESC) 
		AS rank_funds_raised
	FROM  layoffs_staging5
    )
SELECT
		company, 
		location, 
		industry, 
		total_laid_off, 
		percentage_laid_off, 
		`date`,
		stage, 
		country, 
		funds_raised_millions 
FROM max_funds
WHERE rank_funds_raised = 1
ORDER BY funds_raised_millions DESC
-- From this query, we're finding out what the max funds raised in millions is by a company for each country
;



SELECT SUBSTRING(`date`, 6, 2) AS `month`, SUM(total_laid_off)
FROM layoffs_staging5
GROUP BY `month`
;

SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off)
FROM layoffs_staging5
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC
;


SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off)
FROM layoffs_staging5
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC
;


WITH rolling_total AS 
(
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs_staging5
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC
)
SELECT `month`, sum_total_laid_off, SUM(sum_total_laid_off) OVER(ORDER BY `month`) AS cumulative_total
FROM rolling_total
;




SELECT company,  YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging5
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
;


WITH Company_year (company, years, total_laid_off) AS 
(
SELECT company,  YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging5
GROUP BY company, YEAR(`date`)
), 
Company_year_rank AS
(
SELECT *, DENSE_RANK () OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_year_rank
WHERE ranking <= 5
;



