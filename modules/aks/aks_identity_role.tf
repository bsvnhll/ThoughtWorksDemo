# # Resource Group for AKS and Application Gateway resources
resource "azurerm_resource_group" "aks_resource_group" {
  name     = "${var.demo_region}-${var.demo_environment}-${var.demo_team_number}-${var.demo_team_name}-rg"
  location = "${var.location}"

  tags = {
    team_number = "${var.demo_team_number}"
    sub_type    = "${var.demo_environment}"
  }
}

# Managed Identity used by Applicaton Gateway
resource "azurerm_user_assigned_identity" "application_gateway_managed_identity" {
  resource_group_name = "${azurerm_resource_group.aks_resource_group.name}"
  location            = "${azurerm_resource_group.aks_resource_group.location}"

  name = "${var.demo_region}-${var.demo_environment}-${var.demo_team_number}-${var.demo_team_name}-identity"
}
# Assign 'Managed Identity Operator' role for AKS Service Principal for managing Application Gateway Managed Identity
resource "azurerm_role_assignment" "aks_managed_identity_operator_role_assignment" {
  principal_id         = "${data.azuread_service_principal.aks_azuread_service_principal.id}"
  scope                = "${azurerm_user_assigned_identity.application_gateway_managed_identity.id}"
  role_definition_name = "Managed Identity Operator"
  depends_on           = ["azurerm_user_assigned_identity.application_gateway_managed_identity"]
}

# Assign Contributor role for AKS Service Principal at Resource Group scope
resource "azurerm_role_assignment" "aks_contributor_role_assignment_resourcegroup" {
  scope                = "${azurerm_resource_group.aks_resource_group.id}"
  role_definition_name = "Contributor"
  principal_id         = "${data.azuread_service_principal.aks_azuread_service_principal.id}"
}

# Assign 'Contributor' role for Application Gateway Managed Identity for managing Application Gateway resource
resource "azurerm_role_assignment" "aks_contributor_role_assignment" {
  scope                = "${azurerm_application_gateway.applicationGateway.id}"
  role_definition_name = "Contributor"
  principal_id         = "${azurerm_user_assigned_identity.application_gateway_managed_identity.principal_id}"
  depends_on           = ["azurerm_application_gateway.applicationGateway","azurerm_user_assigned_identity.application_gateway_managed_identity"]
}

# Assign 'Reader' role for Application Gateway Managed Identity for reading details from AKS and Application Gateway Resource Group
resource "azurerm_role_assignment" "aks_reader_role_assignment" {
  scope                = "${azurerm_resource_group.aks_resource_group.id}"
  role_definition_name = "Reader"
  principal_id         = "${azurerm_user_assigned_identity.application_gateway_managed_identity.principal_id}"
  depends_on           = ["azurerm_user_assigned_identity.application_gateway_managed_identity"]
}
