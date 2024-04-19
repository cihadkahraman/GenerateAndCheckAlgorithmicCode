
Create PROCEDURE [CheckCodeValidity]
    @Code NVARCHAR(8)
   
AS
 declare @IsValid as BIT
BEGIN
    SET NOCOUNT ON;

	--Uzunluk ve karakter kontrolü
	IF LEN(@Code) != 8 OR @Code LIKE '%[^ACDEFGHKLMNPRTXYZ234579]%'
    BEGIN
        SET @IsValid = 0
		select @IsValid as IsValid
        RETURN
    END
    
    DECLARE @C1 CHAR = SUBSTRING(@Code, 1, 1),
            @C2 CHAR = SUBSTRING(@Code, 2, 1),
            @C3 CHAR = SUBSTRING(@Code, 3, 1),
            @C4 CHAR = SUBSTRING(@Code, 4, 1),
            @C5 CHAR = SUBSTRING(@Code, 5, 1),
            @C6 CHAR = SUBSTRING(@Code, 6, 1),
            @C7 CHAR = SUBSTRING(@Code, 7, 1),
            @C8 CHAR = SUBSTRING(@Code, 8, 1)

    -- Algoritmanın kontrolü
    IF (ASCII(@C1) * ASCII(@C6) % 15 = 7 AND ASCII(@C6) > ASCII(@C1)) AND
       (Power((ASCII(@C2) + ASCII(@C8)),2) % 15 = 10 AND ASCII(@C2) > ASCII(@C8)) AND
       (ASCII(@C3) * ASCII(@C5) % 15 = 2 AND ASCII(@C5) > ASCII(@C3)) AND
       (ASCII(@C4) * ASCII(@C7) % 3 = 0 AND ASCII(@C4) > ASCII(@C7))
    BEGIN
        SET @IsValid = 1
    END
    ELSE
    BEGIN
        SET @IsValid = 0
    END
	select @IsValid as IsValid
END
