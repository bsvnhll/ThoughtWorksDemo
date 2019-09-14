provider "azurerm" {
    version         = "=1.28.0"
}

provider "azuread" {
    version = "=0.4.0"
    alias   = "azuread"
  
}

terraform {
    backend "azurerm" {}
    
}

module "kubernetes_cluster" {
source = "../../modules/aks"
client_id                                   = "${var.client_id}"
client_secret                               = "${var.client_secret}"
demo_region                                = "${var.demo_region}"
resource_group_name                         = "${var.resource_group_name}"
location                                    = "${var.location}"
aks_cluster_name                            = "${var.aks_cluster_name}"
kubernetes_version                          = "${var.kubernetes_version}"
app_gateway_name                            = "${var.app_gateway_name}"
app_gateway_sku                             = "${var.app_gateway_sku}"
app_gateway_tier                            = "${var.app_gateway_tier}"
virtual_network_name                        = "${var.virtual_network_name}"
appgwsubnet_name                            = "${var.appgwsubnet_name}"
demo_team_number                           = "${var.demo_team_number}"
demo_environment                           = "${var.demo_environment}"
demo_team_name                             = "${var.demo_team_name}"
aks_name                                    = "${var.aks_name}"
dns_prefix                                  = "${var.dns_prefix}-dns"
aks_node_count                              = "${var.aks_node_count}"
aks_vm_size                                 = "${var.aks_vm_size}"
spoke_networking_resource_group_name        = "${var.spoke_networking_resource_group_name}"
spoke_networking_learnedroutes_vnet_name    = "${var.spoke_networking_learnedroutes_vnet_name}" # VNet used by AKS cluster
spoke_networking_azdefaultroutes_vnet_name  = "${var.spoke_networking_azdefaultroutes_vnet_name}" # VNet used by Application Gateway
spoke_networking_route_table_name           = "${var.spoke_networking_route_table_name}" # only when 'spoke_to_hub_peering_configured' is enabled
spoke_to_hub_peering_configured             = "${var.spoke_to_hub_peering_configured}"
aks_subnet_cidr                             = "${var.aks_subnet_cidr}"
key_vault_id                                = "${var.key_vault_id}"
cert_key_password                           = "${var.cert_key_password}"
}