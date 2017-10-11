USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_UpdateAdjustmentMonthlyFrequency]    Script Date: 10/11/2017 12:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

　
 
ALTER PROCEDURE [dbo].[Web_SR_UpdateAdjustmentMonthlyFrequency]
    @AdjustmentID INT,
    @ReverseChecked BIT = 0,
    @DuplicateChecked BIT = 0,
    @UpdateUser VARCHAR(1000)
AS
SET NOCOUNT ON;

DECLARE @AdjustmentDate DATETIME = GETDATE();
DECLARE @PeriodID INT;
DECLARE @CompanyID INT;
DECLARE @CurrencyID INT;
DECLARE @AdjustmentAmountSpotUSD MONEY;
DECLARE @AdjustmentCostSpotUSD MONEY;
DECLARE @AdjustmentAmountAvgUSD MONEY;
DECLARE @AdjustmentCostAvgUSD MONEY;
--DECLARE @AdjustmentAmountSpotUSD MONEY;

　
IF @ReverseChecked = 1
BEGIN
    SET @AdjustmentDate = (SELECT PeriodEndDate
    FROM Period
    WHERE DATEADD(MONTH,DATEDIFF(MONTH,1,GETDATE())+1,-1) BETWEEN PeriodStartDate AND PeriodEndDate);

    SET @PeriodID = (SELECT Period
    FROM Period
    WHERE DATEADD(MONTH,DATEDIFF(MONTH,1,GETDATE())+1,-1) BETWEEN PeriodStartDate AND PeriodEndDate);

	
    INSERT INTO [CSIDW].[dbo].[AdjustmentTemplate]
        (AdjustmentQuantity, AdjustmentAmount, AdjustmentCost, AdjustmentFrequency, AdjustmentTypeID,AdjustmentComment
        , CountryID, SubBusinessUnitID, SubSegmentID, AccountSubTypeID, SubCategoryID, CompanyID
        , UpdateUser, UpdateDate)
    SELECT (-1*AdjustmentQuantity) AS AdjustmentQuantity,
        (-1*AdjustmentAmount) AS AdjustmentAmount, (-1*AdjustmentCost) AS AdjustmentCost,
        AdjustmentFrequency, AdjustmentTypeID, CASE WHEN LEFT(AdjustmentComment, 6) = 'REV - '  
                THEN AdjustmentComment
                    ELSE 'REV - ' + AdjustmentComment
                END AS AdjustmentComment, CountryID, SubBusinessUnitID, SubSegmentID,
        AccountSubTypeID, SubCategoryID, CompanyID, @UpdateUser, GETDATE()
    FROM [CSIDW].[dbo].[AdjustmentTemplate]
    WHERE [AdjustmentTemplateID] = @AdjustmentID;
    
    SET @AdjustmentID = SCOPE_IDENTITY();
END

　
IF @DuplicateChecked = 1
BEGIN
    SET @AdjustmentDate = (SELECT PeriodEndDate
    FROM Period
    WHERE DATEADD(MONTH,DATEDIFF(MONTH,-1,GETDATE())-1,-1) BETWEEN PeriodStartDate AND PeriodEndDate);

    SET @PeriodID = (SELECT Period
    FROM Period
    WHERE DATEADD(MONTH,DATEDIFF(MONTH,-1,GETDATE())-1,-1) BETWEEN PeriodStartDate AND PeriodEndDate);

    INSERT INTO [CSIDW].[dbo].[AdjustmentTemplate]
        (AdjustmentQuantity, AdjustmentAmount, AdjustmentCost, AdjustmentFrequency, AdjustmentTypeID,AdjustmentComment
        , CountryID, SubBusinessUnitID, SubSegmentID, AccountSubTypeID, SubCategoryID, CompanyID
        , UpdateUser, UpdateDate)
    SELECT AdjustmentQuantity, AdjustmentAmount	, AdjustmentCost,
        AdjustmentFrequency, AdjustmentTypeID, AdjustmentComment, CountryID, SubBusinessUnitID, SubSegmentID,
        AccountSubTypeID, SubCategoryID, CompanyID, @UpdateUser, GETDATE()
    FROM [CSIDW].[dbo].[AdjustmentTemplate]
    WHERE [AdjustmentTemplateID] = @AdjustmentID;
END

SET @CompanyID = (SELECT CompanyID
FROM [CSIDW].[dbo].[AdjustmentTemplate]
WHERE [AdjustmentTemplateID] = @AdjustmentID);

　
INSERT INTO [CSIDW].[dbo].[Adjustment]
    (
    [AdjustmentDate]
    ,[PeriodID]
    ,[AdjustmentQuantity]
    ,[AdjustmentAmountLCY]
    ,[AdjustmentCostLCY]
    ,[AdjustmentTypeID]
    ,[AdjustmentComment]
    ,[CountryID]
    ,[SubBusinessUnitID]
    ,[CompanyID]
    ,[SubSegmentID]
    ,[AccountSubTypeID]
    ,[SubCategoryID]
    ,[UpdateUser]
    ,[UpdateDate]
    )
