# Export All Configurations Script
# This script applies all configurations from the repository to the local machine

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Exporting All Configurations" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Export Git configuration (first, as it might be needed for other operations)
Write-Host "--- Git Configuration ---" -ForegroundColor Yellow
& "$scriptDir\git\export-config.ps1"
Write-Host ""

# Export VS Code configuration
Write-Host "--- VS Code Configuration ---" -ForegroundColor Yellow
& "$scriptDir\vscode\export-config.ps1"
Write-Host ""

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  All Configurations Exported!" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
