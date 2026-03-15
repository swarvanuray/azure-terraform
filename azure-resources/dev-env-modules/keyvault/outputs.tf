output "keyvault_id" {
  description = "The ID of the Key Vault"
  value       = try(azurerm_key_vault.this[0].id, "Not Created")
}

output "keyvault_uri" {
  description = "The URI of the Key Vault"
  value       = try(azurerm_key_vault.this[0].vault_uri, "Not Created")
}

output "keyvault_name" {
  description = "The name of the Key Vault"
  value       = try(azurerm_key_vault.this[0].name, "Not Created")
}
