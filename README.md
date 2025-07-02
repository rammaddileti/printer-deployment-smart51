# printer-deployment-smart51
Deploy IDP SMART-51 Card Printer using PowerShell and Intune
# IDP SMART-51 Card Printer Deployment Script

This repository provides a PowerShell script to automate the deployment of the **IDP SMART-51 Card Printer** via Microsoft Intune using the Win32 app model.

## Contents

- `install.ps1` – Automates:
  - Adding the printer driver via `pnputil`
  - Installing the printer driver via PowerShell
  - Creating a TCP/IP port using `prnport.vbs`
- `SMART51/` – Contains the required `smart51.inf` printer driver file

## Usage with Intune

1. Package using the **IntuneWinAppUtil.exe** tool:
   ```bash
   IntuneWinAppUtil.exe -c . -s install.ps1 -o output-folder
   
In Microsoft Intune:

Program:

Install command:

powershell.exe -ExecutionPolicy Bypass -File install.ps1
Detection Rule:
Use a script or check for installed printer driver.

Get-PrinterDriver -Name "IDP SMART-51 Card Printer"
Assign the app to your target devices.
