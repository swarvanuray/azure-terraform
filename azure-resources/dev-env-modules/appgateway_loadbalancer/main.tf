# 1. Create Public IP for Application Gateway
resource "azurerm_public_ip" "appgw_pip" {
  count = var.create_resource ? 1 : 0

  name                = "${var.appgw_name}-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

# 2. Create Application Gateway
resource "azurerm_application_gateway" "this" {
  count = var.create_resource ? 1 : 0

  name                = var.appgw_name
  resource_group_name = var.rg_name
  location            = var.location

  tags = var.tags

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = "${var.appgw_name}-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontend-port"
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.appgw_pip[0].id
  }

  backend_address_pool {
    name         = "backend-pool"
    ip_addresses = var.backend_ip_addresses
  }

  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = var.cookie_based_affinity
    port                  = var.backend_port
    protocol              = "Http"
    request_timeout       = var.request_timeout
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    priority                   = 100
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "backend-http-settings"
  }
}
