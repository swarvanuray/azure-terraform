output "data_collection_rule_id" {
  description = "The ID of the Data Collection Rule"
  value       = try(azurerm_monitor_data_collection_rule.this[0].id, "Not Created")
}

output "data_collection_rule_name" {
  description = "The name of the Data Collection Rule"
  value       = try(azurerm_monitor_data_collection_rule.this[0].name, "Not Created")
}

output "immutable_id" {
  description = "The immutable ID of the Data Collection Rule"
  value       = try(azurerm_monitor_data_collection_rule.this[0].immutable_id, "Not Created")
}
