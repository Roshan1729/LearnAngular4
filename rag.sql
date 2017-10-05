CREATE PROCEDURE validate_user
@Username nvarchar(20),
@Password nvarchar(20)
AS
BEGIN
	DECLARE @UserId INT = -1, @LastLoginDate DATETIME
	--select @UserId = UserId, @LastLoginDate = LastLoginDate from Users where LOWER(Username) = LOWER(@Username) and Password = @Password
	SELECT  @UserId = 1 FROM Users WHERE LOWER(Username) = LOWER(@Username) AND Password = @Password

	select @UserId;
end