## RepeatOffender

### Stager - Run Choco and Azure Script
```powershell
$stagerUrl = "https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/stager.ps1"

$tempFile = ".\stager.ps1"
Invoke-WebRequest -Uri $stagerUrl -OutFile $tempFile -UseBasicParsing

# Execute the temporary file with the Azure switch
& $tempFile -Azure

# Clean up the temporary file
Remove-Item $tempFile
```

### Prep - Setup Chocolatey separately first so the Other Scripts can run with choco in PATH
```powershell
.\choco.ps1

# in-mem
iex (iwr https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/Choco.ps1 -UseBasicParsing)
```

### Azure Tools - Windows or Linux (Can run in CloudShell)
```powershell
.\Azure.ps1

# in mem
iex (iwr https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/Azure.ps1 -UseBasicParsing)
```

### AD / Various Tools for use in testing pens - Windows Only
```powershell
.\RepeatOffender.ps1
```

### Cloud Tools - Windows Only
```powershell
.\CloudBig.ps1
```
