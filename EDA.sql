select *  from Dim_Customer ;
select * from dim_product;
select * from dim_promotion;
select * from dim_shipping;
select * from dim_date;
select * from fact_sales;

--- EDA ---

-- Total no of Customers --
Select
	count(*) as Total_Customers
from Dim_Customer;
-- Total customer with Segemnt wise --
select 
	Customer_segment,
	count(*) as Total_customer_segment
from Dim_Customer
group by Customer_segment;

-- Total no of state --
select 
	count(Distinct State) as Total_State
from Dim_Customer;

 -- total products --
select 
     count(*) as Total_products
from Dim_Product;

-- Category wise products ---
select 
	category,
	count(*) as Total_category
from Dim_Product
group by Category;

-- minimum, Average, maximum cost price
select 
	min(cost_price) as min_cost_price,
	avg(cost_price) as avg_cost_price,
	max(cost_price) as max_cost_price
from Dim_Product;


-- Total years --
select 
	count(distinct year) as total_years 
from Dim_Date;

-- minimum, Average, maximum Discount percentage
select 
	min(Discount_Percentage) as min_Discount_percentage,
	avg(Discount_percentage) as avg_Discount_percentage,
	max(discount_percentage) as max_discount_percentage
from Dim_Promotion;

-- total courier --
select 
	count( distinct courier) as Total_courier
from Dim_Shipping;

-- Total sales and orders ---
select 
	count(Sales_Id) as total_sales,
	count(Order_Id) as total_orders
from fact_sales;


select 
      min(unit_price) as min_unit_price,
	  avg(unit_price) as avg_unit_price,
	  max(unit_price) as max_unit_price
from fact_sales;

select
	  min(cost_price) as min_cost_price,
	  avg(cost_price) as avg_cost_price,
	  max(cost_price) as max_cost_price
from fact_sales;

select
	  min(discount_amount) as min_discount_amount,
	  avg(discount_amount) as avg_discount_amount,
	  max(discount_amount) as max_discount_amount
from fact_sales;


select
	  min(shipping_cost) as min_shipping_cost,
	  avg(shipping_cost) as avg_shipping_cost,
	  max(shipping_cost) as max_shipping_cost
from fact_sales;

-- total revenue , profit --
select
	sum(revenue) as total_revenue,
	sum(profit) as total_profit
from fact_sales;

-- region wise revenue --
select 
     c.region,
	  sum(fs.revenue) as total_revenue
from dim_customer c
join Fact_Sales fs on c.Customer_ID = fs.Customer_ID
where Return_Status = 'No'
group by c.region
order by total_revenue desc;

-- category wise total orders , revenue where the order is returned --
select 
     c.region,
	 count(order_ID) as total_orders,
	  sum(fs.revenue) as total_revenue_returned
from dim_customer c
join Fact_Sales fs on c.Customer_ID = fs.Customer_ID
where Return_Status = 'Yes'
group by c.region
order by total_revenue_returned desc;

-- total orders region wise the product is not returned --
select 
	c.region,
	count(order_Id) as total_order_placed
from Dim_Customer c join Fact_Sales fs on c.customer_id = fs.customer_id
where Return_Status = 'No'
group by c.region;

-- total orders, revenue, profit by Category --
select 
	p.Category,
	count(fs.order_id) as total_order,
	sum(fs.revenue) as total_revenue,
	sum(fs.profit) as toal_profit
from dim_product p join fact_sales fs on p.product_id = fs.product_id
where return_status = 'No'
group by p.category;

-- avg discount per based on the promotion type --
select 
	promotion_type,
	avg(discount_percentage) as avg_discount_percentage
from Dim_Promotion
group by promotion_type;

-- trend analysis ---

select 
	 d.year,
	 d.month,
	 sum(revenue) as revenue_trend,
	 sum(Profit) as profit_trend,
	 sum(discount_amount) as discount_trend
from dim_date d join fact_sales fs on d.date_id =fs.date_id 
group by d.year, d.month
order by d.year, d.month desc;

-- region wise dicount amount ---
select 
	c.region,
	sum(fs.discount_amount) as discount_amount
from Dim_Customer c join fact_sales fs on c.customer_id = fs.customer_id
group by c.region;

-- category wise discount amount ---
select
	p.category,
	sum(fs.discount_amount) as discount_amount
from dim_product p join fact_sales fs on p.product_id = fs.product_id
group by p.category;


	