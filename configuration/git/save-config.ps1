# Git Configuration Import Script
# This script exports Git global configuration to the repository

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configDir = Join-Path $scriptDir "config"

# Create config directory if it doesn't exist
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
}

# Export Git global configuration
Write-Host "Exporting Git global configuration..."
$gitConfigPath = "$env:USERPROFILE\.gitconfig"

if (Test-Path $gitConfigPath) {
    Copy-Item -Path $gitConfigPath -Destination "$configDir\.gitconfig" -Force
    Write-Host "Git configuration exported to .gitconfig"
} else {
    Write-Host "Warning: .gitconfig not found at $gitConfigPath" -ForegroundColor Yellow
}

Write-Host "`nConfiguration import completed successfully!" -ForegroundColor Green
