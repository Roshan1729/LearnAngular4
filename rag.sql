USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_AddNewSubBusinessUnit]    Script Date: 10/23/2017 11:08:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

　
ALTER PROCEDURE [dbo].[Web_SR_AddNewSubBusinessUnit] 
	 @SubBusinessUnitCode INT = NULL
	 ,@SubBusinessUnitName NVARCHAR(100) = NULL
	 ,@CompanyName NVARCHAR(100) = NULL
	 ,@BusinessUnitName NVARCHAR(100)=NULL
	,@SubBusinessUnitManagerName NVARCHAR(100) = NULL
	,@EffectiveDate DATETIME
AS
SET NOCOUNT ON;
DECLARE @BusinessUnitID INT =NULL;
DECLARE @CompanyID INT = NULL;
DECLARE @SubBusinessUnitManagerID  NVARCHAR(100) = NULL;
DECLARE @SubBusinessUnitID INT=NULL;

IF (@CompanyName IS NOT NULL)
BEGIN
	SET @CompanyID = (
			SELECT TOP 1 [CompanyID]
			FROM [dbo].[Company]
			WHERE [CompanyName] = @CompanyName
			);
END

IF (@BusinessUnitName IS NOT NULL)
BEGIN
	SET @BusinessUnitID = (
			SELECT TOP 1 [BusinessUnitID]
			FROM [dbo].[BusinessUnit]
			WHERE [BusinessUnitName] = @BusinessUnitName
			);
END

IF (@SubBusinessUnitManagerName IS NOT NULL)
BEGIN
	SET @SubBusinessUnitManagerID = (
			SELECT TOP 1 [SalesRepFirstName]+ ' ' +[SalesRepLastName] AS [SubBusinessUnitManagerName] FROM [SalesRep] SR
INNER JOIN [CSIDW].[dbo].[SalesRepContact] SRC ON SRC.[SalesRepID] = SR.[SalesRepID] AND SRC.[ActiveRecord] = 'A' 
 INNER JOIN [CSIDW].[dbo].[SalesRepType] SRT ON SRT.[SalesRepTypeID] = SRC.[SalesRepTypeID] AND SRT.[SalesRepTypeCode] IN ('M', 'B')

			--WHERE [SubBusinessUnitManagerName] = @SubBusinessUnitManager
			);
END

IF EXISTS (SELECT [SubBusinessUnitCode] FROM [CSIDW].[dbo].[SubBusinessUnit] 
WHERE LOWER([SubBusinessUnitCode]) = RTRIM(LTRIM(LOWER(@SubBusinessUnitCode))) AND [ExpirationDate] IS NULL
 AND [SubBusinessUnitID] != @SubBusinessUnitID )
BEGIN
	SELECT 'Duplicate SubBusinessUnitCode'
END
ELSE 
BEGIN
IF EXISTS (SELECT [SubBusinessUnitName] FROM [CSIDW].[dbo].[SubBusinessUnit] 
WHERE LOWER([SubBusinessUnitName]) = RTRIM(LTRIM(LOWER(@SubBusinessUnitName))) AND [ExpirationDate] IS NULL
 AND [SubBusinessUnitID] != @SubBusinessUnitID )
BEGIN
	SELECT 'Duplicate SubBusinessUnitName'
END
ELSE 
BEGIN 
INSERT INTO [CSIDW].[dbo].[SubBusinessUnit] (
	   [SubBusinessUnitCode]
      ,[SubBusinessUnitName]
	  ,[SubBusinessUnitManagerID]
	  ,[BusinessUnitID]
	  ,[CompanyID]
      ,[EffectiveDate]
	)
VALUES (
	@SubBusinessUnitCode
	,@SubBusinessUnitName
	,@SubBusinessUnitManagerID
	,@BusinessUnitID
	,@CompanyID
	,@EffectiveDate
	);

	SELECT 'Success'
END
END

　
　
