-- =====================================================
-- KPI 7: Revenue, Profit & Margin by Product Category
-- =====================================================
Select 
	p.category,
	COUNT(s.order_line) AS total_orders,
	ROUND (SUM(s.sales)::NUMERIC,2) AS Revenue, 
	ROUND (SUM(s.profit))AS Profit, 
	ROUND((SUM(s.profit) / SUM(s.sales) * 100)::NUMERIC, 2) AS Profit_Margin

From public.product p
Left Join public.sales s
	ON p.product_id = s.product_id
Group By p.category

-- =========================================================
-- KPI 8: Revenue, Profit & Margin by Product Sub-Category
-- =========================================================
Select 
	p.category,
	p.sub_category,
	COUNT(s.order_line) AS total_orders,
	ROUND (SUM(s.sales)::NUMERIC,2) AS Revenue, 
	ROUND (SUM(s.profit))AS Profit, 
	ROUND((SUM(s.profit) / SUM(s.sales) * 100)::NUMERIC, 2) AS Profit_Margin

From public.product p
Left Join public.sales s
	ON p.product_id = s.product_id
Group By p.category, p.sub_category
Order By Profit_Margin Desc
Limit 10

-- =========================================================
-- KPI 9: Top 10 Most Profitable Products
-- =========================================================
Select 
	p.category,
	p.sub_category,
	p.product_name,
	ROUND (SUM(s.sales)::NUMERIC,2) AS Revenue, 
	ROUND (SUM(s.profit))AS Profit, 
	ROUND((SUM(s.profit) / SUM(s.sales) * 100)::NUMERIC, 2) AS Profit_Margin

From public.product p
Join public.sales s
	ON p.product_id = s.product_id
Group By p.category, p.sub_category, p.product_name
Order By Profit Desc
Limit 10

-- =========================================================
-- KPI 10: Top 10 Least Profitable Products
-- =========================================================
Select 
	p.category,
	p.sub_category,
	p.product_name,
	ROUND (SUM(s.sales)::NUMERIC,2) AS Revenue, 
	ROUND (SUM(s.profit))AS Profit, 
	ROUND((SUM(s.profit) / SUM(s.sales) * 100)::NUMERIC, 2) AS Profit_Margin

From public.product p
Join public.sales s
	ON p.product_id = s.product_id
Group By p.category, p.sub_category, p.product_name
Having SUM(s.profit) < 0
Order By Profit Asc
Limit 10

-- =========================================================
-- KPI 11: Best Selling Sub-Category per Region
-- =========================================================
WITH regional_revenue AS (
    SELECT 
        c.region,
        p.sub_category,
        Round (SUM(s.sales)::Numeric, 2) AS total_revenue
    FROM public.sales s
    JOIN public.customer c ON s.customer_id = c.customer_id
    JOIN public.product p  ON s.product_id  = p.product_id
    GROUP BY c.region, p.sub_category
),

ranked As (
	Select 
		region,
		sub_category,
		total_revenue,
			Rank() Over ( Partition by region
						Order By total_revenue DESC
			)As Revenue_rank
	From regional_revenue
)
			
SELECT 
    region,
    sub_category,
    total_revenue
FROM ranked
WHERE revenue_rank = 1
ORDER BY total_revenue DESC


-- =========================================================
-- KPI 12: Sub-Category Revenue Rank within Category
-- =========================================================

With regional_revenue AS (
	Select 
		p.sub_category,
		p.category,
		Round (sum(s.sales)::Numeric,2) AS total_revenue
	From public.sales s
Join public.product p ON s.product_id = p.product_id
Group by p.sub_category, p.category
),

ranked AS (
	Select 
		sub_category,
		category,
		total_revenue,
			Rank () 
				OVER(Partition by category
				Order by total_revenue DESC) AS categorized_revenue
	From regional_revenue
)

Select 
	category,
	sub_category,
	total_revenue,
	categorized_revenue

From ranked
Order By categorized_revenue ASC

	