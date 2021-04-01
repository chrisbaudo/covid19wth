param (
    [string]$storageAccountName,
    [string]$storageContainerName,
    [string]$containerSAS,
    [string]$databaseName,
    [string]$databaseBackupName,
    [string]$sqlUserName,
    [string]$sqlPassword,
    [string]$cosmosDBConnectionString,
    [string]$cosmosDBDatabaseName
)

$covidFileName = "covid_policy_tracker.csv"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://aka.ms/csdmtool -OutFile dt1.8.3.zip
Expand-Archive -Path dt1.8.3.zip -DestinationPath .
$dtutil = Get-ChildItem -Recurse | Where-Object { $_.Name -ieq "Dt.exe" }
$env:path += ";$($dtutil.DirectoryName)"
$azcopy = Get-ChildItem -Recurse | Where-Object { $_.Name -ieq "azcopy.exe" }
$env:path += ";$($azcopy.DirectoryName)"

AzCopy.exe cp "https://$($storageAccountName).blob.core.windows.net/$($storageContainerName)/$($covidFileName)?$($containerSAS)" ".\$($covidFileName)"
dt.exe /s:CsvFile /s.Files:.\$($covidFileName) /t:DocumentDBBulk /t.ConnectionString:"$($cosmosDBConnectionString);Database=$($cosmosDBDatabaseName)" /t.Collection:covidpolicy /t.CollectionThroughput:10000
