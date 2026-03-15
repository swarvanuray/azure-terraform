output "authorization_rule_id" {
  description = "The ID of the EventHub Authorization Rule"
  value       = try(azurerm_eventhub_authorization_rule.this[0].id, "Not Created")
}

output "authorization_rule_name" {
  description = "The name of the EventHub Authorization Rule"
  value       = try(azurerm_eventhub_authorization_rule.this[0].name, "Not Created")
}

output "primary_connection_string" {
  description = "The primary connection string for the EventHub Authorization Rule"
  value       = try(azurerm_eventhub_authorization_rule.this[0].primary_connection_string, "Not Created")
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string for the EventHub Authorization Rule"
  value       = try(azurerm_eventhub_authorization_rule.this[0].secondary_connection_string, "Not Created")
  sensitive   = true
}

output "primary_key" {
  description = "The primary key for the EventHub Authorization Rule"
  value       = try(azurerm_eventhub_authorization_rule.this[0].primary_key, "Not Created")
  sensitive   = true
}

output "secondary_key" {
  description = "The secondary key for the EventHub Authorization Rule"
  value       = try(azurerm_eventhub_authorization_rule.this[0].secondary_key, "Not Created")
  sensitive   = true
}
