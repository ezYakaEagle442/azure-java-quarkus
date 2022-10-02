/*
  /!\ This Bicep file is just a sample and is NOT PRODUCTION-ready
  
*/

@description('The name of the Managed Cluster resource.')
param clusterName string = 'aks101cluster'

@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location

@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 0

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int = 3

@description('The size of the Virtual Machine.')
param agentVMSize string = 'Standard_Ds_v3'

@description('User name for the Linux Virtual Machines.')
param linuxAdminUsername string

@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
param sshRSAPublicKey string



resource aks 'Microsoft.ContainerService/managedClusters@2020-09-01' = {
  dependsOn: [
    resourceGroup, acr, vnet
  ]  
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    servicePrincipalProfile: {
      clientId: 'string'
      secret: 'string'
    }
    dnsPrefix: dnsPrefix
    kubernetesVersion: '1.22.4'
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
        enableAutoScaling: false
        orchestratorVersion: '1.22.4'
        podSubnetID: 'string'
        vnetSubnetID: 'string'
      }
    ]
    networkProfile: {
      loadBalancerSku: 'string'
      networkMode: 'transparent'
      networkPlugin: 'azure'
      networkPolicy: 'azure'
      outboundType: 'loadBalancer'
      serviceCidr: '10.42.0.0/24'
    }
    nodeResourceGroup: 'string'    
    linuxProfile: {
      adminUsername: linuxAdminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshRSAPublicKey
          }
        ]
      }
    }
    autoUpgradeProfile: {
      upgradeChannel: 'patch'
    }
  }
}

output controlPlaneFQDN string = aks.properties.fqdn
