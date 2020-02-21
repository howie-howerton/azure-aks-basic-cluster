variable "resource_group_name" {
  description = "Name of the Resource Group to create."
  default     = "k8s-rg"
}
variable "location" {
  description = "The preferred Region into which to launch the resources outlined in this template."
  default     = "eastus"
}
variable "cluster_name" {
  description = "Cluster name for the AKS cluster"
  default     = "k8s-demo"
}
variable "dns_prefix" {
  description = "The DNS prefix that forms part of the FQDN used to access the cluster.  dns_prefix must contain between 2 and 45 characters. The name can contain only letters, numbers, and hyphens. The name must start with a letter and must end with an alphanumeric character."
  default     = "k8s-demo"
}
variable "ssh_public_key" {
  description = "Path to the SSH public key to be used to log into the worker nodes (if necessary).."
}
variable "agent_count" {
  description = "Number of worker nodes for the cluster."
  default     = "2"
}
variable "client_id" {
  description = "The client_id that K8s uses when creating Azure load balancers.  Can be the same as the client_id that terraform uses to create the cluster."
}

variable "client_secret" {
  description = "The client_secret that K8s uses when creating Azure load balancers.  Can be the same as the client_secret that terraform uses to create the cluster."
}

variable log_analytics_workspace_name {
    default = "testLogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}