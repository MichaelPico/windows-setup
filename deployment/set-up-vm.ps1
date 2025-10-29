# VM Setup Script
# This script runs on the VM after deployment to set up the environment

param(
    [string]$repositoryUrl = "https://github.com/MichaelPico/windows-setup"
)

# Write repository URL to C: drive root
$repoUrlFile = "C:\windows-repo-url.txt"

Write-Host "Writing repository URL to C: drive root..."
$repositoryUrl | Out-File -FilePath $repoUrlFile -Encoding UTF8

# Install Git using winget
Write-Host "Installing Git using winget..."
winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements

# Refresh environment variables to make git available
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
