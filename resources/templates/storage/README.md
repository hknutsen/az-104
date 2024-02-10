# Bicep template for Azure Storage

This directory contains a Bicep template `storage.bicep` that can be used to deploy the Azure Storage service.

## Usage

### Deploy a standard GPv2 storage account

```console
az deployment group create -g <RG_NAME> -f storage.bicep
```

### Deploy a premium block blobs storage account

```console
az deployment group create -g <RG_NAME> -f storage.bicep -p tier=Premium kind=BlockBlobStorage
```

### Deploy a premium file shares storage account

```console
az deployment group create -g <RG_NAME> -f storage.bicep -p tier=Premium kind=FileStorage
```

### Deploy a premium page blobs storage account

TODO: figure out what `kind` to set here.
