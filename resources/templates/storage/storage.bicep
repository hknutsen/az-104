// Required configuration

param name string = 'storage${uniqueString(resourceGroup().id)}'

param location string = resourceGroup().location

@allowed(['BlobStorage', 'BlockBlobStorage', 'FileStorage', 'Storage', 'StorageV2'])
param kind string = 'StorageV2'

@allowed(['Standard', 'Premium'])
param tier string = 'Standard'

@allowed(['LRS', 'ZRS', 'GRS', 'RAGRS', 'GZRS', 'RAGZRS'])
param replication string = 'LRS'

// Optional configuration

param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: name
  location: location
  kind: kind
  sku: {
    name: '${tier}_${replication}'
  }
  properties: {}
  tags: tags
}
