


--- Data Validation ----

SELECT COUNT(*) AS Dim_Date FROM Dim_Date;
SELECT COUNT(*) AS Dim_Date FROM Dim_Customer;
SELECT COUNT(*) AS Dim_Date FROM Dim_Product;
SELECT COUNT(*) AS Dim_Date FROM Dim_Promotion;
SELECT COUNT(*) AS Dim_Date FROM Dim_Shipping;
SELECT COUNT(*) AS Dim_Date FROM Fact_Sales;

select 
    *
from Fact_sales
where Profit < 0;

SELECT *
FROM Dim_Customer
WHERE Age < 18
   OR Age > 65;

-- Duplicate Primary keys --

SELECT Sales_ID, COUNT(*) AS Duplicate_Count
FROM Fact_Sales
GROUP BY Sales_ID
HAVING COUNT(*) > 1;

SELECT Customer_ID, COUNT(*) AS Duplicate_Count
FROM Dim_Customer
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

SELECT Product_ID, COUNT(*) AS Duplicate_Count
FROM Dim_Product
GROUP BY Product_ID
HAVING COUNT(*) > 1;

SELECT Date_ID, COUNT(*) AS Duplicate_Count
FROM Dim_Date
GROUP BY Date_ID
HAVING COUNT(*) > 1;

SELECT Promotion_ID, COUNT(*) AS Duplicate_Count
FROM Dim_Promotion
GROUP BY Promotion_ID
HAVING COUNT(*) > 1;

SELECT Shipping_ID, COUNT(*) AS Duplicate_Count
FROM Dim_Shipping
GROUP BY Shipping_ID
HAVING COUNT(*) > 1;

-- Null Value Check --

SELECT 
    SUM(CASE WHEN Customer_ID is null then 1 else 0 end) as customer_id_nulls,
    SUM(CASE WHEN Customer_Name is null then 1 else 0 end) as customer_Name_nulls,
    SUM(CASE WHEN Gender is null then 1 else 0 end) as Gender_nulls,
    SUM(CASE WHEN Age is null then 1 else 0 end) as Age_nulls,
    SUM(CASE WHEN Customer_Segment is null then 1 else 0 end) as Customer_Segment_nulls,
    SUM(CASE WHEN City is null then 1 else 0 end) as City_nulls,
    SUM(CASE WHEN State is null then 1 else 0 end) as State_nulls,
    SUM(CASE WHEN Region is null then 1 else 0 end) as Region_nulls,
    SUM(CASE WHEN Join_Date is null then 1 else 0 end) as Join_Date_nulls
FROM Dim_Customer;

SELECT 
    SUM(CASE WHEN Product_ID is null then 1 else 0 end) as Product_ID_nulls,
    SUM(CASE WHEN Product_Name is null then 1 else 0 end) as Product_Name_nulls,
    SUM(CASE WHEN Category is null then 1 else 0 end) as Category_nulls,
    SUM(CASE WHEN Brand is null then 1 else 0 end) as Brand_nulls,
    SUM(CASE WHEN Supplier is null then 1 else 0 end) as Supplier_nulls,
    SUM(CASE WHEN Cost_Price is null then 1 else 0 end) as Cost_Price_nulls,
    SUM(CASE WHEN MRP is null then 1 else 0 end) as MRP_nulls,
    SUM(CASE WHEN Margin_Percentage is null then 1 else 0 end) as Margin_Percentage_nulls
FROM Dim_Product;

