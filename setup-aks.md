You can tale the Azure quickstart Templates as a basic sammple to start with : 

- [https://docs.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters?tabs=bicep]https://docs.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters?tabs=bicep()
- [https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.kubernetes/aks](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.kubernetes/aks)
- []()
- []()
- []()


## Create AKS Service Principal
## attach ACR

### Get AKS Credentials

Apply [k alias](./tools#kube-tools)

```sh

ls -al ~/.kube
# rm  ~/.kube/config

az aks get-credentials --resource-group $aks_rg_name --name $aks_cluster_name
az aks show -n $aks_cluster_name -g $aks_rg_name

cat ~/.kube/config
k cluster-info
export KUBECONFIG=~/.kube/config
k config view --minify
k config get-contexts

export KUBECONTEXT=$aks_cluster_name
k config use-context $aks_cluster_name

aks_api_server_url=$(az aks show -n $aks_cluster_name -g $aks_rg_name --query 'fqdn' -o tsv)
echo "AKS API server URL: " $aks_api_server_url

