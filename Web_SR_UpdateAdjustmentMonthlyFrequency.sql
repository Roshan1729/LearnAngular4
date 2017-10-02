
CREATE PROCEDURE [dbo].[Web_SR_UpdateAdjustmentMonthlyFrequency]
    @AdjustmentID INT,
    @ReverseChecked BIT = 0,
    @DuplicateChecked BIT = 0,
    @UpdateUser VARCHAR(1000)
AS
SET NOCOUNT ON;

DECLARE @AdjustmentDate DATETIME = GETDATE();
DECLARE @PeriodID INT;
DECLARE @CompanyID NVARCHAR;

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
	, AdjustmentAmountLCY
	, AdjustmentCostLCY
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
    
