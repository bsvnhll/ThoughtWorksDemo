output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
}

