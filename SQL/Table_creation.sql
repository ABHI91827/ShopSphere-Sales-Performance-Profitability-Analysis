
CREATE DATABASE Profitability_Analysis;

USE Profitability_Analysis;

-- Creation of Table ---
CREATE TABLE Dim_Customer
(
    Customer_ID      INT              PRIMARY KEY,

    Customer_Name    VARCHAR(100)     NOT NULL,

    Gender           VARCHAR(10),

    Age              INT,

    Customer_Segment VARCHAR(20),

    City             VARCHAR(50),

    State            VARCHAR(50),

    Region           VARCHAR(20),

    Join_Date        DATE
);

CREATE TABLE Dim_Product
(
    Product_ID      INT       PRIMARY KEY,

    Product_Name    VARCHAR(100),

    Category        VARCHAR(50),

    Brand           VARCHAR(50),

    Supplier        VARCHAR(50),

    Cost_Price      DECIMAL(10,2),

    MRP             DECIMAL(10,2),

    Margin_Percentage DECIMAL(5,2)
);


CREATE TABLE Dim_Date
(
    Date_ID INT PRIMARY KEY,

    Date DATE,

    Day INT,

    Month INT,

    Month_Name VARCHAR(20),

    Quarter INT,

    Year INT,

    Weekday VARCHAR(20),

    Weekend BIT
);




CREATE TABLE Dim_Promotion
(
    Promotion_ID INT PRIMARY KEY,

    Promotion_Name VARCHAR(100),

    Promotion_Type VARCHAR(50),

    Discount_Percentage DECIMAL(5,2)
);



CREATE TABLE Dim_Shipping
(
    Shipping_ID INT PRIMARY KEY,

    Courier VARCHAR(50),

    Shipping_Mode VARCHAR(30),

    Warehouse VARCHAR(30),

    Region VARCHAR(20)
);


CREATE TABLE Fact_Sales
(
    Sales_ID INT PRIMARY KEY,

    Order_ID INT,

    Date_ID INT,

    Customer_ID INT,

    Product_ID INT,

    Promotion_ID INT,

    Shipping_ID INT,

    Quantity INT,

    Unit_Price DECIMAL(10,2),

    Cost_Price DECIMAL(10,2),

    Discount_Amount DECIMAL(10,2),

    Shipping_Cost DECIMAL(10,2),

    Revenue DECIMAL(12,2),

    Profit DECIMAL(12,2),

    Return_Status VARCHAR(5),

    Return_Reason VARCHAR(50)
);


ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Date
FOREIGN KEY (Date_ID)
REFERENCES Dim_Date(Date_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Customer
FOREIGN KEY (Customer_ID)
REFERENCES Dim_Customer(Customer_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Product
FOREIGN KEY (Product_ID)
REFERENCES Dim_Product(Product_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Promotion
FOREIGN KEY (Promotion_ID)
REFERENCES Dim_Promotion(Promotion_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Shipping
FOREIGN KEY (Shipping_ID)
REFERENCES Dim_Shipping(Shipping_ID);