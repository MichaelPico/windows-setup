# Install Essential Programs with Chocolatey
# This script installs all essential programs for Windows setup

Write-Host "Installing Essential Programs with Chocolatey..." -ForegroundColor Cyan
Write-Host ""

# Check if Chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey is not installed. Installing Chocolatey first..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # Refresh environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Host "Chocolatey installed successfully!" -ForegroundColor Green
    Write-Host ""
}

# List of programs to install
$programs = @(
    '7zip',
    'autohotkey',
    'dotnet-desktopruntime',
    'dotnet-9.0-desktopruntime',
    'firefox',
    'git',
    'nuget.commandline',
    'postman',
    'powershell-core',
    'powertoys',
    'python3',
    'vscode'
)

Write-Host "The following programs will be installed:" -ForegroundColor Cyan
$programs | ForEach-Object { Write-Host "  - $_" }
Write-Host ""

# Install each program
foreach ($program in $programs) {
    Write-Host "Installing $program..." -ForegroundColor Yellow
    choco install $program -y
    Write-Host ""
}

Write-Host "All essential programs have been installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Note: You may need to restart your terminal or computer for all changes to take effect." -ForegroundColor Yellow
