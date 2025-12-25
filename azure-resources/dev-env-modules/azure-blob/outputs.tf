output "storage_id" {
  value = try(azurerm_storage_account.this[0].id, "Not Created")
}

output "primary_endpoint" {
  value = try(azurerm_storage_account.this[0].primary_blob_endpoint, "Not Created")
}