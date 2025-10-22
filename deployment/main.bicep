// vnet
// public ip
// vm
// bastion
// 
@description('The description that will be used to deploy the resources')
param location string = resourceGroup().location

@description('Prefix to be used in all the resources')
param prefix string = 'windows'

@description('The size of the Virtual Machine')
param vmSize string = 'Standard_B2s'

@description('Tags to be used in the resources')
param resourceTags object = {
  owner: 'Michael Pico'
}

@description('The administrator username')
param adminUsername string

@description('The administrator password')
@secure()
param adminPassword string

@description('Sufix to be used in all the resources, default 01')
param sufix string = '01'

var vNetHubPrefix = '10.0.0.0/16'
var subnetBastionPrefix = '10.0.0.0/26'
var subnetVirtualMachinePrefix = '10.0.10.0/26'
var subnetBastionName = 'AzureBastionSubnet'  // FIXED: Must be exactly 'AzureBastionSubnet'
var subnetVirtualMachineName = 'subnet-vm'
var vmName = '${prefix}-vm-${sufix}'

resource mainVnet 'Microsoft.Network/virtualNetworks@2024-10-01' = {
  name: '${prefix}-vnet-${sufix}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vNetHubPrefix
      ]
    }
    subnets: [
      {
        name: subnetBastionName
        properties: {
          addressPrefix: subnetBastionPrefix
        }
      }
      {
        name: subnetVirtualMachineName
        properties: {
          addressPrefix: subnetVirtualMachinePrefix
        }
      }
    ]
  }
}

resource bastionPublicIP 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: '${prefix}-bastion-${sufix}-pip'
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2024-10-01' = {
  name: '${prefix}-bastion-host-${sufix}'
  location: location
  sku: {
    name: 'Basic'
  }
  tags: resourceTags
  properties: {
    ipConfigurations: [
      {
        properties: {
          subnet: {
            id: '${mainVnet.id}/subnets/${subnetBastionName}'
          }
          publicIPAddress: {
            id: bastionPublicIP.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
        name: 'ipconfig1'
      }
    ]
  }
}

resource vmNic 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: '${prefix}-nic-${sufix}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${mainVnet.id}/subnets/${subnetVirtualMachineName}'
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        }
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'Windows-11'
        sku: 'win11-23h2-pro'
        version: 'latest'
      }
      osDisk: {
        name: '${vmName}-os'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'  // FIXED: Changed from Premium_LRS to Standard_LRS
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vmNic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource vmAutoShutdown 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  name: 'shutdown-computevm-${vmName}'
  location: location
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '0500' // 2:00 AM (24-hour format)
    }
    timeZoneId: 'UTC'
    notificationSettings: {
      status: 'Disabled'
    }
    targetResourceId: vm.id
  }
}
