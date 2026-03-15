output "namespace_id" {
  description = "The ID of the EventHub Namespace"
  value       = try(azurerm_eventhub_namespace.this[0].id, "Not Created")
}

output "namespace_name" {
  description = "The name of the EventHub Namespace"
  value       = try(azurerm_eventhub_namespace.this[0].name, "Not Created")
}

output "default_primary_connection_string" {
  description = "The primary connection string for the RootManageSharedAccessKey authorization rule"
  value       = try(azurerm_eventhub_namespace.this[0].default_primary_connection_string, "Not Created")
  sensitive   = true
}

output "default_secondary_connection_string" {
  description = "The secondary connection string for the RootManageSharedAccessKey authorization rule"
  value       = try(azurerm_eventhub_namespace.this[0].default_secondary_connection_string, "Not Created")
  sensitive   = true
}

output "default_primary_key" {
  description = "The primary access key for the RootManageSharedAccessKey authorization rule"
  value       = try(azurerm_eventhub_namespace.this[0].default_primary_key, "Not Created")
  sensitive   = true
}

output "default_secondary_key" {
  description = "The secondary access key for the RootManageSharedAccessKey authorization rule"
  value       = try(azurerm_eventhub_namespace.this[0].default_secondary_key, "Not Created")
  sensitive   = true
}
