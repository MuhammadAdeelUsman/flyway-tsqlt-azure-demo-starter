-- Drop previous version of test class, to allow dynamic recreation of tests
EXEC tSQLt.DropClass 'testMember'
GO

-- Create new test class
EXEC tSQLt.NewTestClass 'testMember'
GO