SELECT @AdjustmentDate
	, @PeriodID
	, AdjustmentQuantity
	, AdjustmentAmount
	, AdjustmentCost
	, AdjustmentTypeID
	, CASE WHEN LEFT(AdjustmentComment, 6) = 'REV - '  
                THEN RIGHT(AdjustmentComment, LEN(AdjustmentComment) - 6)
                    ELSE AdjustmentComment
                END AS AdjustmentComment
	, CountryID
	, SubBusinessUnitID
	, CompanyID
	, SubSegmentID
	, AccountSubTypeID
	, SubCategoryID 
	, @UpdateUser
	, GETDATE()
FROM [CSIDW].[dbo].[AdjustmentTemplate]
WHERE [AdjustmentTemplateID] = @AdjustmentID;

　
SET @AdjustmentID = SCOPE_IDENTITY();

　
SET @CurrencyID = (
		SELECT TOP 1
    CurrencyID
FROM Currency
WHERE CurrencyCode IN (
				SELECT CompanyLocalCurrency
FROM Company
WHERE CompanyID = @CompanyID )
		);
SET @AdjustmentAmountSpotUSD = (
		SELECT TOP 1
    a.AdjustmentAmountLCY * d.SpotRate
FROM Adjustment a
    LEFT JOIN Company b ON a.CompanyID = b.CompanyID
    LEFT JOIN Currency c ON b.CompanyLocalCurrency = c.CurrencyCode
    LEFT JOIN CurrencyRate d ON c.CurrencyCode = d.FromCurrencyCode
WHERE YEAR(a.AdjustmentDate) = YEAR(d.CurrencyRateDate)
    AND MONTH(a.AdjustmentDate) = MONTH(d.CurrencyRateDate)
    AND a.[AdjustmentID] = @AdjustmentID
		);
SET @AdjustmentCostSpotUSD = (
		SELECT TOP 1
    a.AdjustmentCostLCY * d.SpotRate
FROM Adjustment a
    LEFT JOIN Company b ON a.CompanyID = b.CompanyID
    LEFT JOIN Currency c ON b.CompanyLocalCurrency = c.CurrencyCode
    LEFT JOIN CurrencyRate d ON c.CurrencyCode = d.FromCurrencyCode
WHERE YEAR(a.AdjustmentDate) = YEAR(d.CurrencyRateDate)
    AND MONTH(a.AdjustmentDate) = MONTH(d.CurrencyRateDate)
    AND a.[AdjustmentID] = @AdjustmentID
		);
SET @AdjustmentAmountAvgUSD = (
		SELECT TOP 1
    a.AdjustmentAmountLCY * d.AverageRate
FROM Adjustment a
    LEFT JOIN Company b ON a.CompanyID = b.CompanyID
    LEFT JOIN Currency c ON b.CompanyLocalCurrency = c.CurrencyCode
    LEFT JOIN CurrencyRate d ON c.CurrencyCode = d.FromCurrencyCode
WHERE YEAR(a.AdjustmentDate) = YEAR(d.CurrencyRateDate)
    AND MONTH(a.AdjustmentDate) = MONTH(d.CurrencyRateDate)
    AND a.[AdjustmentID] = @AdjustmentID
		);
SET @AdjustmentCostAvgUSD = (
		SELECT TOP 1
    a.AdjustmentCostLCY * d.AverageRate
FROM Adjustment a
    LEFT JOIN Company b ON a.CompanyID = b.CompanyID
    LEFT JOIN Currency c ON b.CompanyLocalCurrency = c.CurrencyCode
    LEFT JOIN CurrencyRate d ON c.CurrencyCode = d.FromCurrencyCode
WHERE YEAR(a.AdjustmentDate) = YEAR(d.CurrencyRateDate)
    AND MONTH(a.AdjustmentDate) = MONTH(d.CurrencyRateDate)
    AND a.[AdjustmentID] = @AdjustmentID
		);

UPDATE [CSIDW].[dbo].[Adjustment]
SET [AdjustmentAmountSpotUSD] = @AdjustmentAmountSpotUSD
	,[AdjustmentCostSpotUSD] = @AdjustmentCostSpotUSD
	,[AdjustmentAmountAvgUSD] = @AdjustmentAmountAvgUSD
	,[AdjustmentCostAvgUSD] = @AdjustmentCostAvgUSD
	,[CurrencyID] = @CurrencyID
WHERE [AdjustmentID] = @AdjustmentID;







-------------------------


USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_AdjustmentFrequency]    Script Date: 10/11/2017 12:34:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Web_SR_AdjustmentFrequency]
    @Frequency NVARCHAR(100)
AS
SET NOCOUNT ON;

