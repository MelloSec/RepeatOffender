
# Script to customize the box and install a bunch of offensive development and security tools
# Based on Rasta Mouse CRTO VM with a bunch of O365 and Malware tools

# Install boxstarter with chocolatey and basic configuration
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Set-TimeZone -Name "Eastern Standard Time" -Verbose

New-Item -Path C:\ -Name Temp -ItemType Directory -ErrorAction SilentlyContinue
New-Item -Path C:\ -Name payloads -ItemType Directory -ErrorAction SilentlyContinue

$toolsPath = "C:\Tools" 
$env:TEMP = "C:\Temp"
$env:TMP = "C:\Temp"

# Defender
$Downloads = Get-ItemPropertyValue 'HKCU:\software\microsoft\windows\currentversion\explorer\shell folders\' -Name '{374DE290-123F-4565-9164-39C4925E467B}'
Add-MpPreference -ExclusionPath $Downloads
Add-MpPreference -ExclusionPath "C:\payloads\"
Add-MpPreference -ExclusionPath "$toolsPath\"
Set-MpPreference -MAPSReporting Disabled
Set-MpPreference -SubmitSamplesConsent NeverSend

# Packages
choco feature enable -n allowGlobalConfirmation
choco install 7zip
choco install git
choco install poshgit
## choco install googlechrome --ignore-checksums
choco install heidisql --version=10.2.0.559900
choco install openjdk11
choco install python3
choco install tabby
choco install firefox
choco install putty
choco install vscode
choco install sysinternals --params "/InstallDir:$toolsPath\sysinternals"
# choco install visualstudio2019community -y
choco install openvpn
choco install powertoys
choco install dotnet-sdk --version=5.0.100
choco install netfx-4.8-devpack
choco install dotnet-sdk
choco install mingw
choco install python3
choco install pip
choco install golang
choco install x64dbg.portable
choco install ollydbg
choco install ida-free
choco install wireshark
choco install ngrok
choco install wireguard


# Install Malware related tooling
choco install autohotkey
choco install dotpeek
choco install ghidra
choco install cutter 
choco install pestudio
choco install pebear
choco install pesieve
choco install hollowshunter
choco install dependencywalker  
choco install ilspy
choco install dnspy
choco install procmon
choco install procdot
choco install processhacker
choco install fiddler
choco install regshot
choco install dnscrypt-proxy
choco install reshack

$gitPath = "C:\Program Files\Git\bin"
$env:Path = "$env:Path;$gitPath"
Add-Content -Path $PROFILE -Value "Set-Location '$gitPath'"



# Need to refresh or reload here
git clone https://github.com/BloodHoundAD/SharpHound3.git $toolsPath\SharpHound3
git clone https://github.com/dafthack/MailSniper.git $toolsPath\MailSniper
git clone https://github.com/decoder-it/juicy-potato.git $toolsPath\juicy-potato
git clone https://github.com/djhohnstein/SharpChrome.git $toolsPath\SharpChrome
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git $toolsPath\Egress-Assess
git clone https://github.com/FSecureLABS/SharpGPOAbuse.git $toolsPath\SharpGPOAbuse
git clone https://github.com/gentilkiwi/mimikatz.git $toolsPath\mimikatz
git clone https://github.com/GhostPack/Seatbelt.git $toolsPath\Seatbelt
git clone https://github.com/HarmJ0y/DAMP.git $toolsPath\DAMP
git clone https://github.com/hfiref0x/UACME.git $toolsPath\UACME
git clone https://github.com/leechristensen/SpoolSample.git $toolsPath\SpoolSample
git clone https://github.com/NetSPI/MicroBurst
git clone https://github.com/NetSPI/PowerUpSQL.git $toolsPath\PowerUpSQL
git clone https://github.com/p3nt4/PowerShdll.git $toolsPath\PowerShdll
git clone https://github.com/PowerShellMafia/PowerSploit.git $toolsPath\PowerSploit
git clone https://github.com/rasta-mouse/MiscTools.git $toolsPath\MiscTools
git clone https://github.com/rasta-mouse/Sherlock.git $toolsPath\Sherlock
git clone https://github.com/rasta-mouse/Watson.git $toolsPath\Watson
git clone https://github.com/tevora-threat/SharpView.git $toolsPath\SharpView
git clone https://github.com/TheWover/donut.git $toolsPath\donut
git clone https://github.com/ZeroPointSecurity/PhishingTemplates.git $toolsPath\PhishingTemplates
git clone https://github.com/rvrsh3ll/TokenTactics.git $toolsPath\TokenTactics
git clone https://github.com/mgeeky/AzureRT $toolsPath\AzureRT
git clone https://github.com/0xZDH/o365spray.git $toolsPath\o365spray
git clone https://github.com/dafthack/GraphRunner.git $toolsPath\GraphRunner
git clone https://github.com/csandker/Azure-AccessPermissions $toolsPath\Azure-AccessPermissions
git clone https://github.com/hausec/PowerZure $toolsPath\PowerZure
git clone https://github.com/MelloSec/Sessioner $toolsPath\Sessioner
git clone https://github.com/MelloSec/PhirstPhish $toolsPath\PhirstPhish
git clone https://github.com/dafthack/MFASweep $toolsPath\MFASweep
git clone https://github.com/dafthack/MSOLSpray $toolsPath\MSOLSpray
git clone https://github.com/AlteredSecurity/365-Stealer.git $toolsPath\365-Stealer


# IE first run
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer"
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name DisableFirstRunCustomize -Value 1

