param (
    [string]$ohmdwSqlserverName,    
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

.\DeploySQLVM.ps1 -ohmdwSqlserverName $ohmdwSqlserverName `
    -storageAccountName $storageAccountName `
    -storageContainerName $storageContainerName `
    -containerSAS $containerSAS `
    -databaseName $databaseName `
    -databaseBackupName $databaseBackupName `
    -sqlUserName $sqlUserName `
    -sqlPassword $sqlPassword

.\DeployCosmosDB.ps1 -storageAccountName $storageAccountName `
    -storageContainerName $storageContainerName `
    -containerSAS $containerSAS `
    -databaseName $databaseName `
    -databaseBackupName $databaseBackupName `
    -sqlUserName $sqlUserName `
    -sqlPassword $sqlPassword `
    -cosmosDBConnectionString $cosmosDBConnectionString `
    -cosmosDBDatabaseName $cosmosDBDatabaseName

.\DisableIEESC.ps1