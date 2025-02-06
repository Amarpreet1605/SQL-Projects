Select * from blinkit_data;

--Count of total rows
SELECT COUNT(*) FROM blinkit_data

--Converting 'LF' and 'low fat' to 'Low Fat' and 'reg' to 'Regular' to keep a single name for same meaning words
UPDATE blinkit_data
SET Item_Fat_Content = 
CASE
WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

--To check unique values in Item_Fat_Content
SELECT DISTINCT(Item_Fat_Content) FROM blinkit_data

--Total Sales of blinkit
SELECT CAST(SUM(Total_Sales)/1000000 AS decimal(10,2)) as Total_Sales_in_Millions FROM blinkit_data

--Average Sales of blinkit
SELECT CAST(AVG(Total_Sales) AS decimal(10,2)) FROM blinkit_data

--Total number of Items
SELECT COUNT(*) AS No_of_Items FROM blinkit_data

--Total 'Low Fat' Sales in Millions
SELECT CAST(SUM(Total_Sales)/1000000 AS decimal(10,2)) AS Low_Fat_Sales FROM blinkit_data WHERE Item_Fat_Content = 'Low Fat'

--Total Sales for outlet established in year 2022
SELECT CAST(SUM(Total_Sales)/1000000 AS decimal(10,2)) AS Sales_For_Outlet_Est_2022 FROM blinkit_data WHERE Outlet_Establishment_Year2 = 2022

--Average Rating
SELECT CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating FROM blinkit_data

--Total Sales by Fat Content where Outlet establishment date is 2020
SELECT Item_Fat_Content, 
	CAST(SUM(Total_Sales)/1000 AS decimal(10,2)) AS Total_Sales_Thousands, 
	CAST(AVG(Total_Sales) AS decimal(10,2)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year2 = 2020
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC

--Total Sales, Average Sales, Average Rating by Item Type
SELECT TOP 5 Item_Type,
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS decimal(10,2)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

--Total Sales, Average Sales, Average Rating by Outlet Location type and Fat Content
SELECT Item_Fat_Content, Outlet_Location_Type,
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS decimal(10,2)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content, Outlet_Location_Type
ORDER BY Total_Sales DESC

SELECT * FROM blinkit_data

--Total Sales by Outlet Establishment Year
SELECT Outlet_Establishment_Year2,
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS decimal(10,2)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year2
ORDER BY Outlet_Establishment_Year2

--Total Sales and Sales Percentage for every Outlet Size
SELECT Outlet_Size,
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales,
	CAST((SUM(Total_Sales) * 100/ SUM(SUM(Total_Sales)) OVER()) AS decimal(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC

--Total Sales by Outlet Location
SELECT Outlet_Location_Type,
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales,
	CAST((SUM(Total_Sales) * 100 / SUM(SUM(Total_Sales)) OVER()) AS decimal(10,2)) AS Sales_Percentage,
	CAST(AVG(Total_Sales) AS decimal(10,2)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC

--All Metrics(Total Sales, Average Sales, Average Rating) by Outlet Type
SELECT Outlet_Type,
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales,
	CAST((SUM(Total_Sales) * 100 / SUM(SUM(Total_Sales)) OVER()) AS decimal(10,2)) AS Sales_Percentage,
	CAST(AVG(Total_Sales) AS decimal(10,2)) AS Avg_Sales,
	COUNT(*) AS No_Of_Sales,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC