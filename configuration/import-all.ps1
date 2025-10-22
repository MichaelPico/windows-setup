# Import All Configurations Script
# This script exports all configurations to the repository

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Importing All Configurations" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Import VS Code configuration
Write-Host "--- VS Code Configuration ---" -ForegroundColor Yellow
& "$scriptDir\vscode\import-config.ps1"
Write-Host ""

# Import Git configuration
Write-Host "--- Git Configuration ---" -ForegroundColor Yellow
& "$scriptDir\git\import-config.ps1"
Write-Host ""

# Import Azure CLI configuration
Write-Host "--- Azure CLI Configuration ---" -ForegroundColor Yellow
& "$scriptDir\azure-cli\import-config.ps1"
Write-Host ""

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  All Configurations Imported!" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
