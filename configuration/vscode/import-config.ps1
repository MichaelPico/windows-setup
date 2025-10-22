# VS Code Configuration Import Script
# This script exports VS Code extensions and configuration files to the repository

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Export installed extensions
Write-Host "Exporting VS Code extensions..."
code --list-extensions | Out-File -FilePath "$scriptDir\extensions.txt" -Encoding utf8
Write-Host "Extensions exported to extensions.txt"

# Define source and destination paths
$vscodeUserDir = "$env:APPDATA\Code\User"
$configFiles = @(
    "settings.json",
    "keybindings.json"
)

# Copy configuration files
Write-Host "`nCopying configuration files..."
foreach ($file in $configFiles) {
    $sourcePath = Join-Path $vscodeUserDir $file
    $destPath = Join-Path $scriptDir $file

    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination $destPath -Force
        Write-Host "Copied $file"
    } else {
        Write-Host "Warning: $file not found at $sourcePath" -ForegroundColor Yellow
    }
}

# Copy snippets folder
Write-Host "`nCopying snippets folder..."
$snippetsSource = Join-Path $vscodeUserDir "snippets"
$snippetsDest = Join-Path $scriptDir "snippets"

if (Test-Path $snippetsSource) {
    # Create snippets directory if it doesn't exist
    if (-not (Test-Path $snippetsDest)) {
        New-Item -ItemType Directory -Path $snippetsDest -Force | Out-Null
    }

    # Copy all snippet files
    Copy-Item -Path "$snippetsSource\*" -Destination $snippetsDest -Force -Recurse
    Write-Host "Snippets folder copied"
} else {
    Write-Host "Warning: Snippets folder not found at $snippetsSource" -ForegroundColor Yellow
}

Write-Host "`nConfiguration import completed successfully!" -ForegroundColor Green
