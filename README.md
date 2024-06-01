## RepeatOffender

### Quick Start
```powershell
# Install Choco
iex (iwr https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/Choco.ps1 -UseBasicParsing)

# Clone repos and Install Azure Tools (cli, storage explorer included)
iex (iwr https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/Azure.ps1 -UseBasicParsing)

# Import Modules
iex (iwr https://raw.githubusercontent.com/MelloSec/RepeatOffender/main/Import-AzureModules.ps1 -UseBasicParsing)
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
