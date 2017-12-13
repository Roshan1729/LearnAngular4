USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_AddNewSalesRepresentative]    Script Date: 12/12/2017 10:24:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

　
ALTER PROCEDURE [dbo].[Web_SR_AddNewSalesRepresentative] 
	--@SalesRepContactID INT = NULL
	--,@SalesRepID INT =NULL
	 @SalesRepFirstName NVARCHAR(100)=NULL
	,@SalesRepLastName NVARCHAR(100)=NULL
	,@Title NVARCHAR(100) = NULL
	,@CustomerNumber NVARCHAR(100)=NULL
	,@SalesRepTypeName NVARCHAR(100)=NULL
	,@SalesRepCompanyName NVARCHAR(100)=NULL
	,@Address1 NVARCHAR(100)=NULL
	,@Address2 NVARCHAR(100)=NULL
	,@Address3 NVARCHAR(100)=NULL
	,@City NVARCHAR(100)=NULL
	,@StateProvinceName NVARCHAR(40)=NULL
	,@PostalCode NVARCHAR(40)=NULL
	,@CountryName NVARCHAR(100)=NULL
	,@HireDate DATETIME = NULL
	,@TerminationDate DATETIME = NULL
	,@WorkPhone NVARCHAR(60)=NULL
	,@VoiceMailExtension NVARCHAR(100)=NULL
	,@VoiceMailPin INT=NULL
	,@FaxNumber NVARCHAR(100)=NULL
	,@MobilePhone NVARCHAR(100)=NULL
	,@Pager NVARCHAR(100)=NULL
	,@PersonalCellPhone NVARCHAR(100)=NULL
	,@InternationalPhone NVARCHAR(100)=NULL
	,@InternationalFax NVARCHAR(100)=NULL
	,@InternationalCell NVARCHAR(100)=NULL
	,@ExternalRepStatus NVARCHAR(100)=NULL
	,@PrimaryEmail NVARCHAR(510)=NULL
	,@SecondaryEmail NVARCHAR(150)=NULL
	,@VendorID VARCHAR(50) =NULL
	,@Notes NVARCHAR(800) =NULL
	,@InventoryNotes NVARCHAR(800)=NULL
	,@DemoSigned DATETIME =NULL
	,@TerritoryName NVARCHAR(100)=NULL
	,@RegionName NVARCHAR(100)=NULL
	,@DistributionRegionName NVARCHAR(100)=NULL
	,@SubBusinessUnitName NVARCHAR(100)=NULL
	,@BusinessUnitName NVARCHAR(100)=NULL
	,@CompanyName NVARCHAR(250) = NULL
	--,@EffectiveDate DATETIME	
	,@ExpirationDate DATETIME = NULL	
	,@GlobalAddress NVARCHAR(100)=NULL
	,@UpdateUser NVARCHAR(100) = NULL
	,@UpdateDate DATETIME=NULL
	
AS
SET NOCOUNT ON;

DECLARE @SalesRepTypeID INT=NULL;
DECLARE @TerritoryID INT=NULL;
DECLARE @RegionID INT=NULL;
DECLARE @DistributionRegionID INT=NULL;
DECLARE @SubBusinessUnitID INT=NULL;
DECLARE @BusinessUnitID INT=NULL;
DECLARE @CompanyID INT=NULL;
DECLARE @CustomerID INT=NULL;
DECLARE @CountryID NVARCHAR(100)=NULL;
DECLARE @StateProvinceID NVARCHAR(100)=NULL;
DECLARE @PostalCodeID NVARCHAR(100)=NULL;
DECLARE @SalesRepID INT =NULL;

　
　
--DECLARE @AExpirationDate DATETIME = '2200-01-01';
--DECLARE @AEffectiveDate DATETIME = NULL;
--DECLARE @BExpirationDate DATETIME = '2200-01-01';
--DECLARE @BEffectiveDate DATETIME = NULL;

 
 IF (@HireDate IS NOT NULL)
