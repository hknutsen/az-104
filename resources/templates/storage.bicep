param storageAccountName string

// Optional parameters
param location string = resourceGroup().location
param kind string = 'StorageV2'
param skuName string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: kind
  sku: {
    name: skuName
  }
}
