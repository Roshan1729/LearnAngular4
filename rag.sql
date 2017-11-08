USE [CSIDW]
GO
/****** Object:  StoredProcedure [dbo].[Web_SR_UpdateSalesRepresentative]    Script Date: 11/7/2017 10:58:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

　
ALTER PROCEDURE [dbo].[Web_SR_UpdateSalesRepresentative]
     @SalesRepContactID INT = NULL
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
	,@Pager NVARCHAR(50)=NULL
	,@PersonalCellPhone NVARCHAR(50)=NULL
	,@InternationalPhone NVARCHAR(50)=NULL
	,@InternationalFax NVARCHAR(50)=NULL
	,@InternationalCell NVARCHAR(50)=NULL
	,@PrimaryEmail NVARCHAR(50)=NULL
	,@SecondaryEmail NVARCHAR(50)=NULL
	,@EffectiveDate DATETIME	
	,@ExpirationDate DATETIME = NULL
	,@UpdateUser NVARCHAR(100) = NULL
AS
SET NOCOUNT ON;

DECLARE @SalesRepTypeID INT=NULL
DECLARE @TerritoryID INT=NULL
DECLARE @RegionID INT=NULL
DECLARE @SubBusinessUnitID INT=NULL
DECLARE @BusinessUnitID INT=NULL

　
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

　
ELSE 
BEGIN 
UPDATE [CSIDW].[dbo].[SalesRepContact]
SET   [Title]= @Title
      ,[CompanyID]= @CompanyName
	  ,[BusinessUnitID]= @BusinessUnitName
	  ,[SubBusinessUnitID]= @SubBusinessUnitName
	  ,[RegionID] = @RegionName
	  ,[TerritoryID] = @TerritoryName
	  ,[SalesRepTypeID] = @SalesRepTypeName
	  ,[SalesRepCompanyName]= @SalesRepCompanyName
	  ,[VoiceMailExtension]= @VoiceMailExtension 
	  ,[FaxNumber]= @FaxNumber 
	  ,[MobilePhone]=  @MobilePhone 
	  ,[Pager] =  @Pager
	  ,[PersonalCellPhone]= @PersonalCellPhone 
	  ,[InternationalPhone]= @InternationalPhone
	  ,[InternationalFax]=  @InternationalFax 
	  ,[InternationalCell]=  @InternationalCell 
	  ,[PrimaryEmail]= @PrimaryEmail 
	  ,[SecondaryEmail]= @SecondaryEmail 
      ,[EffectiveDate] = @EffectiveDate
	  ,[ExpirationDate] = @ExpirationDate
	  ,[UpdateUser] = @UpdateUser
	  ,[UpdateDate] = GETDATE()
WHERE [SalesRepContactID] = @SalesRepContactID

	SELECT 'Success'
END

　
　
　
　
 
 
 --------------------------
 
 
 USE [CSIDW]

GO

/****** Object:  StoredProcedure [dbo].[Web_SR_GetSalesRepresentativeRecords]    Script Date: 11/7/2017 10:58:13 PM ******/

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

	  ,SS.[VendorID]

	  ,SS.[SalesRepCompanyName]

	  ,SS.[DemoSigned]

	  ,SS.[Address1]

	  ,SS.[Address2]

	  ,SS.[Address3]

	  ,SS.[City]

	  --,SP.[StateProvinceName]

	 -- ,PC.[PostalCode]

	--  ,CO.[CountryName]

	  ,SS.[WorkPhone]

	  ,SS.[VoiceMailPin]

	  ,SS.[VoiceMailExtension]

	  ,SS.[FaxNumber]

	  ,SS.[MobilePhone]

	  ,SS.[Pager]

	  ,SS.[PersonalCellPhone]

	  ,SS.[InternationalPhone]

	  ,SS.[InternationalCell]

	  ,SS.[InternationalFax]

	  ,SS.[PrimaryEmail]

	  ,SS.[SecondaryEmail]

	  ,SRT.[SalesRepTypeName]

	  ,T.[TerritoryName]

	  ,R.[RegionName]

	 -- ,DR.[CustomerNumber]

	  ,SB.[SubBusinessUnitName]

	  ,B.[BusinessUnitName]

	  ,C.[CompanyName]

      ,SS.[EffectiveDate]

      ,SS.[ExpirationDate]

      ,SS.[UpdateUser]

      ,SS.[UpdateDate]      	  

  FROM [CSIDW].[dbo].[SalesRepContact] SS

  INNER JOIN [CSIDW].[dbo].[SalesRep] SSN ON SSN.[SalesRepID] = SS.[SalesRepID] 

  INNER JOIN [CSIDW].[dbo].[SalesRepType] SRT ON SRT.[SalesRepTypeID] = SS.[SalesRepTypeID] 

  INNER JOIN [CSIDW].[dbo].[Territory] T ON T.[TerritoryID] = SS.[TerritoryID] 

 INNER JOIN [CSIDW].[dbo].[Region] R ON R.[RegionID] = SS.[RegionID] 

 -- INNER JOIN [CSIDW].[dbo].[Customer] DR ON DR.[CustomerID] = SS.[CustomerID] 

  INNER JOIN [CSIDW].[dbo].[SubBusinessUnit]  SB ON SB.[SubBusinessUnitID] = SS.[SubBusinessUnitID] 

  INNER JOIN [CSIDW].[dbo].[BusinessUnit]  B ON B.[BusinessUnitID] = SS.[BusinessUnitID] 

  INNER JOIN [CSIDW].[dbo].[Company]  C ON C.[CompanyID] = SS.[CompanyID] 

  --INNER JOIN [CSIDW].[dbo].[StateProvince]  SP ON SP.[StateProvinceID] = SS.[StateProvinceID] 

  --INNER JOIN [CSIDW].[dbo].[PostalCode]  PC ON PC.[PostalCodeID] = SS.[PostalCodeID] 

  --INNER JOIN [CSIDW].[dbo].[Country]  CO ON CO.[CountryID] = SS.[CountryID] 

  WHERE C.[CompanyName] = ISNULL(@CompanyName, C.[CompanyName])

 AND SSN.[SalesRepLastName] = ISNULL(@SalesRepLastName, SSN.[SalesRepLastName])

  AND SRT.[SalesRepTypeName] = ISNULL(@SalesRepTypeName, SRT.[SalesRepTypeName])

 AND T.[TerritoryName] = ISNULL(@TerritoryName, T.[TerritoryName])

 AND R.[RegionName] = ISNULL(@RegionName, R.[RegionName])

 -- AND DR.[DistributionRegionName] = ISNULL(@DistributionRegionName, DR.[DistributionRegionName])

  AND SB.[SubBusinessUnitName] = ISNULL(@SubBusinessUnitName, SB.[SubBusinessUnitName])

  AND B.[BusinessUnitName] = ISNULL(@BusinessUnitName, B.[BusinessUnitName]);


　
 
 
 ----------------------
 
 
 
 
 
