# Azure CLI
choco install -y azure-cli
choco install -y git

# Powershell Modules
# Install-Module PSWindowsUpdate -Accept -Force
Install-Module aadinternals -force  -AllowClobber -Scope CurrentUser
Install-Module Az -Force -AllowClobber -Scope CurrentUser
Install-Module -Name ExchangeOnlineManagement -Force  -AllowClobber -Scope CurrentUser
Install-Module MSOnline -Force  -AllowClobber -Scope CurrentUser        # OPTIONAL
Install-Module AzureADPreview -Force -AllowClobber -Scope CurrentUser  # OPTIONAL
Install-Module AzureAD -Force  -AllowClobber -Scope CurrentUser
# Install-Module Microsoft.Graph -Force  -AllowClobber -Scope CurrentUser # OPTIONAL

Install-Package python -Scope CurrentUser

# Check Operating System and Set Tools Path
if ($IsWindows) {
    $toolsPath = "C:\Git"
} elseif ($IsLinux) {
    $toolsPath = "~/Git"
} else {
    Write-Output "Unsupported OS."
    return
}

# Create the directory if it doesn't exist
if (-not (Test-Path $toolsPath)) {
    New-Item -ItemType Directory -Path $toolsPath | Out-Null
}

# Change directory to the tools path
Set-Location $toolsPath

# Determine the Operating System
if ($IsWindows) {
    # Windows-specific commands
    $url = "https://github.com/Flangvik/TeamFiltration/releases/download/v3.5.2/TeamFiltration-v3.5.2-win-x86_64.zip"
    $outfile = "TeamFiltration.zip"
    iwr $url -Outfile $outfile
    Expand-Archive -Path $outfile -DestinationPath .\TeamFiltration
} elseif ($IsLinux) {
    # Linux-specific commands
    $url = "https://github.com/Flangvik/TeamFiltration/releases/download/v3.5.3/TeamFiltration-v3.5.3-linux-x86_64.zip"
    $outfile = "TeamFiltrationLin.zip"
    iwr $url -Outfile $outfile
    # For Linux, using unzip if Expand-Archive is not available
    # PowerShell Core on Linux might not have Expand-Archive readily available
    if (Get-Command 'Expand-Archive' -ErrorAction SilentlyContinue) {
        Expand-Archive -Path $outfile -DestinationPath .\TeamFiltrationLin
    } else {
        # Assuming unzip is installed; if not, it can be installed via package manager
        # For example, on Ubuntu: sudo apt-get install unzip
        bash -c "unzip $outfile -d ./TeamFiltrationLin"
    }
} else {
    Write-Output "Unsupported OS."
}

# Mailsniper for searching mailboxes for creds
git clone https://github.com/dafthack/MailSniper.git

# MFASweep check for 2FA bypasses
git clone https://github.com/dafthack/MFASweep

# O365Creeper
git clone https://github.com/LMGsec/o365creeper

# O365-Stealer
git clone https://github.com/AlteredSecurity/365-Stealer.git

# GraphRunner
git clone https://github.com/dafthack/GraphRunner

# TokenTactics
git clone https://github.com/rvrsh3ll/TokenTactics.git

# TokenTactics V2 - CAE Tokens
git clone https://github.com/f-bader/TokenTacticsV2.git

# TokenTormentor
git clone https://github.com/CompassSecurity/TokenTormentor

# TokenPhisher
git clone https://github.com/CompassSecurity/TokenPhisher

# PhirstPhish
git clone https://github.com/mellosec/phirstphish

# AzureAppTools
git clone https://github.com/rvrsh3ll/Azure-App-Tools

# Azure Acces Permissions tool
git clone https://github.com/csandker/Azure-AccessPermissions.git

# Microburst
git clone https://github.com/NetSPI/MicroBurst.git

# PowerZure
git clone https://github.com/hausec/PowerZure.git

# Egress Assessor
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git

# MSOLSpray for fine-enumeration of accounts / checking valid creds without a PUSH notification
git clone https://github.com/dafthack/MSOLSpray

# Omnispray - Spiritual Succesor of MSOLspray
git clone https://github.com/0xZDH/Omnispray.git

# o365spray - Re-Implement spraying in Go
git clone https://github.com/0xZDH/o365spray

# go365 - spray RST endpoint
git clone https://github.com/optiv/Go365

# Spray365
git clone https://github.com/MarkoH17/Spray365
cd Spray365
pip install -r requirements.txt -U
python spray365.py
cd ..

# BlobHunter
git clone https://github.com/cyberark/BlobHunter.git $toolsPath\BlobHunter
cd $toolsPath\Blobhunter
pip3 install -r requirements.txt
cd ..

# ROADTools
git clone https://github.com/dirkjanm/ROADtools.git
pip install roadrecon roadlib roadtx neo4j-driver

# Check Operating System and Download Correct geckodriver Version
if ($IsWindows) {
    # For Windows
    iwr https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-win-aarch64.zip -Outfile geckodriver-win.zip
    Expand-Archive -Path geckodriver-win.zip -DestinationPath .\geckodriver
    Remove-Item geckodriver-win.zip # Clean up ZIP file
} elseif ($IsLinux) {
    # For Linux
    iwr https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux-aarch64.tar.gz -Outfile geckodriver-lin.tar.gz
    tar -xzf geckodriver-lin.tar.gz -C ./geckodriver
    Remove-Item geckodriver-lin.tar.gz # Clean up TAR.GZ file
} else {
    Write-Output "Unsupported OS."
}

# Fireprox
git clone https://github.com/ustayready/fireprox
cd fireprox
# virtualenv -p python3 .
# source bin/activate
pip install -r requirements.txt
python fire.py
cd ..

# CAP Gap Analyzer
git clone https://github.com/jsa2/caOptics

# Bridgekeeper for scraping linkedin
git clone https://github.com/0xZDH/BridgeKeeper
cd BridgeKeeper
pip install -r requirements.txt
cd ..

# 365 Stealer
git clone https://github.com/AlteredSecurity/365-Stealer.git
cd 365-Stealer
pip install -r requirements.txt 

# XAMPP
iwr https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/8.0.30/xampp-windows-x64-8.0.30-0-VS16-installer.exe -o C:\xampp.exe
Start-Process C:\xampp.exe
