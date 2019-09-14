resource "azurerm_application_gateway" "applicationGateway" {
  name                = "${var.demo_region}-${var.app_gateway_name}-${var.demo_environment}"
  resource_group_name = "${azurerm_resource_group.aks_resource_group.name}"
  location            = "${azurerm_resource_group.aks_resource_group.location}"

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
  }

  sku {
    name     = "${var.app_gateway_sku}"
    tier     = "${var.app_gateway_tier}"
    capacity = 2
  }


  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = "${data.azurerm_subnet.appgwsubnet.id}"
  }

  frontend_port {
    name = "httpPort"
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = "${azurerm_public_ip.publickIp.id}"
  }

  backend_address_pool {
    name = "bepool"
  }

  backend_http_settings {
    name                  = "appGatewayBackendHttpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
  }

  ssl_certificate {
    name     = "${var.demo_region}-${var.app_gateway_name}-${var.demo_environment}"
    data     = "${filebase64("certificate/${var.demo_region}-${var.app_gateway_name}-${var.demo_environment}.pfx")}"
    password = "${var.cert_key_password}"
    }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "httpsPort"
    protocol                       = "Https"
    ssl_certificate_name           = "${var.demo_region}-${var.app_gateway_name}-${var.demo_environment}"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "bepool"
    backend_http_settings_name = "appGatewayBackendHttpSettings"
  }

  tags = {
    team_number = "${var.demo_team_number}"
    sub_type    = "${var.demo_environment}"
  }
  depends_on = ["azurerm_public_ip.publickIp"]
}