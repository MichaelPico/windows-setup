# VM Deployment

This folder contains Azure deployment scripts to quickly spin up a Windows virtual machine for testing setup configurations.

## Prerequisites

- Azure CLI installed and configured
- An active Azure subscription
- Appropriate permissions to create resources in your subscription

## Deploying a Test VM

The Bicep templates and PowerShell scripts in this folder deploy a Windows 11 Pro VM with the following features:

- **VM Specifications**: Standard_B2s with Windows 11 23H2 Pro
- **Networking**: Virtual network with dedicated subnets for VM and Azure Bastion
- **Access**: Azure Bastion for secure RDP access without exposing public ports
- **Auto-shutdown**: Configured to automatically shut down at 5:00 AM UTC to save costs
- **Storage**: Standard LRS managed disks (256 GB)
- **Repository Link**: Automatically creates a `windows-repo-url.txt` file on the Desktop with the repository URL, if the file is not in the Desktop it may be in the root of the C: Disk

## Quick Start

1. Navigate to the deployment folder:
   ```powershell
   cd deployment
   ```

2. Create a parameters file from the sample:
   ```powershell
   cp main.parameters.json.sample main.parameters.json
   ```

3. Edit [main.parameters.json](./main.parameters.json) and provide:
   - `adminUsername`: Your desired admin username
   - `adminPassword`: A secure password for the VM

4. Run the deployment script:
   ```powershell
   .\deploy-bicep.ps1
   ```

   Optionally, you can specify a custom resource group name and location:
   ```powershell
   .\deploy-bicep.ps1 -rgName "my-custom-rg" -location "eastus"
   ```

The script will create the resource group and deploy all necessary resources. Once complete:

1. Connect to the VM via Azure Bastion through the Azure Portal
2. Copy the windows-setup repository to the VM Desktop
3. Run the setup scripts from the repository

## Files

- [main.bicep](./main.bicep) - Main Bicep template defining the infrastructure
- [deploy-bicep.ps1](./deploy-bicep.ps1) - PowerShell script to execute the deployment
- [main.parameters.json.sample](./main.parameters.json.sample) - Sample parameters file
