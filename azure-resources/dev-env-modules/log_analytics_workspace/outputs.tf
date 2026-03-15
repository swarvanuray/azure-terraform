output "workspace_id" {
  description = "The ID of the Log Analytics Workspace"
  value       = try(azurerm_log_analytics_workspace.this[0].id, "Not Created")
}

output "workspace_name" {
  description = "The name of the Log Analytics Workspace"
  value       = try(azurerm_log_analytics_workspace.this[0].name, "Not Created")
}

output "workspace_customer_id" {
  description = "The Workspace (Customer) ID of the Log Analytics Workspace"
  value       = try(azurerm_log_analytics_workspace.this[0].workspace_id, "Not Created")
}

output "primary_shared_key" {
  description = "The primary shared key of the Log Analytics Workspace"
  value       = try(azurerm_log_analytics_workspace.this[0].primary_shared_key, "Not Created")
  sensitive   = true
}

output "secondary_shared_key" {
  description = "The secondary shared key of the Log Analytics Workspace"
  value       = try(azurerm_log_analytics_workspace.this[0].secondary_shared_key, "Not Created")
  sensitive   = true
}
