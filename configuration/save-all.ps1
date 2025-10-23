# Save All Configurations Script
# This script saves all configurations from the machine to the repository

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Saving All Configurations" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Save VS Code configuration
Write-Host "--- VS Code Configuration ---" -ForegroundColor Yellow
& "$scriptDir\vscode\save-config.ps1"
Write-Host ""

# Save Git configuration
Write-Host "--- Git Configuration ---" -ForegroundColor Yellow
& "$scriptDir\git\save-config.ps1"
Write-Host ""

# Save Azure CLI configuration
Write-Host "--- Azure CLI Configuration ---" -ForegroundColor Yellow
& "$scriptDir\azure-cli\save-config.ps1"
Write-Host ""

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  All Configurations Saved!" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