USE [CSIDW]GO/****** Object:  StoredProcedure [dbo].[Web_SR_AddNewSalesRepresentative]    Script Date: 11/7/2017 6:03:28 PM ******/SET ANSI_NULLS ONGOSET QUOTED_IDENTIFIER ONGO
ALTER PROCEDURE [dbo].[Web_SR_AddNewSalesRepresentative]   @SalesRepContactID INT = NULL ,@SalesRepID INT =NULL ,@SalesRepFirstName NVARCHAR(50)=NULL ,@SalesRepLastName NVARCHAR(50)=NULL ,@Title NVARCHAR(250) = NULL ,@HireDate DATETIME = NULL ,@TerminationDate DATETIME = NULL ,@Notes NVARCHAR(800) =NULL ,@VendorID INT =NULL ,@DemoSigned DATETIME =NULL ,@InventoryNotes NVARCHAR(800)=NULL ,@CompanyName NVARCHAR(250) = NULL ,@SalesRepCompanyName NVARCHAR(100)=NULL ,@WorkPhone NVARCHAR(100)=NULL ,@SalesRepTypeName NVARCHAR(100)=NULL ,@TerritoryName NVARCHAR(100)=NULL ,@RegionName NVARCHAR(100)=NULL ,@SubBusinessUnitName NVARCHAR(100)=NULL ,@BusinessUnitName NVARCHAR(100)=NULL ,@VoiceMailExtension NVARCHAR(50)=NULL ,@FaxNumber NVARCHAR(50)=NULL ,@MobilePhone NVARCHAR(50)=NULL ,@Pager NVARCHAR(50)=NULL ,@PersonalCellPhone NVARCHAR(50)=NULL ,@InternationalPhone NVARCHAR(50)=NULL ,@InternationalFax NVARCHAR(50)=NULL ,@InternationalCell NVARCHAR(50)=NULL ,@PrimaryEmail NVARCHAR(50)=NULL ,@SecondaryEmail NVARCHAR(50)=NULL ,@Address1 NVARCHAR(100)=NULL ,@Address2 NVARCHAR(100)=NULL ,@Address3 NVARCHAR(100)=NULL ,@City NVARCHAR(100)=NULL ,@StateProvinceName NVARCHAR(40)=NULL ,@PostalCode NVARCHAR(40)=NULL ,@CountryName NVARCHAR(100)=NULL ,@CustomerID INT=NULL ,@VoiceMailPin NVARCHAR(100)=NULL ,@GlobalAddress NVARCHAR(100)=NULL ,@EffectiveDate DATETIME  ,@ExpirationDate DATETIME = NULL ,@UpdateUser NVARCHAR(100) = NULL ASSET NOCOUNT ON;
DECLARE @SalesRepTypeID INT=NULLDECLARE @TerritoryID INT=NULLDECLARE @RegionID INT=NULLDECLARE @SubBusinessUnitID INT=NULLDECLARE @BusinessUnitID INT=NULLDECLARE @CompanyID INT=NULLDECLARE @CountryID INT=NULLDECLARE @StateProvinceID INT=NULLDECLARE @PostalCodeID INT=NULL
--DECLARE @AExpirationDate DATETIME = '2200-01-01';--DECLARE @AEffectiveDate DATETIME = NULL;--DECLARE @BExpirationDate DATETIME = '2200-01-01';--DECLARE @BEffectiveDate DATETIME = NULL;
 

