output "vmss_id" {
  description = "The ID of the Virtual Machine Scale Set"
  value       = try(azurerm_linux_virtual_machine_scale_set.this[0].id, "Not Created")
}

output "vmss_name" {
  description = "The name of the Virtual Machine Scale Set"
  value       = try(azurerm_linux_virtual_machine_scale_set.this[0].name, "Not Created")
}

output "vmss_unique_id" {
  description = "The unique ID of the Virtual Machine Scale Set"
  value       = try(azurerm_linux_virtual_machine_scale_set.this[0].unique_id, "Not Created")
}

output "admin_password" {
  description = "The generated admin password for the VMSS instances"
  value       = try(random_password.vmss_password[0].result, "Not Created")
  sensitive   = true
}

output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = try(azurerm_virtual_network.vmss_vnet[0].id, "Not Created")
}
