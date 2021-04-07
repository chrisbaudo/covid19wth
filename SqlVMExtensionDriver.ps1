param (
    [string]$ohmdwSqlserverName,    
    [string]$databaseName,
    [string]$databaseBackupName,
    [string]$sqlUserName,
    [securestring]$sqlPassword,
    [string]$cosmosDBConnectionString,
    [string]$cosmosDBDatabaseName
)

.\DeploySQLVM.ps1 -ohmdwSqlserverName $ohmdwSqlserverName `
    -databaseName $databaseName `
    -databaseBackupName $databaseBackupName `
    -sqlUserName $sqlUserName `
    -sqlPassword $sqlPassword

.\DeployCosmosDB.ps1 -databaseName $databaseName `
    -databaseBackupName $databaseBackupName `
    -sqlUserName $sqlUserName `
    -sqlPassword $sqlPassword `
    -cosmosDBConnectionString $cosmosDBConnectionString `
    -cosmosDBDatabaseName $cosmosDBDatabaseName

.\DisableIEESC.ps1