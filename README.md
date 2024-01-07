# Data Analytics Power BI Report
- Milestone 2 Importing and transforming the data
- Milestone 3 Creating the data model
- Milestone 5 Customer Detail Page
- Milestone 6 Executive Summary Page
- Milestone 7 Product Detail Page
- Milestone 8 Stores Map Page
- Milestone 9 Cross-filtering and Navigation
- Milestone 10 SQL Queries

This was my final project for the AI Core Data Analytics Coure, in which I created a report in power BI with the following brief:
"You have recently been approached by a medium-sized international retailer who is keen on elevating their business intelligence practices. With operations spanning across different regions, they've accumulated large amounts of sales from disparate sources over the years.

Recognizing the value of this data, they aim to transform it into actionable insights for better decision-making. Your goal is to use Microsoft Power BI to design a comprehensive Quarterly report. This will involve extracting and transforming data from various origins, designing a robust data model rooted in a star-based schema, and then constructing a multi-page report.

The report will present a high-level business summary tailored for C-suite executives, and also give insights into their highest value customers segmented by sales region, provide a detailed analysis of top-performing products categorised by type against their sales targets, and a visually appealing map visual that spotlights the performance metrics of their retail outlets across different territories."

This was a useful project to consolidate the following:
- importing and transforming data
- using DAX expressions
- creating different visuals, filters and slicers
    
# Importing and transforming the data
Different tables in the project were loaded using the following methods:
1) Orders table - via Azure SQL database
2) Product dimension table - via csv file
3) Stores dimension table - via Azure Blob storage
4) Customers dimension table - via csv file

Tables were transformed to remove duplicate values, remove confidential information such as credit card details and standardise dates and weights used in the data.
For each of the following, click on the 'get data' option to start the process. Then, choose the appropriate option depending on the data source:

# Creating the data model

Date Table
I created a Date Table using the following DAX expression:
Date = 
ADDCOLUMNS (
CALENDAR (DATE (2010, 1, 1), DATE (2023, 12, 31)),
"Year", YEAR([Date]),
"MonthNumber", MONTH([Date]),
"Quarter", QUARTER([Date]),
"DayOfWeek", WEEKDAY([Date])
)

I then using expressions like the one below to create StartofMonth/Quarter/Year columns 
StartofMonth = MONTH('Date'[Date])

I also created a date hierarchy to faciliate drilling down into the data later on in the project - this was "start of year, quarter, month, date"

I created relationships between the tables to allow for measure calculation and analysis, with the model here below:
![image](https://github.com/DanielH2314/data-analytics-power-bi-report949/assets/147092367/43db7a5c-f7f1-48f7-a63b-cfc602a1aa1a)


Measure Table
For key measures I created the following DAX expressions in a new table, integral to the report page later on.

TotalOrders = COUNT(Orders[Product Code])
TotalProfit = SUMX(Orders, (RELATED(Products[Sale Price]) - RELATED(Products[Cost Price])) * Orders[Product Quantity])
TotalQuantity = SUM(Orders[Product Quantity])
TotalCustomers = DISTINCTCOUNT(Orders[User ID])
Total Revenue = SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale Price]))
RevenueYTD = CALCULATE(
[Total Revenue],
DATESYTD('Date'[Date])
)
ProfitYTD = CALCULATE(
[TotalProfit],
DATESYTD('Date'[Date])
)


Customer Detail Page
![image](https://github.com/DanielH2314/data-analytics-power-bi-report949/assets/147092367/b255ac61-ebcd-4ca5-81e7-ca607ebac851)


Executive Summary Page
![image](https://github.com/DanielH2314/data-analytics-power-bi-report949/assets/147092367/c5a24fde-5e2b-4bb9-aacf-f29b0e9a13c1)

Product Detail Page
![image](https://github.com/DanielH2314/data-analytics-power-bi-report949/assets/147092367/4c8f1b19-a831-4557-854b-72809c2d0530)

Stores Map Page
![image](https://github.com/DanielH2314/data-analytics-power-bi-report949/assets/147092367/ca8b9e46-cec5-45b1-b39b-b04c2c0b9c52)

The stores drillthrough page
![image](https://github.com/DanielH2314/data-analytics-power-bi-report949/assets/147092367/a061f6e2-8603-4f36-8f76-129469facd2d)

SQL Queries
The final part of the project included calculating metrics using SQL.
I connected to the SQL server through VS Code using the following access info:

Connection Name: OrdersDB
Connect using: Server and Port
Server address: powerbi-data-analytics-server.postgres.database.azure.com
Port: 5432
Database: orders-db
Username: ****
Password: Ask on connect

I queried the database to answer the following 5 questions below, with each answer uploaded as a .sql and .csv 
Q1. How many staff are there in UK stores?
Q2. In 2022, which month had the highest revenue?
Q3. In 2022, which German store had the highest revenue?
Q4. Create a table that has store types, total sales, percentage of total sales and order count.
Q5. Which product category generated the most profit for "Wiltshire, UK", in 2021?
