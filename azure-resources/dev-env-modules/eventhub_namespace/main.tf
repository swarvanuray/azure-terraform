# 1. Create EventHub Namespace
resource "azurerm_eventhub_namespace" "this" {
  count = var.create_resource ? 1 : 0

  name                          = var.namespace_name
  resource_group_name           = var.rg_name
  location                      = var.location
  sku                           = var.sku
  capacity                      = var.capacity
  auto_inflate_enabled          = var.auto_inflate_enabled
  maximum_throughput_units      = var.maximum_throughput_units
  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled
  minimum_tls_version           = var.minimum_tls_version

  # Identity block (optional)
  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = var.tags
}