BEGIN
	SET @HireDate = (
	select CONVERT(DATE, GETDATE())
			);
END
　
 IF (@TerminationDate IS NOT NULL)
BEGIN
	SET @TerminationDate = (
	select CONVERT(DATE, GETDATE())
			);
END
　
　
IF (@CompanyName IS NOT NULL)
BEGIN
	SET @CompanyID = (
			SELECT TOP 1 [CompanyID]
			FROM [dbo].[Company]
			WHERE [CompanyName] = @CompanyName
			);
END

　
IF (@SalesRepTypeName IS NOT NULL)
BEGIN
	SET @SalesRepTypeID = (
			SELECT TOP 1 [SalesRepTypeID]
			FROM [dbo].[SalesRepType]
			WHERE [SalesRepTypeName] = @SalesRepTypeName
			);
END

IF (@TerritoryName IS NOT NULL)
BEGIN
	SET @TerritoryID = (
			SELECT TOP 1 [TerritoryID]
			FROM [dbo].[Territory]
			WHERE (CAST([TerritoryCode] AS VARCHAR(20))+Space(3)+[TerritoryName]) = @TerritoryName
			);
END

IF (@RegionName IS NOT NULL)
BEGIN
	SET @RegionID = (
			SELECT TOP 1 [RegionID]
			FROM [dbo].[Region]
			WHERE (CAST([RegionCode] AS VARCHAR(20))+Space(3)+[RegionName]) = @RegionName
			);
END

　
IF (@DistributionRegionName IS NOT NULL)
BEGIN
	SET @DistributionRegionID = (
			SELECT TOP 1 [DistributionRegionID]
			FROM [dbo].[DistributionRegion]
			WHERE [DistributionRegionName] = @DistributionRegionName
			);
END

　
IF (@SubBusinessUnitName IS NOT NULL)
BEGIN
	SET @SubBusinessUnitID = (
			SELECT TOP 1 [SubBusinessUnitID]
			FROM [dbo].[SubBusinessUnit]
			WHERE (CAST([SubBusinessUnitCode] AS VARCHAR(20))+SPACE(3)+[SubBusinessUnitName]) = @SubBusinessUnitName
			);
END

IF (@BusinessUnitName IS NOT NULL)
BEGIN
	SET @BusinessUnitID = (
			SELECT TOP 1 [BusinessUnitID]
			FROM [dbo].[BusinessUnit]
			WHERE (CAST([BusinessUnitCode] AS VARCHAR(20))+Space(3)+[BusinessUnitName]) = @BusinessUnitName
			);
END

　
　
IF (@CountryName IS NOT NULL)
BEGIN
	SET @CountryID = (
			SELECT TOP 1 [CountryID]
			FROM [dbo].[Country]
			WHERE [CountryName] = @CountryName
			);
END
　
IF (@StateProvinceName IS NOT NULL)
BEGIN
	SET @StateProvinceID = (
			SELECT TOP 1 [StateProvinceID]
			FROM [dbo].[StateProvince]
			WHERE [StateProvinceName] = @StateProvinceName
			);
END

IF (@CustomerNumber IS NOT NULL)
BEGIN
	SET @CustomerID = (
			SELECT TOP 1 [CustomerID]
			FROM [dbo].[Customer]
			WHERE [CustomerNumber] = @CustomerNumber
			);
END

IF (@PostalCode IS NOT NULL)
BEGIN
	SET @PostalCodeID = (
			SELECT TOP 1 [PostalCodeID]
			FROM [dbo].[PostalCode]
			WHERE @PostalCode = @PostalCode
			);
END

　
　
IF NOT EXISTS (SELECT 1 FROM [dbo].[Customer]  WHERE [CustomerNumber] = @CustomerNumber) 
BEGIN
    SELECT 'Customer Number does not exists'
