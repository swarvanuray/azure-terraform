# 1. Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "this" {
  count = var.create_resource ? 1 : 0

  name                = var.workspace_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.sku
  retention_in_days   = var.retention_in_days

  # Optional settings
  allow_resource_only_permissions         = var.allow_resource_only_permissions
  local_authentication_enabled            = var.local_authentication_enabled
  daily_quota_gb                          = var.daily_quota_gb
  cmk_for_query_forced                    = var.cmk_for_query_forced
  internet_ingestion_enabled              = var.internet_ingestion_enabled
  internet_query_enabled                  = var.internet_query_enabled
  reservation_capacity_in_gb_per_day      = var.reservation_capacity_in_gb_per_day
  data_collection_rule_id                 = var.data_collection_rule_id
  immediate_data_purge_on_30_days_enabled = var.immediate_data_purge_on_30_days_enabled

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
