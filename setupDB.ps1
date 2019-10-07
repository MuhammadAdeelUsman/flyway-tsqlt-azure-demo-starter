param(
	[Parameter(Mandatory=$true)][string]$databaseName
)

$serverName = "localhost"

# Base database name.
# WARNING: if you change it here, you need to change it in the "azure-pipelines.yml" file too, to be consistent
# $databaseName = "flyway-tSQLt-azure-demo"

# Tags for Development, User-Acceptance and Production environments ("Dev", "UAT" and "Prod" by default).
# WARNING: if you change these here, you need to change them in the "azure-pipelines.yml" file too, to be consistent
$dev = "Dev"
$uat = "UAT"
$prod = "Prod"

# Full database names.
$devDatabase = "$databaseName-$dev"
$uatDatabase = "$databaseName-$uat"
$prodDatabase = "$databaseName-$prod"

# SQL code to create the database in all 3 environments. Dev and UAT can be recreated at will, but NOT Prod, to avoid accidentally
# losing important business data. 
$createDev = "DROP DATABASE IF EXISTS [$devDatabase]; CREATE DATABASE [$devDatabase];"
$createUAT = "DROP DATABASE IF EXISTS [$uatDatabase]; CREATE DATABASE [$uatDatabase];"
$createProd =   "IF NOT EXISTS 
                (
                    SELECT name FROM master.dbo.sysdatabases 
                    WHERE name = N'$prodDatabase'
                )
                CREATE DATABASE [$prodDatabase];"

$flywayConf = "./pipeline/util/flyway.conf"

# (Re)Create and baseline the Dev DB
Invoke-Sqlcmd -ServerInstance $serverName -Query $createDev
flyway baseline -configFiles="$flywayConf" -url="jdbc:sqlserver://localhost;database=$devDatabase;integratedSecurity=true"

# (Re)Create and baseline the UAT DB
Invoke-Sqlcmd -ServerInstance $serverName -Query $createUAT
flyway baseline -configFiles="$flywayConf" -url="jdbc:sqlserver://localhost;database=$uatDatabase;integratedSecurity=true"

# Create and baseline the Prod DB.
Invoke-Sqlcmd -ServerInstance $serverName -Query $createProd
flyway baseline -configFiles="$flywayConf" -url="jdbc:sqlserver://localhost;database=$prodDatabase;integratedSecurity=true"