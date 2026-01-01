# SQL Exploratory Data Analysis Layoffs

### Identifying Extremes: Mass layoffs and total shutdowns
From our exploratory data analysis, we used the MAX() function to find the highest layoffs for a company, which was 12,000. The highest layoff perecntage was 1.0 (100%), meaning every employee was let go, due to bankrupcy/liquidation or a full business closure. Interestingly, some companies had raised millions of funding, yet still completely collapsed, proving high capital does not always prevent total shutdown. For example, Britishvolt raised 2.4 billion, but let off all of the employees; the company collapsed. This could be due to spending high amounts on salaries etc, or investors pulling out due to missed deadlines.

### Highest Layoffs
Unsiprisingly, bigger companies like Amazon (18150 layoffs), Google (12000 layoffs)and Meta (11000 layoffs) had the greatest number of layoffs for all the companies in the global dataset. This makes sense as these companies have the most employees. However, looking at the percentage of layoffs, for example Amazon (2.5% laid off), are nowhere near at a level of collapsing like britishvolt who had every employee let off, yet britishvolt only had 206 employees across the whole company. It is imperative to always look at the percentage of data, as looking at the raw total only tells you the volume, not the situation of a company. Also, because this dataset was between 2020 and 2023, a high amount of layoffs for companies could be due to the covid 19 pandemic- companies did not have the capacity to pay people salaries while not bringing any money themselves. From a simple query we found out that the industries with the highest layoffs was consumer, retail and transportation, which is expected as the global lockdown stoped human interaction, thus companies had no choice but to let go of employees. From another query I found at that United States had the greatest number of layoffs (256,559). This value was a lot greater than the second greatest number of layoffs which was India (35,993). This may not be represetative of India and all the other countries as not every company in the wworld is in the dataset. Vietnam had the highest average laid off (83.3%) but United states had an average of 25.2%.

### Funds Raised
From one query, I found out that Lithuania (although there was only one row in the enitre dataset for Lithuania- therefore not as representative) had the highest average funds raised, followed by Netherlands, China and India. I did this using the aggregate function AVG with the OVER(partition by) function, in which we partitioned by country. From another query we also found out the highest funds raised per company for every country. We did this using a CTE in which we made a column which assigned a row number to a partition of country, and ordering the funds raised descending (and this was as funds raised ranked) so that when we selected funds raised ranked = 1 (and country) from the CTE it would retrun the highest funds raised by a company for each country. The highest funds raised for United States was Netflix.

### Other Analysis
Using a CTE, I made a rolling total of the sum of layoffs for every country, going up a month every row. From this I discovered that in 2020 there was around 80,000 layoffs (March to December), in 2021 there was only around 16,000 layoffs, in 2022 there was 161,000 layoffs, in 2023 there was 125,000 layoffs (January to March). I made another query that displayed the top 5 most layoffs by companies for each year (2020-2023). we first used a CTE that groups our data so that we have one row per company per year. Next, we use another CTE which selects from the first CTE. In this CTE, we use a dense_rank, and we do this over  partitioning by years so that companies in 2022 and 2023 are ranked seperately. Also having the ORDER BY total layoffs descending in the dense rank ensures that the greatest number of layoffs will be ranked as 1. Finally we select from the second CTE using a WHERE() and <= 5 to get rankings 1 to 5.











