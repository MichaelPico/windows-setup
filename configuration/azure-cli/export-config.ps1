# Azure CLI Configuration Export Script
# This script applies Azure CLI configuration from the repository to the local machine

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configDir = Join-Path $scriptDir "config"

# Check if config directory exists
if (-not (Test-Path $configDir)) {
    Write-Host "Error: Config directory not found at $configDir" -ForegroundColor Red
    Write-Host "Run import-config.ps1 first to export your configuration." -ForegroundColor Yellow
    exit 1
}

# Apply Azure CLI configuration
Write-Host "Applying Azure CLI configuration..."
$azureConfigPath = "$env:USERPROFILE\.azure"

# Create .azure directory if it doesn't exist
if (-not (Test-Path $azureConfigPath)) {
    New-Item -ItemType Directory -Path $azureConfigPath -Force | Out-Null
}

# Copy config file
if (Test-Path "$configDir\config") {
    Copy-Item -Path "$configDir\config" -Destination "$azureConfigPath\config" -Force
    Write-Host "Azure CLI config applied"
} else {
    Write-Host "Warning: config file not found in config directory" -ForegroundColor Yellow
}

# Copy clouds.config if it exists
if (Test-Path "$configDir\clouds.config") {
    Copy-Item -Path "$configDir\clouds.config" -Destination "$azureConfigPath\clouds.config" -Force
    Write-Host "Azure CLI clouds.config applied"
}

Write-Host "`nConfiguration export completed successfully!" -ForegroundColor Green
