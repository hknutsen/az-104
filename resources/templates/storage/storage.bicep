@minLength(3)
@maxLength(24)
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'

param location string = resourceGroup().location

@allowed(['BlobStorage', 'BlockBlobStorage', 'FileStorage', 'Storage', 'StorageV2'])
param kind string = 'StorageV2'

@allowed(['Standard', 'Premium'])
param tier string = 'Standard'

@allowed(['LRS', 'ZRS', 'GRS', 'RAGRS', 'GZRS', 'RAGZRS'])
param replication string = 'LRS'

@allowed(['Hot', 'Cool']) // Archive tier cannot be configured at storage account level
param accessTier string = 'Hot'

param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: kind
  sku: {
    name: '${tier}_${replication}'
  }
  properties: {
    accessTier: accessTier
  }
  tags: tags
}

output storageAccountId string = storageAccount.id

output blobServiceEndpoint string = storageAccount.properties.primaryEndpoints.blob

output fileServiceEndpoint string = storageAccount.properties.primaryEndpoints.file

output queueServiceEndpoint string = storageAccount.properties.primaryEndpoints.queue

output tableServiceEndpoint string = storageAccount.properties.primaryEndpoints.table
