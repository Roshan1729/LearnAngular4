USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_AddNewSalesRepresentative]    Script Date: 11/8/2017 8:19:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Web_SR_AddNewSalesRepresentative] 
	 @SalesRepContactID INT = NULL
	--,@SalesRepID INT =NULL
	,@SalesRepFirstName NVARCHAR(50)=NULL
	,@SalesRepLastName NVARCHAR(50)=NULL
	,@Title NVARCHAR(50) = NULL
	,@HireDate DATETIME = NULL
	,@TerminationDate DATETIME = NULL
	,@Notes NVARCHAR(800) =NULL
	,@VendorID VARCHAR(50) =NULL
	,@DemoSigned DATETIME =NULL
	,@InventoryNotes NVARCHAR(800)=NULL
	,@CompanyName NVARCHAR(250) = NULL
	,@SalesRepCompanyName NVARCHAR(50)=NULL
	,@WorkPhone NVARCHAR(100)=NULL
	,@SalesRepTypeName NVARCHAR(100)=NULL
	,@TerritoryName NVARCHAR(100)=NULL
	,@RegionName NVARCHAR(100)=NULL
	,@DistributionRegionName NVARCHAR(100)=NULL
	,@SubBusinessUnitName NVARCHAR(100)=NULL
	,@BusinessUnitName NVARCHAR(100)=NULL
	,@VoiceMailExtension NVARCHAR(50)=NULL
	,@FaxNumber NVARCHAR(50)=NULL
	,@MobilePhone NVARCHAR(50)=NULL
	,@Pager NVARCHAR(50)=NULL
	,@PersonalCellPhone NVARCHAR(50)=NULL
	,@InternationalPhone NVARCHAR(50)=NULL
	,@InternationalFax NVARCHAR(50)=NULL
	,@InternationalCell NVARCHAR(50)=NULL
	,@PrimaryEmail NVARCHAR(50)=NULL
	,@SecondaryEmail NVARCHAR(50)=NULL
	,@Address1 NVARCHAR(100)=NULL
	,@Address2 NVARCHAR(100)=NULL
	,@Address3 NVARCHAR(100)=NULL
	,@City NVARCHAR(100)=NULL
	,@StateProvinceName NVARCHAR(40)=NULL
	,@PostalCode NVARCHAR(40)=NULL
	,@CountryName NVARCHAR(100)=NULL
	,@CustomerID INT=NULL
	,@VoiceMailPin INT=NULL
	,@GlobalAddress NVARCHAR(100)=NULL
	,@EffectiveDate DATETIME	
	,@ExpirationDate DATETIME = NULL
	,@UpdateUser NVARCHAR(100) = NULL
	
AS
SET NOCOUNT ON;

DECLARE @SalesRepTypeID INT=NULL
DECLARE @TerritoryID INT=NULL
DECLARE @RegionID INT=NULL
DECLARE @DistributionRegionID INT=NULL
DECLARE @SubBusinessUnitID INT=NULL
DECLARE @BusinessUnitID INT=NULL
DECLARE @CompanyID INT=NULL
DECLARE @CountryID INT=NULL
DECLARE @StateProvinceID INT=NULL
DECLARE @PostalCodeID INT=NULL

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
			WHERE [TerritoryName] = @TerritoryName
			);
END

IF (@RegionName IS NOT NULL)
BEGIN
	SET @RegionID = (
			SELECT TOP 1 [RegionID]
			FROM [dbo].[Region]
			WHERE [RegionName] = @RegionName
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
			WHERE [SubBusinessUnitName] = @SubBusinessUnitName
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

　
BEGIN
INSERT INTO [CSIDW].[dbo].[SalesRep] (
	--  [SalesRepID]
	  [SalesRepFirstName]
	  ,[SalesRepLastName]
      ,[EffectiveDate]
	)
VALUES (
	--@SalesRepID
	@SalesRepFirstName
	,@SalesRepLastName
	,@EffectiveDate
	);

END

　
　
BEGIN

INSERT INTO [CSIDW].[dbo].[SalesRepContact] (
	  [Title]
	  ,[HireDate]
	  ,[TerminationDate]
	  ,[Notes]
	  ,[VendorID]
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
	  ,[VoiceMailExtension]
	  ,[FaxNumber]
	  ,[MobilePhone]
	  ,[Pager]
	  ,[PersonalCellPhone]
	  ,[InternationalPhone]
	  ,[InternationalFax]
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
	  ,[VoiceMailPin] 
      ,[EffectiveDate]
	)
VALUES (
	@Title
	,@HireDate
	,@TerminationDate
	,@Notes
	,@VendorID
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
	,@VoiceMailExtension
	,@FaxNumber
	,@MobilePhone
	,@Pager
	,@PersonalCellPhone
	,@InternationalPhone
	,@InternationalFax
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
	,@VoiceMailPin 
	,@EffectiveDate
	);

　
	SELECT 'Success'
END

　