SELECT
    SUM(CASE WHEN Sales_ID IS NULL THEN 1 ELSE 0 END) AS Sales_ID_Nulls,
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS Order_ID_Nulls,
    SUM(CASE WHEN Date_ID IS NULL THEN 1 ELSE 0 END) AS Date_ID_Nulls,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Nulls,
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS Product_ID_Nulls,
    SUM(CASE WHEN Promotion_ID IS NULL THEN 1 ELSE 0 END) AS Promotion_ID_Nulls,
    SUM(CASE WHEN Shipping_ID IS NULL THEN 1 ELSE 0 END) AS Shipping_ID_Nulls,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_Nulls,
    SUM(CASE WHEN Unit_Price IS NULL THEN 1 ELSE 0 END) AS Unit_Price_Nulls,
    SUM(CASE WHEN Cost_Price IS NULL THEN 1 ELSE 0 END) AS Cost_Price_Nulls,
    SUM(CASE WHEN Discount_Amount IS NULL THEN 1 ELSE 0 END) AS Discount_Amount_Nulls,
    SUM(CASE WHEN Shipping_Cost IS NULL THEN 1 ELSE 0 END) AS Shipping_Cost_Nulls,
    SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END) AS Revenue_Nulls,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Profit_Nulls,
    SUM(CASE WHEN Return_Status IS NULL THEN 1 ELSE 0 END) AS Return_Status_Nulls,
    SUM(CASE WHEN Return_Reason IS NULL THEN 1 ELSE 0 END) AS Return_Reason_Nulls
FROM Fact_Sales;

SELECT
    SUM(CASE WHEN Date_ID IS NULL THEN 1 ELSE 0 END) AS Date_ID_Nulls,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Date_Nulls,
    SUM(CASE WHEN Day IS NULL THEN 1 ELSE 0 END) AS Day_Nulls,
    SUM(CASE WHEN Month IS NULL THEN 1 ELSE 0 END) AS Month_Nulls,
    SUM(CASE WHEN Month_Name IS NULL THEN 1 ELSE 0 END) AS Month_Name_Nulls,
    SUM(CASE WHEN Quarter IS NULL THEN 1 ELSE 0 END) AS Quarter_Nulls,
    SUM(CASE WHEN Year IS NULL THEN 1 ELSE 0 END) AS Year_Nulls,
    SUM(CASE WHEN Weekday IS NULL THEN 1 ELSE 0 END) AS Weekday_Nulls,
    SUM(CASE WHEN Weekend IS NULL THEN 1 ELSE 0 END) AS Weekend_Nulls
FROM Dim_Date;

SELECT
    SUM(CASE WHEN Promotion_ID IS NULL THEN 1 ELSE 0 END) AS Promotion_ID_Nulls,
    SUM(CASE WHEN Promotion_Name IS NULL THEN 1 ELSE 0 END) AS Promotion_Name_Nulls,
    SUM(CASE WHEN Promotion_Type IS NULL THEN 1 ELSE 0 END) AS Promotion_Type_Nulls,
    SUM(CASE WHEN Discount_Percentage IS NULL THEN 1 ELSE 0 END) AS Discount_Percentage_Nulls
FROM Dim_Promotion;

SELECT
    SUM(CASE WHEN Shipping_ID IS NULL THEN 1 ELSE 0 END) AS Shipping_ID_Nulls,
    SUM(CASE WHEN Courier IS NULL THEN 1 ELSE 0 END) AS Courier_Nulls,
    SUM(CASE WHEN Shipping_Mode IS NULL THEN 1 ELSE 0 END) AS Shipping_Mode_Nulls,
    SUM(CASE WHEN Warehouse IS NULL THEN 1 ELSE 0 END) AS Warehouse_Nulls,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Region_Nulls
FROM Dim_Shipping;

-- Relationship Validation --

SELECT *
FROM Fact_Sales F
LEFT JOIN Dim_Customer C
ON F.Customer_ID = C.Customer_ID
WHERE C.Customer_ID IS NULL;

SELECT *
FROM Fact_Sales F
LEFT JOIN Dim_Product P
ON F.Product_ID = P.Product_ID
WHERE P.Product_ID IS NULL;


SELECT *
FROM Fact_Sales F
LEFT JOIN Dim_Promotion Pr
ON F.Promotion_ID = Pr.Promotion_ID
WHERE Pr.Promotion_ID IS NULL;


SELECT *
FROM Fact_Sales F
LEFT JOIN Dim_Shipping S
ON F.Shipping_ID = S.Shipping_ID
WHERE S.Shipping_ID IS NULL;

SELECT *
FROM Fact_Sales F
LEFT JOIN Dim_Date D
ON F.Date_ID = D.Date_ID
WHERE D.Date_ID IS NULL;