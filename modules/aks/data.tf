# data "azurerm_resource_group" "rg" {
#   name = "${var.resource_group_name}"
# }

data "azurerm_subnet" "appgwsubnet" {
   name                 = "${var.appgwsubnet_name}"
   virtual_network_name = "${var.virtual_network_name}"
   resource_group_name  = "${var.spoke_networking_resource_group_name}"
 }
 
 data "azurerm_subnet" "aks_subnet" {
   name                 = "subnet_${var.demo_environment}"
   virtual_network_name = "${var.spoke_networking_learnedroutes_vnet_name}"
   resource_group_name  = "${var.spoke_networking_resource_group_name}"
 }

# Use this data source to access the configuration of the AzureRM provider
data "azurerm_client_config" "current" {
}

data "azuread_service_principal" "aks_azuread_service_principal"{
  application_id = "${var.client_id}"
}

# data "azurerm_key_vault_certificate" "certificate" {
#     name         = "${var.demo_region}-${var.app_gateway_name}-${var.demo_environment}"
#     key_vault_id = "${var.key_vault_id}"
# }