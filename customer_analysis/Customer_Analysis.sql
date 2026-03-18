
-- ================================================
-- KPI 1: Revenue by Segment
-- ================================================
Select c.segment, 
	ROUND (SUM(s.sales)::NUMERIC,2) AS Revenue, 
	ROUND (SUM(s.profit))AS Profit, 
	ROUND((SUM(s.profit) / SUM(s.sales) * 100)::NUMERIC, 2) AS Profit_Margin
From public.sales s
Join public.customer c
	ON c.customer_id = s.customer_id
Group by c.segment
Order by Profit_Margin desc

-- ================================================
-- KPI 2: Top 10 Customers by Revenue & Profit
-- ================================================

Select c.customer_id, c.customer_name, c.segment, 
	Round (sum(s.sales)::Numeric, 2) AS Revenue,
	Round (sum(s.profit)::Numeric,2) As Profit
From public.customer c
Join public.sales s
	ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name, c.segment
Order By Revenue desc
Limit 10


-- ================================================
-- KPI 3: Customer count by Segment and Region
-- ================================================
Select 
	c.region,
	c.segment,
	COUNT (c.customer_id) AS Customer_Count
From public.customer c
Group by c.region, c.segment
Order by Customer_Count Desc

-- ================================================
-- KPI 4: Customer count by Segment and Region
-- ================================================
Select 	
	c.segment, 
	Count (s.order_line) AS Total_orders,
	Round (avg(s.sales)::Numeric,2) AS Revenue
From public.customer c
Join public.sales s
	ON c.customer_id = s.customer_id
Group By c.segment
Order By Revenue DESC

-- ================================================
-- KPI 5: Repeat Customers
-- ================================================
WITH customer_orders AS (
    SELECT s.customer_id,
           COUNT(DISTINCT s.order_id) AS order_count,
           SUM(s.sales)               AS total_sales
    FROM sales s
    GROUP BY s.customer_id
)
SELECT
    CASE WHEN order_count > 1 THEN 'Repeat Customer'
         ELSE 'One-Time Buyer'
    END                                  AS customer_type,
    COUNT(customer_id)                   AS total_customers,
    ROUND(SUM(total_sales)::NUMERIC, 2)  AS total_revenue,
    ROUND(AVG(total_sales)::NUMERIC, 2)  AS avg_revenue_per_customer
FROM customer_orders
GROUP BY customer_type
ORDER BY total_revenue DESC

-- =======================================================
-- KPI 6: Top 10 Most Loyal Customers by Order Frequency
-- =======================================================
Select
	c.customer_id,
	c.customer_name,
	c.segment,
	count(distinct s.order_id) as order_count,
	Round (sum(sales)::Numeric,2) As Revenue
From public.customer c
Join public.sales s
	ON c.customer_id = s.customer_id
Group by c.customer_id, c.customer_name, c.segment
Having count(distinct s.order_id) > 1 
Order by order_count Desc
Limit 10
	










