
# Check Operating System and Install Azure CLI and Git
if ($IsWindows) {
    # Ensure Chocolatey is installed before running these commands
    # Install Azure CLI
    choco install -y azure-cli
    # Install Storage Explorer
    choco install -y microsoftazurestorageexplorer
    # Install Git
    choco install -y git
    choco install -y poshgit
    choco install -y terraform
    choco install -y azure-functions-core-tools
    choco install -y burp-suite-free-edition
    choco install -y postman
    # Postman CLI
    iex ((New-Object System.Net.WebClient).DownloadString('https://dl-cli.pstmn.io/install/win64.ps1'))
    # Install Python
    Install-Package python -Scope CurrentUser
    # XAMPP
    iwr https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/8.0.30/xampp-windows-x64-8.0.30-0-VS16-installer.exe -OutFile C:\xampp.exe
    Start-Process C:\xampp.exe
    # Copy-Item $toolsPath\365-Stealer\* C:\xampp\htdocs
    # # Start XAMPP as admin
    # # uncomment ;extension=sqlite3` from  Apache/php.ini
    # # Set Apache to run Port 8000 to avoid conflict with 365stealer on 443
    # cd C:\xampp\htdocs 
    # pip install -r requirements.txt
} elseif ($IsLinux) {
    # Install Azure CLI
    curl -L https://aka.ms/InstallAzureCli | bash
    # Install Git
    sudo apt-get update -y
    sudo apt-get install -y git unzip terraform tmux
    # Function Tools
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
    sudo apt-get update -y
    sudo apt-get install -y azure-functions-core-tools-4
    # Postman CLI
    curl -o- "https://dl-cli.pstmn.io/install/linux64.sh" | sh    
} else {
    Write-Output "Unsupported OS."
}

# Powershell Modules
# Install-Module PSWindowsUpdate -Accept -Force
Install-Module aadinternals -force  -AllowClobber -Scope CurrentUser
Install-Module Az -Force -AllowClobber -Scope CurrentUser
Install-Module -Name ExchangeOnlineManagement -Force  -AllowClobber -Scope CurrentUser
Install-Module MSOnline -Force  -AllowClobber -Scope CurrentUser   
Install-Module AzureADPreview -Force -AllowClobber -Scope CurrentUser  
Install-Module Microsoft.Graph -Force  -AllowClobber -Scope CurrentUser

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

# CARTP
git clone https://github.com/mellosec/cartp

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

# Nishang 
git clone https://github.com/samratashok/nishang

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
cd ..

# AzureHound - Download the correct AzureHound binary for the detected OS
$binaryName = ""
$exePath = ""
if ($IsWindows) {
    $os = "windows"
    Write-Output "Detected Windows OS."
    $binaryName = "azurehound-windows-amd64.zip"
    $exePath = ".\azurehound.exe"
} elseif ($IsLinux) {
    $os = "linux"
    Write-Output "Detected Linux OS."
    $binaryName = "azurehound-linux-amd64.zip"
    $exePath = "./azurehound"
} else {
    Write-Output "Unsupported OS."
    exit 1
}

$outputZipFile = $binaryName
$downloadUrl = "https://github.com/BloodHoundAD/AzureHound/releases/latest/download/$binaryName"
Invoke-WebRequest -Uri $downloadUrl -OutFile $outputZipFile
Expand-Archive -LiteralPath $outputZipFile -DestinationPath . -Force
Remove-Item -Path $outputZipFile -Force
