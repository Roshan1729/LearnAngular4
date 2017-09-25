CREATE PROCEDURE [dbo].[Web_SR_GetNewCompanyData]
	@CompanyName NVARCHAR(1000)
AS
SET NOCOUNT ON;
SELECT DISTINCT '' AS CurrencyName, '' AS SubSegmentName  
-- FROM AdjustmentType a
-- INNER JOIN Company b ON a.CompanyID = b.CompanyID
-- WHERE b.CompanyName = @CompanyName;

-------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Web_SR_GetNewAdjustmentTypeName]
	@CompanyName NVARCHAR(1000)
AS
SET NOCOUNT ON;
SELECT DISTINCT AdjustmentTypeName 
FROM AdjustmentType a
INNER JOIN Company b ON a.CompanyID = b.CompanyID
WHERE b.CompanyName = @CompanyName;


-------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Web_SR_GetNewSubCategoryName]
	@CompanyName NVARCHAR(1000)
AS
SET NOCOUNT ON;
SELECT DISTINCT c.SubCategoryName
FROM AdjustmentType a
INNER JOIN Company b ON a.CompanyID = b.CompanyID
INNER JOIN SubCategory c ON a.SubCategoryID = c.SubCategoryID
WHERE b.CompanyName = @CompanyName;


-------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Web_SR_GetNewCountryName]
	@CompanyName NVARCHAR(1000)
AS
SET NOCOUNT ON;
SELECT DISTINCT CountryName
FROM Country a
INNER JOIN Company b ON a.CompanyID = b.CompanyID
WHERE b.CompanyName = @CompanyName;


-------------------------------------------------------------------------


CREATE PROCEDURE [dbo].[Web_SR_GetAdjustmentSubBusinessUnitName]
	@CompanyName NVARCHAR(1000)
AS
SET NOCOUNT ON;
SELECT DISTINCT SubBusinessUnitName
FROM SubBusinessUnit a
	INNER JOIN Company b ON a.CompanyID = b.CompanyID
WHERE CompanyName = @CompanyName;


-------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Web_SR_GetAdjustmentCountryName]
	@CompanyName NVARCHAR(1000)
AS
SET NOCOUNT ON;
SELECT DISTINCT CountryName
FROM Country a
	INNER JOIN Company b ON a.CompanyID = b.CompanyID
WHERE CompanyName = @CompanyName;


-------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Web_SR_GetAdjustmentSegmentName]
	@CompanyName NVARCHAR(1000)
AS
SET NOCOUNT ON;
SELECT DISTINCT SegmentName
FROM Company a
	INNER JOIN Segment b ON a.SubSegmentID = b.SegmentID
WHERE CompanyName = @CompanyName;


-------------------------------------------------------------------------


-------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Web_SR_GetAdjustmentAccountSubTypeName]
AS
SET NOCOUNT ON;
SELECT DISTINCT AccountSubTypeName
FROM AccountSubType a
	INNER JOIN AccountType b ON a.AccountTypeID = b.AccountTypeID
WHERE b.AccountTypeName = 'Adjustment';


-------------------------------------------------------------------------

USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_AdjustmentFrequency]    Script Date: 9/20/2017 1:53:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Web_SR_AdjustmentFrequency]
	@Frequency NVARCHAR(100)
AS
SET NOCOUNT ON;

IF @Frequency = 'D'
BEGIN
	SELECT DATEADD(day,DATEDIFF(day,0,GETDATE()),-1) As AdjustmentDate,
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
		'' As AdjustmentComment
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
	SELECT h.PeriodEndDate As AdjustmentDate,
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
		'' As AdjustmentComment
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
	WHERE a.AdjustmentFrequency = 'M' AND h.OpenPeriodFlag = 1

END
-------------------------------




USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_UpdateAdjustmentTemplate]    Script Date: 9/20/2017 1:56:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Web_SR_UpdateAdjustmentTemplate]
	@AdjustmentTemplateID INT = NULL,
	@AdjustmentQuantity FLOAT(53) = NULL	,
	@AdjustmentAmount MONEY = NULL	,
	@AdjustmentCost MONEY = NULL	,
	@UpdateUser NVARCHAR(100) = NULL	,
	@Frequency NVARCHAR(100) = NULL	,
	@AdjustmentDate DATETIME	,
	@AdjustmentComment NVARCHAR(4000),
	@CountryName NVARCHAR(100) = NULL	,
	@SubBusinessUnitTypeName NVARCHAR(100) = NULL	,
	@CompanyName NVARCHAR(100) = NULL	,
	@SubSegmentName NVARCHAR(100) = NULL	,
	@AccountSubTypeName NVARCHAR(100) = NULL	,
	@SubCategoryName NVARCHAR(100) = NULL,
	@ReverseChecked BIT,
	@DuplicateChecked BIT
AS
SET NOCOUNT ON;

DECLARE @AdjustmentAmountSpotUSD MONEY = NULL;
DECLARE @AdjustmentCostSpotUSD MONEY = NULL;
DECLARE @AdjustmentAmountAvgUSD MONEY = NULL;
DECLARE @AdjustmentCostAvgUSD MONEY = NULL;
DECLARE @AdjustmentID INT;
DECLARE @CurrencyID INT;
DECLARE @PeriodID INT;
DECLARE @CountryID INT = NULL;
DECLARE @SubBusinessUnitID INT = NULL;
DECLARE @CompanyID INT = NULL;
DECLARE @SubSegmentID INT = NULL;
DECLARE @AccountSubTypeID INT = NULL;
DECLARE @SubCategoryID INT = NULL;
--DECLARE @AdjustmentDate DATETIME;


