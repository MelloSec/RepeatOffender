## RepeatOffender

### Stager - Run Choco and Azure Script
```powershell
$stagerUrl = "https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/stager.ps1"

$tempFile = New-TemporaryFile
Invoke-WebRequest -Uri $stagerUrl -OutFile $tempFile -UseBasicParsing

# Execute the temporary file with the Azure switch
& $tempFile -Azure

# Or, to pass a custom script URL
& $tempFile -scriptUrl "https://example.com/custom-script.ps1"

# Clean up the temporary file
Remove-Item $tempFile
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
