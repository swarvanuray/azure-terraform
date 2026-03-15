output "disk_ids" {
  description = "The IDs of the managed disks"
  value       = try(azurerm_managed_disk.data_disk[*].id, [])
}

output "disk_names" {
  description = "The names of the managed disks"
  value       = try(azurerm_managed_disk.data_disk[*].name, [])
}

output "attachment_ids" {
  description = "The IDs of the data disk attachments"
  value       = try(azurerm_virtual_machine_data_disk_attachment.disk_attach[*].id, [])
}
