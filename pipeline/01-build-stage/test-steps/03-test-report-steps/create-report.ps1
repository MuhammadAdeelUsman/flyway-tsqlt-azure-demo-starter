param(
	[Parameter(Mandatory=$true)][string]$serverName,
	[Parameter(Mandatory=$true)][string]$databaseName,
	[string]$user,
	[string]$pass,
	[Parameter(Mandatory=$true)][string]$createReportSQL
)

sqlcmd -b -S "$serverName" -d $databaseName -i $createReportSQL -o ".\tests\TestResults\$databaseName-TestResults.xml"