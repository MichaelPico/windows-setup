param(
    [string]$rgName = "rg-michael-windows-vm-test",
    [string]$location = "uksouth"
)

$deploymentName = "deployment-$(Get-Date -Format 'yyyyMMMdd-HH\hmm\m')"
az group create -n $rgName -l $location
az deployment group create -g $rgName -n $deploymentName --template-file .\main.bicep --parameters .\main.parameters.json