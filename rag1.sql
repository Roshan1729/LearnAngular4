IF (@SubSegmentName IS NOT NULL)
BEGIN
	SET @SubSegmentID = (
			SELECT TOP 1
		[SegmentID]
	FROM [dbo].[Segment]
	WHERE [SegmentName]  = @SubSegmentName
			);
END
