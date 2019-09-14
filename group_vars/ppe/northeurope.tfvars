#General Configurations
demo_region = "eun"
location = "northeurope"
tenant_id = "tenanent id"
subscription_id = "subscriptionid"
demo_team_number = "010"
demo_environment = "ppe"
demo_team_name = "svs"
sp_principal_id = "a0838236-f2a3-4d20-83de-1fbf68de4f73"

#AKS Configuration
aks_cluster_name = "couponservice-cluster"
app_gateway_name = "couponapiappgateway"
aks_name = "coupon"
dns_prefix = "couponservice-cluster"
aks_node_count = 2
aks_vm_size = "Standard_F4s"
aks_subnet_cidr = "10.119.32.0/25"
kubernetes_version = "1.13.10"
resource_group_name = "resource group name"

#Application Gateway Configuration
app_gateway_sku = "WAF_v2"
app_gateway_tier = "WAF_v2"
virtual_network_name = "vnet-azdefaultroutes"
appgwsubnet_name = "subnet-applicationgateway"
key_vault_id = "key vault id"

# Spoke Networking
spoke_networking_resource_group_name = "resource group name"
spoke_networking_learnedroutes_vnet_name = "vnet-learnedroutes"
spoke_networking_azdefaultroutes_vnet_name = "vent-azdefaultroutes"
spoke_networking_route_table_name = "routetable-hubinternet"
spoke_to_hub_peering_configured = 1
