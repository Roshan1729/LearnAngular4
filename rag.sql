CREATE PROCEDURE dbo.sp_GetSearchResults 
    @ReviewID nvarchar(50)
AS 
    SET NOCOUNT ON;
    SELECT ReviewID, Project_Description, Date_Action_Due, 
    Active, Actions_Needed, Project_Latitude, Project_Longitude
    FROM Review.Review
    WHERE ReviewID = @ReviewID;
GO