IF (@CompanyName IS NOT NULL)BEGIN SET @CompanyID = (   SELECT TOP 1 [CompanyID]   FROM [dbo].[Company]   WHERE [CompanyName] = @CompanyName   );END
IF (@SalesRepTypeName IS NOT NULL)BEGIN SET @SalesRepTypeID = (   SELECT TOP 1 [SalesRepTypeID]   FROM [dbo].[SalesRepType]   WHERE [SalesRepTypeName] = @SalesRepTypeName   );END
IF (@TerritoryName IS NOT NULL)BEGIN SET @TerritoryID = (   SELECT TOP 1 [TerritoryID]   FROM [dbo].[Territory]   WHERE [TerritoryName] = @TerritoryName   );END
IF (@RegionName IS NOT NULL)BEGIN SET @RegionID = (   SELECT TOP 1 [RegionID]   FROM [dbo].[Region]   WHERE [RegionName] = @RegionName   );END
IF (@SubBusinessUnitName IS NOT NULL)BEGIN SET @SubBusinessUnitID = (   SELECT TOP 1 [SubBusinessUnitID]   FROM [dbo].[SubBusinessUnit]   WHERE [SubBusinessUnitName] = @SubBusinessUnitName   );END
IF (@BusinessUnitName IS NOT NULL)BEGIN SET @BusinessUnitID = (   SELECT TOP 1 [BusinessUnitID]   FROM [dbo].[BusinessUnit]   WHERE [BusinessUnitName] = @BusinessUnitName   );END

IF (@CountryName IS NOT NULL)BEGIN SET @CountryID = (   SELECT TOP 1 [CountryID]   FROM [dbo].[Country]   WHERE [CountryName] = @CountryName   );END

IF (@StateProvinceName IS NOT NULL)BEGIN SET @StateProvinceID = (   SELECT TOP 1 [StateProvinceID]   FROM [dbo].[StateProvince]   WHERE [StateProvinceName] = @StateProvinceName   );END

BEGIN
INSERT INTO [CSIDW].[dbo].[SalesRepContact] (   [Title]   ,[HireDate]   ,[TerminationDate]   ,[Notes]   ,[VendorID]   ,[DemoSigned]   ,[InventoryNotes]      ,[BusinessUnitID]   ,[SubBusinessUnitID]   ,[RegionID]   ,[CompanyID]   ,[SalesRepTypeID]   ,[TerritoryID]   ,[SalesRepCompanyName]   ,[VoiceMailExtension]   ,[FaxNumber]   ,[MobilePhone]   ,[Pager]   ,[PersonalCellPhone]   ,[InternationalPhone]   ,[InternationalFax]   ,[InternationalCell]   ,[PrimaryEmail]   ,[SecondaryEmail]   ,[Address1]   ,[Address2]   ,[Address3]   ,[City]   ,[StateProvinceID]   ,[PostalCodeID]   ,[CountryID]   ,[CustomerID]   ,[VoiceMailPin]       ,[EffectiveDate] )VALUES ( @Title ,@HireDate ,@TerminationDate ,@Notes ,@VendorID ,@DemoSigned ,@InventoryNotes ,@BusinessUnitID ,@SubBusinessUnitID ,@RegionID ,@CompanyID ,@SalesRepTypeID ,@TerritoryID ,@SalesRepCompanyName ,@VoiceMailExtension ,@FaxNumber ,@MobilePhone ,@Pager ,@PersonalCellPhone ,@InternationalPhone ,@InternationalFax ,@InternationalCell ,@PrimaryEmail ,@SecondaryEmail ,@Address1  ,@Address2  ,@Address3  ,@City  ,@StateProvinceID ,@PostalCodeID  ,@CountryID ,@CustomerID  ,@VoiceMailPin  ,@EffectiveDate );
 SELECT 'Success'END

