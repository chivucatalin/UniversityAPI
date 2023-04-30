USE Universitate;
GO

CREATE FUNCTION ultimeleNote(@argId INT)
RETURNS @result TABLE (Id INT, StudentId INT, MaterieDenumire NVARCHAR(255), NotaObtinuta INT)
AS
BEGIN
    WITH LatestNotes AS (
        SELECT 
            ROW_NUMBER() OVER (PARTITION BY MaterieDenumire ORDER BY Id DESC) AS RowNum,
            Id,
            StudentId,
            MaterieDenumire,
            NotaObtinuta
        FROM Note
        WHERE StudentId = @argId
    )
    INSERT INTO @result
    SELECT Id, StudentId, MaterieDenumire, NotaObtinuta
    FROM LatestNotes
    WHERE RowNum = 1;
    RETURN;
END



GO;
