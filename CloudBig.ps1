# Install boxstarter with chocolatey and basic configuration
# . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Set-TimeZone -Name "Eastern Standard Time" -Verbose

New-Item -Path C:\ -Name Temp -ItemType Directory -ErrorAction SilentlyContinue
New-Item -Path C:\ -Name payloads -ItemType Directory -ErrorAction SilentlyContinue

$env:TEMP = "C:\Temp"
$env:TMP = "C:\Temp"

# Defender
$Downloads = Get-ItemPropertyValue 'HKCU:\software\microsoft\windows\currentversion\explorer\shell folders\' -Name '{374DE290-123F-4565-9164-39C4925E467B}'
Add-MpPreference -ExclusionPath $Downloads
Add-MpPreference -ExclusionPath "C:\payloads\"
Add-MpPreference -ExclusionPath "C:\tools\"
Set-MpPreference -MAPSReporting Disabled
Set-MpPreference -SubmitSamplesConsent NeverSend

# Set a nice wallpaper : 
write-host "Setting a nice wallpaper"
$web_dl = new-object System.Net.WebClient
$wallpaper_url = "https://dev.straylightsecurity.com/assets/lich3.jpg"
$wallpaper_file = "C:\Users\Public\Pictures\desktop.jpg"
$web_dl.DownloadFile($wallpaper_url, $wallpaper_file)
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Users\Public\Pictures\desktop.jpg" /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallpaperStyle /t REG_DWORD /d "0" /f 
# reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v StretchWallpaper /t REG_DWORD /d "2" /f 
reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v Background /t REG_SZ /d "0 0 0" /f


# Dev Tools
choco feature enable -n allowGlobalConfirmation
choco install 7zip
choco install git
choco install poshgit
choco install microsoft-windows-terminal
choco install vscode

# RTO paths and Defender
New-Item -Path C:\ -Name Temp -ItemType Directory -ErrorAction SilentlyContinue
New-Item -Path C:\ -Name payloads -ItemType Directory -ErrorAction SilentlyContinue
New-Item -Path C:\ -Name Git -ItemType Directory -ErrorAction SilentlyContinue

$env:TEMP = "C:\Temp"
$env:TMP = "C:\Temp"

$Downloads = Get-ItemPropertyValue 'HKCU:\software\microsoft\windows\currentversion\explorer\shell folders\' -Name '{374DE290-123F-4565-9164-39C4925E467B}'
Add-MpPreference -ExclusionPath $Downloads
Add-MpPreference -ExclusionPath "C:\payloads\"
Add-MpPreference -ExclusionPath "C:\tools\"
Add-MpPreference -ExclusionPath "C:\Git\"
Set-MpPreference -MAPSReporting Disabled
Set-MpPreference -SubmitSamplesConsent NeverSend

# Cloud tools
choco install awscli
choco install azure-cli
choco install terraform

# Proxy software
choco install proxifier
choco install burp-suite-free-edition
choco install firefox

# languages
refreshenv
choco install python3
choco install pip
choco install golang
choco install heidisql --version=10.2.0.559900
choco install openjdk11
choco install neo4j-community
choco install sysinternals --params "/InstallDir:C:\tools\sysinternals"

# Powershell Modules
Install-Module aadinternals -force -Confirm -AllowClobber -Scope CurrentUser
Install-Module Az -Force -Confirm -AllowClobber -Scope CurrentUser
Install-Module -Name ExchangeOnlineManagement -Force -Confirm -AllowClobber -Scope CurrentUser
Install-Module Microsoft.Graph -Force -Confirm -AllowClobber -Scope CurrentUser # OPTIONAL
Install-Module MSOnline -Force -Confirm -AllowClobber -Scope CurrentUser        # OPTIONAL
Install-Module AzureADPreview -Force -Confirm -AllowClobber -Scope CurrentUser  # OPTIONAL
# Install-Module AzureAD -Force -Confirm -AllowClobber -Scope CurrentUser

# Public Repos
cd C:\Git
pip install virtualenv

# Fireprox
git clone https://github.com/ustayready/fireprox
cd fireprox
virtualenv -p python3 .
# source bin/activate
pip install -r requirements.txt
python fire.py
cd ..

# Credmaster for spraying through fireprox
# https://github.com/knavesec/CredMaster/wiki/
git clone https://github.com/knavesec/CredMaster.git
cd CredMaster
pip install -r requirements.txt
cd ..

# Teamfiltration fer der Spraymaking
iwr https://github.com/Flangvik/TeamFiltration/releases/download/v3.5.2/TeamFiltration-v3.5.2-win-x86_64.zip -o TeamFiltration.zip
Expand-Arhcive Teamfiltration.zip

# Mailsniper for searching mailboxes for creds
git clone https://github.com/dafthack/MailSniper.git

