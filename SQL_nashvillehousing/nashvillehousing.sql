-- Selecting all columns from the table "nashvillehousing"

SELECT*FROM nashvillehousing

-- Standardize date

ALTER TABLE nashvillehousing
ADD Sale_Date DATE

SELECT CONVERT(DATE,SaleDate) FROM nashvillehousing

UPDATE nashvillehousing
SET Sale_Date = CONVERT(DATE,SaleDate)

ALTER TABLE nashvillehousing
DROP COLUMN SaleDate

-- LandUse grouping

SELECT DISTINCT(LandUse), COUNT(LandUse) AS LandUse_Count FROM nashvillehousing
GROUP BY LandUse
ORDER BY LandUse_Count DESC

-- Taking the sale year from SaleDate

SELECT Sale_Date FROM nashvillehousing

ALTER TABLE nashvillehousing
ADD Sale_Month nvarchar(25)

UPDATE nashvillehousing
SET Sale_Month = MONTH(Sale_Date) FROM nashvillehousing

ALTER TABLE nashvillehousing
ADD Sale_Year nvarchar(25)

UPDATE nashvillehousing
SET Sale_Year = YEAR(Sale_Date) FROM nashvillehousing

SELECT Sale_Date, SaleMonth, Sale_Year FROM nashvillehousing

SELECT CONVERT(varchar(3), Sale_Date, 100) AS Month FROM nashvillehousing

ALTER TABLE nashvillehousing
ADD SaleMonth varchar (3)

UPDATE nashvillehousing
SET SaleMonth = CONVERT(varchar(3), Sale_Date, 100)

-- Sale per year

SELECT DISTINCT(Sale_Year), COUNT (Sale_Year) AS Year_Count FROM nashvillehousing
GROUP BY Sale_Year
ORDER BY Sale_Year DESC

-- Year of built

SELECT DISTINCT(YearBuilt), COUNT(YearBuilt) AS YearBuilt_Count FROM nashvillehousing
WHERE YearBuilt IS NOT NULL 
AND YearBuilt >= 2000
GROUP BY YearBuilt
ORDER BY YearBuilt DESC

-- Average TotalValue per city

SELECT DISTINCT(Owner_City), AVG(TotalValue) AS AVGTotalValuePerCity FROM nashvillehousing
WHERE Owner_City IS NOT NULL
GROUP BY Owner_City
ORDER BY AVGTotalValuePerCity DESC

-- Average BuildingValue per city

SELECT DISTINCT(Owner_City), AVG(BuildingValue) AS AVGBuildingValuePerCity FROM nashvillehousing
WHERE Owner_City IS NOT NULL
GROUP BY Owner_City
ORDER BY AVGBuildingValuePerCity DESC

-- Average LandValue per city

SELECT DISTINCT(Owner_City), AVG(LandValue) AS AVGLandValuePerCity FROM nashvillehousing
WHERE Owner_City IS NOT NULL
GROUP BY Owner_City
ORDER BY AVGLandValuePerCity DESC

-- Breaking out owner's first and last names

SELECT SUBSTRING(OwnerName, CHARINDEX(',',OwnerName)+1, LEN(OwnerName)) AS OwnerFirstName FROM nashvillehousing
SELECT SUBSTRING(OwnerName,1,CHARINDEX(',',OwnerName)) AS OwnerLastName FROM nashvillehousing

ALTER TABLE nashvillehousing
ADD OwnerFirstName nvarchar (255)

UPDATE nashvillehousing
SET OwnerFirstName = SUBSTRING(OwnerName, CHARINDEX(',',OwnerName)+1, LEN(OwnerName))

ALTER TABLE nashvillehousing
ADD OwnerLastName nvarchar (255)

UPDATE nashvillehousing
SET OwnerLastName = SUBSTRING(OwnerName,1,CHARINDEX(',',OwnerName))

-- Replacing ',' with ' '

SELECT REPLACE(OwnerLastName,',',' ') FROM nashvillehousing

ALTER TABLE nashvillehousing
ADD Owner_LastName nvarchar (255)

UPDATE nashvillehousing
SET Owner_LastName = REPLACE(OwnerLastName,',',' ')

ALTER TABLE nashvillehousing
DROP COLUMN OwnerLastName

--Concatenating owner's first and last name
SELECT CONCAT(OwnerFirstName,' ',Owner_LastName) FROM nashvillehousing
