# Attach 3 data disks to each existing VM (each with different config)
module "vm_data_disks" {
  source = "../dev-env-modules/managed-disk"

  rg_name         = data.azurerm_resource_group.vm_rg.name
  location        = "East US"
  create_resource = true
  vm_ids          = module.vm_machines.vm_ids

  # Per-disk configurations (each entry = 1 disk per VM)
  disk_configs = [
    {
      name                 = "dev-vm-data"
      disk_size_gb         = 64
      storage_account_type = "Standard_LRS"
    },
    {
      name                 = "dev-vm-logs"
      disk_size_gb         = 64
      storage_account_type = "Standard_LRS"
    },
    {
      name                 = "dev-vm-backup"
      disk_size_gb         = 128
      storage_account_type = "Premium_LRS"
    }
  ]

  # Attachment settings (all options)
  caching                   = "ReadWrite"
  attach_create_option      = "Attach"
  write_accelerator_enabled = false
}

output "data_disk_ids" {
  value = module.vm_data_disks.disk_ids
}

output "data_disk_names" {
  value = module.vm_data_disks.disk_names
}
