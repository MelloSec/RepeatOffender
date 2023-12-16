# Install PowerShell Modules with force and auto accept
$modules = @("AADInternals", "AzureADPreview", "Az", "AzureAd", "Microsoft.Graph")
foreach ($module in $modules) {
    Install-Module -Name $module -Force -AllowClobber -Scope CurrentUser -Confirm:$false
}

# Function to check if Chocolatey is already installed
function IsChocolateyInstalled {
    $chocoPath = Get-Command choco -ErrorAction SilentlyContinue
    return $chocoPath -ne $null
}

# Install Chocolatey if it's not already installed
if (-not (IsChocolateyInstalled)) {
    # Set up the Chocolatey package manager
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    Write-Output "Chocolatey is already installed."
}

# Verify installations
Write-Output "Installed PowerShell Modules:"
Get-Module -ListAvailable $modules

# Check if Chocolatey is installed
if (IsChocolateyInstalled) {
    Write-Output "Chocolatey is installed."
} else {
    Write-Output "Chocolatey installation failed."
}
