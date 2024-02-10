param virtualMachineName string = 'vm-${uniqueString(resourceGroup().id)}'

param location string = resourceGroup().location

param virtualNetworkAddressPrefix string = '10.0.0.0/16'

param subnetAddressPrefix string = '10.0.0.0/24'

param vmSize string = 'Standard_D2s_v3'

@allowed(['PremiumV2_LRS', 'Premium_LRS', 'Premium_ZRS', 'StandardSSD_LRS', 'StandardSSD_ZRS', 'Standard_LRS', 'UltraSSD_LRS'])
param osDiskType string = 'Standard_LRS'

param imagePublisher string =  'MicrosoftWindowsServer'

param imageOffer string = 'WindowsServer'

param imageSku string = '2022-datacenter-azure-edition'

param imageVersion string = 'latest'

param adminUsername string

@secure()
param adminPassword string

param bootDiagnosticsEnabled bool = true

param tags object = {}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'vnet-${virtualMachineName}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [ virtualNetworkAddressPrefix ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefixes: [ subnetAddressPrefix ]
        }
      }
    ]
  }
  tags: tags
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: 'pip-${virtualMachineName}'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  tags: tags
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: 'nsg-${virtualMachineName}'
  location: location
  properties: {
    securityRules: [] // TODO: open required ports for SSH and/or RDP
  }
  tags: tags
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: 'nic-${virtualMachineName}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: virtualNetwork.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
  tags: tags
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: virtualMachineName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: imageVersion
      }
    }
    osProfile: {
      computerName: virtualMachineName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: bootDiagnosticsEnabled
      }
    }
  }
  tags: tags
}
