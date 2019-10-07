param(
	[Parameter(Mandatory=$true)][string] $databaseName = "Null",
	[Parameter(Mandatory=$true)][string] $environmentName = "Null"
)

flyway migrate -configFiles="pipeline/util/flyway.conf" -url="jdbc:sqlserver://localhost;database=$databaseName-$environmentName;integratedSecurity=true"

#flyway validate -configFiles="flyway_Dev.conf"