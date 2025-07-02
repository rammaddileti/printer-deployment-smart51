# install.ps1
# Run with system context in Intune. Ensure smart51.inf is in .\SMART51\smart51.inf relative to script.

$ErrorActionPreference = "Stop"

# Define paths and variables
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InfPath = Join-Path -Path $ScriptRoot -ChildPath "SMART51\smart51.inf"
$PortName = "SMART-51 Card:"
$IPAddress = "10.250.1.107"

Write-Host "Installation of 'IDP SMART-51 Card Printer' started at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

# Add driver to driver store
try {
    pnputil.exe /add-driver "`"$InfPath`"" /install | Out-Null
    Write-Host "Driver added to driver store successfully."
} catch {
    Write-Error "Failed to add driver via pnputil: $_"
    exit 1
}

# Install printer driver
try {
    Add-PrinterDriver -Name "IDP SMART-51 Card Printer" -InfPath $InfPath
    Write-Host "Printer driver installed successfully."
} catch {
    Write-Error "Failed to install printer driver: $_"
    exit 1
}

# Add TCP/IP printer port
try {
    $portExists = Get-PrinterPort -Name $PortName -ErrorAction SilentlyContinue
    if (-not $portExists) {
        cscript.exe "$env:windir\System32\Printing_Admin_Scripts\en-US\prnport.vbs" -a -r "$PortName" -h $IPAddress -o raw -n 9100 | Out-Null
        Write-Host "Printer port '$PortName' created."
    } else {
        Write-Host "Printer port '$PortName' already exists. Skipping creation."
    }
} catch {
    Write-Error "Failed to add printer port: $_"
    exit 1
}

Write-Host "Installation of 'IDP SMART-51 Card Printer' completed successfully at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
exit 0