# MFASweep check for 1FA / bypasses
git clone https://github.com/dafthack/MFASweep

# MSOLSpray for fine-enumeration of accounts / checking valid creds without a PUSH notification
git clone https://github.com/dafthack/MSOLSpray

# O365-Stealer
git clone https://github.com/AlteredSecurity/365-Stealer.git

# TokenTactics
git clone https://github.com/rvrsh3ll/TokenTactics.git

# AzureAppTools
git clone https://github.com/rvrsh3ll/Azure-App-Tools

# Azure Acces Permissions tool
git clone https://github.com/csandker/Azure-AccessPermissions.git

# Microburst
git clone https://github.com/NetSPI/MicroBurst.git

# PowerZure
git clone https://github.com/hausec/PowerZure.git

# Patsy
git clone https://github.com/MelloSec/Patsy

# pingTunnel
git clone https://github.com/mellonaut/pingtunnel

$toolsPath = "C:\Git"
git clone https://github.com/dafthack/MailSniper.git $toolsPath\MailSniper
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git $toolsPath\Egress-Assess
git clone https://github.com/NetSPI/MicroBurst
git clone https://github.com/NetSPI/PowerUpSQL.git $toolsPath\PowerUpSQL
git clone https://github.com/p3nt4/PowerShdll.git $toolsPath\PowerShdll
git clone https://github.com/TheWover/donut.git $toolsPath\donut
git clone https://github.com/ZeroPointSecurity/PhishingTemplates.git $toolsPath\PhishingTemplates
git clone https://github.com/mgeeky/AzureRT $toolsPath\AzureRT
git clone https://github.com/0xZDH/o365spray.git $toolsPath\o365spray
git clone https://github.com/dafthack/GraphRunner.git $toolsPath\GraphRunner
git clone https://github.com/csandker/Azure-AccessPermissions $toolsPath\Azure-AccessPermissions
git clone https://github.com/MelloSec/Sessioner $toolsPath\Sessioner
git clone https://github.com/MelloSec/PhirstPhish $toolsPath\PhirstPhish
git clone https://github.com/AlteredSecurity/365-Stealer.git $toolsPath\365-Stealer


# Password Spraying Tools
# https://github.com/knavesec/CredMaster/wiki/
git clone https://github.com/knavesec/CredMaster.git $toolsPath\CredMaster
cd $toolsPath\CredMaster
pip install -r requirements.txt
cd ..

# BlobHunter
git clone https://github.com/cyberark/BlobHunter.git $toolsPath\BlobHunter
cd $toolsPath\Blobhunter
pip3 install -r requirements.txt

# LinkedIn OSINT for usernames
git clone https://github.com/mellonaut/linkedin2username

# ROADTools
git clone https://github.com/dirkjanm/ROADtools.git
pip install roadrecon roadlib roadtx neo4j-driver
iwr https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-win-aarch64.zip -o geckodriver-win.zip
# iwr https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux-aarch64.tar.gz -o geckodriver-lin.tar.gz

# deepCE for docker privesc
git clone https://github.com/stealthcopter/deepce.git

#  Subdomain takeover
git clone https://github.com/Ice3man543/SubOver.git

# ROPCI for MFA bypass testing using obscure flow
git clone https://github.com/mellonaut/ropci
wget https://github.com/wunderwuzzi23/ropci/releases/download/v0.1/ropci-linux-v0.1.zip
# iwr https://github.com/wunderwuzzi23/ropci/releases/download/v0.1/ropci-windows-v0.1.zip -o ropci.zip


# Neo4j linux
# mkdir -p /usr/share/neo4j/run/
# mkdir -p /usr/share/neo4j/logs/
# sed -i -r 's:#dbms.allow_upgrade=true:dbms.allow_upgrade=true:' /etc/neo4j/neo4j.conf
# neo4j start
# Changes Neo4j credentials to: neo4j/neo4jj
# curl -H "Content-Type: application/json" -X POST -d '{"password":"neo4jj"}' -u neo4j:neo4j http://localhost:7474/user/neo4j/password

# Import-Module Az
# Import-Module AzureADPreview
# Import-Module Microsoft.Graph 
# import-module aadinternals

# Patator for better password attacks
# git clone https://github.com/lanjelot/patator.git
# git clone https://github.com/danielmiessler/SecLists.git
# docker build -t patator patator/
# docker run -it --rm -v $PWD/SecLists/Passwords:/mnt patator dummy_test data=FILE0 0=/mnt/richelieu-french-top5000.txt


echo "Import-Module AADInternals
Import-Module C:\Git\TokenTactics\TokenTactics.psd1 -force
Import-Module Az
Import-Module AzureAdPreview" > $Profile
