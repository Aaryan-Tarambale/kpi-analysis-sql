-- ================================================
-- KPI 13: Revenue & Profit by Region
-- ================================================
SELECT 
    c.region,
    COUNT(s.order_line)                          AS total_orders,
    ROUND(SUM(s.sales)::NUMERIC, 2)              AS total_revenue,
    ROUND(SUM(s.profit)::NUMERIC, 2)             AS total_profit,
    ROUND((SUM(s.profit) / SUM(s.sales) * 100)::NUMERIC, 2) AS profit_margin
FROM sales s
JOIN customer c ON s.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_revenue DESC

-- ================================================
-- KPI 14: Top 10 States by Revenue & Profit
-- ================================================

Select 
	c.state,
	c.region,
	count (s.order_line) as total_orders,
	ROUND (SUM(s.sales)::NUMERIC,2) AS Revenue, 
	ROUND (SUM(s.profit)::NUMERIC,2)AS Profit, 
	ROUND((SUM(s.profit) / SUM(s.sales) * 100)::NUMERIC, 2) AS Profit_Margin
From public.customer c
Join public.sales s
	ON s.customer_id = c.customer_id
Group By c.region, c.state
Order By Revenue Desc
Limit 10

-- ================================================
-- KPI 15: Year Over Year Revenue Growth by Region
-- ================================================

WITH yearly_revenue AS (
    SELECT 
        c.region,
        EXTRACT(YEAR FROM s.order_date) AS year,
        ROUND(SUM(s.sales)::NUMERIC, 2) AS total_revenue
    FROM sales s
    JOIN customer c ON s.customer_id = c.customer_id
    GROUP BY c.region, EXTRACT(YEAR FROM s.order_date)
),

yoy AS (
    SELECT 
        region,
        year,
        total_revenue,
        LAG(total_revenue) OVER (
            PARTITION BY region
            ORDER BY year
        ) AS prev_year_revenue
    FROM yearly_revenue
)

SELECT 
    region,
    year,
    total_revenue,
    prev_year_revenue,
    ROUND(((total_revenue - prev_year_revenue) 
        / prev_year_revenue * 100)::NUMERIC, 2) AS yoy_growth_pct
FROM yoy
ORDER BY region, year ASC

-- ================================================
-- KPI 16: Top 10 Cities by Profit
-- ================================================
Select 
	c.region,
	c.state,
	c.city,
	count (s.order_line) as total_orders,
	ROUND (SUM(s.profit)::NUMERIC,2)AS Profit,
	ROUND (SUM(s.sales)::NUMERIC,2)AS Total_revenue
	
From public.customer c
Join public.sales s
	ON s.customer_id = c.customer_id
Group By c.region, c.state, c.city
Order By Profit Desc
Limit 10

-- ================================================
-- KPI 17: Shipping Mode Usage & Profit Impact
-- ================================================

Select 
	ship_mode,
	count (order_line) As total_orders,
	ROUND (SUM(sales)::NUMERIC,2) AS Revenue, 
	ROUND (SUM(profit)::NUMERIC,2)AS Profit,
	ROUND((SUM(profit) / SUM(sales) * 100)::NUMERIC, 2) AS Profit_Margin
From public.sales
Group by ship_mode

-- ================================================
-- KPI 18: Monthly Revenue Trend Across All Years
-- ================================================

Select 
	Extract (Year From order_date)  AS year,
	Extract (Month From order_date) As month,
	ROUND (SUM(sales)::NUMERIC,2) AS total_revenue
From public.sales
Group by Extract (Year From order_date), Extract (Month From order_date)
Order by year, month
	
	
	
	









