# Apply All Configurations Script
# This script applies all configurations from the repository to the local machine

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Applying All Configurations" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Apply Git configuration (first, as it might be needed for other operations)
Write-Host "--- Git Configuration ---" -ForegroundColor Yellow
& "$scriptDir\git\apply-config.ps1"
Write-Host ""

# Apply Azure CLI configuration
Write-Host "--- Azure CLI Configuration ---" -ForegroundColor Yellow
& "$scriptDir\azure-cli\apply-config.ps1"
Write-Host ""

# Apply VS Code configuration
Write-Host "--- VS Code Configuration ---" -ForegroundColor Yellow
& "$scriptDir\vscode\apply-config.ps1"
Write-Host ""

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  All Configurations Applied!" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
