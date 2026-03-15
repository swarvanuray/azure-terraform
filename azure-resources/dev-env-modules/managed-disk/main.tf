# Flatten vm_ids × disk_configs into a single list for count-based iteration
locals {
  disk_map = var.create_resource ? flatten([
    for vm_idx, vm_id in var.vm_ids : [
      for disk_idx, disk in var.disk_configs : {
        vm_idx               = vm_idx
        vm_id                = vm_id
        disk_idx             = disk_idx
        name                 = "${disk.name}-${vm_idx}-disk-${disk_idx}"
        disk_size_gb         = disk.disk_size_gb
        storage_account_type = disk.storage_account_type
      }
    ]
  ]) : []
}

# 1. Create Managed Disks (vm_count × disk_configs)
resource "azurerm_managed_disk" "data_disk" {
  count = length(local.disk_map)

  name                 = local.disk_map[count.index].name
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = local.disk_map[count.index].storage_account_type
  create_option        = "Empty"
  disk_size_gb         = local.disk_map[count.index].disk_size_gb

  tags = {
    CreatedBy = "Terraform"
    Module    = "ManagedDisk"
    VM        = "vm-${local.disk_map[count.index].vm_idx}"
    DiskIndex = local.disk_map[count.index].disk_idx
  }
}

# 2. Attach Data Disks to VMs (all arguments included)
resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
  count = length(local.disk_map)

  managed_disk_id    = azurerm_managed_disk.data_disk[count.index].id
  virtual_machine_id = local.disk_map[count.index].vm_id
  lun                = local.disk_map[count.index].disk_idx
  caching            = var.caching

  # Optional arguments
  create_option             = var.attach_create_option
  write_accelerator_enabled = var.write_accelerator_enabled
}
