# Bicep template for Azure VM

This directory contains a Bicep template `vm.bicep` that can be used to deploy the Azure Virtual Machine service.

## Usage

### Deploy a Windows Server 2022 Datacenter VM

```console
az deployment group create -g <RG_NAME> -f vm.bicep -p adminUsername=<ADMIN_USERNAME> adminPassword=<ADMIN_PASSWORD>
```
