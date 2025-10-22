param(
    [string]$rgName = "rg-michael-windows-vm-test",
    [string]$location = "uksouth"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$bicepFile = Join-Path $scriptDir "main.bicep"
$parametersFile = Join-Path $scriptDir "main.parameters.json"

if (-not (Test-Path $parametersFile)) {
    Write-Host "Error: Parameters file not found at $parametersFile" -ForegroundColor Red
    Write-Host "Create one from main.parameters.json.sample" -ForegroundColor Yellow
    exit 1
}

# Create resource group
Write-Host "Creating resource group: $rgName in $location..." -ForegroundColor Cyan
$rgResult = az group create -n $rgName -l $location 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to create resource group" -ForegroundColor Red
    Write-Host $rgResult -ForegroundColor Red
    exit 1
}

# Deploy resources
$deploymentName = "deployment-$(Get-Date -Format 'yyyyMMMdd-HH\hmm\m')"
Write-Host "Starting deployment: $deploymentName..." -ForegroundColor Cyan
$deployResult = az deployment group create -g $rgName -n $deploymentName --template-file $bicepFile --parameters $parametersFile 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Deployment failed" -ForegroundColor Red
    Write-Host $deployResult -ForegroundColor Red
    exit 1
}

Write-Host "`nDeployment completed successfully!" -ForegroundColor Green

Write-Host "`nNext Steps:" -ForegroundColor Cyan
Write-Host "1. Connect to the VM via Azure Bastion in the Azure Portal" -ForegroundColor White
Write-Host "2. Copy the windows-setup repository to the VM Desktop" -ForegroundColor White
Write-Host "3. Run the setup scripts from the repository" -ForegroundColor White