# BloodHound
Invoke-WebRequest -Uri 'https://github.com/BloodHoundAD/BloodHound/releases/latest/download/BloodHound-win32-x64.zip' -OutFile "$env:TEMP\BloodHound.zip"
Expand-Archive -Path "$env:TEMP\BloodHound.zip" -DestinationPath $toolsPath\
Rename-Item -Path $toolsPath\BloodHound-win32-x64\ -NewName BloodHound
Invoke-WebRequest -Uri 'https://neo4j.com/artifact.php?name=neo4j-community-4.0.0-windows.zip' -OutFile "$env:TEMP\neo4j.zip"
Expand-Archive -Path "$env:TEMP\neo4j.zip" -DestinationPath $toolsPath\
Rename-Item -Path $toolsPath\neo4j-community-4.0.0\ -NewName Neo4j

## Visual Studio
Invoke-WebRequest -Uri 'https://visualstudioclient.gallerycdn.vsassets.io/extensions/visualstudioclient/microsoftvisualstudio2017installerprojects/1.0.0/1620063166533/InstallerProjects.vsix' -OutFile "$Downloads\InstallerProjects.vsix"
Invoke-WebRequest -Uri 'https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe' -OutFile "$Downloads\BuildTools.exe"
Enable-WindowsOptionalFeature -FeatureName NetFx3 -Online

# GPRegistryPolicy
Install-Module GPRegistryPolicy -Force

# Install Sysmon with Swift on Security
Set-ExecutionPolicy -Bypass
mkdir "C:\sysmon";
Invoke-WebRequest -Uri "https://github.com/mellonaut/sysmon/raw/main/sysmon.zip" -OutFile "C:\sysmon\sysmon.zip";
Expand-Archive "c:\sysmon\sysmon.zip" -DestinationPath "C:\sysmon";
cd "c:\sysmon";
c:\sysmon\sysmon.exe -acceptEula -i c:\sysmon\sysmon-swift.xml


# Networking
# ## VMware
# netsh interface ip set address "Ethernet1" static 192.168.152.101 255.255.255.0 192.168.152.100

# ## VBox
# netsh interface ip set address "Ethernet 2" static 192.168.152.101 255.255.255.0 192.168.152.100

# route add -p 10.8.0.0 mask 255.255.255.0 192.168.152.100
# route add -p 10.9.0.0 mask 255.255.255.0 192.168.152.100
# route add -p 10.10.110.0 mask 255.255.255.0 192.168.152.100
# Add-Content C:\Windows\System32\drivers\etc\hosts "192.168.152.100 kali"

# UI
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableExpandToOpenFolder -EnableShowRibbon
Install-ChocolateyShortcut -shortcutFilePath "C:\Users\Public\Desktop\tools.lnk" -targetPath $toolsPath\
Install-ChocolateyShortcut -shortcutFilePath "C:\Users\Public\Desktop\Neo4j.lnk" -targetPath "$toolsPath\Neo4j\bin\neo4j.bat" -arguments "console" -runAsAdmin

# Misc
$DesktopPath = [Environment]::GetFolderPath("Desktop")
Remove-Item -Path "C:\Users\Public\Desktop\Boxstarter Shell.lnk"
Remove-Item -Path C:\Temp\ -Recurse -Force

# House keeping and Updates
Disable-BingSearch
Set-TaskbarOptions -Dock Bottom
Set-ExplorerOptions -showHiddenFilesFoldersDrives -showFileExtensions

# O365 Tools
# Install modules
Install-Module -Name Az -Force
Install-Module -Name AzureAD -Force
Install-Module -Name MSOnline -Force
Install-Module -Name ExchangeOnlineManagement -Force
Install-Module -Name AADInternals -Force
Install-Module -Name Microsoft.Graph -Scope AllUsers -Force

# Import modules
Import-Module Az
Import-Module AzureAD
Import-Module MSOnline
Import-Module ExchangeOnlineManagement
Import-Module AADInternals
Import-Module Microsoft.Graph

$toolsPath = "C:\Tools" 

# Token Tactics
git clone https://github.com/rvrsh3ll/TokenTactics.git $toolsPath\TokenTactics
cd $toolsPath\TokenTactics
Import-Module .\TokenTactics.psd1
cd ..

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

# Road Tools
pip install roadlib
pip install roadrecon
pip install roadtx

# TeamFiltration
iwr https://github.com/Flangvik/TeamFiltration/releases/download/v3.5.0/TeamFiltration-Linux-v3.5.0.zip -o $toolsPath\teamfiltration.zip
Expand-Archive $toolsPath\teamfiltration.zip





# Set a nice wallpaper : 
write-host "Setting a nice wallpaper"
$web_dl = new-object System.Net.WebClient
$wallpaper_url = "https://dev.straylightsecurity.com/assets/lich3.jpg"
$wallpaper_file = "C:\Users\Public\Pictures\desktop.jpg"
$web_dl.DownloadFile($wallpaper_url, $wallpaper_file)
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Users\Public\Pictures\desktop.jpg" /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallpaperStyle /t REG_DWORD /d "0" /f 
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v StretchWallpaper /t REG_DWORD /d "2" /f 
reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v Background /t REG_SZ /d "0 0 0" /f

Enable-PSRemoting -Force
# Update-Help
Enable-WindowsUpdate
Enable-RemoteDesktop
Install-WindowsUpdate


# TrevorSpray
pip install git+https://github.com/blacklanternsecurity/trevorproxy
pip install git+https://github.com/blacklanternsecurity/trevorspray
