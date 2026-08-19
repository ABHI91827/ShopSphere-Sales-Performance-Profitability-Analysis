use Profitability_Analysis;

--- Root Cause Analysis ----

---1. hypothesis ---
--- AOV ---
select 
	d.year,
	sum(fs.revenue) as Total_revenue,
	count(fs.order_id) as Total_orders,
	sum(fs.revenue)  / count(fs.order_id) as AOV
from dim_date d join fact_sales fs on d.Date_ID = fs.Date_ID
group by d.year;

--- output
   year	Total_revenue	Total_orders	AOV
    2024	428378966.86	49992	    8568.950369
    2025	427139721.83	50008	    8541.427808 
--------------------------------------------------------------------------

-- 1.1 why AOV is decreased ---

select 
	d.year,
	sum(fs.revenue) as Total_revenue,
	count(fs.order_id) as Total_orders,
	sum(fs.revenue)  / count(fs.order_id) as AOV,
	sum(fs.Discount_Amount) as dis_amount,
    avg(pr.discount_percentage) as avg_dis_per
from dim_date d 
join fact_sales fs on d.Date_ID = fs.Date_ID
join dim_promotion pr on fs.Promotion_ID = pr.Promotion_ID
group by d.year;

--- output
   year	  Total_revenue	  Total_orders    AOV	        dis_amount
   2024	  428378966.86	  49992	          8568.950369	84080593.28
   2025	  427139721.83	  50008	          8541.427808	83385365.89
-------------------------------------------------------------------------------



-- 1.2. Product Mix Analysis
-- Category-wise Revenue
SELECT
    d.year,
    p.category,
    SUM(fs.revenue) AS revenue,
    SUM(fs.quantity) AS units_sold
FROM fact_sales fs
JOIN dim_product p
    ON fs.product_id = p.product_id
JOIN dim_date d
    ON fs.date_id = d.date_id
GROUP BY d.year, p.category
ORDER BY p.category, d.year;

---- output 
year	category	    revenue	        units_sold
2024	Beauty	        137411123.20	23713
2025	Beauty	        134832451.90	23456
2024	Electronics	    61158737.48	    21680
2025	Electronics 	60562387.67	    21364
2024	Fashion	        79714712.05	    18632
2025	Fashion	        82198058.37	    19052
2024	Home & Kitchen	78656115.06	    18031
2025	Home & Kitchen	77211193.32	    17730
2024	Sports	        71438279.07	    17832
2025	Sports	        72335630.57	    18106
----------------------------------------------------------------


---1.3 AVG selling price 

SELECT
    d.year,
    SUM(fs.revenue) / SUM(fs.quantity) AS Avg_Selling_Price
FROM fact_sales fs
JOIN dim_date d
    ON fs.date_id = d.date_id
GROUP BY d.year;

---- output 
    year	Avg_Selling_Price
    2024	4288.592892
    2025	4283.906224
--------------------------------------

--1.4 Avg selling price category wise ---

SELECT
    p.category,
    ROUND(SUM(fs.revenue) / SUM(fs.quantity), 2) AS Avg_Selling_Price
FROM fact_sales fs
JOIN dim_product p
    ON fs.product_id = p.product_id
GROUP BY p.category
ORDER BY Avg_Selling_Price DESC;


--- output
category	    Avg_Selling_Price
Beauty	        5771.660000
Home & Kitchen	4358.580000
Fashion	        4296.590000
Sports	        4000.610000
Electronics	    2827.830000
---------------------------------------------------------------------------------------------


--2.Did profit margins decline in one or more product categories?

select 
    p.category,
    sum(fs.revenue) as total_revenue,
    sum(fs.cost_price) as cost_price,
    sum(fs.profit) as total_profit,
    (sum(fs.profit) / sum(fs.revenue) ) * 100 as Profit_margin 
from dim_product p
join fact_sales fs on p.product_id = fs.product_id
group by p.category;


--- output
category	     total_revenue	cost_price	total_profit	Profit_margin
Beauty	         272243575.10	62579651	145644882.10	53.498000
Electronics	     121721125.15	55214273	8587041.15	    7.054600
Fashion	         161912770.42	44369238	70208721.42	    43.362000
Home & Kitchen   155867308.38	50442124	53108001.38	    34.072500
Sports	         143773909.64	43327257	55245236.64	    38.425000
----------------------------------------------------------------------------------

select 
    p.category,
    d.year,
    sum(fs.revenue) as total_revenue,
    sum(fs.cost_price) as cost_price,
    sum(fs.profit) as total_profit,
    (sum(fs.profit) / sum(fs.revenue) ) * 100 as Profit_margin 
from dim_date d
join fact_sales fs on d.Date_id = fs.date_id
join dim_product p on fs.product_id = p.product_id
group by d.year, p.category
order by d.year asc, profit_margin desc;

--- output 
category	    year	total_revenue	cost_price	total_profit	Profit_margin
Beauty	        2024	137411123.20	31434278	73661213.20	    53.606400
Fashion	        2024	79714712.05	    22007783	34510766.05	    43.292800
Sports	        2024	71438279.07  	21611704	27302286.07	    38.218000
Home & Kitchen	2024	78656115.06	    25351492	26769004.06	    34.032900
Electronics	    2024	61158737.48	    27661345	4343750.48	    7.102400
Beauty	        2025	134832451.90	31145373	71983668.90	    53.387400
Fashion	        2025	82198058.37	    22361455	35697955.37	    43.429100
Sports	        2025	72335630.57	    21715553	27942950.57	    38.629500
Home & Kitchen	2025	77211193.32	    25090632	26338997.32	    34.112900
Electronics	    2025	60562387.67	    27552928	4243290.67	    7.006400
--------------------------------------------------------------------------------------------------------


--- Which category contributed the most to the overall revenue decline?

SELECT
    p.category,
    SUM(CASE WHEN d.year = 2024 THEN fs.revenue ELSE 0 END) AS Revenue_2024,
    SUM(CASE WHEN d.year = 2025 THEN fs.revenue ELSE 0 END) AS Revenue_2025,
    SUM(CASE WHEN d.year = 2025 THEN fs.revenue ELSE 0 END) -
    SUM(CASE WHEN d.year = 2024 THEN fs.revenue ELSE 0 END) AS Revenue_Change
FROM fact_sales fs
JOIN dim_product p
    ON fs.product_id = p.product_id
JOIN dim_date d
    ON fs.date_id = d.date_id
GROUP BY p.category
ORDER BY Revenue_Change;

--- output 
category	    Revenue_2024	Revenue_2025	Revenue_Change
Beauty	        137411123.20	134832451.90	-2578671.30
Home & Kitchen	78656115.06	    77211193.32	    -1444921.74
Electronics	    61158737.48	    60562387.67	    -596349.81
Sports	        71438279.07	    72335630.57	     897351.50
Fashion	        79714712.05	    82198058.37	     2483346.32
---------------------------------------------------------------------------



SELECT
    d.year,
    SUM(fs.cost_price) AS Total_Cost,
    SUM(fs.revenue) AS Total_Revenue,
    SUM(fs.profit) AS Total_Profit,
    SUM(fs.cost_price) * 100.0 / SUM(fs.revenue) AS Cost_Percentage
FROM fact_sales fs
JOIN dim_date d
    ON fs.date_id = d.date_id
GROUP BY d.year;


