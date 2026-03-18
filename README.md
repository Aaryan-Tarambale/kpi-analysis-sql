# 📊 Retail KPI Analysis — SQL Analytics Project

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analytics-blue?style=flat)
![Tableau](https://img.shields.io/badge/Tableau-Public-orange?style=flat)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow?style=flat)

## Overview

End-to-end SQL analytics project simulating a real retail company's data team. As the **Lead Data Analyst** at NexMart Retail Group, I was tasked with answering critical business questions before a board meeting — analyzing 9,994 transactions across 793 customers and 1,862 products spanning 4 years (2014–2017).

The project covers customer behaviour, product performance, regional trends, discount impact and executive-level KPIs — all written in PostgreSQL and structured as a professional analytics deliverable.

---

## Business Context

> *"Revenue has grown every year — but profit margin hit an all-time low. The board wants answers."*

Five stakeholders. One week. 28 SQL queries.

| Stakeholder | Role | Focus Area |
|---|---|---|
| Sarah Chen | CEO | Revenue, margin & segment health |
| James Park | CFO | Profitability, discounts & cost control |
| Mia Torres | VP Sales | Best regions, products & growth opportunities |
| Raj Mehta | Head of Product | Category performance, winners & losers |
| Dana Wells | Head of Logistics | Shipping modes, speed & delivery profitability |

---

## Database

| Table | Rows | Key Columns |
|---|---|---|
| `customer` | 793 | customer_id, segment, region, state, city |
| `product` | 1,862 | product_id, category, sub_category, product_name |
| `sales` | 9,994 | order_id, order_date, sales, profit, discount, ship_mode |

**Database:** PostgreSQL  
**Period:** 2014 – 2017  
**Relationships:** `sales.customer_id → customer.customer_id` · `sales.product_id → product.product_id`

---

## Project Structure

## Project Structure
 
```
kpi-analysis-sql/
│
├── README.md
│
├── data/
│   ├── Customer.csv
│   ├── Product.csv
│   └── Sales.csv
│
├── schema/
│   └── schema.sql
│
├── customer-analysis/
│   ├── customer_analysis.sql
│   └── results/
│       ├── kpi_01_segment_revenue.csv
│       ├── kpi_02_top_customers.csv
│       ├── kpi_03_customer_count.csv
│       ├── kpi_04_avg_order_value.csv
│       ├── kpi_05_repeat_vs_onetime.csv
│       └── kpi_06_loyal_customers.csv
│
├── product-analysis/
│   ├── product_analysis.sql
│   └── results/
│       ├── kpi_07_category_revenue.csv
│       ├── kpi_08_subcategory_revenue.csv
│       ├── kpi_09_top_products.csv
│       ├── kpi_10_loss_making_products.csv
│       ├── kpi_11_best_subcategory_region.csv
│       └── kpi_12_subcategory_rank.csv
│
├── regional-analysis/
│   ├── regional_analysis.sql
│   └── results/
│       ├── kpi_13_revenue_by_region.csv
│       ├── kpi_14_top_states.csv
│       ├── kpi_15_yoy_growth.csv
│       ├── kpi_16_top_cities.csv
│       ├── kpi_17_shipping_mode.csv
│       └── kpi_18_monthly_trend.csv
│
├── discount-analysis/
│   ├── discount_analysis.sql
│   └── results/
│
└── executive-dashboard/
    ├── executive_dashboard.sql
    └── results/
```
 
---

## SQL Concepts Covered

```
INNER JOIN, LEFT JOIN         — 2 and 3 table joins
GROUP BY + aggregates         — SUM, AVG, COUNT, ROUND
HAVING vs WHERE               — filtering aggregated results
CASE WHEN                     — conditional classification
CTEs with WITH                — multi-step calculations
Subqueries                    — nested queries
RANK(), DENSE_RANK()          — window functions
PARTITION BY                  — ranking within groups
LAG()                         — year over year comparisons
EXTRACT()                     — date part extraction
DATE_TRUNC()                  — date truncation

```

---

## Key Business Insights

### Customer
- **Consumer** segment drives 50% of revenue but has the **worst margin at 11.55%**
- **Home Office** is the most efficient segment at 14.03% margin
- **98.5% of customers are repeat buyers** — generating 99.8% of total revenue
- **Emily Phan** is our most loyal customer with 17 orders

### Product
- **Technology** leads with 17.40% margin — our healthiest category
- **Furniture Tables** are actively losing money at **-8.56% margin**
- **Labels and Paper** are hidden gems — 44% and 43% margin respectively
- **Canon imageCLASS 2200 Copier** is our single most profitable product ($25,200 profit)
- **Cubify 3D Printer** is our worst product — losing $8,880 at -80% margin

### Regional
- **West** leads in revenue ($764k) but **East** has the best margin (15.46%)
- **North Carolina** is actively loss-making at -3.63% margin
- **New York City** is our most profitable city ($41,892 profit)
- **September, November and December** are consistently our strongest months every year
- **First Class shipping** surprisingly has better margin (13.93%) than Standard Class (12.08%)

---

## How to Run This Project

**1 — Set up the database**
```sql
CREATE DATABASE nexmart;
```

**2 — Create the tables**
```bash
-- Run schema.sql in pgAdmin Query Tool
```

**3 — Import the data**
```
Right click each table in pgAdmin
→ Import/Export Data
→ Select the corresponding CSV file
→ Header: ON, Delimiter: comma
```

**4 — Run the queries**
```
Open each .sql file in pgAdmin Query Tool
Run queries individually or all at once
```

---

## Tools Used

| Tool | Purpose |
|---|---|
| PostgreSQL | Database |
| pgAdmin 4 | Query editor & database management |
| Tableau Public | Data visualization & dashboards |
| GitHub | Version control & portfolio |

---

## Dashboard

> Tableau Public dashboard coming soon.
---

*This project was built as a portfolio piece to demonstrate real-world SQL analytics skills across customer, product, regional and financial analysis domains.*
