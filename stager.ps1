[CmdletBinding()]
param (
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]$scriptUrl,
    [switch]$Azure,
    [switch]$Cloud,
    [switch]$CloudBig,
    [switch]$RepeatOffender
)

$urlMapping = @{
    Azure         = "https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/Azure.ps1"
    Cloud         = "https://example.com/cloud-script.ps1"
    CloudBig      = "https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/CloudBig.ps1"
    RepeatOffender = "https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/RepeatOffender.ps1"
}

if ($scriptUrl) {
    $selectedUrl = $scriptUrl
} elseif ($Azure) {
    $selectedUrl = $urlMapping.Azure
} elseif ($Cloud) {
    $selectedUrl = $urlMapping.Cloud
} elseif ($CloudBig) {
    $selectedUrl = $urlMapping.CloudBig
} elseif ($RepeatOffender) {
    $selectedUrl = $urlMapping.RepeatOffender
} else {
    Write-Error "No script URL or switch parameter provided."
    exit 1
}

# Install Script
$chocolateySetupScriptUrl = "https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/Choco.ps1"

# Run the Chocolatey setup script
Invoke-Expression (Invoke-WebRequest -Uri $chocolateySetupScriptUrl -UseBasicParsing).Content

# Function to reload the PowerShell session
function Reload-PowerShellSession {
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "$env:PATH = [System.Environment]::GetEnvironmentVariable('Path','Machine')"
    exit
}

# Function to check if Chocolatey is in the PATH
function Test-ChocolateyInPath {
    return (Get-Command choco -ErrorAction SilentlyContinue) -ne $null
}

# Reload the session
Reload-PowerShellSession

# After reloading the session, check if Chocolatey is in the PATH and execute another script if it is
# After reloading the session, check if Chocolatey is in the PATH and execute the selected script if it is
if (Test-ChocolateyInPath) {
    # Run the selected script
    Invoke-Expression (Invoke-WebRequest -Uri $selectedUrl -UseBasicParsing).Content
} else {
    Write-Output "Chocolatey is not in the PATH. Please ensure it is installed correctly."
}