END
--ELSE　
IF NOT EXISTS (SELECT 1 FROM [dbo].[PostalCode]  WHERE [PostalCode] = @PostalCode) 
BEGIN
    SELECT 'PostalCode does not exists'
END
ELSE　

BEGIN
INSERT INTO [CSIDW].[dbo].[SalesRep] (
	--  [SalesRepID]
	  [SalesRepFirstName]
	  ,[SalesRepLastName]
	  ,[ExternalRep]
	  --,[UpdateDate]
	  --,[UpdateUser]
      --,[EffectiveDate]
	 -- ,[ExpirationDate]
	)
VALUES (
	--@SalesRepID
	@SalesRepFirstName
	,@SalesRepLastName
	,@ExternalRepStatus
	--,GETDATE()
	--,@UpdateUser
	--,@HireDate
	--,@TerminationDate
	);

SET @SalesRepID = (SELECT SCOPE_IDENTITY());	

　
INSERT INTO [CSIDW].[dbo].[SalesRepContact] (
	  [Title]
	  ,[SalesRepID]
	  ,[HireDate]
	  ,[TerminationDate]
	  ,[Notes]
	 -- ,[VendorID]
	  ,[DemoSigned]
	  ,[InventoryNotes]
      ,[BusinessUnitID]
	  ,[SubBusinessUnitID]
	  ,[RegionID]
	  ,[DistributionRegionID]
	  ,[CompanyID]
	  ,[SalesRepTypeID]
	  ,[TerritoryID]
	  ,[SalesRepCompanyName]
	  --,[VoiceMailExtension]
	  ,[FaxNumber]
	  ,[MobilePhone]
	 -- ,[Pager]
	  ,[PersonalCellPhone]
	  ,[InternationalPhone]
	  --,[InternationalFax]
	  ,[InternationalCell]
	  ,[PrimaryEmail]
	  ,[SecondaryEmail]
	  ,[Address1]
	  ,[Address2]
	  ,[Address3]
	  ,[City]
	  ,[StateProvinceID]
	  ,[PostalCodeID]
	  ,[CountryID]
	  ,[CustomerID]
	  ,[WorkPhone]
	 --,[updateUser]
	-- ,[UpdateDate]
	 -- ,[VoiceMailPin] 
     -- ,[EffectiveDate]
	)
VALUES (
	@Title
	,@SalesRepID
	,@HireDate
	,@TerminationDate
	,@Notes
	--,@VendorID
	,@DemoSigned
	,@InventoryNotes
	,@BusinessUnitID
	,@SubBusinessUnitID
	,@RegionID
	,@DistributionRegionID
	,@CompanyID
	,@SalesRepTypeID
	,@TerritoryID
	,@SalesRepCompanyName
	--,@VoiceMailExtension
	,@FaxNumber
	,@MobilePhone
	--,@Pager
	,@PersonalCellPhone
	,@InternationalPhone
	--,@InternationalFax
	,@InternationalCell
	,@PrimaryEmail
	,@SecondaryEmail
	,@Address1 
	,@Address2 
	,@Address3 
	,@City 
	,@StateProvinceID
	,@PostalCodeID 
	,@CountryID
	,@CustomerID 
	,@WorkPhone
	--,@UpdateUser
	--,GETDATE()
	--,@VoiceMailPin 
	--,@EffectiveDate
	);

　
	SELECT 'Success'
END

　
 
 
 
 -------------------------
 
 
 USE [CSIDW]

GO

/****** Object:  StoredProcedure [dbo].[Web_SR_GetSalesRepresentativeRecords]    Script Date: 12/12/2017 10:25:26 PM ******/

SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER ON

GO


　

