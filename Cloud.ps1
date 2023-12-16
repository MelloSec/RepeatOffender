# Install PowerShell Modules with force and auto accept
$modules = @("AADInternals", "AzureADPreview", "Az", "AzureAd", "Microsoft.Graph")
foreach ($module in $modules) {
    Install-Module -Name $module -Force -AllowClobber -Scope CurrentUser -Confirm:$false
}

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

