# VM Setup Script
# This script runs on the VM after deployment to set up the environment

param(
    [string]$repositoryUrl = "https://github.com/MichaelPico/windows-setup"
)

# Write repository URL to C: drive root
$repoUrlFile = "C:\windows-repo-url.txt"

Write-Host "Writing repository URL to C: drive root..."
$repositoryUrl | Out-File -FilePath $repoUrlFile -Encoding UTF8

# Install Chocolatey
Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
    [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Refresh environment variables to make choco available
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Install Git using Chocolatey
Write-Host "Installing Git using Chocolatey..."
choco install git -y

# Refresh environment variables again to make git available
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Clone the repository to C:\windows-setup
$cloneDestination = "C:\windows-setup"
Write-Host "Cloning repository to $cloneDestination..."

if (Test-Path $cloneDestination) {
    Write-Host "Directory $cloneDestination already exists. Skipping clone."
} else {
    git clone $repositoryUrl $cloneDestination
    Write-Host "Repository cloned successfully to $cloneDestination"
}

Write-Host "Setup completed successfully!"
Write-Host "Repository URL: $repositoryUrl"
Write-Host "File location: $repoUrlFile"
Write-Host "Repository cloned to: $cloneDestination"
