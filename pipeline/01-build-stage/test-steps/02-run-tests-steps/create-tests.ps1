param(
	[Parameter(Mandatory=$true)][string]$serverName,
	[Parameter(Mandatory=$true)][string]$databaseName,
	[string]$user,
	[string]$pass,
	[Parameter(Mandatory=$true)][string]$testsDirectory
)

# Create testMember test class 
Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -InputFile "$testsDirectory\create_testMember_class.sql"

#Create tests
$testsDirectory = "$testsDirectory\testMember"

$testFiles = Get-ChildItem -Path $testsDirectory -Recurse -Include test*.sql
foreach ($test in $testFiles){
	Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -InputFile $test
}