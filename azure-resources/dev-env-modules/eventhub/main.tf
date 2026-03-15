# 1. Create EventHub
resource "azurerm_eventhub" "this" {
  count = var.create_resource ? 1 : 0

  name                = var.eventhub_name
  namespace_name      = var.namespace_name
  resource_group_name = var.rg_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
  status              = var.status

  # Capture Description block (optional)
  dynamic "capture_description" {
    for_each = var.capture_enabled ? [1] : []
    content {
      enabled             = var.capture_enabled
      encoding            = var.capture_encoding
      interval_in_seconds = var.capture_interval_in_seconds
      size_limit_in_bytes = var.capture_size_limit_in_bytes
      skip_empty_archives = var.capture_skip_empty_archives

      destination {
        name                = var.capture_destination_name
        blob_container_name = var.capture_blob_container_name
        storage_account_id  = var.capture_storage_account_id
        archive_name_format = var.capture_archive_name_format
      }
    }
  }
}
