variable "demo_region" {
    default="euw"
    description="region where resources will be created"
}

variable "resource_group_name" {
    default="euw-ppe-010-coupon-rg"
    description="Resource group used for creting application gateway "
}

variable "location" {
    default="westeurope"
    description="location where application gateway will be created"
}
variable "aks_cluster_name" {
    default="couponservice-cluster"
    description="Resource group used for creting application gateway "
}

variable "app_gateway_name" {
    default="couponapiappgateway"
    description="Name of the applicaion gateway"
}
variable "client_id" {
    default=""
    description="Service principal id"
}
variable "client_secret" {
    default=""
    description="service principal password"
}
variable "tenant_id" {
    default="f55b1f7d-7a7f-49e4-9b90-55218aad89f8"
    description="Azure subscription tenant id"
}

variable "subscription_id" {
    default="151e932e-d37f-44c6-a400-22d4942ccb6e"
    description="Azure subscription  id"
}

variable "app_gateway_sku" {
    default="WAF_v2"
    description="Stock keeping unit - Type of application gateway "
}
variable "app_gateway_tier" {
    default="WAF_v2"
    description="Stock keeping unit - Type of application tier"
}
variable "virtual_network_name" {
    default="euw-prod-010-svs-azdefaultroutes"
    description="Name of the virual network where the application gateway will be created"
}
variable "appgwsubnet_name" {
   default="euw-prod-010-svs-applicationgateway"
  description="Name of the subnet used for creating application gateway"
}
variable "demo_team_number" {
    default="010"
    description="Tesco Team number"
}
variable "demo_environment" {
    default="ppe"
    description="Environment where the resource will be created"
}
variable "demo_team_name" {
    default="svs"
    description="Tesco team name"
}
variable "aks_name" {
    default="coupon"
    description="Name of the aks service"
}

variable "kubernetes_version" {
  default="1.13.10"
  description="kubernetes version"
}

variable "dns_prefix" {
    default="couponservice-cluster"
    description="AKS cluster dns prefix name"
}
variable "aks_node_count" {
    default=3
    description="AKS cluster node count"
}
variable "aks_vm_size" {
    default="Standard_DS2_v2"
    description="Azure VM size"
}

# Spoke Networking
variable "spoke_networking_resource_group_name" {
    default="euw-prod-010-svs-net"
}

variable "spoke_networking_learnedroutes_vnet_name" {
     default= "euw-prod-010-svs-learnedroutes" # VNet used by AKS cluster
}

variable "spoke_networking_azdefaultroutes_vnet_name" {
    default= "euw-prod-010-svs-azdefaultroutes" # VNet used by Application Gateway
}
variable "spoke_networking_route_table_name" {
    default= "euw-prod-010-svs-hubinternet" # only when 'spoke_to_hub_peering_configured' is enabled
}

variable "spoke_to_hub_peering_configured" {
    default = 1
}
variable "aks_subnet_cidr" {
    default= "10.114.40.0/24"
}

variable "aks_service_cidr" {
  default = "172.29.0.0/24"
}

variable "aks_dns_ip" {
  default = "172.29.0.10"
}

variable "aks_docker_bridge_cidr" {
  default = "172.28.0.1/25"
}

variable "key_vault_id" {
    default = ""
}
variable "cert_key_password" {
  default = ""
}