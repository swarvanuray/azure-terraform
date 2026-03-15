# 1. Create EventHub Authorization Rule
resource "azurerm_eventhub_authorization_rule" "this" {
  count = var.create_resource ? 1 : 0

  name                = var.authorization_rule_name
  namespace_name      = var.namespace_name
  eventhub_name       = var.eventhub_name
  resource_group_name = var.rg_name
  listen              = var.listen
  send                = var.send
  manage              = var.manage
}
