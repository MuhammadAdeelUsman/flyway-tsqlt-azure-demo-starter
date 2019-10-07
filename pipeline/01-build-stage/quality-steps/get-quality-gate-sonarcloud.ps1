param(
    [Parameter(Mandatory=$true)][string]$project
)

$metricKeys = "alert_status"
$qualityGateURL = "https://sonarcloud.io/api/measures/component?component=$project&metricKeys=$metricKeys"

# SonarCloud is not requiring authorization headers for now, since I'm using public repos/projects
# However, the included Personal Access Token (PAT) and Headers code are here as future reference

# $PAT = "InsertYourOwnSonarcloudPAThere"

# This won't work with an Azure DevOps Cloud Agent, because it doesn't have access to my personal PC's environment variables
# $PAT = Get-ChildItem Env:SonarcloudPAT

$PAT = "87a6fb68a878d0ada33e1f338648d0df46aca547"

$headers = @{Authorization = "bearer $PAT"}

$responseBody = (Invoke-WebRequest -URI $qualityGateURL -Method 'Get' -Headers $headers).Content
# Enable Write-Output if you want to debug and check the responseBody
#Write-Output $responseBody

$qualityGateResult = (ConvertFrom-Json $responseBody).component.measures[0].value

Write-Output "Quality Gate status:" $qualityGateResult
if ( $qualityGateResult -ne "OK"){
    Write-Output "Quality Gate Failed! Deployment may NOT proceed. Please review results @ SonarCloud"
    return 1
}
else{
    Write-Output "Quality Gate Passed! Deployment may proceed"
    return 0
}
#curl -d "login=rodfontessoares@github&password=JNO75Zi5gaILfug1kC9X" -H "Content-Type: application/x-www-form-urlencoded" -X POST 'https://sonarcloud.io/api/authentication/login'

#$response = $(curl -d "organization=$organization&project=$project" -H "Content-Type: application/x-www-form-urlencoded" -X GET 'https://sonarcloud.io/api/qualitygates/get_by_project?organization=$organization&project=$project')