output "vm_ids" {
  description = "The IDs of the Virtual Machines"
  value       = azurerm_linux_virtual_machine.vm[*].id
}

output "vm_private_ips" {
  description = "The particular Private IP addresses of the Virtual Machines"
  value       = azurerm_linux_virtual_machine.vm[*].private_ip_address
}

output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vm_vnet.id
}

output "admin_password" {
  description = "The generated admin password for the VMs"
  value       = random_password.vm_password.result
  sensitive   = true
}

output "vm_public_ips" {
  description = "The Public IP addresses of the Virtual Machines"
  value       = azurerm_public_ip.vm_pip[*].ip_address
}
