
# https://docs.microsoft.com/en-us/azure/terraform/terraform-create-k8s-cluster-with-tf-and-aks
# https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html


# This RouteTable is already created during Subscription bootstrap
# It allows for outgoing internet access through Network Hub
data "azurerm_route_table" "network_hub_route_table" {
  count                 = "${var.spoke_to_hub_peering_configured}" # only if peering to network hub is configured
  name                  = "${var.spoke_networking_route_table_name}"
  resource_group_name   = "${var.spoke_networking_resource_group_name}"
}
# Subnet used by AKS cluster
# resource "azurerm_subnet" "aks_subnet" {
#   name                 = "${azurerm_resource_group.aks_resource_group.name}-${var.aks_name}"
#   resource_group_name  = "${var.spoke_networking_resource_group_name}"
#   virtual_network_name = "${var.spoke_networking_learnedroutes_vnet_name}"
#   address_prefix       = "${var.aks_subnet_cidr}"
#   route_table_id       = "${data.azurerm_route_table.network_hub_route_table[0].id}"
# }

resource "azurerm_kubernetes_cluster" "aks_cluster" {
    name                = "${var.demo_region}-${var.aks_cluster_name}-${var.demo_environment}"
    resource_group_name = "${azurerm_resource_group.aks_resource_group.name}"
    location            = "${azurerm_resource_group.aks_resource_group.location}"
    # resource_group_name      = "${var.resource_group_name}"
    # location                 = "${var.location}"
    dns_prefix          = "${var.dns_prefix}"
    kubernetes_version  = "${var.kubernetes_version}"


    agent_pool_profile {
        name            = "default"
        count           = "${var.aks_node_count}"
        vm_size         =  "${var.aks_vm_size}" # "Standard_DS2_v2 - https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general
        os_type         = "Linux"
        os_disk_size_gb = 100
        vnet_subnet_id  = "${data.azurerm_subnet.aks_subnet.id}"
    }

    network_profile {
        network_plugin     = "azure"
        network_policy     = "calico"
        dns_service_ip     = "${var.aks_dns_ip}"
        docker_bridge_cidr = "${var.aks_docker_bridge_cidr}"
        service_cidr       = "${var.aks_service_cidr}"
  }

    role_based_access_control {
        enabled = true
    }
  
    service_principal {
        client_id     = "${var.client_id}"
        client_secret = "${var.client_secret}"
    }
    # tags = {
    #     Environment = "Development"
    # }
}

resource "local_file" "kubeconfig" {
  sensitive_content = "${azurerm_kubernetes_cluster.aks_cluster.kube_config_raw}"
  filename          = "/tmp/kubeconfig"
  depends_on        = ["azurerm_kubernetes_cluster.aks_cluster"]
}