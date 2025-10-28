# VM Setup Script
# This script runs on the VM after deployment to set up the environment

param(
    [string]$repositoryUrl = "https://github.com/MichaelPico/windows-setup"
)

# Write repository URL to C: drive root
$repoUrlFile = "C:\windows-repo-url.txt"

Write-Host "Writing repository URL to C: drive root..."
$repositoryUrl | Out-File -FilePath $repoUrlFile -Encoding UTF8

Write-Host "Setup completed successfully!"
Write-Host "Repository URL: $repositoryUrl"
Write-Host "File location: $repoUrlFile"
