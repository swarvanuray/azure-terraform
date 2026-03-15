# 1. Create Azure File Share
resource "azurerm_storage_share" "this" {
  count = var.create_resource ? 1 : 0

  name                 = var.share_name
  storage_account_name = var.storage_account_name
  quota                = var.quota
  enabled_protocol     = var.enabled_protocol
}

# 2. Optionally upload a file to the share
resource "azurerm_storage_share_file" "this" {
  count = var.create_resource && var.create_share_file ? 1 : 0

  name             = var.file_name
  storage_share_id = azurerm_storage_share.this[0].id
  source           = var.source_file
  path             = var.file_path
  content_type     = var.file_content_type
}
