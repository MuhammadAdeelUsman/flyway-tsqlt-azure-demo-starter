param(
    [Parameter(Mandatory=$true)][string]$serverName,
    [Parameter(Mandatory=$true)][string]$databaseName,
    [string]$user,
    [string]$pass
)

$OutputFolder = "tests\TestResults"

# run all tests
Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -Query "EXEC tSQLt.RUNALL"# | Out-File -FilePath "$OutputFolder\$databaseName tSQLt Report.txt"