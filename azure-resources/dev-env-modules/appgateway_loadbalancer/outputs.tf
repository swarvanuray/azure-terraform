output "appgw_id" {
  description = "The ID of the Application Gateway"
  value       = try(azurerm_application_gateway.this[0].id, "Not Created")
}

output "appgw_name" {
  description = "The name of the Application Gateway"
  value       = try(azurerm_application_gateway.this[0].name, "Not Created")
}

output "public_ip_address" {
  description = "The public IP address of the Application Gateway"
  value       = try(azurerm_public_ip.appgw_pip[0].ip_address, "Not Created")
}
