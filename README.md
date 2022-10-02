## **Disclaimer**

**The features described in this workshop might be not yet production-ready, we enable preview-features for the purpose of learning.**

# azure-java-quarkus

See also :
- [Deploy Bicep file with parameter file](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameter-files)

Note: You can use inline parameters and a local parameter file in the same deployment operation. For example, you can specify some values in the local parameter file and add other values inline during deployment. If you provide values for a parameter in both the local parameter file and inline, the inline value takes precedence.

## ToC

1. Setup [Tools](tools.md)
1. Check [subscription](subscription.md)
1. setup [AKS](setup-aks.md)

```sh
az deployment group create \
  --name ExampleDeployment \
  --resource-group ExampleGroup \
  --template-file main.bicep \
  --parameters @storage.parameters.json
```