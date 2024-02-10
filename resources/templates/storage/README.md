# Bicep template for Azure Storage

This directory contains a Bicep template `storage.bicep` that can be used to deploy the Azure Storage service.

## Usage

### Deploy a standard GPv2 storage account

```bash
az deployment group create -g <RG_NAME> -f storage.bicep
```