ALTER PROCEDURE [dbo].[Web_SR_GetSalesRepresentativeRecords]

		@SalesRepLastName nvarchar(100) = NULL

		,@SalesRepTypeName nvarchar(100) = NULL

		,@CompanyName nvarchar(100)=null

		,@TerritoryName nvarchar(100) = NULL

		,@RegionName nvarchar(100) = NULL

		,@DistributionRegionName nvarchar(100) = NULL

		,@SubBusinessUnitName nvarchar(100) = NULL

		,@BusinessUnitName nvarchar(100) = NULL

		,@StateProvinceName nvarchar(100)= NULL

		,@CountryName nvarchar(100)=null

AS

BEGIN

SET NOCOUNT ON;


DECLARE @SQL NVARCHAR(MAX)

SET @SQL = 'SELECT [SalesRepContactID]

	  , SSN.[SalesRepFirstName]

	  , SSN.[SalesRepLastName]

	  , SSN.[SalesRepID]

      , SS.[Title]

      , SS.[HireDate]

      , SS.[TerminationDate]

	  , SS.[Notes]

	  , SS.[InventoryNotes]

	  --,SS.[VendorID]

	  , SS.[SalesRepCompanyName]

	  , SS.[DemoSigned]

	  , SS.[Address1]

	  , SS.[Address2]

	  , SS.[Address3]

	  , SS.[City]

	  , SP.[StateProvinceName]

	 , PC.[PostalCode]

	 , CO.[CountryName]

	  , SS.[WorkPhone]

	  --,SS.[VoiceMailPin]

	  --,SS.[VoiceMailExtension]

	  , SS.[FaxNumber]

	  , SS.[MobilePhone]

	 -- ,SS.[Pager]

	  , SS.[PersonalCellPhone]

	  , SS.[InternationalPhone]

	  , SS.[InternationalCell]

	  --,SS.[InternationalFax]

	  , SS.[PrimaryEmail]

	  , SS.[SecondaryEmail]

	  ,PC.[PostalCode]

	  ,SP.[StateProvinceName]

	  , SRT.[SalesRepTypeName]

	  , (CAST(T.[TerritoryCode] AS VARCHAR(20))+Space(3)+T.[TerritoryName])As [TerritoryName]

	  , (CAST(R.[RegionCode] AS VARCHAR(20))+Space(3)+R.[RegionName]) As [RegionName]

	  , DR.[CustomerNumber]

	  , (CAST(SB.[SubBusinessUnitCode] AS VARCHAR(20))+SPACE(3)+SB.[SubBusinessUnitName])As [SubBusinessUnitName]

	  , (CAST(B.[BusinessUnitCode] AS VARCHAR(20))+Space(3)+B.[BusinessUnitName]) As [BusinessUnitName]

	  , C.[CompanyName]

     -- ,SS.[EffectiveDate]

     -- ,SS.[ExpirationDate]

      , SS.[UpdateUser]

      , SS.[UpdateDate]= SELECT CAST (GETDATE() AS DATE)

FROM [CSIDW].[dbo].[SalesRepContact] SS ';


　

IF (@SalesRepLastName IS NOT NULL)

BEGIN

	SET @SQL = @SQL + 'INNER JOIN [CSIDW].[dbo].[SalesRep] SSN ON SSN.[SalesRepID] = SS.[SalesRepID] 

						AND SSN.[SalesRepLastName] = ''' + @SalesRepLastName + '''';

END

ELSE

BEGIN 

	SET @SQL = @SQL + 'LEFT JOIN [CSIDW].[dbo].[SalesRep] SSN ON SSN.[SalesRepID] = SS.[SalesRepID]';

END


IF (@SalesRepTypeName IS NOT NULL)

BEGIN

	SET @SQL = @SQL + 'INNER JOIN [CSIDW].[dbo].[SalesRepType] SRT ON SRT.[SalesRepTypeID] = SS.[SalesRepTypeID]

						 AND SRT.[SalesRepTypeName] = ''' + @SalesRepTypeName + '''';

END

ELSE

BEGIN 

	SET @SQL = @SQL + 'LEFT JOIN [CSIDW].[dbo].[SalesRepType] SRT ON SRT.[SalesRepTypeID] = SS.[SalesRepTypeID]';

