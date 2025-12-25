# This connects EVERY Web App created in the module to the "web-subnet"
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  for_each = local.web_apps

  app_service_id = module.multiple_webapps.webapp_ids[each.key]
  subnet_id      = module.my_network.subnet_ids["web-subnet"]
}