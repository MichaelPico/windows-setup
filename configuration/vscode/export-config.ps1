# VS Code Configuration Export Script
# This script applies VS Code configuration from the repository to the local machine

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configDir = Join-Path $scriptDir "config"

# Check if config directory exists
if (-not (Test-Path $configDir)) {
    Write-Host "Error: Config directory not found at $configDir" -ForegroundColor Red
    Write-Host "Run import-config.ps1 first to export your configuration." -ForegroundColor Yellow
    exit 1
}

# Define destination path
$vscodeUserDir = "$env:APPDATA\Code\User"

# Create VS Code User directory if it doesn't exist
if (-not (Test-Path $vscodeUserDir)) {
    New-Item -ItemType Directory -Path $vscodeUserDir -Force | Out-Null
}

# Copy configuration files
$configFiles = @(
    "settings.json",
    "keybindings.json"
)

Write-Host "Copying configuration files..."
foreach ($file in $configFiles) {
    $sourcePath = Join-Path $configDir $file
    $destPath = Join-Path $vscodeUserDir $file

    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination $destPath -Force
        Write-Host "Copied $file"
    } else {
        Write-Host "Warning: $file not found in config directory" -ForegroundColor Yellow
    }
}

# Copy snippets folder
Write-Host "`nCopying snippets folder..."
$snippetsSource = Join-Path $configDir "snippets"
$snippetsDest = Join-Path $vscodeUserDir "snippets"

if (Test-Path $snippetsSource) {
    # Create snippets directory if it doesn't exist
    if (-not (Test-Path $snippetsDest)) {
        New-Item -ItemType Directory -Path $snippetsDest -Force | Out-Null
    }

    # Copy all snippet files
    Copy-Item -Path "$snippetsSource\*" -Destination $snippetsDest -Force -Recurse
    Write-Host "Snippets folder copied"
} else {
    Write-Host "Warning: Snippets folder not found in config directory" -ForegroundColor Yellow
}

# Install extensions
Write-Host "`nInstalling VS Code extensions..."
$extensionsFile = Join-Path $configDir "extensions.txt"

if (Test-Path $extensionsFile) {
    $extensions = Get-Content $extensionsFile
    $totalExtensions = $extensions.Count
    $currentExtension = 0

    foreach ($extension in $extensions) {
        $currentExtension++
        if ($extension.Trim()) {
            Write-Host "[$currentExtension/$totalExtensions] Installing $extension..."
            code --install-extension $extension --force
        }
    }
    Write-Host "`nAll extensions installed!"
} else {
    Write-Host "Warning: extensions.txt not found in config directory" -ForegroundColor Yellow
}

Write-Host "`nConfiguration export completed successfully!" -ForegroundColor Green
Write-Host "Please restart VS Code for all changes to take effect." -ForegroundColor Cyan
