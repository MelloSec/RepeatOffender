# Function to check path and import module if exists
function Import-ModuleIfExists {
    param (
        [string]$modulePath,
        [string]$moduleName
    )

    if (Test-Path $modulePath) {
        Write-Output "Importing module: $moduleName"
        Import-Module $modulePath -Force
    } else {
        Write-Output "Module not found: $moduleName at path: $modulePath"
    }
}

# Define paths to modules
$modulesToCheck = @{
    "TokenTactics" = "C:\Git\TokenTactics\TokenTactics.psd1"
    "GraphRunner" = "C:\Git\GraphRunner\GraphRunner.ps1"
}

# Check and import the modules
foreach ($module in $modulesToCheck.GetEnumerator()) {
    Import-ModuleIfExists -modulePath $module.Value -moduleName $module.Key
}

# Import other required modules
$requiredModules = @("AADInternals", "Az", "AzureADPreview", "MSOnline", "Microsoft.Graph")

foreach ($module in $requiredModules) {
    Write-Output "Importing module: $module"
    Import-Module $module -Force
}
