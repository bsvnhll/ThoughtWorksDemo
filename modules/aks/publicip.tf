 resource "azurerm_public_ip" "publickIp" {
   name                         = "publicIp1"
   location                     = "${azurerm_resource_group.aks_resource_group.location}"
   resource_group_name          = "${azurerm_resource_group.aks_resource_group.name}"
   allocation_method            = "Static"
   sku                          = "Standard"
   domain_name_label            = "couponapi-${var.demo_environment}"
 }