END


　

IF (@CompanyName IS NOT NULL)

BEGIN

	SET @SQL = @SQL + 'INNER JOIN [CSIDW].[dbo].[Company]  C ON C.[CompanyID] = SS.[CompanyID]

						 AND C.[CompanyName] = ''' + @CompanyName + '''';

END

ELSE

BEGIN 

	SET @SQL = @SQL + 'LEFT JOIN [CSIDW].[dbo].[Company]  C ON C.[CompanyID] = SS.[CompanyID]';

END


IF (@TerritoryName IS NOT NULL)

BEGIN

	SET @SQL = @SQL + 'INNER JOIN [CSIDW].[dbo].[Territory] T ON T.[TerritoryID] = SS.[TerritoryID]

						AND (CAST(T.[TerritoryCode] AS NVARCHAR(20)) + SPACE(3) + T.[TerritoryName]) = ''' + @TerritoryName + '''';

END

ELSE

BEGIN 

	SET @SQL = @SQL + 'LEFT JOIN [CSIDW].[dbo].[Territory] T ON T.[TerritoryID] = SS.[TerritoryID]';

END


IF (@RegionName IS NOT NULL)

BEGIN

	SET @SQL = @SQL + 'INNER JOIN [CSIDW].[dbo].[Region] R ON R.[RegionID] = SS.[RegionID]

						 AND (CAST(R.[RegionCode] AS NVARCHAR(20)) + SPACE(3) + R.[RegionName]) = ''' + @RegionName + '''';

END

ELSE

BEGIN 

	SET @SQL = @SQL + 'LEFT JOIN [CSIDW].[dbo].[Region] R ON R.[RegionID] = SS.[RegionID]';

END


IF (@SubBusinessUnitName IS NOT NULL)

BEGIN

	SET @SQL = @SQL + 'INNER JOIN [CSIDW].[dbo].[SubBusinessUnit]  SB ON SB.[SubBusinessUnitID] = SS.[SubBusinessUnitID]

						 AND (CAST(SB.[SubBusinessUnitCode] AS VARCHAR(20))+SPACE(3)+SB.[SubBusinessUnitName])  = ''' + @SubBusinessUnitName + '''';

END

ELSE

BEGIN 

	SET @SQL = @SQL + 'LEFT JOIN [CSIDW].[dbo].[SubBusinessUnit]  SB ON SB.[SubBusinessUnitID] = SS.[SubBusinessUnitID]';

END


IF (@BusinessUnitName IS NOT NULL)

BEGIN

	SET @SQL = @SQL + 'INNER JOIN [CSIDW].[dbo].[BusinessUnit]  B ON B.[BusinessUnitID] = SS.[BusinessUnitID]

						 AND (CAST(B.[BusinessUnitCode] AS VARCHAR(20))+Space(3)+B.[BusinessUnitName])  = ''' + @BusinessUnitName + '''';

END

ELSE

BEGIN 

	SET @SQL = @SQL + 'LEFT JOIN [CSIDW].[dbo].[BusinessUnit]  B ON B.[BusinessUnitID] = SS.[BusinessUnitID]';

END


SET @SQL = @SQL + 'LEFT JOIN [CSIDW].[dbo].[Customer] DR ON DR.[CustomerID] = SS.[CustomerID]

					LEFT JOIN [CSIDW].[dbo].[StateProvince]  SP ON SP.[StateProvinceID] = SS.[StateProvinceID]

					LEFT JOIN [CSIDW].[dbo].[PostalCode]  PC ON PC.[PostalCodeID] = SS.[PostalCodeID]

					LEFT JOIN [CSIDW].[dbo].[Country]  CO ON CO.[CountryID] = SS.[CountryID]';

 

EXEC(@SQL);

END




-----------------------------------------


https://gist.github.com/adhipg/1600028




