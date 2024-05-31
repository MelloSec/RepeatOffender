## RepeatOffender

### Stager - Run Choco and Azure Script
```powershell
$stagerUrl = "https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/stager.ps1"

# Download and execute the stager script with the Azure switch
Invoke-Expression (Invoke-WebRequest -Uri $stagerUrl -UseBasicParsing).Content -Azure
```

### Prep - Setup Chocolatey separately first so the Other Scripts can run with choco in PATH
```powershell
.\choco.ps1
```

### Azure Tools - Windows or Linux (Can run in CloudShell)
```powershell
.\Azure.ps1
```

### AD / Various Tools for use in testing pens - Windows Only
```powershell
.\RepeatOffender.ps1
```

### Cloud Tools - Windows Only
```powershell
.\CloudBig.ps1
```
