
　
ALTER PROCEDURE [dbo].[Web_SR_UpdateSalesRepresentative]
     @SalesRepContactID INT = NULL
	,@TerminationDate DATETIME
	,@HireDate DATETIME	
	,@DemoSigned DATETIME
	,@Title NVARCHAR(250) = NULL
	,@CompanyName NVARCHAR(250) = NULL
	,@SalesRepCompanyName NVARCHAR(100)=NULL
	,@WorkPhone NVARCHAR(100)=NULL
	,@SalesRepTypeName NVARCHAR(100)=NULL
	,@TerritoryName NVARCHAR(100)=NULL
	,@RegionName NVARCHAR(100)=NULL
	,@SubBusinessUnitName NVARCHAR(100)=NULL
	,@BusinessUnitName NVARCHAR(100)=NULL
	,@VoiceMailExtension NVARCHAR(50)=NULL
	,@FaxNumber NVARCHAR(50)=NULL
	,@MobilePhone NVARCHAR(50)=NULL
	,@Address1 NVARCHAR(300)=NULL
	,@Address2 NVARCHAR(300)=NULL
	,@Address3 NVARCHAR(300)=NULL
	,@Pager NVARCHAR(50)=NULL
	,@Notes NVARCHAR(800)=NULL
	,@InventoryNotes NVARCHAR(800)=NULL
	,@PersonalCellPhone NVARCHAR(50)=NULL
	,@InternationalPhone NVARCHAR(50)=NULL
	,@InternationalFax NVARCHAR(50)=NULL
	,@InternationalCell NVARCHAR(50)=NULL
	,@PrimaryEmail NVARCHAR(50)=NULL
	,@SecondaryEmail NVARCHAR(50)=NULL
	,@UpdateUser NVARCHAR(100) = NULL
AS
SET NOCOUNT ON;

DECLARE @SalesRepID INT=NULL
DECLARE @SalesRepTypeID INT=NULL
DECLARE @TerritoryID INT=NULL
DECLARE @RegionID INT=NULL
DECLARE @SubBusinessUnitID INT=NULL
DECLARE @BusinessUnitID INT=NULL
DECLARE @CompanyID INT=NULL

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
IF (@CompanyName IS NOT NULL)
BEGIN
	SET @CompanyID = (
			SELECT TOP 1 [CompanyID]
			FROM [dbo].[Company]
			WHERE [CompanyName] = @CompanyName
			);
END

 
BEGIN 
UPDATE [CSIDW].[dbo].[SalesRepContact]
SET   
      [Title]= @Title
      ,[CompanyID]= @CompanyID
	  ,[BusinessUnitID]= @BusinessUnitID
	  ,[SubBusinessUnitID]= @SubBusinessUnitID
	  ,[RegionID] = @RegionID
	  ,[TerritoryID] = @TerritoryID
	  ,[SalesRepTypeID] = @SalesRepTypeID
	  ,[SalesRepCompanyName]= @SalesRepCompanyName
	,[TerminationDate]= @TerminationDate 
	 ,[Address1]=@Address1
	 ,[Address2]=@Address2
	 ,[Address3]=@Address3
	  ,[WorkPhone] =@WorkPhone
	  ,[FaxNumber]= @FaxNumber 
	  ,[MobilePhone]=  @MobilePhone 
	 ,[Notes] =  @Notes
	  ,[PersonalCellPhone]= @PersonalCellPhone 
	  ,[InternationalPhone]= @InternationalPhone
	 ,[InventoryNotes]=  @InventoryNotes 
	  ,[InternationalCell]=  @InternationalCell 
	  ,[PrimaryEmail]= @PrimaryEmail 
	  ,[SecondaryEmail]= @SecondaryEmail 
     ,[DemoSigned] = @DemoSigned
      ,[HireDate] = @HireDate
	  --,[ExpirationDate] = @ExpirationDate
	  ,[UpdateUser] = @UpdateUser
	  ,[UpdateDate] = GETDATE()
WHERE [SalesRepContactID] = @SalesRepContactID;

	SELECT 'Success'
END

　
　
-------------------------------------

　
　
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
      --,[EffectiveDate]
	 -- ,[ExpirationDate]
	)
VALUES (
	--@SalesRepID
	@SalesRepFirstName
	,@SalesRepLastName
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
	--,@VoiceMailPin 
	--,@EffectiveDate
	);

　
	SELECT 'Success'
END

　
　
　
　
　
------------------------------------------

　
　
USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_GetSalesRepresentativeRecords]    Script Date: 11/19/2017 9:24:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

　
　
　
ALTER PROCEDURE [dbo].[Web_SR_GetSalesRepresentativeRecords]
		@SalesRepLastName nvarchar(100) = NULL
		,@CompanyName nvarchar(100)=null
		,@SalesRepTypeName nvarchar(100) = NULL
		,@TerritoryName nvarchar(100) = NULL
		,@RegionName nvarchar(100) = NULL
		,@DistributionRegionName nvarchar(100) = NULL
		,@SubBusinessUnitName nvarchar(100) = NULL
		,@BusinessUnitName nvarchar(100) = NULL
		,@StateProvinceName nvarchar(100)= NULL
		,@CountryName nvarchar(100)=null
