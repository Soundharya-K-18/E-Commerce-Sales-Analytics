drop database ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE orders (
Order_ID VARCHAR(50),
Order_Date DATE,
Customer_Name VARCHAR(100),
Region VARCHAR(50),
Category VARCHAR(50),
Sub_Category VARCHAR(50),
Sales FLOAT,
Profit FLOAT
);
desc orders;
SHOW VARIABLES LIKE 'Secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/superstore.csv'
INTO TABLE orders
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Order_ID, @Order_Date, Customer_Name, Region, Category, Sub_Category, Sales, Profit)
SET Order_Date =
    CASE
        WHEN @Order_Date LIKE '%/%'
            THEN STR_TO_DATE(@Order_Date, '%m/%d/%Y')
        WHEN @Order_Date LIKE '%-%'
            THEN STR_TO_DATE(@Order_Date, '%d-%m-%Y')
    END;
    
SELECT * FROM Orders;
SELECT ROUND(SUM(Sales),2) AS Total_Sales FROM orders;
SELECT ROUND(SUM(Profit),2) AS Total_Profit FROM orders;

SELECT Region, ROUND(SUM(Sales),2) AS Regional_Sales FROM orders
GROUP BY Region ORDER BY Regional_Sales DESC;

SELECT Category, ROUND(SUM(Profit),2) AS Total_Profit FROM orders
GROUP BY Category ORDER BY Total_Profit DESC;

SELECT Customer_Name, ROUND(SUM(Sales),2) AS Total_Sales FROM orders
GROUP BY Customer_Name ORDER BY Total_Sales DESC
LIMIT 5;

SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Month, ROUND(SUM(Sales),2) AS Monthly_Sales
FROM orders
GROUP BY Month ORDER BY Monthly_Sales DESC;

SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Month, ROUND(SUM(Sales),2) AS Monthly_Sales
FROM orders
GROUP BY Month ORDER BY Month;

SELECT ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin FROM orders;
    
