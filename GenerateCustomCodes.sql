
Create PROCEDURE [GenerateCustomCodes]
    @NumberOfCodes INT
AS
BEGIN
    SET NOCOUNT ON;


    DECLARE @ValidChars NVARCHAR(50) = 'ACDEFGHKLMNPRTXYZ234579'
    DECLARE @Codes TABLE (Code NVARCHAR(8) UNIQUE)
    DECLARE @Count INT = 0
    DECLARE @C1 CHAR, @C2 CHAR, @C3 CHAR, @C4 CHAR, @C5 CHAR, @C6 CHAR, @C7 CHAR, @C8 CHAR
	DECLARE @Count2_8 INT = 0
	DECLARE @Count3_5 INT = 0
	DECLARE @Count4_7 INT = 0

    WHILE @Count < @NumberOfCodes
    BEGIN
	SET @Count2_8 = 0
	SET @Count3_5 = 0
	SET @Count4_7 = 0
		--ABS(CHECKSUM(NEWID())) unique ve pozitif sayı üretir. Checksum sayesinde sayı her zaman int değer aralığındadır.
        SELECT @C1 = SUBSTRING(@ValidChars, ABS(CHECKSUM(NEWID())) % LEN(@ValidChars) + 1, 1),
               @C6 = SUBSTRING(@ValidChars, ABS(CHECKSUM(NEWID())) % LEN(@ValidChars) + 1, 1)
			   --Önce kodun 1. ve 6. hanesi üretilir ve uygunlukları kontrol edilir.
			  IF (ASCII(@C1) * ASCII(@C6) % 15 = 7) AND ASCII(@C6) > ASCII(@C1)
			  BEGIN
			  WHILE @Count2_8 = 0
				BEGIN
				--Ardından 2. ve 8. hane üretilip kontrol edilir ve bu şekilde devam eder.
				SELECT @C2 = SUBSTRING(@ValidChars, ABS(CHECKSUM(NEWID())) % LEN(@ValidChars) + 1, 1),
						 @C8 = SUBSTRING(@ValidChars, ABS(CHECKSUM(NEWID())) % LEN(@ValidChars) + 1, 1)
						 IF POWER((ASCII(@C2) + ASCII(@C8)),2) % 15 = 10 AND ASCII(@C2) > ASCII(@C8)
						 BEGIN
							SET @Count2_8 = 1
							
							WHILE @Count3_5 = 0
							BEGIN
							SELECT  @C3 = SUBSTRING(@ValidChars, ABS(CHECKSUM(NEWID())) % LEN(@ValidChars) + 1, 1),
									@C5 = SUBSTRING(@ValidChars, ABS(CHECKSUM(NEWID())) % LEN(@ValidChars) + 1, 1)
									IF ASCII(@C3) * ASCII(@C5) % 15 = 2 AND ASCII(@C5) > ASCII(@C3)
									BEGIN
										SET @Count3_5 = 1
										WHILE @Count4_7 = 0
										BEGIN
										SELECT @C4 = SUBSTRING(@ValidChars, ABS(CHECKSUM(NEWID())) % LEN(@ValidChars) + 1, 1),
											   @C7 = SUBSTRING(@ValidChars, ABS(CHECKSUM(NEWID())) % LEN(@ValidChars) + 1, 1)
											   IF ASCII(@C4) * ASCII(@C7) % 3 = 0 AND ASCII(@C4) > ASCII(@C7)
											   BEGIN
											   SET @Count4_7 = 1
											   BEGIN TRY
											   --Uygun kod üretilince @Codes değişkenine atılır ancak burada duplicate kod varsa catch'e düşer
													INSERT INTO @Codes (Code) VALUES (@C1 + @C2 + @C3 + @C4 + @C5 + @C6 + @C7 + @C8)
													SET @Count = @Count + 1
													END TRY
													BEGIN CATCH
													END CATCH
											   END
										END
									END
							END
						 END
				END
			  END 		                     
    END

    SELECT Code FROM @Codes
END
