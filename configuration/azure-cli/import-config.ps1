# Azure CLI Configuration Import Script
# This script exports Azure CLI configuration to the repository

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configDir = Join-Path $scriptDir "config"

# Create config directory if it doesn't exist
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
}

# Export Azure CLI configuration
Write-Host "Exporting Azure CLI configuration..."
$azureConfigPath = "$env:USERPROFILE\.azure"

if (Test-Path $azureConfigPath) {
    # Copy config file
    if (Test-Path "$azureConfigPath\config") {
        Copy-Item -Path "$azureConfigPath\config" -Destination "$configDir\config" -Force
        Write-Host "Azure CLI config exported"
    }

    # Copy clouds.config if it exists
    if (Test-Path "$azureConfigPath\clouds.config") {
        Copy-Item -Path "$azureConfigPath\clouds.config" -Destination "$configDir\clouds.config" -Force
        Write-Host "Azure CLI clouds.config exported"
    }
} else {
    Write-Host "Warning: Azure CLI config directory not found at $azureConfigPath" -ForegroundColor Yellow
}

Write-Host "`nConfiguration import completed successfully!" -ForegroundColor Green