SET @PeriodID = (
		SELECT Period
FROM Period
WHERE DATEADD(day,DATEDIFF(day,0,@AdjustmentDate),-1) BETWEEN PeriodStartDate AND PeriodEndDate
		);

IF (@CountryName IS NOT NULL)
BEGIN
	SET @CountryID = (
			SELECT TOP 1
		[CountryID]
	FROM [dbo].[Country]
	WHERE [CountryName] = @CountryName
			);
END

IF (@SubBusinessUnitTypeName IS NOT NULL)
BEGIN
	SET @SubBusinessUnitID = (
			SELECT TOP 1
		[SubBusinessUnitID]
	FROM [dbo].[SubBusinessUnit]
	WHERE [SubBusinessUnitName] = @SubBusinessUnitTypeName
			);
END

IF (@CompanyName IS NOT NULL)
BEGIN
	SET @CompanyID = (
			SELECT TOP 1
		[CompanyID]
	FROM [dbo].[Company]
	WHERE [CompanyName] = @CompanyName
			);
END

IF (@SubSegmentName IS NOT NULL)
BEGIN
	SET @SubSegmentID = (
			SELECT TOP 1
		[SubSegmentID]
	FROM [dbo].[SubSegment]
	WHERE LTRIM(RTRIM(REPLACE([SubSegmentName], CHAR(13) + CHAR(10), '')))  = @SubSegmentName
			);
END

IF (@AccountSubTypeName IS NOT NULL)
BEGIN
	SET @AccountSubTypeID = (
			SELECT TOP 1
		[AccountSubTypeID]
	FROM [dbo].[AccountSubType]
	WHERE [AccountSubTypeName] = @AccountSubTypeName
			);
END

IF (@SubCategoryName IS NOT NULL)
BEGIN
	SET @SubCategoryID = (
			SELECT TOP 1
		[SubCategoryID]
	FROM [dbo].[SubCategory]
	WHERE [SubCategoryName] = @SubCategoryName
			);
END

IF @Frequency = 'D' OR @Frequency = 'M'
BEGIN
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
	, @AdjustmentQuantity
	, @AdjustmentAmount
	, @AdjustmentCost
	, [AdjustmentTypeID]
	, @AdjustmentComment
	, @CountryID
	, @SubBusinessUnitID
	, @CompanyID
	, @SubSegmentID
	, @AccountSubTypeID
	, @SubCategoryID 
	, @UpdateUser
	, GETDATE()
	FROM [CSIDW].[dbo].[AdjustmentTemplate]
	WHERE [AdjustmentTemplateID] = @AdjustmentTemplateID;



	SET @AdjustmentID = SCOPE_IDENTITY();


	SET @CurrencyID = (
		SELECT TOP 1
		CurrencyID
	FROM Currency
	WHERE CurrencyCode IN (
				SELECT CurrencyCode
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

END

IF @Frequency = 'M'
BEGIN
	IF @ReverseChecked = 1
BEGIN
		INSERT INTO [CSIDW].[dbo].[AdjustmentTemplate]
			(AdjustmentQuantity, AdjustmentAmount, AdjustmentCost, AdjustmentFrequency, AdjustmentTypeID
			, CountryID, SubBusinessUnitID, SubSegmentID, AccountSubTypeID, SubCategoryID, CompanyID
			, UpdateUser, UpdateDate)
		SELECT (-1 * @AdjustmentQuantity) AS AdjustmentQuantity, (-1 * @AdjustmentAmount) AS AdjustmentAmount, (-1 * @AdjustmentCost) AS AdjustmentCost, 
																	AdjustmentFrequency, AdjustmentTypeID
 													, @CountryID, @SubBusinessUnitID, @SubSegmentID, @AccountSubTypeID, @SubCategoryID, @CompanyID
													 , @UpdateUser, GETDATE()
		FROM [CSIDW].[dbo].[AdjustmentTemplate]
		WHERE [AdjustmentTemplateID] = @AdjustmentTemplateID;
	END

	IF @DuplicateChecked = 1
BEGIN
		INSERT INTO [CSIDW].[dbo].[AdjustmentTemplate]
			(AdjustmentQuantity, AdjustmentAmount, AdjustmentCost, AdjustmentFrequency, AdjustmentTypeID
			, CountryID, SubBusinessUnitID, SubSegmentID, AccountSubTypeID, SubCategoryID, CompanyID
			, UpdateUser, UpdateDate)
		SELECT @AdjustmentQuantity	, @AdjustmentAmount	, @AdjustmentCost, AdjustmentFrequency, AdjustmentTypeID
 													, @CountryID, @SubBusinessUnitID, @SubSegmentID, @AccountSubTypeID, @SubCategoryID, @CompanyID
													 , @UpdateUser, GETDATE()
		FROM [CSIDW].[dbo].[AdjustmentTemplate]
		WHERE [AdjustmentTemplateID] = @AdjustmentTemplateID;
	END
END


--------------------------------------
