# Windows Setup

This repository documents my personal Windows setup and contains scripts and configurations to help me quickly configure any Windows machine to my preferences.

## VM Deployment

The repository includes Azure deployment scripts to set up a Windows virtual machine for testing setup configurations.

### Prerequisites

- Azure CLI installed and configured
- An active Azure subscription
- Appropriate permissions to create resources in your subscription

### Deploying a Test VM

The [deployment](./deployment/) folder contains Bicep templates and PowerShell scripts to deploy a Windows 11 Pro VM with the following features:

- **VM Specifications**: Standard_B2s with Windows 11 23H2 Pro
- **Networking**: Virtual network with dedicated subnets for VM and Azure Bastion
- **Access**: Azure Bastion for secure RDP access without exposing public ports
- **Auto-shutdown**: Configured to automatically shut down at 2:00 AM UTC to save costs
- **Storage**: Standard LRS managed disks

#### Quick Start

1. Navigate to the deployment folder:
   ```powershell
   cd deployment
   ```

2. Create a parameters file from the sample:
   ```powershell
   cp main.parameters.json.sample main.parameters.json
   ```

3. Edit [main.parameters.json](./deployment/main.parameters.json) and provide:
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

The script will create the resource group and deploy all necessary resources. Once complete, you can connect to the VM via Azure Bastion through the Azure Portal.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