DECLARE @AdjustmentDate DATETIME = GETDATE();

　
IF @Frequency = 'D'
BEGIN
    SET @AdjustmentDate = 
    (SELECT CASE WHEN DATEPART(dw,GETDATE()) = 2 THEN 
        (SELECT DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 0)-3) 
        ELSE 
        (SELECT dateadd(day,datediff(day,1,GETDATE()),0))
    END);

    SELECT @AdjustmentDate As AdjustmentDate,
        a.AdjustmentTemplateID,
        h.Period,
        a.AdjustmentQuantity,
        a.AdjustmentAmount,
        a.AdjustmentCost,
        b.AdjustmentTypeName,
        c.CountryName,
        d.SubBusinessUnitName,
        g.CompanyName,
        e.SegmentName,
        f.AccountSubTypeName,
        i.SubCategoryName,
        a.AdjustmentComment
    FROM AdjustmentTemplate a
        INNER JOIN AdjustmentType b ON a.AdjustmentTypeID = b.AdjustmentTypeID
        INNER JOIN Country c ON a.CountryID = c.CountryID
        INNER JOIN SubBusinessUnit d ON a.SubBusinessUnitID = d.SubBusinessUnitID
        INNER JOIN Segment e ON a.SubSegmentID = e.SegmentID
        INNER JOIN AccountSubType f ON a.AccountSubTypeID = f.AccountSubTypeID
        INNER JOIN Company g ON a.CompanyID = g.CompanyID
        INNER JOIN (SELECT Period, PeriodStartDate, PeriodEndDate
        FROM Period) h ON DATEADD(day,DATEDIFF(day,0,GETDATE()),-1) BETWEEN PeriodStartDate AND PeriodEndDate
        INNER JOIN SubCategory i ON a.SubCategoryID = i.SubCategoryID
    WHERE a.AdjustmentFrequency = 'D';
END
ELSE
BEGIN

    SELECT
        CASE WHEN LEFT(a.AdjustmentComment, 6) = 'REV - '  
                THEN (SELECT PeriodEndDate
        FROM Period
        WHERE DATEADD(MONTH,DATEDIFF(MONTH,1,GETDATE())+1,-1) BETWEEN PeriodStartDate AND PeriodEndDate)
                    ELSE (SELECT PeriodEndDate
        FROM Period
        WHERE DATEADD(MONTH,DATEDIFF(MONTH,-1,GETDATE())-1,-1) BETWEEN PeriodStartDate AND PeriodEndDate)
                END AS AdjustmentDate,
        CASE WHEN LEFT(a.AdjustmentComment, 6) = 'REV - '  
                THEN (SELECT Period
        FROM Period
        WHERE DATEADD(MONTH,DATEDIFF(MONTH,1,GETDATE())+1,-1) BETWEEN PeriodStartDate AND PeriodEndDate)
                    ELSE (SELECT Period
        FROM Period
        WHERE DATEADD(MONTH,DATEDIFF(MONTH,-1,GETDATE())-1,-1) BETWEEN PeriodStartDate AND PeriodEndDate)
                END AS Period,
        CASE WHEN LEFT(a.AdjustmentComment, 6) = 'REV - '  
                THEN RIGHT(a.AdjustmentComment, LEN(a.AdjustmentComment) - 6)
                    ELSE a.AdjustmentComment
                END AS AdjustmentComment,
        --  h.PeriodEndDate As AdjustmentDate,
        a.AdjustmentTemplateID,
        -- h.Period,
        a.AdjustmentQuantity,
        a.AdjustmentAmount,
        a.AdjustmentCost,
        b.AdjustmentTypeName,
        c.CountryName,
        d.SubBusinessUnitName,
        g.CompanyName,
        e.SegmentName,
        f.AccountSubTypeName,
        i.SubCategoryName
    --   a.AdjustmentComment
    FROM AdjustmentTemplate a
        INNER JOIN AdjustmentType b ON a.AdjustmentTypeID = b.AdjustmentTypeID
        INNER JOIN Country c ON a.CountryID = c.CountryID
        INNER JOIN SubBusinessUnit d ON a.SubBusinessUnitID = d.SubBusinessUnitID
        INNER JOIN Segment e ON a.SubSegmentID = e.SegmentID
        INNER JOIN AccountSubType f ON a.AccountSubTypeID = f.AccountSubTypeID
        INNER JOIN Company g ON a.CompanyID = g.CompanyID
        INNER JOIN (SELECT Period, PeriodStartDate, PeriodEndDate, OpenPeriodFlag
        FROM Period) h ON DATEADD(MONTH,DATEDIFF(MONTH,-1,GETDATE())-1,-1) BETWEEN PeriodStartDate AND PeriodEndDate
        INNER JOIN SubCategory i ON a.SubCategoryID = i.SubCategoryID
    WHERE a.AdjustmentFrequency = 'M'
    --AND h.OpenPeriodFlag = 1
    ORDER BY b.AdjustmentTypeName,
		c.CountryName, d.SubBusinessUnitName, g.CompanyName, e.SegmentName, f.AccountSubTypeName,
		i.SubCategoryName

END
