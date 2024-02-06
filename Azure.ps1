# Azure CLI
choco install -y azure-cli

# Powershell Modules
Install-Module aadinternals -force  -AllowClobber -Scope CurrentUser
Install-Module Az -Force -AllowClobber -Scope CurrentUser
Install-Module -Name ExchangeOnlineManagement -Force  -AllowClobber -Scope CurrentUser
Install-Module Microsoft.Graph -Force  -AllowClobber -Scope CurrentUser # OPTIONAL
Install-Module MSOnline -Force  -AllowClobber -Scope CurrentUser        # OPTIONAL
Install-Module AzureADPreview -Force -AllowClobber -Scope CurrentUser  # OPTIONAL
Install-Module AzureAD -Force  -AllowClobber -Scope CurrentUser

# Repos
mkdir C:\Git
$toolsPath = "C:\Git"
cd C:\Git

# Teamfiltration 
iwr https://github.com/Flangvik/TeamFiltration/releases/download/v3.5.2/TeamFiltration-v3.5.2-win-x86_64.zip -o TeamFiltration.zip
Expand-Arhcive Teamfiltration.zip

# Mailsniper for searching mailboxes for creds
git clone https://github.com/dafthack/MailSniper.git

# MFASweep check for 2FA bypasses
git clone https://github.com/dafthack/MFASweep

# MSOLSpray for fine-enumeration of accounts / checking valid creds without a PUSH notification
git clone https://github.com/dafthack/MSOLSpray

# O365Creeper
git clone https://github.com/LMGsec/o365creeper

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

# Egress Assessor
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git $toolsPath\Egress-Assess

# BlobHunter
git clone https://github.com/cyberark/BlobHunter.git $toolsPath\BlobHunter
cd $toolsPath\Blobhunter
pip3 install -r requirements.txt
cd ..

# ROADTools
git clone https://github.com/dirkjanm/ROADtools.git
pip install roadrecon roadlib roadtx neo4j-driver
iwr https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-win-aarch64.zip -o geckodriver-win.zip
# iwr https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux-aarch64.tar.gz -o geckodriver-lin.tar.gz

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

# Spray365
git clone https://github.com/MarkoH17/Spray365
cd Spray365
pip install -r requirements.txt -U
python spray365.py
cd ..

# Bridgekeeper for scraping linkedin
git clone https://github.com/0xZDH/BridgeKeeper
cd BridgeKeeper
pip install -r requirements.txt
cd ..