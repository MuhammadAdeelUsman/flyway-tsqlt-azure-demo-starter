param(
	[Parameter(Mandatory=$true)][string]$serverName,
	[Parameter(Mandatory=$true)][string]$databaseName,
	[string]$user,
	[string]$pass,
	[Parameter(Mandatory=$true)][string]$installTSQLtSQL
)

Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -InputFile $installTSQLtSQL