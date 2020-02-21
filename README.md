# azure-aks-basic-cluster
Terraform template to create a basic Azure AKS cluster


## Detailed Description

This terraform template is designed to facilitate the creation of a 'vanilla' Azure AKS cluster for usage with testing/demos/etc.
It will create:
- A new Resource Group that contains all associated resoruces
- An AKS cluster with 2 (Ubuntu-based) worker nodes.

The output from running the template will contain (amongst other output) the Kubernetes config that you'll need in order to use the kubectl command line utility.

You can use the output to set the KUBECONFIG environment variable by issuing the following commands:
```
echo "$(terraform output kube_config)" > ./azurek8s
```
```
export KUBECONFIG=./azurek8s
```


# Local MBP/Linux workstation Pre-Requisites
- git               
- terraform v0.12+  
- azure-cli 2.0+
- kubectl v1.15+    
- helm v3.0+        
On a MBP, you can easily install all of these pre-requisites with:
```
brew update && brew install git terraform azure-cli kubectl helm
```


# Azure Pre-Requisites
Terraform's Azure provider expects that you have the following environment variables set:

- export ARM_SUBSCRIPTION_ID="<your-subscriptionId-here>"
- export ARM_CLIENT_ID="<your-appID/client_id-here>"
- export ARM_CLIENT_SECRET="<your-password/client_secret-here>"
- export ARM_TENANT_ID="<your-tenantId-here>"

The ARM_SUBSCRIPTION_ID is the UUID of the Azure Subscription in which you are working.\s\s
The ARM_TENANT_ID is the UUID of the current Azure Active Directory in which you are working.\s\s 
The ARM_CLIENT_ID is the (UUID-based) Application ID (aka: client_id) of the service principal that terraform will use to create resources.\s\s
The ARM_CLIENT_SECRET is a (UUID-based) password for the service principal that terraform will use to create resources.\s\s

To obtain the above information via azure-cli, use the following commands:\s\s
Login to Azure:
```
az login
```
Obtain your Subscription ID and Tentant ID:
```
az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}"
```
Create a Service Principal for use with Terraform:
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
```
Note: ARM_CLIENT_ID==appID, ARM_CLIENT_SECRET==password



# Usage
Before beginning, ensure that you've exported the necessary environment variables as explained above.

1. Clone this repository
```
git clone https://github.com/howie-howerton/azure-aks-basic-cluster.git
```
2. Edit the variables in the sample 'terraform.tfvars.changeme' file to suit your Azure environment

3. Remove the '.changeme' extension from terraform.tfvars.changeme so that the filename reads as: terraform.tfvars

4. Initialize terraform
```
terraform init
```
5. Run 'terraform apply' to execute the template
```
terraform apply
```
   This process typically takes 10-15 minutes.
6. Use the 'terraform output kube_config' command to set the KUBECONFIG environment variable by issuing the following commands:
```
echo "$(terraform output kube_config)" > ./azurek8s
```
```
export KUBECONFIG=./azurek8s
```
7. You should now be able to manage your cluster with the kubectl cli utility:
```
kubectl cluster-info
```
```
kubectl get nodes
```

# Access the Kubernetes Dashboard
Start the kubectl proxy
```
kubectl proxy
```
Open a browser to:  'http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/#!/overview?namespace=default'

# Cleaning up
After you've finished with your cluster, you can destroy/delete it (to keep your Azure bill as low as possible)
```
terraform destroy -auto-approve
```
   This process typically takes 10-15 minutes.
