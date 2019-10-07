CREATE OR ALTER PROCEDURE testMember.[test that table Member exist]
AS
BEGIN

------Assert
    EXEC tSQLt.AssertObjectExists 'Member';
END;