AS   

    SET NOCOUNT ON; 

	
    SELECT [SalesRepContactID]
	  ,SSN.[SalesRepFirstName]
	  ,SSN.[SalesRepLastName]
	  ,SSN.[SalesRepID]
      ,SS.[Title]
      ,SS.[HireDate]
      ,SS.[TerminationDate]
	  ,SS.[Notes]
	  ,SS.[InventoryNotes]
	  --,SS.[VendorID]
	  ,SS.[SalesRepCompanyName]
	  ,SS.[DemoSigned]
	  ,SS.[Address1]
	  ,SS.[Address2]
	  ,SS.[Address3]
	  ,SS.[City]
	  ,SP.[StateProvinceName]
	 ,PC.[PostalCode]
	 ,CO.[CountryName]
	  ,SS.[WorkPhone]
	  --,SS.[VoiceMailPin]
	  --,SS.[VoiceMailExtension]
	  ,SS.[FaxNumber]
	  ,SS.[MobilePhone]
	 -- ,SS.[Pager]
	  ,SS.[PersonalCellPhone]
	  ,SS.[InternationalPhone]
	  ,SS.[InternationalCell]
	  --,SS.[InternationalFax]
	  ,SS.[PrimaryEmail]
	  ,SS.[SecondaryEmail]
	  ,SRT.[SalesRepTypeName]
	  ,(CAST(T.[TerritoryCode] AS VARCHAR(20))+Space(3)+T.[TerritoryName])As [TerritoryName]
	  ,(CAST(R.[RegionCode] AS VARCHAR(20))+Space(3)+R.[RegionName]) As [RegionName]
	  ,DR.[CustomerNumber]
	  ,(CAST(SB.[SubBusinessUnitCode] AS VARCHAR(20))+SPACE(3)+SB.[SubBusinessUnitName])As [SubBusinessUnitName]
	  ,(CAST(B.[BusinessUnitCode] AS VARCHAR(20))+Space(3)+B.[BusinessUnitName]) As [BusinessUnitName]
	  ,C.[CompanyName]
     -- ,SS.[EffectiveDate]
     -- ,SS.[ExpirationDate]
      ,SS.[UpdateUser]
      ,SS.[UpdateDate]      	  
    FROM [CSIDW].[dbo].[SalesRepContact] SS
  LEFT JOIN [CSIDW].[dbo].[SalesRep] SSN ON SSN.[SalesRepID] = SS.[SalesRepID] 
  LEFT JOIN [CSIDW].[dbo].[SalesRepType] SRT ON SRT.[SalesRepTypeID] = SS.[SalesRepTypeID] 
  LEFT JOIN [CSIDW].[dbo].[Territory] T ON T.[TerritoryID] = SS.[TerritoryID] 
 AND (CAST(T.[TerritoryCode] AS VARCHAR(20))+Space(3)+T.[TerritoryName]) = ISNULL(@TerritoryName, (CAST(T.[TerritoryCode] AS VARCHAR(20))+Space(3)+T.[TerritoryName]))
 LEFT JOIN [CSIDW].[dbo].[Region] R ON R.[RegionID] = SS.[RegionID] 
 AND (CAST(R.[RegionCode] AS VARCHAR(20))+Space(3)+R.[RegionName]) = ISNULL(@RegionName, (CAST(R.[RegionCode] AS VARCHAR(20))+Space(3)+R.[RegionName]))
 LEFT JOIN [CSIDW].[dbo].[Customer] DR ON DR.[CustomerID] = SS.[CustomerID] 
  LEFT JOIN [CSIDW].[dbo].[SubBusinessUnit]  SB ON SB.[SubBusinessUnitID] = SS.[SubBusinessUnitID] 
  AND (CAST(SB.[SubBusinessUnitCode] AS VARCHAR(20))+SPACE(3)+SB.[SubBusinessUnitName]) = ISNULL(@SubBusinessUnitName, (CAST(SB.[SubBusinessUnitCode] AS VARCHAR(20))+SPACE(3)+SB.[SubBusinessUnitName]))
  LEFT JOIN [CSIDW].[dbo].[BusinessUnit]  B ON B.[BusinessUnitID] = SS.[BusinessUnitID] 
  AND (CAST(B.[BusinessUnitCode] AS VARCHAR(20))+Space(3)+B.[BusinessUnitName]) = ISNULL(@BusinessUnitName, (CAST(B.[BusinessUnitCode] AS VARCHAR(20))+Space(3)+B.[BusinessUnitName]))
  LEFT JOIN [CSIDW].[dbo].[Company]  C ON C.[CompanyID] = SS.[CompanyID] 
  LEFT JOIN [CSIDW].[dbo].[StateProvince]  SP ON SP.[StateProvinceID] = SS.[StateProvinceID] 
  LEFT JOIN [CSIDW].[dbo].[PostalCode]  PC ON PC.[PostalCodeID] = SS.[PostalCodeID] 
  LEFT JOIN [CSIDW].[dbo].[Country]  CO ON CO.[CountryID] = SS.[CountryID] 
 WHERE SSN.[SalesRepLastName] = ISNULL(@SalesRepLastName, SSN.[SalesRepLastName])
       AND SRT.[SalesRepTypeName] = ISNULL(@SalesRepTypeName, SRT.[SalesRepTypeName])
	   AND  C.[CompanyName] = ISNULL(@CompanyName, C.[CompanyName])
	  
 ------------------------------------

　
　
 ------------------------------------

　
　
