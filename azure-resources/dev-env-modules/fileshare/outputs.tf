output "fileshare_id" {
  description = "The ID of the Azure File Share"
  value       = try(azurerm_storage_share.this[0].id, "Not Created")
}

output "fileshare_name" {
  description = "The name of the Azure File Share"
  value       = try(azurerm_storage_share.this[0].name, "Not Created")
}

output "share_file_id" {
  description = "The ID of the uploaded share file (if enabled)"
  value       = try(azurerm_storage_share_file.this[0].id, "Not Created")
}
