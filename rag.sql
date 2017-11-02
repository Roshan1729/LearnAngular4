USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_UpdateBusinessUnits]    Script Date: 11/1/2017 11:23:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Web_SR_UpdateBusinessUnits]
     @BusinessUnitID INT = NULL
	 ,@BusinessUnitCode INT = NULL
	 ,@BusinessUnitName NVARCHAR(100) = NULL
	,@EffectiveDate DATETIME
	,@ExpirationDate DATETIME = NULL
	,@CompanyName NVARCHAR(100) = NULL
	,@BusinessUnitManagerName NVARCHAR(100) = NULL
	,@UpdateUser NVARCHAR(100) = NULL
AS
SET NOCOUNT ON;

DECLARE @CompanyID INT = NULL;
DECLARE @BusinessUnitManagerID  INT=NULL;

IF (@CompanyName IS NOT NULL)
BEGIN
	SET @CompanyID = (
			SELECT TOP 1 [CompanyID]
			FROM [dbo].[Company]
			WHERE [CompanyName] = @CompanyName
			);
END

　
IF (@BusinessUnitManagerName IS NOT NULL)
BEGIN
	SET @BusinessUnitManagerID = (
			SELECT TOP 1 SR.[SalesRepID] AS [BusinessUnitManagerID] FROM [SalesRep] SR
INNER JOIN [CSIDW].[dbo].[SalesRepContact] SRC ON SRC.[SalesRepID] = SR.[SalesRepID] AND SRC.[ActiveRecord] = 'A' 
 INNER JOIN [CSIDW].[dbo].[SalesRepType] SRT ON SRT.[SalesRepTypeID] = SRC.[SalesRepTypeID] AND SRT.[SalesRepTypeCode] IN ('B')

			WHERE [SalesRepFirstName]+ ' ' +[SalesRepLastName] = @BusinessUnitManagerName
			);
END

　
IF EXISTS (SELECT [BusinessUnitCode] FROM [CSIDW].[dbo].[BusinessUnit] 
WHERE LOWER([BusinessUnitCode]) = RTRIM(LTRIM(LOWER(@BusinessUnitCode))) AND [ExpirationDate] IS NULL
AND [BusinessUnitID]!=@BusinessUnitID)
BEGIN
	SELECT 'Duplicate BusinessUnitCode'
END
ELSE 
BEGIN
IF EXISTS (SELECT [BusinessUnitName] FROM [CSIDW].[dbo].[BusinessUnit] 
WHERE LOWER([BusinessUnitName]) = RTRIM(LTRIM(LOWER(@BusinessUnitName))) AND [ExpirationDate] IS NULL
AND [BusinessUnitID]!=@BusinessUnitID)
BEGIN
	SELECT 'Duplicate BusinessUnitName'
END
ELSE 
BEGIN 
UPDATE [CSIDW].[dbo].[BusinessUnit]
SET [EffectiveDate] = @EffectiveDate
	,[BusinessUnitName] = @BusinessUnitName
	,[BusinessUnitCode]=@BusinessUnitCode
	,[ExpirationDate] = @ExpirationDate
	,[BusinessUnitManagerID] = @BusinessUnitManagerID
	,[CompanyID] = @CompanyID
	,[UpdateUser] = @UpdateUser
	,[UpdateDate] = GETDATE()
WHERE [BusinessUnitID] = @BusinessUnitID

	SELECT 'Success'
END
END
