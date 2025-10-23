# Git Configuration Export Script
# This script applies Git global configuration from the repository to the local machine

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configDir = Join-Path $scriptDir "config"

# Check if config directory exists
if (-not (Test-Path $configDir)) {
    Write-Host "Error: Config directory not found at $configDir" -ForegroundColor Red
    Write-Host "Run import-config.ps1 first to export your configuration." -ForegroundColor Yellow
    exit 1
}

# Apply Git global configuration
Write-Host "Applying Git global configuration..."
$sourceConfig = Join-Path $configDir ".gitconfig"
$destConfig = "$env:USERPROFILE\.gitconfig"

if (Test-Path $sourceConfig) {
    Copy-Item -Path $sourceConfig -Destination $destConfig -Force
    Write-Host "Git configuration applied to $destConfig"
} else {
    Write-Host "Error: .gitconfig not found in config directory" -ForegroundColor Red
    exit 1
}

Write-Host "`nConfiguration export completed successfully!" -ForegroundColor Green
