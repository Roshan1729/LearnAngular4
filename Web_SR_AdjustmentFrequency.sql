--------------------------------------
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
                END AS AdjustmentComment,
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
