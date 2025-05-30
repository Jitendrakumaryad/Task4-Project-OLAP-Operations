CREATE DATABASE sales_analysis;
USE sales_analysis;

CREATE TABLE sales_sample (
    Product_Id INT,
    Product_Name VARCHAR(50),
    Region VARCHAR(50),
    Sale_Date DATE,
    Sales_Amount NUMERIC(10,2)
);

------ 2.Data Creation


INSERT INTO sales_sample (Product_Id, Product_Name, Region, Sale_Date, Sales_Amount) VALUES
(101, 'Tata Tea', 'East', '2025-05-01', 1500),
(102, 'Parle-G Biscuits', 'West', '2025-05-02', 2000),
(103, 'Amul Butter', 'North', '2025-05-03', 2500),
(104, 'Bournvita', 'South', '2025-05-01', 1800),
(101, 'Tata Tea', 'West', '2025-05-02', 1200),
(102, 'Parle-G Biscuits', 'South', '2025-05-03', 1600),
(103, 'Amul Butter', 'East', '2025-05-01', 2200),
(104, 'Bournvita', 'North', '2025-05-03', 2100),
(101, 'Tata Tea', 'South', '2025-05-02', 1700),
(104, 'Bournvita', 'West', '2025-05-03', 1900);

--- 3.Perform OLAP operations(A-Drill Down-Analyze sales data at a more detailed level. Write a query to perform drill down from region to product level to understand sales performance.)

--- Get more detailed sales data per product within each region. 

SELECT Region, Product_Name, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_Name
ORDER BY Region, Product_Name;

---- 3.Perform OLAP operations (B-Rollup- To summarize sales data at different levels of granularity. Write a query to perform roll up from product to region level to view total sales by region.)

--- Aggregate sales by Region (higher level of granularity).

SELECT Region, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region
ORDER BY Region;

---- 3.Perform OLAP operations (C-Cube - To analyze sales data from multiple dimensions simultaneously. Write a query to Explore sales data from different perspectives, such as product, region, and date.)
---- Since MySQL does not have a direct CUBE() function like SQL Server. Hence, simulating it using GROUP BY WITH ROLLUP

SELECT 
    COALESCE(Product_Name, 'ALL Products') AS Product,
    COALESCE(Region, 'ALL Regions') AS Region,
    COALESCE(Sale_Date, 'ALL Dates') AS Date,
    SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Product_Name, Region, Sale_Date WITH ROLLUP;

---- 3.Perform OLAP operations (D-Slice- To extract a subset of data based on specific criteria. Write a query to slice the data to view sales for a particular region or date range.)

--- Slice for Region = ‘North’
SELECT * 
FROM sales_sample 
WHERE Region = 'North';

---- 3.Perform OLAP operations (E-Dice - To extract data based on multiple criteria. Write a query to view sales for specific combinations of product, region, and date.)

-- View sales of Bournvita in the West region on 2025-05-03.

SELECT * 
FROM sales_sample
WHERE Product_Name = 'Bournvita'
  AND Region = 'West'
  AND Sale_Date = '2025-05-03';

