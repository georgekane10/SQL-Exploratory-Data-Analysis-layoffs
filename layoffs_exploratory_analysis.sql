# Data Cleaning

SELECT *
FROM layoffs
;


-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove Any columns or rows


CREATE TABLE layoffs_staging3
LIKE layoffs
;

SELECT *
FROM layoffs_staging3;

INSERT layoffs_staging3
SELECT *
FROM layoffs
;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, 
location, industry, 
total_laid_off, 
percentage_laid_off, 
`date`, 
stage,
 country,
 funds_raised_millions) AS row_num
FROM layoffs_staging3
)
SELECT* 
FROM duplicate_cte
WHERE row_num > 1;



SELECT *
FROM layoffs_staging
WHERE company = 'Casper'
;


SELECT *
FROM layoffs_staging
WHERE company = 'Casper';



WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, 
location, industry, 
total_laid_off, 
percentage_laid_off, 
`date`, 
stage,
 country,
 funds_raised_millions) AS row_num
FROM layoffs_staging3
)
DELETE 
FROM duplicate_cte
WHERE row_num > 1;


CREATE TABLE `layoffs_staging5` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




SELECT *
FROM layoffs_staging5;

INSERT INTO layoffs_staging5
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, 
location, industry, 
total_laid_off, 
percentage_laid_off, 
`date`, 
stage,
 country,
 funds_raised_millions) AS row_num
 FROM layoffs_staging3
 ;
 
DELETE 
FROM layoffs_staging5
WHERE row_num > 1 
;



SELECT *
FROM layoffs_staging5
WHERE row_num > 1 
;

SELECT *
FROM layoffs_staging5
;




-- Standardizing data



SELECT company, TRIM(company)
FROM layoffs_staging5
;


UPDATE layoffs_staging5
SET company = TRIM(company);



SELECT *
FROM layoffs_staging5
WHERE industry LIKE 'Crypto%'
;


UPDATE layoffs_staging5
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'
;


SELECT DISTINCT country
FROM layoffs_staging5
ORDER BY country
;



UPDATE layoffs_staging5
SET country = 'United States'
WHERE country LIKE 'United States%';

-- or you could do

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layofss_staging5
ORDER BY country
;


-- Changing the definition of date (it's as text, we need it to be int/integer)

SELECT `date`,
STR_TO_DATE( `date`, '%m/%d/%Y')
FROM layoffs_staging5
;

UPDATE layoffs_staging5
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y')
;


ALTER TABLE layoffs_staging5
MODIFY COLUMN `date` DATE; 

SELECT *
FROM layoffs_staging5;



-- Removing NULLS


SELECT *
FROM layoffs_staging5
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



SELECT DISTINCT *
FROM layoffs_staging5
WHERE industry IS NULL 
OR industry = '';


SELECT *
FROM layoffs_staging5
WHERE company = 'Airbnb'
;



SELECT *
FROM layoffs_staging5
WHERE company LIKE 'bally%'
;



SELECT table1.industry , table2.industry
FROM layoffs_staging5 AS table1
JOIN layoffs_staging5 AS table2
	ON table1.company = table2.company
    AND table1.location = table2.location
WHERE (table1.industry IS NULL OR table1.industry = '')
AND table2.industry IS NOT NULL 
;


UPDATE layoffs_staging5
SET industry= NULL
WHERE industry = '';




UPDATE layoffs_staging5 AS table1
JOIN layoffs_staging5 AS table2
	ON table1.company = table2.company
SET table1.industry = table2.industry
WHERE (table1.industry IS NULL)
AND table2.industry IS NOT NULL
;



SELECT *
FROM layoffs_staging5
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL 
;

DELETE 
FROM layoffs_staging5
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL 
;


SELECT *
FROM layoffs_staging5
;

ALTER TABLE layoffs_staging5
DROP COLUMN row_num
;














