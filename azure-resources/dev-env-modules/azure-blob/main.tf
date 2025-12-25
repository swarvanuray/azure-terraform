resource "azurerm_storage_account" "this" {
  count = var.create_resource ? 1 : 0

  name                     = var.storage_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  access_tier              = var.access_tier
  min_tls_version          = var.min_tls

  

  # Feature: Data Protection (Versioning & Soft Delete)
  blob_properties {
    versioning_enabled = var.enable_versioning
    
    delete_retention_policy {
      days = 7 # Keep deleted files for 7 days (Soft Delete)
    }
  }

  

  tags = {
    CreatedBy = "Terraform"
    Module    = "AdvancedStorage"
  }
}