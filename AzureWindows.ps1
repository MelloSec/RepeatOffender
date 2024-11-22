# Ensure Chocolatey is installed before running these commands
# Install Azure CLI and other tools
choco install -y azure-cli
choco install -y microsoftazurestorageexplorer
choco install -y git
choco install -y poshgit
choco install -y terraform
choco install -y azure-functions-core-tools
choco install -y burp-suite-free-edition
choco install -y firefox
choco install -y postman
# Postman CLI
iex ((New-Object System.Net.WebClient).DownloadString('https://dl-cli.pstmn.io/install/win64.ps1'))
# Install Python
Install-Package python -Scope CurrentUser
# XAMPP
iwr https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/8.0.30/xampp-windows-x64-8.0.30-0-VS16-installer.exe -OutFile C:\xampp.exe
Start-Process C:\xampp.exe

# PowerShell Modules
Install-Module aadinternals -force -AllowClobber -Scope CurrentUser
Install-Module Az -Force -AllowClobber -Scope CurrentUser
Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber -Scope CurrentUser
Install-Module MSOnline -Force -AllowClobber -Scope CurrentUser
Install-Module AzureADPreview -Force -AllowClobber -Scope CurrentUser
Install-Module Microsoft.Graph -Force -AllowClobber -Scope CurrentUser

# Set Tools Path
$toolsPath = "C:\Git"
if (-not (Test-Path $toolsPath)) {
    New-Item -ItemType Directory -Path $toolsPath | Out-Null
}
Set-Location $toolsPath

# Download and setup TeamFiltration
$url = "https://github.com/Flangvik/TeamFiltration/releases/download/v3.5.2/TeamFiltration-v3.5.2-win-x86_64.zip"
$outfile = "TeamFiltration.zip"
iwr $url -Outfile $outfile
Expand-Archive -Path $outfile -DestinationPath .\TeamFiltration

# Clone repositories for various tools
git clone https://github.com/dafthack/MailSniper.git
git clone https://github.com/dafthack/MFASweep.git
git clone https://github.com/LMGsec/o365creeper.git
git clone https://github.com/dafthack/GraphRunner.git
git clone https://github.com/rvrsh3ll/TokenTactics.git
git clone https://github.com/f-bader/TokenTacticsV2.git
git clone https://github.com/CompassSecurity/TokenTormentor.git
git clone https://github.com/CompassSecurity/TokenPhisher.git
git clone https://github.com/mellosec/cartp.git
git clone https://github.com/mellosec/phirstphish.git
git clone https://github.com/rvrsh3ll/Azure-App-Tools.git
git clone https://github.com/csandker/Azure-AccessPermissions.git
git clone https://github.com/NetSPI/MicroBurst.git
git clone https://github.com/hausec/PowerZure.git
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git
git clone https://github.com/samratashok/nishang.git
git clone https://github.com/dafthack/MSOLSpray.git
git clone https://github.com/0xZDH/Omnispray.git
git clone https://github.com/0xZDH/o365spray.git
git clone https://github.com/optiv/Go365.git
git clone https://github.com/MarkoH17/Spray365.git
cd Spray365
pip install -r requirements.txt -U
cd ..

# BlobHunter
git clone https://github.com/cyberark/BlobHunter.git $toolsPath\BlobHunter
cd $toolsPath\BlobHunter
pip3 install -r requirements.txt
cd ..

# ROADTools
git clone https://github.com/dirkjanm/ROADtools.git
pip install roadrecon roadlib roadtx neo4j-driver

# Download and setup geckodriver
iwr https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-win-aarch64.zip -Outfile geckodriver-win.zip
Expand-Archive -Path geckodriver-win.zip -DestinationPath .\geckodriver
Remove-Item geckodriver-win.zip

# Fireprox
git clone https://github.com/ustayready/fireprox.git
cd fireprox
pip install -r requirements.txt
cd ..

# CAP Gap Analyzer
git clone https://github.com/jsa2/caOptics.git

# Bridgekeeper for scraping LinkedIn
git clone https://github.com/0xZDH/BridgeKeeper.git
cd BridgeKeeper
pip install -r requirements.txt
cd ..

# 365 Stealer
git clone https://github.com/AlteredSecurity/365-Stealer.git
cd 365-Stealer
pip install -r requirements.txt
cd ..

# AzureHound
$binaryName = "azurehound-windows-amd64.zip"
$exePath = ".\azurehound.exe"
$outputZipFile = $binaryName
$downloadUrl = "https://github.com/BloodHoundAD/AzureHound/releases/latest/download/$binaryName"
Invoke-WebRequest -Uri $downloadUrl -OutFile $outputZipFile
Expand-Archive -LiteralPath $outputZipFile -DestinationPath . -Force
Remove-Item -Path $outputZipFile -Force
